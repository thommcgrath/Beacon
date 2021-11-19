#!/usr/bin/python3.6
import discord, re, phonetics, Levenshtein, argparse, fcntl, sys, os, logging

class BeaconBot(discord.Client):
	logger = None;
	
	def __init__(self, logger):
		intents = discord.Intents.default()
		intents.members = True
		
		super().__init__(intents=intents)
		self.logger = logger
	
	def logMessage(self, message):
		self.logger.info(message)
	
	async def on_ready(self):
		self.logMessage('Bot is ready')
	
	async def on_member_join(self, member):
		self.logMessage(member.name + ' has joined the server');
		channel = member.dm_channel
		if channel == None:
			channel = await member.create_dm()
		await channel.send('Hi there! So I can make sure you get the best help possible, tell me, on which platform do you play Ark?')
		await channel.send('In the meantime, check out https://usebeacon.app/help for solutions to most issues.')
		
	async def on_message(self, message):
		if isinstance(message.channel, discord.DMChannel) == False:
			return
		if message.author.id == self.user.id:
			return
		
		desired_platform_name = ''
		words = message.content.lower()
		words = re.sub(r'([^\s\w]|_)+', '', words)
		words = words.split()
		metaphones = []
		for word in words:
			for word in words:
				if word == 'pc' or word == 'steam' or word == 'windows' or word == 'win':
					desired_platform_name = 'PC'
					break
				elif word == 'xbox' or word == 'xb' or word == 'xb1':
					desired_platform_name = 'Xbox'
					break
				elif word == 'ps4' or word == 'ps' or word == 'playstation':
					desired_platform_name = 'PlayStation'
					break
				else:
					metaphones.append(phonetics.metaphone(word))
		
		if desired_platform_name == '':
			pc_keywords = ['ANTS', 'PK', 'STM'];
			xbox_keywords = ['SPKS'];
			playstation_keywords = ['PLSTXN'];
			
			for left_word in metaphones:
				for right_word in pc_keywords:
					if self.doWordsMatch(left_word, right_word) == True:
						desired_platform_name = 'PC'
						break
					
				if desired_platform_name != '':
					break
					
				for right_word in xbox_keywords:
					if self.doWordsMatch(left_word, right_word) == True:
						desired_platform_name = 'Xbox'
						break
				
				if desired_platform_name != '':
					break
				
				for right_word in playstation_keywords:
					if self.doWordsMatch(left_word, right_word) == True:
						desired_platform_name = 'PlayStation'
						break
				
				if desired_platform_name != '':
					break
		
		if desired_platform_name == '':
			self.logMessage('Could not determine platform: User ' + message.author.name + ' said `' + message.content + '`')
			await message.channel.send('Sorry, I didn\'t understand which platform you meant. Try saying `PC`, `Xbox`, or `PlayStation`.')
			return
		
		num_members = 0;
		for guild in client.guilds:
			remove_roles = []
			add_roles = []
			for role in guild.roles:
				if role.name == desired_platform_name:
					add_roles.append(role)
				elif role.name == 'Xbox' or role.name == 'PC' or role.name == 'PlayStation':
					remove_roles.append(role)
			
			member = guild.get_member(message.author.id)
			if member != None:
				num_members += 1
				for role in remove_roles:
					await member.remove_roles(role)
				for role in add_roles:
					await member.add_roles(role)
		
		if num_members == 0:
			self.logMessage('Could not find member object for user ' + message.author.name + '.');
			self.logMessage('User said `' + message.content + '`');
			await message.channel.send('Sorry, I seem to be having trouble. You should contact the server admin.')
			return
		
		self.logMessage('Assigned user ' + message.author.name + ' the platform ' + desired_platform_name + ' based on message `' + message.content + '`')	
		await message.channel.send('Ok, I\'ve set your platform to {0}. If I got this wrong, just reply with `PC`, `Xbox`, or `PlayStation` and I\'ll correct it for you.'.format(desired_platform_name))
		await message.channel.send('You can now access the Beacon Discord server\'s general channel.')
			
	def doWordsMatch(self, left_word, right_word):
		if left_word == '' or right_word == '':
			return False
			
		if left_word == right_word:
			return True
		
		lev = Levenshtein.distance(left_word, right_word)
		count = max(len(left_word), len(right_word))
		return lev / count < 0.2
	
parser = argparse.ArgumentParser(description='Run the Beacon Discord bot')
parser.add_argument('token', help='The token issued by Discord for the bot')
args = parser.parse_args()

pid_file = os.path.expanduser('~/beaconbot.pid')
pid_pointer = open(pid_file, 'w')
try:
	fcntl.lockf(pid_pointer, fcntl.LOCK_EX | fcntl.LOCK_NB)
	pid_pointer.write(str(os.getpid()))
except IOError:
	sys.exit(-1)

log_file = os.path.expanduser('~/beaconbot.log')
logging.basicConfig(filename=log_file, level=logging.INFO, format='%(asctime)s %(levelname)s %(name)s %(message)s')
logger = logging.getLogger(__name__)

try:
	client = BeaconBot(logger);
	client.run(args.token)
except Exception as err:
	logger.error(err)
finally:
	fcntl.lockf(pid_pointer, fcntl.LOCK_UN)
	pid_pointer.close()
	os.unlink(pid_file)