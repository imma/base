ci_script = "#{ENV['BLOCK_PATH']}/limbo/script/cloud-init-bootstrap"

Vagrant.configure("2") do |config|
  config.ssh.shell = "bash"
  config.ssh.username = "ubuntu"
  config.ssh.forward_agent = true
  config.ssh.insert_key = false
  config.ssh.keys_only = false

  config.vm.provider "docker" do |v, override|
    override.vm.synced_folder '/data', '/data'
    override.vm.synced_folder '/config', '/config'

    override.ssh.guest_port = "2222"

    v.image = "docker.nih/block:#{Dir.pwd.split("/")[-1]}"
    v.has_ssh = true
    v.ports = [ ":2222" ]
    v.create_args = [ "--network", "ubuntu_default" ]
  end

  config.vm.provider "virtualbox" do |v, override|
    override.vm.box = ENV['BASEBOX_NAME_OVERRIDE'] ? ENV['BASEBOX_NAME_OVERRIDE'] : (ENV['BASEBOX_NAME'] ? ENV['BASEBOX_NAME'] : "block:ubuntu")

    override.vm.synced_folder '/data', '/data', type: "nfs"
    override.vm.synced_folder '/config', '/config', type: "nfs"

    override.vm.provision "shell", path: ci_script, args: [], privileged: true

    override.vm.network "private_network", ip: '172.28.128.10', nic_type: 'virtio'

    v.memory = 1024
    v.cpus = 2

    v.customize [ 
      'storageattach', :id, 
      '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, 
      '--type', 'dvddrive', '--medium', "#{ENV['BLOCK_PATH']}/base/cidata.vagrant.iso"
    ]
  end

  config.vm.provider "aws" do |v, override|
    override.vm.box = ENV['BASEBOX_NAME_OVERRIDE'] ? ENV['BASEBOX_NAME_OVERRIDE'] : (ENV['BASEBOX_NAME'] ? ENV['BASEBOX_NAME'] : "block:ubuntu")

    override.vm.synced_folder '/data/cache/nodist', '/data/cache/nodist', type: "rsync", rsync__args: [ "-ia" ]
    override.vm.synced_folder ENV['AWS_SYNC'], ENV['AWS_SYNC'], type: "rsync", rsync__args: [ "-ia" ] if ENV['AWS_SYNC']

    override.vm.provision "shell", path: ci_script, args: [], privileged: true

    v.ami = ENV['AWS_AMI'] || 'id-aws-ami-not-set'
  end
end
