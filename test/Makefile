SRC=../cat.c ../dog.c ../common.c ../gfxc.c ../data_kernel.c ../data_alley.c ../alley_land.c ../alley_bg.c host.c gfxtab_host.c ../snd.c ../data_alleybg.c ../data_wash.c ../wash.c
libcat.so: $(SRC) ../*.h
	gcc -std=gnu2x -O1 -g -fPIC -shared -DHOST -include stdint.h -o $@ $(SRC)
