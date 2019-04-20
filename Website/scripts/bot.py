#!/usr/bin/python3.6
import discord, re, phonetics, Levenshtein, argparse;

class BeaconBot(discord.Client):
	async def on_ready(self):
		print('Ready')
	
	async def on_member_join(self, member):
		channel = member.dm_channel
		if channel == None:
			channel = await member.create_dm()
		await channel.send('Hi there! So I can make sure you get the best help possible, tell me, on which platform do you play Ark?')
		await channel.send('In the meantime, check out https://beaconapp.cc/help for solutions to most issues.')
		
	async def on_message(self, message):
		if isinstance(message.channel, discord.DMChannel) == False:
			return
		if message.author.id == self.user.id:
			return
		
		words = message.content.lower()
		words = re.sub(r'([^\s\w]|_)+', '', words)
		words = words.split()
		metaphones = []
		for word in words:
			metaphones.append(phonetics.metaphone(word))
		
		desired_platform_name = ''
		pc_keywords = ['AN', 'ANTS', 'PK', 'STM'];
		xbox_keywords = ['SPKS', 'SP'];
		playstation_keywords = ['S', 'PLSTXN'];
		
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
			await message.channel.send('Sorry, I didn\'t understand which platform you meant. Try saying `PC`, `Xbox`, or `PlayStation`.')
			return
		
		for guild in client.guilds:
			remove_roles = []
			add_roles = []
			for role in guild.roles:
				if role.name == desired_platform_name:
					add_roles.append(role)
				elif role.name == 'Xbox' or role.name == 'PC' or role.name == 'PlayStation':
					remove_roles.append(role)
			
			member = guild.get_member(message.author.id)
			if member == None:
				continue
			
			for role in remove_roles:
				await member.remove_roles(role)
			for role in add_roles:
				await member.add_roles(role)
			
		await message.channel.send('Ok, I\'ve set your platform to {0}. You can now access the Beacon Discord server\'s general channel.'.format(desired_platform_name))
			
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

client = BeaconBot();
client.run(args.token)