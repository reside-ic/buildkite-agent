vault_config_file = 'vault_config'

if !File.file?(vault_config_file)
  raise "Run ./provision/vault-prepare.sh first!"
end

vault_config = Hash[File.read(vault_config_file).split("\n").
                     map{|s| s.split('=')}]

Vagrant.configure("2") do |config|
  config.vm.box = "builds/virtualbox-ubuntu1804.box"
  config.ssh.username = "vagrant"
  config.ssh.password = "vagrant"

  config.vm.provision :shell do |shell|
    shell.path = 'provision/start-agent.sh'
    shell.env = vault_config
  end
    
end
