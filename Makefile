default:
	@echo Transpiling Crafter into lua...
	@tl build
	@echo Successfully built Crafter.

run: 
	@echo Transpiling Crafter into lua...
	@tl build
	@echo Successfully built Crafter.
	@echo Starting Minetest.
	@../../bin/minetest.exe