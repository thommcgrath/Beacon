<?php

namespace BeaconAPI\v4\Sentinel;
use BeaconAPI\v4\{Application, Core, DatabaseObject, DatabaseObjectProperty, DatabaseSchema, DatabaseSearchParameters, MutableDatabaseObject, User};
use BeaconCommon, BeaconRecordSet, JsonSerializable;

class Group extends DatabaseObject implements JsonSerializable {
	use MutableDatabaseObject;
	use SentinelObject;

	const GroupPermissionUsage = 1;
	const GroupPermissionManage = 2;

	protected string $groupId;
	protected string $userId;
	protected string $name;
	protected string $color;
	protected int $permissions;
	protected bool $enableGroupChat;
	protected ?string $discordInviteCode;
	protected ?string $discordLinkCode;
	protected ?string $discordGuildId;
	protected ?string $discordGuildName;
	protected ?string $discordChatChannelId;
	protected ?string $discordChatChannelName;
	protected bool $isClusterGroup;

	public function __construct(BeaconRecordSet $row) {
		$this->groupId = $row->Field('group_id');
		$this->userId = $row->Field('user_id');
		$this->name = $row->Field('name');
		$this->color = $row->Field('color');
		$this->permissions = $row->Field('permissions');
		$this->enableGroupChat = $row->Field('enable_group_chat');
		$this->discordInviteCode = $row->Field('discord_invite');
		$this->discordLinkCode = $row->Field('discord_link_code');
		$this->discordGuildId = $row->Field('discord_guild_id');
		$this->discordGuildName = $row->Field('discord_guild_name');
		$this->discordChatChannelId = $row->Field('discord_chat_channel_id');
		$this->discordChatChannelName = $row->Field('discord_chat_channel_name');
		$this->isClusterGroup = $row->Field('is_cluster_group');
	}

	public static function BuildDatabaseSchema(): DatabaseSchema {
		return new DatabaseSchema(
			schema: 'sentinel',
			table: 'groups',
			definitions: [
				new DatabaseObjectProperty('groupId', ['primaryKey' => true, 'columnName' => 'group_id', 'required' => false]),
				new DatabaseObjectProperty('userId', ['columnName' => 'user_id']),
				new DatabaseObjectProperty('name', ['editable' => DatabaseObjectProperty::kEditableAlways]),
				new DatabaseObjectProperty('color', ['required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]),
				new DatabaseObjectProperty('permissions', ['required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'group_permissions.permissions']),
				new DatabaseObjectProperty('enableGroupChat', ['columnName' => 'enable_group_chat', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]),
				new DatabaseObjectProperty('discordInviteCode', ['columnName' => 'discord_invite', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]),
				new DatabaseObjectProperty('discordLinkCode', ['columnName' => 'discord_link_code', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]),
				new DatabaseObjectProperty('discordGuildId', ['columnName' => 'discord_guild_id', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]),
				new DatabaseObjectProperty('discordGuildName', ['columnName' => 'discord_guild_name', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'discord_guilds.guild_name']),
				new DatabaseObjectProperty('discordChatChannelId', ['columnName' => 'discord_chat_channel_id', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableAlways]),
				new DatabaseObjectProperty('discordChatChannelName', ['columnName' => 'discord_chat_channel_name', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever, 'accessor' => 'discord_channels.channel_name']),
				new DatabaseObjectProperty('isClusterGroup', ['columnName' => 'is_cluster_group', 'required' => false, 'editable' => DatabaseObjectProperty::kEditableNever]),
			],
			joins: [
				'INNER JOIN sentinel.group_permissions ON (groups.group_id = group_permissions.group_id AND group_permissions.user_id = %%USER_ID%%)',
				'LEFT JOIN public.discord_guilds ON (groups.discord_guild_id = discord_guilds.guild_id)',
				'LEFT JOIN public.discord_channels ON (groups.discord_chat_channel_id = discord_channels.channel_id)',
			],
		);
	}

	protected static function BuildSearchParameters(DatabaseSearchParameters $parameters, array $filters, bool $isNested): void {
		$schema = static::DatabaseSchema();
		$parameters->orderBy = $schema->Accessor('name');
		$parameters->allowAll = true;

		$parameters->AddFromFilter($schema, $filters, 'color');
		$parameters->AddFromFilter($schema, $filters, 'name', 'SEARCH');
	}

	public function jsonSerialize(): mixed {
		return [
			'groupId' => $this->groupId,
			'userId' => $this->userId,
			'name' => $this->name,
			'color' => $this->color,
			'permissions' => $this->permissions,
			'enableGroupChat' => $this->enableGroupChat,
			'discordInviteCode' => $this->discordInviteCode,
			'discordLinkCode' => $this->discordLinkCode,
			'discordGuildId' => $this->discordGuildId,
			'discordGuildName' => $this->discordGuildName,
			'discordChatChannelId' => $this->discordChatChannelId,
			'discordChatChannelName' => $this->discordChatChannelName,
			'isClusterGroup' => $this->isClusterGroup,
		];
	}

	public function GroupId(): string {
		return $this->groupId;
	}

	public function UserId(): string {
		return $this->userId;
	}

	public function Name(): string {
		return $this->name;
	}

	public function SetName(string $name): void {
		$this->SetProperty('name', $name);
	}

	public function Color(): string {
		return $this->color;
	}

	public function SetColor(string $color): void {
		$this->SetProperty('color', $color);
	}

	public function DiscordGuildId(): ?string {
		return $this->discordGuildId;
	}

	public static function SetupAuthParameters(string &$authScheme, array &$requiredScopes, bool $editable): void {
		$requiredScopes[] = Application::kScopeSentinelRead;
		if ($editable) {
			$requiredScopes[] = Application::kScopeSentinelWrite;
		}
	}

	public function GetPermissionsForUser(User $user): int {
		$permissions = static::GetSentinelPermissions($this->groupId, $user->UserId());
		if ($permissions === 0) {
			return 0;
		}

		if (($permissions & PermissionBits::EditGroup) > 0) {
			return self::kPermissionAll;
		} else {
			return self::kPermissionRead;
		}
	}

	public static function CanUserCreate(User $user, ?array &$newObjectProperties): bool {
		return true;
	}

	public static function GetSentinelPermissions(string $objectId, string $userId): int {
		if (BeaconCommon::IsUUID($objectId) === false || BeaconCommon::IsUUID($userId) === false) {
			return 0;
		}

		$database = BeaconCommon::Database();
		$rows = $database->Query('SELECT permissions FROM sentinel.group_permissions WHERE group_id = $1 AND user_id = $2;', $objectId, $userId);
		if ($rows->RecordCount() === 0) {
			return 0;
		}
		return $rows->Field('permissions');
	}
}

?>
