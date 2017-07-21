class Homestead

    def Homestead.custom_pre(config, settings)

        # Sort folders to keep vagrant-winnfsd happy
        settings["folders"].sort! { |a,b| a["map"].length <=> b["map"].length }

    end

    def Homestead.custom_post(config, settings)

        # Configure Local Variable To Access Scripts From Remote Location
        scriptDir = File.dirname(__FILE__)

        # cache
        if Vagrant.has_plugin?("vagrant-cachier")
            config.cache.scope = :box
        end

        # vb guest additions
        if Vagrant.has_plugin?("vagrant-vbguest")
            #config.vbguest.auto_update = false
        end

        # hostmanager
        if Vagrant.has_plugin?('vagrant-hostmanager')
            config.hostmanager.enabled           = true
            config.hostmanager.manage_host       = true
            config.hostmanager.ignore_private_ip = false
            config.hostmanager.include_offline   = true

            hosts = []
            if settings.include? 'sites'
                settings["sites"].each do |site|
                    hosts.push(site["map"])
                end
            end
            config.hostmanager.aliases = hosts
        end

        # Install Adminer if necessary
        if settings.has_key?("adminer") && settings["adminer"]
            config.vm.provision "shell" do |s|
                s.path = scriptDir + "/scripts/install-adminer.sh"
            end
        end

        # Install Mailhog if necessary
        if settings.has_key?("mailhog") && settings["mailhog"]
            config.vm.provision "shell" do |s|
                s.path = scriptDir + "/scripts/install-mailhog.sh"
            end
        end

        # message
        if settings.include? 'message'
            config.vm.post_up_message = "#{settings['message']}"
        end
    end
end
