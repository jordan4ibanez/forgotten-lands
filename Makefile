# defaults to linux
default:
	@echo Transpiling Forgotten Times into lua...
	@npx tstl
	@echo Successfully built Forgotten Times.
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
	@echo Starting Minetest.
	@minetest --go --gameid forgotten-lands --world $$HOME/.minetest/worlds/debugging
