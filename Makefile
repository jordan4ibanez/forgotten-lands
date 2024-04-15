# defaults to linux, expects you to already have made the debugging world.
default:
	@echo Transpiling Forgotten Times into lua...
	@npx tstl
	@echo Successfully built Forgotten Times.
	@echo Copying mod conf files...
	@./important_scripts/move_conf_files.sh
	@echo Successfully copied mod conf files. 
	@echo Starting Minetest.
	@minetest --go --gameid forgotten-lands --world $$HOME/.minetest/worlds/debugging

windows: 
	@echo Transpiling Forgotten Times into lua...
	@npx tstl
	@echo Successfully built Forgotten Times.
	@echo Starting Minetest.
	@../../bin/minetest.exe

linux:
	@echo Transpiling Forgotten Times into lua...
	@npx tstl
	@echo Successfully built Forgotten Times.
	@echo Copying mod conf files...
	@./important_scripts/move_conf_files.sh
	@echo Successfully copied mod conf files. 
	@echo Starting Minetest.
	@minetest --go --gameid forgotten-lands --world $$HOME/.minetest/worlds/debugging

clean:
	@echo Destroying the built game.
	@rm -rf mods/
	@echo "It's done."