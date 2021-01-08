Config = {}

Config.AllLogs = false --Ne pas activé
Config.postal = true
Config.username = "NTH_LOGS"
Config.avatar = "https://cdn.discordapp.com/attachments/718551929416056892/770971659141382174/-2.png"
Config.communtiyName = "NightCorp"
Config.communtiyLogo = "https://cdn.discordapp.com/attachments/718551929416056892/770971060735705129/20200926_082818.png"


Config.weaponLog = true
Config.weaponLogDelay = 10000 --Ne pas touché

Config.playerID = true
Config.steamID = true
Config.steamURL = false
Config.discordID = true

--https://jokedevil.com/colorPicker
Config.joinColor = "000000"
Config.leaveColor = "000000"
Config.chatColor = "000000"
Config.shootingColor = "000000"
Config.deathColor = "000000"
Config.resourceColor = "000000"



Config.webhooks = {
	all = "",--Ne pas utillisé
	chat = "https://discordapp.com/api/webhooks/747836450221064315/q5PFVPR4zN1G1fJ-nLzzjDSrA0NrPeOdYr0LxjJvwEak1MQaML6dCGheq0fHgyWk3S6O",
	joins = "https://discordapp.com/api/webhooks/747823596356763689/PZf_qJttd8Vb549WOPnx2_n3sdLPjO-mw1XnfbCqC0B-AUecb4AgH1ARb9NK7oEeBZ3a",
	leaving = "https://discordapp.com/api/webhooks/747824707318841435/H2ON-UcQ1Ma-N70wQrOtS5Sl4sJlgCVpy7__-y0qVsHmpYvNEj3Xba89HCz8Loif9L-j",
	deaths = "https://discordapp.com/api/webhooks/747830503486521349/KMaLoztiJMBQm74JCj1tq_nHgy4uRX_IZ_bPvgsHqBwlX79qNxGw3Ca2EkxQGqznfIkc",
	shooting = "https://discordapp.com/api/webhooks/747830624261242990/iKzIthXSc48s7TStuqWNOtb6XiUyIK1w58mM43DVFePpNHKBKVIkmp_Q1n6sW7JpHebz",
	resources = "https://discordapp.com/api/webhooks/747831213464485978/3DHulGsNuvmSM_BW2EvkqGQZxhSdKckTjcHOFlTXWSUAsPUp-iXxHcMdOiLjhK9_jrdv",

	--Menu admin
	ADMIN_GIVE_MONEY = "https://discordapp.com/api/webhooks/747831353256706158/ZmLQC0lnAgrwnKuM8ykqSK1nU0j2im91EgKyBpCIRopFU8KBJr3C-l04Sqi3_1gMzmt2",
	ADMIN_GIVE_BANK = "https://discordapp.com/api/webhooks/747831630588280883/MUe9-drzZYmBdwKF6H8EqwOHq4rkHdxUZumsHToQANzS7X1-da4kjz8j8JnrYJeTg5VQ",
	ADMIN_GIVE_DIRTY = "https://discordapp.com/api/webhooks/747831732979367956/0X0T5X0m1yH9V6DhvYazQIeF19Ki8BZNkEkJqxznjs8I8gRvggvNbr2FNvJzF8pTj__n",
	ADMIN_TP_POINT = "https://discordapp.com/api/webhooks/747831843864444949/3-j988SSFUzoaomU5apWCElWGr0_8LQRnUil54B2GilSrr4gwNkGFfzjrCYv0Mydfbmv",
	ADMIN_REVIVE = "https://discordapp.com/api/webhooks/747831950315618354/pU5nlyz4XRa8T7cBBum8YvShrQvfLUl5b9-Jq-JR4MKhQuVi6tR_ZrBLEHwUvYlrgtL0",
	ADMIN_FLIP = "https://discordapp.com/api/webhooks/747832040610725938/vAANEjIhFebFPrvuolnE2UtkGVc-WBab6h3dQuL4-GUvrk6ahSDSrYR_SjD1f2gBB4p4",
	ADMIN_REPAIR = "https://discordapp.com/api/webhooks/747832170185359395/HUJG8oAZXfA0H5ntULVT5cdU86x9WzYLWjZGkk5lNqYE0icQ8ktrK8RxcCwxPbYXObQC",
	ADMIN_SPAWN = "https://discordapp.com/api/webhooks/747832256961183828/DI3b8Sqk9WwY3D9tE-4ItS5edTKvUo0HB2Vb5s3rEjjdhgxeS-DHnWjzfK1UUDL2n8wn",
	ADMIN_GHOST = "https://discordapp.com/api/webhooks/747832355103965184/EOK6aN3XOn2mxvD1iaM_8IFfrtttuw9-zu42WvcJQuykAgED9xjVyUA9uEDl6DJrAUE7",
	ADMIN_GODMODE = "https://discordapp.com/api/webhooks/747832436590772368/_jE8OkIpRU5hKO6bs4ivuce_dHDPDDQ0nToK_wPF0HDnIvvwhD0GpefpVqXBwCHcS99O",
	ADMIN_NOCLIP = "https://discordapp.com/api/webhooks/747832521495937165/G0oSA5F1PGMXj1oZLi0IMOxo6qk8eam5k77Zahv3euTCgg8WME6ELkmtSUR19A_yVQL4",
	ADMIN_TP_COORD = "https://discordapp.com/api/webhooks/747832632565432390/DkwHk8Y7FGaxLYh8iIlqbbSEmhDKJMKVn3fsEMFR1OZX2QUwtwm_gs0CzKhf0yQIahbQ",

	--MAGASIN
	BUY_MAGASIN = "https://discordapp.com/api/webhooks/747840014972354640/382dqEeZxdkGX864VPBQQX4ivjPl-6TREuXLAym_-x-ZVR2QZ7arTIBID9sd3xc12HND",

	--RAPORT D'INCIDENT
	BUG_REPORT = "https://discordapp.com/api/webhooks/770969660274245652/g9e3aLrAyClji-0810DyjDDUQm4I8ySmGzJZsk0L4INie7gDYayE6MlK8iHVv4QQomVW",
  }

Config.debug = false --Ne pas activé
