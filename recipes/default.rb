# 
# if ssh keys are mounted in from the host, we can 
# create links to the root and vagrant user to them
# 

if ::File.exists? '/tmp/.ssh'

  %w( root vagrant ).each do |user|

    home = `echo ~#{user}`.strip

    directory "#{home}/.ssh" do
      owner user
      mode "0755"
    end
    
    file "#{home}/.ssh/authorized_keys" do
      owner user
      mode "0600"
    end

    execute "cat /tmp/.ssh/id_rsa.pub >> #{home}/.ssh/authorized_keys" do
      not_if { `cat #{home}/.ssh/authorized_keys | grep "$(cat /tmp/.ssh/id_rsa.pub)" | wc -l`.to_i != 0 }
    end

    cookbook_file "#{home}/.ssh/config" do
      owner user
      mode "0600"
    end

    link "#{home}/.ssh/id_rsa" do
      to "/tmp/.ssh/id_rsa"
    end

    link "#{home}/.ssh/id_rsa.pub" do
      to "/tmp/.ssh/id_rsa.pub"
    end

  end
  
end

