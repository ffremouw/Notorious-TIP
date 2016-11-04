local httpservConfig = {}

-- Basic Authentication Conf
httpservConfig.auth = {}
httpservConfig.auth.enabled = true
httpservConfig.auth.realm = "Notorious TIP" -- displayed in the login dialog users get
httpservConfig.auth.user = ""
httpservConfig.auth.password = "" -- PLEASE change this

return httpservConfig
