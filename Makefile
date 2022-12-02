$(eval include ./.env)

ifndef HOST
$(info No HOST variable is defined in the .env file)
$(info See '.env.example')
$(info )
$(error No HOST specified in .env file)
endif

ifdef OFFLINE
$(info (IMPORTANT) *Building in offline mode*)
endif

test:
	nixos-rebuild --use-remote-sudo test $(OFFLINE) --flake .#$(HOST)

switch:
	nixos-rebuild --use-remote-sudo switch $(OFFLINE) --flake .#$(HOST)

