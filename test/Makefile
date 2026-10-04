SRC=../cat.c ../dog.c ../common.c ../gfxc.c ../data_kernel.c ../data_alley.c ../alley_land.c ../alley_bg.c host.c gfxtab_host.c ../snd.c ../data_alleybg.c ../data_wash.c ../wash.c
libcat.so: $(SRC) ../*.h
	gcc -std=gnu2x -O1 -g -fPIC -shared -DHOST -include stdint.h -o $@ $(SRC)

# комнаты: всё static открыто наружу (-Dstatic=), чтобы тест видел функции и переменные
ROOM_COMMON=../cat.c ../dog.c ../common.c ../gfxc.c ../data_kernel.c ../snd.c ../score.c host.c gfxtab_host.c room_host.c
ROOM_SRC0=../ovl_alley.c ../alley.c ../alley_land.c ../alley_bg.c ../wash.c ../data_alley.c ../data_alleybg.c ../data_wash.c
ROOM_SRC1=../ovl_room1.c ../room.c ../data_room.c ../data_room1.c
ROOM_SRC2=../ovl_room2.c ../data_room2.c
ROOM_SRC3=../ovl_room3.c ../room.c ../data_room.c ../data_room3.c
ROOM_SRC4=../ovl_room4.c ../room.c ../data_room.c ../data_room4.c
ROOM_SRC5=../ovl_room5.c ../room.c ../data_room.c ../data_room5.c
ROOM_SRC6=../ovl_room6.c ../room.c ../data_room.c ../data_room6.c
ROOM_SRC7=../ovl_room7.c ../bonus.c ../data_room7.c ../data_bonus.c
libroom%.so: $(ROOM_COMMON) ../*.h ../*.c
	gcc -std=gnu2x -O1 -g -fPIC -shared -DHOST -Dstatic= -fno-common -include stdint.h -o $@ $(ROOM_COMMON) $(ROOM_SRC$*)
rooms: $(foreach r,0 1 2 3 4 5 6 7,libroom$(r).so)
