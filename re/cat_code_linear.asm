00000000  1E                push ds
00000001  B80000            mov ax,0x0
00000004  50                push ax
00000005  E8585C            call 0x5c60
00000008  B81000            mov ax,0x10
0000000B  8ED8              mov ds,ax
0000000D  E89A13            call 0x13aa
00000010  C606900604        mov byte [0x690],0x4
00000015  C706F86D0000      mov word [0x6df8],0x0
0000001B  C6069B0600        mov byte [0x69b],0x0
00000020  E8F613            call 0x1419
00000023  E8C213            call 0x13e8
00000026  A19306            mov ax,[0x693]
00000029  054002            add ax,0x240
0000002C  A3006E            mov [0x6e00],ax
0000002F  B80400            mov ax,0x4
00000032  CD10              int 0x10
00000034  B004              mov al,0x4
00000036  803E9706FD        cmp byte [0x697],0xfd
0000003B  7402              jz 0x3f
0000003D  B006              mov al,0x6
0000003F  A29006            mov [0x690],al
00000042  B40B              mov ah,0xb
00000044  BB0101            mov bx,0x101
00000047  CD10              int 0x10
00000049  C70616040000      mov word [0x416],0x0
0000004F  C70604000000      mov word [0x4],0x0
00000055  E8D91C            call 0x1d31
00000058  803E9706FD        cmp byte [0x697],0xfd
0000005D  7406              jz 0x65
0000005F  BAD903            mov dx,0x3d9
00000062  B020              mov al,0x20
00000064  EE                out dx,al
00000065  E8A82D            call 0x2e10
00000068  E87626            call 0x26e1
0000006B  E86C26            call 0x26da
0000006E  C6061A0400        mov byte [0x41a],0x0
00000073  B8FFFF            mov ax,0xffff
00000076  A31D04            mov [0x41d],ax
00000079  A31F04            mov [0x41f],ax
0000007C  C6060000FF        mov byte [0x0],0xff
00000081  E80C26            call 0x2690
00000084  C70608000000      mov word [0x8],0x0
0000008A  C70604000000      mov word [0x4],0x0
00000090  E89E1C            call 0x1d31
00000093  E88B5A            call 0x5b21
00000096  E8175C            call 0x5cb0
00000099  E8855A            call 0x5b21
0000009C  803E1A0400        cmp byte [0x41a],0x0
000000A1  750B              jnz 0xae
000000A3  E87B5A            call 0x5b21
000000A6  E83C5E            call 0x5ee5
000000A9  C6061A0401        mov byte [0x41a],0x1
000000AE  A1F86D            mov ax,[0x6df8]
000000B1  A30800            mov [0x8],ax
000000B4  C606801F03        mov byte [0x1f80],0x3
000000B9  E81E26            call 0x26da
000000BC  C70604000000      mov word [0x4],0x0
000000C2  E86C1C            call 0x1d31
000000C5  E8595A            call 0x5b21
000000C8  C706301C0000      mov word [0x1c30],0x0
000000CE  2AE4              sub ah,ah
000000D0  CD1A              int 0x1a
000000D2  89161204          mov [0x412],dx
000000D6  C70614040000      mov word [0x414],0x0
000000DC  C606180400        mov byte [0x418],0x0
000000E1  C606190400        mov byte [0x419],0x0
000000E6  C6061C0400        mov byte [0x41c],0x0
000000EB  C6061B0400        mov byte [0x41b],0x0
000000F0  E82E5A            call 0x5b21
000000F3  803E801F00        cmp byte [0x1f80],0x0
000000F8  7487              jz 0x81
000000FA  803E1B0400        cmp byte [0x41b],0x0
000000FF  75AD              jnz 0xae
00000101  803E1C0400        cmp byte [0x41c],0x0
00000106  759B              jnz 0xa3
00000108  E8F528            call 0x2a00
0000010B  E8F252            call 0x5400
0000010E  C606811FFF        mov byte [0x1f81],0xff
00000113  E80B5A            call 0x5b21
00000116  C70604000000      mov word [0x4],0x0
0000011C  803E190400        cmp byte [0x419],0x0
00000121  7414              jz 0x137
00000123  E87B06            call 0x7a1
00000126  C606500502        mov byte [0x550],0x2
0000012B  C606760501        mov byte [0x576],0x1
00000130  C606780520        mov byte [0x578],0x20
00000135  EB09              jmp short 0x140
00000137  C70679050000      mov word [0x579],0x0
0000013D  E8CD05            call 0x70d
00000140  E8FD1C            call 0x1e40
00000143  E8EA16            call 0x1830
00000146  E8C720            call 0x2210
00000149  E8E421            call 0x2330
0000014C  E8A325            call 0x26f2
0000014F  E8AA25            call 0x26fc
00000152  E86857            call 0x58bd
00000155  803E801F00        cmp byte [0x1f80],0x0
0000015A  7503              jnz 0x15f
0000015C  E922FF            jmp 0x81
0000015F  E8D611            call 0x1338
00000162  803E1C0400        cmp byte [0x41c],0x0
00000167  7403              jz 0x16c
00000169  E937FF            jmp 0xa3
0000016C  803E1B0400        cmp byte [0x41b],0x0
00000171  7403              jz 0x176
00000173  E938FF            jmp 0xae
00000176  E88710            call 0x1200
00000179  E86907            call 0x8e5
0000017C  E8E41C            call 0x1e63
0000017F  803EB81C00        cmp byte [0x1cb8],0x0
00000184  750B              jnz 0x191
00000186  FE060F04          inc byte [0x40f]
0000018A  F6060F0403        test byte [0x40f],0x3
0000018F  75C4              jnz 0x155
00000191  E8D952            call 0x546d
00000194  E80903            call 0x4a0
00000197  E89C17            call 0x1936
0000019A  E8AE16            call 0x184b
0000019D  E87620            call 0x2216
000001A0  E8D821            call 0x237b
000001A3  E80D25            call 0x26b3
000001A6  803E510500        cmp byte [0x551],0x0
000001AB  74A8              jz 0x155
000001AD  803E801F00        cmp byte [0x1f80],0x0
000001B2  7503              jnz 0x1b7
000001B4  E9CAFE            jmp 0x81
000001B7  2AE4              sub ah,ah
000001B9  CD1A              int 0x1a
000001BB  89161004          mov [0x410],dx
000001BF  A17905            mov ax,[0x579]
000001C2  A30100            mov [0x1],ax
000001C5  A07B05            mov al,[0x57b]
000001C8  A20300            mov [0x3],al
000001CB  C606190401        mov byte [0x419],0x1
000001D0  803E180400        cmp byte [0x418],0x0
000001D5  740E              jz 0x1e5
000001D7  C606180400        mov byte [0x418],0x0
000001DC  C70604000700      mov word [0x4],0x7
000001E2  EB54              jmp short 0x238
000001E4  90                nop
000001E5  E8152C            call 0x2dfd
000001E8  F6C2A0            test dl,0xa0
000001EB  741D              jz 0x20a
000001ED  8B1E0800          mov bx,[0x8]
000001F1  81E30300          and bx,0x3
000001F5  83FB03            cmp bx,byte +0x3
000001F8  7410              jz 0x20a
000001FA  B102              mov cl,0x2
000001FC  D3E3              shl bx,cl
000001FE  81E20300          and dx,0x3
00000202  03DA              add bx,dx
00000204  8A872104          mov al,[bx+0x421]
00000208  EB12              jmp short 0x21c
0000020A  E8F02B            call 0x2dfd
0000020D  81E20700          and dx,0x7
00000211  83FA05            cmp dx,byte +0x5
00000214  73F4              jnc 0x20a
00000216  8BDA              mov bx,dx
00000218  8A872D04          mov al,[bx+0x42d]
0000021C  2AE4              sub ah,ah
0000021E  3B061D04          cmp ax,[0x41d]
00000222  7506              jnz 0x22a
00000224  3B061F04          cmp ax,[0x41f]
00000228  74BB              jz 0x1e5
0000022A  A30400            mov [0x4],ax
0000022D  8B0E1D04          mov cx,[0x41d]
00000231  890E1F04          mov [0x41f],cx
00000235  A31D04            mov [0x41d],ax
00000238  C70606000000      mov word [0x6],0x0
0000023E  8B1E0400          mov bx,[0x4]
00000242  83FB07            cmp bx,byte +0x7
00000245  7602              jna 0x249
00000247  2BDB              sub bx,bx
00000249  D1E3              shl bx,1
0000024B  2EFFA75002        jmp [cs:bx+0x250]
00000250  E203              loop 0x255
00000252  E203              loop 0x257
00000254  59                pop cx
00000255  0494              add al,0x94
00000257  034903            add cx,[bx+di+0x3]
0000025A  FE02              inc byte [bp+si]
0000025C  AA                stosb
0000025D  026002            add ah,[bx+si+0x2]
00000260  C70604000700      mov word [0x4],0x7
00000266  E88719            call 0x1bf0
00000269  E82425            call 0x2790
0000026C  E83205            call 0x7a1
0000026F  E8CE1B            call 0x1e40
00000272  E89031            call 0x3405
00000275  E8885E            call 0x6100
00000278  E8DE4C            call 0x4f59
0000027B  E83F56            call 0x58bd
0000027E  E8B710            call 0x1338
00000281  E87C0F            call 0x1200
00000284  E8E651            call 0x546d
00000287  E85B06            call 0x8e5
0000028A  E8795E            call 0x6106
0000028D  E8D62C            call 0x2f66
00000290  E8CD2B            call 0x2e60
00000293  E87A49            call 0x4c10
00000296  A05105            mov al,[0x551]
00000299  0A065305          or al,[0x553]
0000029D  0A061C04          or al,[0x41c]
000002A1  0A061B04          or al,[0x41b]
000002A5  74D7              jz 0x27e
000002A7  E97D01            jmp 0x427
000002AA  C70604000600      mov word [0x4],0x6
000002B0  E83D19            call 0x1bf0
000002B3  E8DA24            call 0x2790
000002B6  E84749            call 0x4c00
000002B9  E8E504            call 0x7a1
000002BC  E84631            call 0x3405
000002BF  E87E1B            call 0x1e40
000002C2  E8F855            call 0x58bd
000002C5  E87010            call 0x1338
000002C8  E8350F            call 0x1200
000002CB  E89F51            call 0x546d
000002CE  E87246            call 0x4943
000002D1  E80245            call 0x47d6
000002D4  E80E06            call 0x8e5
000002D7  803EB81C00        cmp byte [0x1cb8],0x0
000002DC  7405              jz 0x2e3
000002DE  E8821B            call 0x1e63
000002E1  EB03              jmp short 0x2e6
000002E3  E86A2E            call 0x3150
000002E6  A05105            mov al,[0x551]
000002E9  0A065205          or al,[0x552]
000002ED  0A065305          or al,[0x553]
000002F1  0A061B04          or al,[0x41b]
000002F5  0A061C04          or al,[0x41c]
000002F9  74CA              jz 0x2c5
000002FB  E92901            jmp 0x427
000002FE  C70604000500      mov word [0x4],0x5
00000304  E8E918            call 0x1bf0
00000307  E88624            call 0x2790
0000030A  E86D42            call 0x457a
0000030D  E89104            call 0x7a1
00000310  E8F230            call 0x3405
00000313  E82A1B            call 0x1e40
00000316  E8A455            call 0x58bd
00000319  E81C10            call 0x1338
0000031C  E8E10E            call 0x1200
0000031F  E84B51            call 0x546d
00000322  E88642            call 0x45ab
00000325  E81840            call 0x4340
00000328  E8BA05            call 0x8e5
0000032B  E8222E            call 0x3150
0000032E  E8321B            call 0x1e63
00000331  A05205            mov al,[0x552]
00000334  0A065305          or al,[0x553]
00000338  0A065105          or al,[0x551]
0000033C  0A061C04          or al,[0x41c]
00000340  0A061B04          or al,[0x41b]
00000344  74D3              jz 0x319
00000346  E9DE00            jmp 0x427
00000349  C70604000400      mov word [0x4],0x4
0000034F  E89E18            call 0x1bf0
00000352  E83B24            call 0x2790
00000355  E84904            call 0x7a1
00000358  E8AA30            call 0x3405
0000035B  E8E21A            call 0x1e40
0000035E  E82F3D            call 0x4090
00000361  E85955            call 0x58bd
00000364  E8D10F            call 0x1338
00000367  E8960E            call 0x1200
0000036A  E80051            call 0x546d
0000036D  E87505            call 0x8e5
00000370  E81D3B            call 0x3e90
00000373  E84C3D            call 0x40c2
00000376  E8D72D            call 0x3150
00000379  E8E71A            call 0x1e63
0000037C  A05205            mov al,[0x552]
0000037F  0A065305          or al,[0x553]
00000383  0A065105          or al,[0x551]
00000387  0A061C04          or al,[0x41c]
0000038B  0A061B04          or al,[0x41b]
0000038F  74D3              jz 0x364
00000391  E99300            jmp 0x427
00000394  C70604000300      mov word [0x4],0x3
0000039A  E85318            call 0x1bf0
0000039D  E8F023            call 0x2790
000003A0  E8FE03            call 0x7a1
000003A3  E85F30            call 0x3405
000003A6  E8971A            call 0x1e40
000003A9  E88437            call 0x3b30
000003AC  E8E138            call 0x3c90
000003AF  E80B55            call 0x58bd
000003B2  E8830F            call 0x1338
000003B5  E8480E            call 0x1200
000003B8  E8B250            call 0x546d
000003BB  E82705            call 0x8e5
000003BE  E8F038            call 0x3cb1
000003C1  E87E37            call 0x3b42
000003C4  E8892D            call 0x3150
000003C7  E8991A            call 0x1e63
000003CA  A05205            mov al,[0x552]
000003CD  0A065305          or al,[0x553]
000003D1  0A065105          or al,[0x551]
000003D5  0A061C04          or al,[0x41c]
000003D9  0A061B04          or al,[0x41b]
000003DD  74D3              jz 0x3b2
000003DF  EB46              jmp short 0x427
000003E1  90                nop
000003E2  C70604000100      mov word [0x4],0x1
000003E8  E80518            call 0x1bf0
000003EB  E8A223            call 0x2790
000003EE  E8B003            call 0x7a1
000003F1  E81130            call 0x3405
000003F4  E8491A            call 0x1e40
000003F7  E8C354            call 0x58bd
000003FA  E83B0F            call 0x1338
000003FD  E8000E            call 0x1200
00000400  E86A50            call 0x546d
00000403  E8DF04            call 0x8e5
00000406  E8472D            call 0x3150
00000409  E8571A            call 0x1e63
0000040C  E84134            call 0x3850
0000040F  803E540500        cmp byte [0x554],0x0
00000414  7543              jnz 0x459
00000416  A05205            mov al,[0x552]
00000419  0A065105          or al,[0x551]
0000041D  0A061B04          or al,[0x41b]
00000421  0A061C04          or al,[0x41c]
00000425  74D3              jz 0x3fa
00000427  803E1B0400        cmp byte [0x41b],0x0
0000042C  7403              jz 0x431
0000042E  E97DFC            jmp 0xae
00000431  803E1C0400        cmp byte [0x41c],0x0
00000436  7403              jz 0x43b
00000438  E968FC            jmp 0xa3
0000043B  803E520500        cmp byte [0x552],0x0
00000440  7405              jz 0x447
00000442  C606190400        mov byte [0x419],0x0
00000447  A10400            mov ax,[0x4]
0000044A  A30600            mov [0x6],ax
0000044D  C70604000000      mov word [0x4],0x0
00000453  E89A17            call 0x1bf0
00000456  E99AFC            jmp 0xf3
00000459  C70604000200      mov word [0x4],0x2
0000045F  E88E17            call 0x1bf0
00000462  E82B23            call 0x2790
00000465  E86131            call 0x35c9
00000468  E83603            call 0x7a1
0000046B  C606BF1C00        mov byte [0x1cbf],0x0
00000470  C606B81C00        mov byte [0x1cb8],0x0
00000475  E84554            call 0x58bd
00000478  E8BD0E            call 0x1338
0000047B  E8820D            call 0x1200
0000047E  E8EC4F            call 0x546d
00000481  E86104            call 0x8e5
00000484  E8EE31            call 0x3675
00000487  E85B33            call 0x37e5
0000048A  A05205            mov al,[0x552]
0000048D  0A065305          or al,[0x553]
00000491  0A061C04          or al,[0x41c]
00000495  0A061B04          or al,[0x41b]
00000499  74DD              jz 0x478
0000049B  EB8A              jmp short 0x427
0000049D  0000              add [bx+si],al
0000049F  00FE              add dh,bh
000004A1  0E                push cs
000004A2  3105              xor [di],ax
000004A4  7401              jz 0x4a7
000004A6  C3                ret
000004A7  FE063105          inc byte [0x531]
000004AB  E82A0F            call 0x13d8
000004AE  75F6              jnz 0x4a6
000004B0  803E5A0500        cmp byte [0x55a],0x0
000004B5  75EF              jnz 0x4a6
000004B7  803E731600        cmp byte [0x1673],0x0
000004BC  75E8              jnz 0x4a6
000004BE  2AE4              sub ah,ah
000004C0  CD1A              int 0x1a
000004C2  3B164405          cmp dx,[0x544]
000004C6  74DE              jz 0x4a6
000004C8  89164405          mov [0x544],dx
000004CC  8B1E0800          mov bx,[0x8]
000004D0  8A873205          mov al,[bx+0x532]
000004D4  803E7B0560        cmp byte [0x57b],0x60
000004D9  7704              ja 0x4df
000004DB  D0E8              shr al,1
000004DD  D0E8              shr al,1
000004DF  A23105            mov [0x531],al
000004E2  8B1E2F05          mov bx,[0x52f]
000004E6  E86F01            call 0x658
000004E9  7421              jz 0x50c
000004EB  A02505            mov al,[0x525]
000004EE  02872905          add al,[bx+0x529]
000004F2  3C04              cmp al,0x4
000004F4  72B0              jc 0x4a6
000004F6  E80429            call 0x2dfd
000004F9  80E203            and dl,0x3
000004FC  3A162F05          cmp dl,[0x52f]
00000500  74F4              jz 0x4f6
00000502  80FA03            cmp dl,0x3
00000505  74EF              jz 0x4f6
00000507  8ADA              mov bl,dl
00000509  EB2A              jmp short 0x535
0000050B  90                nop
0000050C  8A872905          mov al,[bx+0x529]
00000510  00062505          add [0x525],al
00000514  803E250504        cmp byte [0x525],0x4
00000519  7268              jc 0x583
0000051B  E8DF28            call 0x2dfd
0000051E  80FA40            cmp dl,0x40
00000521  7716              ja 0x539
00000523  E8D728            call 0x2dfd
00000526  80E203            and dl,0x3
00000529  80FA03            cmp dl,0x3
0000052C  74F5              jz 0x523
0000052E  8ADA              mov bl,dl
00000530  E82501            call 0x658
00000533  75EE              jnz 0x523
00000535  891E2F05          mov [0x52f],bx
00000539  8A872605          mov al,[bx+0x526]
0000053D  A22505            mov [0x525],al
00000540  B81000            mov ax,0x10
00000543  8EC0              mov es,ax
00000545  BFD704            mov di,0x4d7
00000548  8AA72C05          mov ah,[bx+0x52c]
0000054C  8B1E0800          mov bx,[0x8]
00000550  8A9FBA2A          mov bl,[bx+0x2aba]
00000554  8AFC              mov bh,ah
00000556  E82401            call 0x67d
00000559  833E2F0501        cmp word [0x52f],byte +0x1
0000055E  740E              jz 0x56e
00000560  D02E4005          shr byte [0x540],1
00000564  E8CC00            call 0x633
00000567  D02E4005          shr byte [0x540],1
0000056B  EB0F              jmp short 0x57c
0000056D  90                nop
0000056E  A04005            mov al,[0x540]
00000571  D0E8              shr al,1
00000573  D0E8              shr al,1
00000575  E8BB00            call 0x633
00000578  D02E4005          shr byte [0x540],1
0000057C  E8B400            call 0x633
0000057F  8B1E2F05          mov bx,[0x52f]
00000583  803ED60400        cmp byte [0x4d6],0x0
00000588  7446              jz 0x5d0
0000058A  A17905            mov ax,[0x579]
0000058D  80FB01            cmp bl,0x1
00000590  742D              jz 0x5bf
00000592  FF065F05          inc word [0x55f]
00000596  050400            add ax,0x4
00000599  3D2301            cmp ax,0x123
0000059C  722F              jc 0x5cd
0000059E  C6065B0511        mov byte [0x55b],0x11
000005A3  C606710501        mov byte [0x571],0x1
000005A8  C606760501        mov byte [0x576],0x1
000005AD  C606780518        mov byte [0x578],0x18
000005B2  C606720501        mov byte [0x572],0x1
000005B7  C6065C0500        mov byte [0x55c],0x0
000005BC  EB12              jmp short 0x5d0
000005BE  90                nop
000005BF  FF0E5F05          dec word [0x55f]
000005C3  2D0400            sub ax,0x4
000005C6  72D6              jc 0x59e
000005C8  3D0800            cmp ax,0x8
000005CB  72D1              jc 0x59e
000005CD  A37905            mov [0x579],ax
000005D0  1E                push ds
000005D1  D1E3              shl bx,1
000005D3  8B871D05          mov ax,[bx+0x51d]
000005D7  A32305            mov [0x523],ax
000005DA  8BB71705          mov si,[bx+0x517]
000005DE  B800B8            mov ax,0xb800
000005E1  8ED8              mov ds,ax
000005E3  8EC0              mov es,ax
000005E5  8BFE              mov di,si
000005E7  83FB02            cmp bx,byte +0x2
000005EA  7505              jnz 0x5f1
000005EC  FC                cld
000005ED  4F                dec di
000005EE  EB03              jmp short 0x5f3
000005F0  90                nop
000005F1  FD                std
000005F2  47                inc di
000005F3  B97F02            mov cx,0x27f
000005F6  57                push di
000005F7  56                push si
000005F8  F3A4              rep movsb
000005FA  5E                pop si
000005FB  5F                pop di
000005FC  81C60020          add si,0x2000
00000600  81C70020          add di,0x2000
00000604  B98002            mov cx,0x280
00000607  F3A4              rep movsb
00000609  1F                pop ds
0000060A  8B3E2305          mov di,[0x523]
0000060E  8A1E2505          mov bl,[0x525]
00000612  2AFF              sub bh,bh
00000614  81C3D704          add bx,0x4d7
00000618  B91000            mov cx,0x10
0000061B  8A07              mov al,[bx]
0000061D  268805            mov [es:di],al
00000620  83C304            add bx,byte +0x4
00000623  81F70020          xor di,0x2000
00000627  F7C70020          test di,0x2000
0000062B  7503              jnz 0x630
0000062D  83C750            add di,byte +0x50
00000630  E2E9              loop 0x61b
00000632  C3                ret
00000633  9F                lahf
00000634  8B1E2F05          mov bx,[0x52f]
00000638  8A9F4105          mov bl,[bx+0x541]
0000063C  B90500            mov cx,0x5
0000063F  80FB09            cmp bl,0x9
00000642  740A              jz 0x64e
00000644  9E                sahf
00000645  D09F1610          rcr byte [bx+0x1016],1
00000649  9F                lahf
0000064A  43                inc bx
0000064B  E2F7              loop 0x644
0000064D  C3                ret
0000064E  9E                sahf
0000064F  D0971610          rcl byte [bx+0x1016],1
00000653  9F                lahf
00000654  4B                dec bx
00000655  E2F7              loop 0x64e
00000657  C3                ret
00000658  C606D60400        mov byte [0x4d6],0x0
0000065D  A07C05            mov al,[0x57c]
00000660  3A873D05          cmp al,[bx+0x53d]
00000664  7213              jc 0x679
00000666  3A873A05          cmp al,[bx+0x53a]
0000066A  730D              jnc 0x679
0000066C  803E5C0501        cmp byte [0x55c],0x1
00000671  7301              jnc 0x674
00000673  C3                ret
00000674  C606D60401        mov byte [0x4d6],0x1
00000679  3AC0              cmp al,al
0000067B  C3                ret
0000067C  C3                ret
0000067D  C606400500        mov byte [0x540],0x0
00000682  FC                cld
00000683  B92000            mov cx,0x20
00000686  B8AAAA            mov ax,0xaaaa
00000689  F3AB              rep stosw
0000068B  83EF40            sub di,byte +0x40
0000068E  B84444            mov ax,0x4444
00000691  26894504          mov [es:di+0x4],ax
00000695  26894506          mov [es:di+0x6],ax
00000699  E86127            call 0x2dfd
0000069C  3AD3              cmp dl,bl
0000069E  7204              jc 0x6a4
000006A0  3AF7              cmp dh,bh
000006A2  7701              ja 0x6a5
000006A4  C3                ret
000006A5  E85527            call 0x2dfd
000006A8  80FA18            cmp dl,0x18
000006AB  721A              jc 0x6c7
000006AD  80FA60            cmp dl,0x60
000006B0  721E              jc 0x6d0
000006B2  57                push di
000006B3  E82800            call 0x6de
000006B6  D0E0              shl al,1
000006B8  A24005            mov [0x540],al
000006BB  5F                pop di
000006BC  83C702            add di,byte +0x2
000006BF  E81C00            call 0x6de
000006C2  08064005          or [0x540],al
000006C6  C3                ret
000006C7  B92000            mov cx,0x20
000006CA  BE9004            mov si,0x490
000006CD  EB07              jmp short 0x6d6
000006CF  90                nop
000006D0  B91000            mov cx,0x10
000006D3  BE6004            mov si,0x460
000006D6  F3A5              rep movsw
000006D8  C606400503        mov byte [0x540],0x3
000006DD  C3                ret
000006DE  E81C27            call 0x2dfd
000006E1  81E20600          and dx,0x6
000006E5  80FA06            cmp dl,0x6
000006E8  7503              jnz 0x6ed
000006EA  2AC0              sub al,al
000006EC  C3                ret
000006ED  8BDA              mov bx,dx
000006EF  8BB7D004          mov si,[bx+0x4d0]
000006F3  B90800            mov cx,0x8
000006F6  AD                lodsw
000006F7  AB                stosw
000006F8  83C702            add di,byte +0x2
000006FB  E2F9              loop 0x6f6
000006FD  B001              mov al,0x1
000006FF  C3                ret
00000700  C7067D050000      mov word [0x57d],0x0
00000706  C70684060000      mov word [0x684],0x0
0000070C  C3                ret
0000070D  B90000            mov cx,0x0
00000710  B401              mov ah,0x1
00000712  813E7905A000      cmp word [0x579],0xa0
00000718  7205              jc 0x71f
0000071A  B92801            mov cx,0x128
0000071D  B4FF              mov ah,0xff
0000071F  88266E05          mov [0x56e],ah
00000723  C606580503        mov byte [0x558],0x3
00000728  C60659050C        mov byte [0x559],0xc
0000072D  B2B4              mov dl,0xb4
0000072F  890E7905          mov [0x579],cx
00000733  88167B05          mov [0x57b],dl
00000737  C6067C05E6        mov byte [0x57c],0xe6
0000073C  E87125            call 0x2cb0
0000073F  A35F05            mov [0x55f],ax
00000742  C7066105030B      mov word [0x561],0xb03
00000748  E8D909            call 0x1124
0000074B  C606710500        mov byte [0x571],0x0
00000750  C70672050200      mov word [0x572],0x2
00000756  C606760501        mov byte [0x576],0x1
0000075B  C6065B0500        mov byte [0x55b],0x0
00000760  C606500500        mov byte [0x550],0x0
00000765  C6065C0500        mov byte [0x55c],0x0
0000076A  C6065A0500        mov byte [0x55a],0x0
0000076F  C606830500        mov byte [0x583],0x0
00000774  C606980600        mov byte [0x698],0x0
00000779  C606990600        mov byte [0x699],0x0
0000077E  C606510500        mov byte [0x551],0x0
00000783  C606840500        mov byte [0x584],0x0
00000788  C606520500        mov byte [0x552],0x0
0000078D  C70654050000      mov word [0x554],0x0
00000793  C606530500        mov byte [0x553],0x0
00000798  C6067C1200        mov byte [0x127c],0x0
0000079D  E860FF            call 0x700
000007A0  C3                ret
000007A1  8B1E0400          mov bx,[0x4]
000007A5  83FB00            cmp bx,byte +0x0
000007A8  750B              jnz 0x7b5
000007AA  8B0E0100          mov cx,[0x1]
000007AE  8A160300          mov dl,[0x3]
000007B2  EB0B              jmp short 0x7bf
000007B4  90                nop
000007B5  8A97E905          mov dl,[bx+0x5e9]
000007B9  D0E3              shl bl,1
000007BB  8B8FD905          mov cx,[bx+0x5d9]
000007BF  890E7905          mov [0x579],cx
000007C3  88167B05          mov [0x57b],dl
000007C7  8AC2              mov al,dl
000007C9  0432              add al,0x32
000007CB  A27C05            mov [0x57c],al
000007CE  E8DF24            call 0x2cb0
000007D1  A35F05            mov [0x55f],ax
000007D4  A1B20F            mov ax,[0xfb2]
000007D7  A36905            mov [0x569],ax
000007DA  A1BE0F            mov ax,[0xfbe]
000007DD  A36705            mov [0x567],ax
000007E0  A36105            mov [0x561],ax
000007E3  E83E09            call 0x1124
000007E6  C606710501        mov byte [0x571],0x1
000007EB  C6066E0500        mov byte [0x56e],0x0
000007F0  C606760501        mov byte [0x576],0x1
000007F5  C606780540        mov byte [0x578],0x40
000007FA  B00A              mov al,0xa
000007FC  833E040007        cmp word [0x4],byte +0x7
00000801  7502              jnz 0x805
00000803  2AC0              sub al,al
00000805  A25B05            mov [0x55b],al
00000808  C606500500        mov byte [0x550],0x0
0000080D  C6065C0500        mov byte [0x55c],0x0
00000812  C6065A0500        mov byte [0x55a],0x0
00000817  C606830500        mov byte [0x583],0x0
0000081C  C606980600        mov byte [0x698],0x0
00000821  C606990600        mov byte [0x699],0x0
00000826  C606510500        mov byte [0x551],0x0
0000082B  C606840500        mov byte [0x584],0x0
00000830  C606520500        mov byte [0x552],0x0
00000835  C70654050000      mov word [0x554],0x0
0000083B  C606530500        mov byte [0x553],0x0
00000840  C6067C1200        mov byte [0x127c],0x0
00000845  E8B8FE            call 0x700
00000848  833E040002        cmp word [0x4],byte +0x2
0000084D  7522              jnz 0x871
0000084F  C606760510        mov byte [0x576],0x10
00000854  C70674051000      mov word [0x574],0x10
0000085A  2AE4              sub ah,ah
0000085C  CD1A              int 0x1a
0000085E  8916F105          mov [0x5f1],dx
00000862  C606F30500        mov byte [0x5f3],0x0
00000867  C606F40505        mov byte [0x5f4],0x5
0000086C  C606F50501        mov byte [0x5f5],0x1
00000871  C3                ret
00000872  C7062A590004      mov word [0x592a],0x400
00000878  803E840500        cmp byte [0x584],0x0
0000087D  7401              jz 0x880
0000087F  C3                ret
00000880  C606760508        mov byte [0x576],0x8
00000885  B2FF              mov dl,0xff
00000887  A07B05            mov al,[0x57b]
0000088A  3A065226          cmp al,[0x2652]
0000088E  7302              jnc 0x892
00000890  B201              mov dl,0x1
00000892  88167105          mov [0x571],dl
00000896  A17905            mov ax,[0x579]
00000899  2B065026          sub ax,[0x2650]
0000089D  B2FF              mov dl,0xff
0000089F  7704              ja 0x8a5
000008A1  B201              mov dl,0x1
000008A3  F7D0              not ax
000008A5  88166E05          mov [0x56e],dl
000008A9  80FC00            cmp ah,0x0
000008AC  7403              jz 0x8b1
000008AE  B8FF00            mov ax,0xff
000008B1  F6D0              not al
000008B3  3C30              cmp al,0x30
000008B5  7302              jnc 0x8b9
000008B7  B030              mov al,0x30
000008B9  8AD8              mov bl,al
000008BB  D0EB              shr bl,1
000008BD  D0EB              shr bl,1
000008BF  2AC3              sub al,bl
000008C1  A27805            mov [0x578],al
000008C4  B105              mov cl,0x5
000008C6  D2E8              shr al,cl
000008C8  A37205            mov [0x572],ax
000008CB  C6065C0500        mov byte [0x55c],0x0
000008D0  C606E03900        mov byte [0x39e0],0x0
000008D5  C606770501        mov byte [0x577],0x1
000008DA  C6065B0510        mov byte [0x55b],0x10
000008DF  C606840501        mov byte [0x584],0x1
000008E4  C3                ret
000008E5  2AE4              sub ah,ah
000008E7  CD1A              int 0x1a
000008E9  3B167D05          cmp dx,[0x57d]
000008ED  750E              jnz 0x8fd
000008EF  833E840600        cmp word [0x684],byte +0x0
000008F4  7406              jz 0x8fc
000008F6  FF0E8406          dec word [0x684]
000008FA  7410              jz 0x90c
000008FC  C3                ret
000008FD  B82000            mov ax,0x20
00000900  803E9706FD        cmp byte [0x697],0xfd
00000905  7502              jnz 0x909
00000907  D1E8              shr ax,1
00000909  A38406            mov [0x684],ax
0000090C  833E040002        cmp word [0x4],byte +0x2
00000911  740A              jz 0x91d
00000913  8A0E7105          mov cl,[0x571]
00000917  0A0E6E05          or cl,[0x56e]
0000091B  7509              jnz 0x926
0000091D  52                push dx
0000091E  50                push ax
0000091F  E8B60A            call 0x13d8
00000922  58                pop ax
00000923  5A                pop dx
00000924  74D6              jz 0x8fc
00000926  89167D05          mov [0x57d],dx
0000092A  A37F05            mov [0x57f],ax
0000092D  833E040004        cmp word [0x4],byte +0x4
00000932  7507              jnz 0x93b
00000934  803EE13900        cmp byte [0x39e1],0x0
00000939  75C1              jnz 0x8fc
0000093B  833E040006        cmp word [0x4],byte +0x6
00000940  7507              jnz 0x949
00000942  803EBD4400        cmp byte [0x44bd],0x0
00000947  75B3              jnz 0x8fc
00000949  833E040002        cmp word [0x4],byte +0x2
0000094E  7403              jz 0x953
00000950  E95902            jmp 0xbac
00000953  8B360800          mov si,[0x8]
00000957  D1E6              shl si,1
00000959  A17D05            mov ax,[0x57d]
0000095C  2B06F105          sub ax,[0x5f1]
00000960  3B848905          cmp ax,[si+0x589]
00000964  7270              jc 0x9d6
00000966  3B849905          cmp ax,[si+0x599]
0000096A  7205              jc 0x971
0000096C  C606520501        mov byte [0x552],0x1
00000971  FE0EF505          dec byte [0x5f5]
00000975  7542              jnz 0x9b9
00000977  E80550            call 0x597f
0000097A  C606F50506        mov byte [0x5f5],0x6
0000097F  A0F405            mov al,[0x5f4]
00000982  803E7B05B3        cmp byte [0x57b],0xb3
00000987  7209              jc 0x992
00000989  3CC8              cmp al,0xc8
0000098B  7305              jnc 0x992
0000098D  041E              add al,0x1e
0000098F  A2F405            mov [0x5f4],al
00000992  8A167B05          mov dl,[0x57b]
00000996  2AD0              sub dl,al
00000998  7302              jnc 0x99c
0000099A  2AD2              sub dl,dl
0000099C  8B0E7905          mov cx,[0x579]
000009A0  80E2F8            and dl,0xf8
000009A3  E80A23            call 0x2cb0
000009A6  8BF8              mov di,ax
000009A8  BE4E06            mov si,0x64e
000009AB  B800B8            mov ax,0xb800
000009AE  8EC0              mov es,ax
000009B0  BD0E00            mov bp,0xe
000009B3  B90305            mov cx,0x503
000009B6  E87C23            call 0x2d35
000009B9  C6066E0500        mov byte [0x56e],0x0
000009BE  C606710501        mov byte [0x571],0x1
000009C3  C606F30501        mov byte [0x5f3],0x1
000009C8  C606760520        mov byte [0x576],0x20
000009CD  2BDB              sub bx,bx
000009CF  B40B              mov ah,0xb
000009D1  CD10              int 0x10
000009D3  E9B000            jmp 0xa86
000009D6  8B360800          mov si,[0x8]
000009DA  D1E6              shl si,1
000009DC  2BDB              sub bx,bx
000009DE  3B84A905          cmp ax,[si+0x5a9]
000009E2  7212              jc 0x9f6
000009E4  FEC3              inc bl
000009E6  3B84B905          cmp ax,[si+0x5b9]
000009EA  720A              jc 0x9f6
000009EC  B305              mov bl,0x5
000009EE  3B84C905          cmp ax,[si+0x5c9]
000009F2  7202              jc 0x9f6
000009F4  FECB              dec bl
000009F6  B40B              mov ah,0xb
000009F8  CD10              int 0x10
000009FA  A06E05            mov al,[0x56e]
000009FD  A26F05            mov [0x56f],al
00000A00  A07105            mov al,[0x571]
00000A03  A27005            mov [0x570],al
00000A06  A09806            mov al,[0x698]
00000A09  3C00              cmp al,0x0
00000A0B  750D              jnz 0xa1a
00000A0D  833E740510        cmp word [0x574],byte +0x10
00000A12  721A              jc 0xa2e
00000A14  FF0E7405          dec word [0x574]
00000A18  EB1D              jmp short 0xa37
00000A1A  3A066E05          cmp al,[0x56e]
00000A1E  750E              jnz 0xa2e
00000A20  833E740530        cmp word [0x574],byte +0x30
00000A25  7310              jnc 0xa37
00000A27  8306740503        add word [0x574],byte +0x3
00000A2C  EB09              jmp short 0xa37
00000A2E  A26E05            mov [0x56e],al
00000A31  C70674052000      mov word [0x574],0x20
00000A37  A17405            mov ax,[0x574]
00000A3A  B103              mov cl,0x3
00000A3C  D3E8              shr ax,cl
00000A3E  8B1E0800          mov bx,[0x8]
00000A42  D0E3              shl bl,1
00000A44  3B876C06          cmp ax,[bx+0x66c]
00000A48  7604              jna 0xa4e
00000A4A  8B876C06          mov ax,[bx+0x66c]
00000A4E  A37205            mov [0x572],ax
00000A51  E87505            call 0xfc9
00000A54  A09906            mov al,[0x699]
00000A57  3C00              cmp al,0x0
00000A59  750F              jnz 0xa6a
00000A5B  F6D0              not al
00000A5D  803E760510        cmp byte [0x576],0x10
00000A62  721A              jc 0xa7e
00000A64  FE0E7605          dec byte [0x576]
00000A68  EB1C              jmp short 0xa86
00000A6A  3A067105          cmp al,[0x571]
00000A6E  750E              jnz 0xa7e
00000A70  803E760540        cmp byte [0x576],0x40
00000A75  730F              jnc 0xa86
00000A77  8006760504        add byte [0x576],0x4
00000A7C  EB08              jmp short 0xa86
00000A7E  A27105            mov [0x571],al
00000A81  C606760520        mov byte [0x576],0x20
00000A86  8B360800          mov si,[0x8]
00000A8A  8A167B05          mov dl,[0x57b]
00000A8E  B104              mov cl,0x4
00000A90  8A1E7605          mov bl,[0x576]
00000A94  D2EB              shr bl,cl
00000A96  3A9C7C06          cmp bl,[si+0x67c]
00000A9A  7604              jna 0xaa0
00000A9C  8A9C7C06          mov bl,[si+0x67c]
00000AA0  A07105            mov al,[0x571]
00000AA3  3C01              cmp al,0x1
00000AA5  7227              jc 0xace
00000AA7  750B              jnz 0xab4
00000AA9  02D3              add dl,bl
00000AAB  80FAB4            cmp dl,0xb4
00000AAE  721E              jc 0xace
00000AB0  B2B3              mov dl,0xb3
00000AB2  EB1A              jmp short 0xace
00000AB4  2AD3              sub dl,bl
00000AB6  7205              jc 0xabd
00000AB8  80FA03            cmp dl,0x3
00000ABB  7711              ja 0xace
00000ABD  A1B809            mov ax,[0x9b8]
00000AC0  3B065D05          cmp ax,[0x55d]
00000AC4  7506              jnz 0xacc
00000AC6  A17D05            mov ax,[0x57d]
00000AC9  A3F105            mov [0x5f1],ax
00000ACC  B202              mov dl,0x2
00000ACE  88167B05          mov [0x57b],dl
00000AD2  8B0E7905          mov cx,[0x579]
00000AD6  E8D721            call 0x2cb0
00000AD9  A36305            mov [0x563],ax
00000ADC  803EF30500        cmp byte [0x5f3],0x0
00000AE1  7406              jz 0xae9
00000AE3  BB1000            mov bx,0x10
00000AE6  EB7C              jmp short 0xb64
00000AE8  90                nop
00000AE9  A06E05            mov al,[0x56e]
00000AEC  3A066F05          cmp al,[0x56f]
00000AF0  7509              jnz 0xafb
00000AF2  A07105            mov al,[0x571]
00000AF5  3A067005          cmp al,[0x570]
00000AF9  7405              jz 0xb00
00000AFB  BB1800            mov bx,0x18
00000AFE  EB64              jmp short 0xb64
00000B00  FF068705          inc word [0x587]
00000B04  8B1E8705          mov bx,[0x587]
00000B08  A09806            mov al,[0x698]
00000B0B  0A069906          or al,[0x699]
00000B0F  7502              jnz 0xb13
00000B11  D0EB              shr bl,1
00000B13  803E7B05B3        cmp byte [0x57b],0xb3
00000B18  7207              jc 0xb21
00000B1A  803E710501        cmp byte [0x571],0x1
00000B1F  741B              jz 0xb3c
00000B21  803E7B0504        cmp byte [0x57b],0x4
00000B26  7707              ja 0xb2f
00000B28  803E990600        cmp byte [0x699],0x0
00000B2D  7524              jnz 0xb53
00000B2F  A07605            mov al,[0x576]
00000B32  2AE4              sub ah,ah
00000B34  D1E8              shr ax,1
00000B36  3B067405          cmp ax,[0x574]
00000B3A  7317              jnc 0xb53
00000B3C  803E6E0500        cmp byte [0x56e],0x0
00000B41  7410              jz 0xb53
00000B43  81E30600          and bx,0x6
00000B47  803E6E0501        cmp byte [0x56e],0x1
00000B4C  7416              jz 0xb64
00000B4E  80CB08            or bl,0x8
00000B51  EB11              jmp short 0xb64
00000B53  81E30200          and bx,0x2
00000B57  80CB10            or bl,0x10
00000B5A  803E710501        cmp byte [0x571],0x1
00000B5F  7503              jnz 0xb64
00000B61  80C304            add bl,0x4
00000B64  8B87A609          mov ax,[bx+0x9a6]
00000B68  A35D05            mov [0x55d],ax
00000B6B  8B87C009          mov ax,[bx+0x9c0]
00000B6F  A36505            mov [0x565],ax
00000B72  B030              mov al,0x30
00000B74  B9BC02            mov cx,0x2bc
00000B77  803E9706FD        cmp byte [0x697],0xfd
00000B7C  7219              jc 0xb97
00000B7E  7405              jz 0xb85
00000B80  B008              mov al,0x8
00000B82  B9E803            mov cx,0x3e8
00000B85  38067B05          cmp [0x57b],al
00000B89  770C              ja 0xb97
00000B8B  E84A08            call 0x13d8
00000B8E  75FB              jnz 0xb8b
00000B90  E84508            call 0x13d8
00000B93  74FB              jz 0xb90
00000B95  E2FE              loop 0xb95
00000B97  E84906            call 0x11e3
00000B9A  A16305            mov ax,[0x563]
00000B9D  A35F05            mov [0x55f],ax
00000BA0  E8A205            call 0x1145
00000BA3  E8FA28            call 0x34a0
00000BA6  7303              jnc 0xbab
00000BA8  E89A05            call 0x1145
00000BAB  C3                ret
00000BAC  E8CB0F            call 0x1b7a
00000BAF  7301              jnc 0xbb2
00000BB1  C3                ret
00000BB2  803EB81C00        cmp byte [0x1cb8],0x0
00000BB7  75F8              jnz 0xbb1
00000BB9  803E580500        cmp byte [0x558],0x0
00000BBE  745C              jz 0xc1c
00000BC0  803E590500        cmp byte [0x559],0x0
00000BC5  740C              jz 0xbd3
00000BC7  803EBF1C00        cmp byte [0x1cbf],0x0
00000BCC  7504              jnz 0xbd2
00000BCE  FE0E5905          dec byte [0x559]
00000BD2  C3                ret
00000BD3  FE0E5805          dec byte [0x558]
00000BD7  750C              jnz 0xbe5
00000BD9  C70672050800      mov word [0x572],0x8
00000BDF  E8E703            call 0xfc9
00000BE2  EB38              jmp short 0xc1c
00000BE4  90                nop
00000BE5  E83804            call 0x1020
00000BE8  891E5D05          mov [0x55d],bx
00000BEC  A05805            mov al,[0x558]
00000BEF  8A266E05          mov ah,[0x56e]
00000BF3  E89103            call 0xf87
00000BF6  803E580502        cmp byte [0x558],0x2
00000BFB  7403              jz 0xc00
00000BFD  E8E305            call 0x11e3
00000C00  E8770F            call 0x1b7a
00000C03  7216              jc 0xc1b
00000C05  E8ED14            call 0x20f5
00000C08  7211              jc 0xc1b
00000C0A  8A167B05          mov dl,[0x57b]
00000C0E  8B0E7905          mov cx,[0x579]
00000C12  E89B20            call 0x2cb0
00000C15  A35F05            mov [0x55f],ax
00000C18  E82A05            call 0x1145
00000C1B  C3                ret
00000C1C  803E5C0501        cmp byte [0x55c],0x1
00000C21  7247              jc 0xc6a
00000C23  753A              jnz 0xc5f
00000C25  FE065C05          inc byte [0x55c]
00000C29  C70672050600      mov word [0x572],0x6
00000C2F  8A167B05          mov dl,[0x57b]
00000C33  8B0E7905          mov cx,[0x579]
00000C37  E87620            call 0x2cb0
00000C3A  A36305            mov [0x563],ax
00000C3D  E8A305            call 0x11e3
00000C40  E8370F            call 0x1b7a
00000C43  7221              jc 0xc66
00000C45  E8AD14            call 0x20f5
00000C48  721C              jc 0xc66
00000C4A  A16305            mov ax,[0x563]
00000C4D  A35F05            mov [0x55f],ax
00000C50  C7066505030E      mov word [0x565],0xe03
00000C56  C7065D05DA09      mov word [0x55d],0x9da
00000C5C  E8E604            call 0x1145
00000C5F  803E990600        cmp byte [0x699],0x0
00000C64  7501              jnz 0xc67
00000C66  C3                ret
00000C67  E90E02            jmp 0xe78
00000C6A  803E710500        cmp byte [0x571],0x0
00000C6F  7503              jnz 0xc74
00000C71  E9AF01            jmp 0xe23
00000C74  E85203            call 0xfc9
00000C77  7317              jnc 0xc90
00000C79  C6066E0500        mov byte [0x56e],0x0
00000C7E  C606760502        mov byte [0x576],0x2
00000C83  C606710501        mov byte [0x571],0x1
00000C88  C6065B0500        mov byte [0x55b],0x0
00000C8D  EB32              jmp short 0xcc1
00000C8F  90                nop
00000C90  A07805            mov al,[0x578]
00000C93  28067705          sub [0x577],al
00000C97  7328              jnc 0xcc1
00000C99  803E710501        cmp byte [0x571],0x1
00000C9E  7416              jz 0xcb6
00000CA0  803E760501        cmp byte [0x576],0x1
00000CA5  7607              jna 0xcae
00000CA7  FE0E7605          dec byte [0x576]
00000CAB  EB14              jmp short 0xcc1
00000CAD  90                nop
00000CAE  C606710501        mov byte [0x571],0x1
00000CB3  EB0C              jmp short 0xcc1
00000CB5  90                nop
00000CB6  803E760504        cmp byte [0x576],0x4
00000CBB  7304              jnc 0xcc1
00000CBD  FE067605          inc byte [0x576]
00000CC1  803E5A0500        cmp byte [0x55a],0x0
00000CC6  751F              jnz 0xce7
00000CC8  803E5B0500        cmp byte [0x55b],0x0
00000CCD  7406              jz 0xcd5
00000CCF  FE0E5B05          dec byte [0x55b]
00000CD3  7512              jnz 0xce7
00000CD5  803E710501        cmp byte [0x571],0x1
00000CDA  750B              jnz 0xce7
00000CDC  E82909            call 0x1608
00000CDF  7306              jnc 0xce7
00000CE1  A07C05            mov al,[0x57c]
00000CE4  EB43              jmp short 0xd29
00000CE6  90                nop
00000CE7  A07C05            mov al,[0x57c]
00000CEA  803E710501        cmp byte [0x571],0x1
00000CEF  7415              jz 0xd06
00000CF1  2A067605          sub al,[0x576]
00000CF5  7358              jnc 0xd4f
00000CF7  2AC0              sub al,al
00000CF9  C606710501        mov byte [0x571],0x1
00000CFE  C606760501        mov byte [0x576],0x1
00000D03  EB4A              jmp short 0xd4f
00000D05  90                nop
00000D06  02067605          add al,[0x576]
00000D0A  3CE6              cmp al,0xe6
00000D0C  7641              jna 0xd4f
00000D0E  833E040007        cmp word [0x4],byte +0x7
00000D13  750D              jnz 0xd22
00000D15  3CF8              cmp al,0xf8
00000D17  7236              jc 0xd4f
00000D19  B0F8              mov al,0xf8
00000D1B  C606510501        mov byte [0x551],0x1
00000D20  EB2D              jmp short 0xd4f
00000D22  B0E6              mov al,0xe6
00000D24  C606500500        mov byte [0x550],0x0
00000D29  C606710500        mov byte [0x571],0x0
00000D2E  C606840500        mov byte [0x584],0x0
00000D33  C70672050200      mov word [0x572],0x2
00000D39  C6065B0500        mov byte [0x55b],0x0
00000D3E  C6065A0500        mov byte [0x55a],0x0
00000D43  803E5C0500        cmp byte [0x55c],0x0
00000D48  7405              jz 0xd4f
00000D4A  50                push ax
00000D4B  E8744D            call 0x5ac2
00000D4E  58                pop ax
00000D4F  A27C05            mov [0x57c],al
00000D52  2C32              sub al,0x32
00000D54  7302              jnc 0xd58
00000D56  2AC0              sub al,al
00000D58  A27B05            mov [0x57b],al
00000D5B  8A167B05          mov dl,[0x57b]
00000D5F  8B0E7905          mov cx,[0x579]
00000D63  E84A1F            call 0x2cb0
00000D66  A36305            mov [0x563],ax
00000D69  803E830500        cmp byte [0x583],0x0
00000D6E  7503              jnz 0xd73
00000D70  E87004            call 0x11e3
00000D73  E8040E            call 0x1b7a
00000D76  724C              jc 0xdc4
00000D78  E87A13            call 0x20f5
00000D7B  7247              jc 0xdc4
00000D7D  A16305            mov ax,[0x563]
00000D80  A35F05            mov [0x55f],ax
00000D83  803E840500        cmp byte [0x584],0x0
00000D88  7417              jz 0xda1
00000D8A  8306850502        add word [0x585],byte +0x2
00000D8F  8B1E8505          mov bx,[0x585]
00000D93  81E30E00          and bx,0xe
00000D97  8B87C20F          mov ax,[bx+0xfc2]
00000D9B  8B9FD20F          mov bx,[bx+0xfd2]
00000D9F  EB07              jmp short 0xda8
00000DA1  A16905            mov ax,[0x569]
00000DA4  8B1E6705          mov bx,[0x567]
00000DA8  A35D05            mov [0x55d],ax
00000DAB  891E6505          mov [0x565],bx
00000DAF  B032              mov al,0x32
00000DB1  2A067C05          sub al,[0x57c]
00000DB5  7427              jz 0xdde
00000DB7  7225              jc 0xdde
00000DB9  B96801            mov cx,0x168
00000DBC  E2FE              loop 0xdbc
00000DBE  2AF8              sub bh,al
00000DC0  7402              jz 0xdc4
00000DC2  7306              jnc 0xdca
00000DC4  C606830501        mov byte [0x583],0x1
00000DC9  C3                ret
00000DCA  891E6505          mov [0x565],bx
00000DCE  8AE3              mov ah,bl
00000DD0  D0E4              shl ah,1
00000DD2  F6E4              mul ah
00000DD4  03066905          add ax,[0x569]
00000DD8  A35D05            mov [0x55d],ax
00000DDB  EB42              jmp short 0xe1f
00000DDD  90                nop
00000DDE  833E040007        cmp word [0x4],byte +0x7
00000DE3  7509              jnz 0xdee
00000DE5  A07B05            mov al,[0x57b]
00000DE8  2CBB              sub al,0xbb
00000DEA  7233              jc 0xe1f
00000DEC  730E              jnc 0xdfc
00000DEE  803E500502        cmp byte [0x550],0x2
00000DF3  752A              jnz 0xe1f
00000DF5  A07B05            mov al,[0x57b]
00000DF8  2C5E              sub al,0x5e
00000DFA  7223              jc 0xe1f
00000DFC  2AF8              sub bh,al
00000DFE  7402              jz 0xe02
00000E00  7314              jnc 0xe16
00000E02  833E040007        cmp word [0x4],byte +0x7
00000E07  7506              jnz 0xe0f
00000E09  C606510501        mov byte [0x551],0x1
00000E0E  C3                ret
00000E0F  E8FBF8            call 0x70d
00000E12  E8B64B            call 0x59cb
00000E15  C3                ret
00000E16  891E6505          mov [0x565],bx
00000E1A  C606760502        mov byte [0x576],0x2
00000E1F  E82303            call 0x1145
00000E22  C3                ret
00000E23  833E040007        cmp word [0x4],byte +0x7
00000E28  7407              jz 0xe31
00000E2A  803E7B05B4        cmp byte [0x57b],0xb4
00000E2F  7347              jnc 0xe78
00000E31  E8D407            call 0x1608
00000E34  720D              jc 0xe43
00000E36  C6066E0500        mov byte [0x56e],0x0
00000E3B  C606710501        mov byte [0x571],0x1
00000E40  EB6F              jmp short 0xeb1
00000E42  90                nop
00000E43  833E040000        cmp word [0x4],byte +0x0
00000E48  752E              jnz 0xe78
00000E4A  E8AA14            call 0x22f7
00000E4D  7207              jc 0xe56
00000E4F  C6066C0500        mov byte [0x56c],0x0
00000E54  EB22              jmp short 0xe78
00000E56  803E6C0500        cmp byte [0x56c],0x0
00000E5B  7503              jnz 0xe60
00000E5D  E8BF4A            call 0x591f
00000E60  C606990601        mov byte [0x699],0x1
00000E65  C6066C0501        mov byte [0x56c],0x1
00000E6A  E8901F            call 0x2dfd
00000E6D  80E201            and dl,0x1
00000E70  7502              jnz 0xe74
00000E72  B2FF              mov dl,0xff
00000E74  88169806          mov [0x698],dl
00000E78  A06E05            mov al,[0x56e]
00000E7B  A26F05            mov [0x56f],al
00000E7E  A09806            mov al,[0x698]
00000E81  A26E05            mov [0x56e],al
00000E84  A09906            mov al,[0x699]
00000E87  A27105            mov [0x571],al
00000E8A  3C00              cmp al,0x0
00000E8C  7503              jnz 0xe91
00000E8E  E9A300            jmp 0xf34
00000E91  803E710501        cmp byte [0x571],0x1
00000E96  7531              jnz 0xec9
00000E98  803E7B05B4        cmp byte [0x57b],0xb4
00000E9D  7212              jc 0xeb1
00000E9F  C606710500        mov byte [0x571],0x0
00000EA4  C606840500        mov byte [0x584],0x0
00000EA9  C606990600        mov byte [0x699],0x0
00000EAE  E98300            jmp 0xf34
00000EB1  B401              mov ah,0x1
00000EB3  B020              mov al,0x20
00000EB5  C6065B0508        mov byte [0x55b],0x8
00000EBA  803E500501        cmp byte [0x550],0x1
00000EBF  7530              jnz 0xef1
00000EC1  C606500500        mov byte [0x550],0x0
00000EC6  EB29              jmp short 0xef1
00000EC8  90                nop
00000EC9  C6065B0500        mov byte [0x55b],0x0
00000ECE  A17205            mov ax,[0x572]
00000ED1  8AD8              mov bl,al
00000ED3  3C02              cmp al,0x2
00000ED5  7602              jna 0xed9
00000ED7  2C02              sub al,0x2
00000ED9  A37205            mov [0x572],ax
00000EDC  B408              mov ah,0x8
00000EDE  8AC3              mov al,bl
00000EE0  340F              xor al,0xf
00000EE2  B104              mov cl,0x4
00000EE4  D2E0              shl al,cl
00000EE6  803E500501        cmp byte [0x550],0x1
00000EEB  7504              jnz 0xef1
00000EED  FE065005          inc byte [0x550]
00000EF1  A27805            mov [0x578],al
00000EF4  88267605          mov [0x576],ah
00000EF8  C606770501        mov byte [0x577],0x1
00000EFD  C6065C0500        mov byte [0x55c],0x0
00000F02  8A1E6E05          mov bl,[0x56e]
00000F06  FEC3              inc bl
00000F08  D0E3              shl bl,1
00000F0A  803E7105FF        cmp byte [0x571],0xff
00000F0F  7403              jz 0xf14
00000F11  80C306            add bl,0x6
00000F14  2AFF              sub bh,bh
00000F16  8B87AA0F          mov ax,[bx+0xfaa]
00000F1A  A36905            mov [0x569],ax
00000F1D  8B87B60F          mov ax,[bx+0xfb6]
00000F21  A36705            mov [0x567],ax
00000F24  C606E03900        mov byte [0x39e0],0x0
00000F29  803E7C1200        cmp byte [0x127c],0x0
00000F2E  7403              jz 0xf33
00000F30  E8C549            call 0x58f8
00000F33  C3                ret
00000F34  833E040000        cmp word [0x4],byte +0x0
00000F39  740A              jz 0xf45
00000F3B  833E040007        cmp word [0x4],byte +0x7
00000F40  7403              jz 0xf45
00000F42  E80025            call 0x3445
00000F45  E88100            call 0xfc9
00000F48  8A167B05          mov dl,[0x57b]
00000F4C  8B0E7905          mov cx,[0x579]
00000F50  E85D1D            call 0x2cb0
00000F53  A36305            mov [0x563],ax
00000F56  A06E05            mov al,[0x56e]
00000F59  0A067105          or al,[0x571]
00000F5D  7504              jnz 0xf63
00000F5F  E80701            call 0x1069
00000F62  C3                ret
00000F63  E8BA00            call 0x1020
00000F66  891E5D05          mov [0x55d],bx
00000F6A  E87602            call 0x11e3
00000F6D  E80A0C            call 0x1b7a
00000F70  7214              jc 0xf86
00000F72  E88011            call 0x20f5
00000F75  720F              jc 0xf86
00000F77  A16305            mov ax,[0x563]
00000F7A  A35F05            mov [0x55f],ax
00000F7D  C7066505030B      mov word [0x565],0xb03
00000F83  E8BF01            call 0x1145
00000F86  C3                ret
00000F87  B9030B            mov cx,0xb03
00000F8A  2AC8              sub cl,al
00000F8C  890E6505          mov [0x565],cx
00000F90  80FCFF            cmp ah,0xff
00000F93  7411              jz 0xfa6
00000F95  2AE4              sub ah,ah
00000F97  D0E0              shl al,1
00000F99  01065D05          add [0x55d],ax
00000F9D  C70679050000      mov word [0x579],0x0
00000FA3  EB0F              jmp short 0xfb4
00000FA5  90                nop
00000FA6  2AE4              sub ah,ah
00000FA8  D0E0              shl al,1
00000FAA  D0E0              shl al,1
00000FAC  D0E0              shl al,1
00000FAE  052801            add ax,0x128
00000FB1  A37905            mov [0x579],ax
00000FB4  1E                push ds
00000FB5  07                pop es
00000FB6  8B365D05          mov si,[0x55d]
00000FBA  BF0E00            mov di,0xe
00000FBD  B003              mov al,0x3
00000FBF  E8AE1D            call 0x2d70
00000FC2  C7065D050E00      mov word [0x55d],0xe
00000FC8  C3                ret
00000FC9  C706F6050800      mov word [0x5f6],0x8
00000FCF  C706F8052301      mov word [0x5f8],0x123
00000FD5  833E040007        cmp word [0x4],byte +0x7
00000FDA  750C              jnz 0xfe8
00000FDC  C706F6052400      mov word [0x5f6],0x24
00000FE2  C706F8050F01      mov word [0x5f8],0x10f
00000FE8  A17905            mov ax,[0x579]
00000FEB  803E6E0501        cmp byte [0x56e],0x1
00000FF0  722C              jc 0x101e
00000FF2  7513              jnz 0x1007
00000FF4  03067205          add ax,[0x572]
00000FF8  3B06F805          cmp ax,[0x5f8]
00000FFC  721D              jc 0x101b
00000FFE  A1F805            mov ax,[0x5f8]
00001001  48                dec ax
00001002  A37905            mov [0x579],ax
00001005  F9                stc
00001006  C3                ret
00001007  2B067205          sub ax,[0x572]
0000100B  7206              jc 0x1013
0000100D  3B06F605          cmp ax,[0x5f6]
00001011  7308              jnc 0x101b
00001013  A1F605            mov ax,[0x5f6]
00001016  A37905            mov [0x579],ax
00001019  F9                stc
0000101A  C3                ret
0000101B  A37905            mov [0x579],ax
0000101E  F8                clc
0000101F  C3                ret
00001020  A06E05            mov al,[0x56e]
00001023  3A066F05          cmp al,[0x56f]
00001027  7406              jz 0x102f
00001029  C70672050200      mov word [0x572],0x2
0000102F  833E720508        cmp word [0x572],byte +0x8
00001034  730F              jnc 0x1045
00001036  FE0E7705          dec byte [0x577]
0000103A  A07705            mov al,[0x577]
0000103D  2403              and al,0x3
0000103F  7504              jnz 0x1045
00001041  FF067205          inc word [0x572]
00001045  8A1E6B05          mov bl,[0x56b]
00001049  FEC3              inc bl
0000104B  80FB06            cmp bl,0x6
0000104E  7202              jc 0x1052
00001050  B300              mov bl,0x0
00001052  881E6B05          mov [0x56b],bl
00001056  803E6E05FF        cmp byte [0x56e],0xff
0000105B  7503              jnz 0x1060
0000105D  80C306            add bl,0x6
00001060  D0E3              shl bl,1
00001062  2AFF              sub bh,bh
00001064  8B9F7A0F          mov bx,[bx+0xf7a]
00001068  C3                ret
00001069  C70672050200      mov word [0x572],0x2
0000106F  C606770508        mov byte [0x577],0x8
00001074  813E6105020C      cmp word [0x561],0xc02
0000107A  750B              jnz 0x1087
0000107C  FE066D05          inc byte [0x56d]
00001080  F6066D0507        test byte [0x56d],0x7
00001085  7555              jnz 0x10dc
00001087  E85901            call 0x11e3
0000108A  E8ED0A            call 0x1b7a
0000108D  724D              jc 0x10dc
0000108F  E86310            call 0x20f5
00001092  7248              jc 0x10dc
00001094  E8661D            call 0x2dfd
00001097  8ADA              mov bl,dl
00001099  81E30E00          and bx,0xe
0000109D  8BB7920F          mov si,[bx+0xf92]
000010A1  B800B8            mov ax,0xb800
000010A4  8EC0              mov es,ax
000010A6  8B3E5F05          mov di,[0x55f]
000010AA  BDFA05            mov bp,0x5fa
000010AD  C7066105020C      mov word [0x561],0xc02
000010B3  B90206            mov cx,0x602
000010B6  E87C1C            call 0x2d35
000010B9  E8411D            call 0x2dfd
000010BC  8ADA              mov bl,dl
000010BE  81E30600          and bx,0x6
000010C2  8BB7A20F          mov si,[bx+0xfa2]
000010C6  8B3E5F05          mov di,[0x55f]
000010CA  81C7F000          add di,0xf0
000010CE  BD1206            mov bp,0x612
000010D1  B90206            mov cx,0x602
000010D4  E85E1C            call 0x2d35
000010D7  C606830500        mov byte [0x583],0x0
000010DC  C3                ret
000010DD  C6065C0500        mov byte [0x55c],0x0
000010E2  C606710501        mov byte [0x571],0x1
000010E7  C606760502        mov byte [0x576],0x2
000010EC  C606780501        mov byte [0x578],0x1
000010F1  C6067705FF        mov byte [0x577],0xff
000010F6  C6066E0500        mov byte [0x56e],0x0
000010FB  C6065A0501        mov byte [0x55a],0x1
00001100  A1AC0F            mov ax,[0xfac]
00001103  A36905            mov [0x569],ax
00001106  A1B80F            mov ax,[0xfb8]
00001109  A36705            mov [0x567],ax
0000110C  C606500502        mov byte [0x550],0x2
00001111  C3                ret
00001112  8B0E7905          mov cx,[0x579]
00001116  8A167B05          mov dl,[0x57b]
0000111A  E8931B            call 0x2cb0
0000111D  A35F05            mov [0x55f],ax
00001120  E80100            call 0x1124
00001123  C3                ret
00001124  B81000            mov ax,0x10
00001127  8EC0              mov es,ax
00001129  BFFA05            mov di,0x5fa
0000112C  1E                push ds
0000112D  8B365F05          mov si,[0x55f]
00001131  B800B8            mov ax,0xb800
00001134  8ED8              mov ds,ax
00001136  268B0E6105        mov cx,[es:0x561]
0000113B  E88C1C            call 0x2dca
0000113E  1F                pop ds
0000113F  C606830500        mov byte [0x583],0x0
00001144  C3                ret
00001145  B800B8            mov ax,0xb800
00001148  8EC0              mov es,ax
0000114A  8B3E5F05          mov di,[0x55f]
0000114E  BDFA05            mov bp,0x5fa
00001151  8B365D05          mov si,[0x55d]
00001155  8B0E6505          mov cx,[0x565]
00001159  890E6105          mov [0x561],cx
0000115D  C606830500        mov byte [0x583],0x0
00001162  E8D01B            call 0x2d35
00001165  C3                ret
00001166  8A167B05          mov dl,[0x57b]
0000116A  8B0E7905          mov cx,[0x579]
0000116E  83E90C            sub cx,byte +0xc
00001171  7302              jnc 0x1175
00001173  2BC9              sub cx,cx
00001175  81F90F01          cmp cx,0x10f
00001179  7203              jc 0x117e
0000117B  B90E01            mov cx,0x10e
0000117E  E82F1B            call 0x2cb0
00001181  A38105            mov [0x581],ax
00001184  8BF8              mov di,ax
00001186  B800B8            mov ax,0xb800
00001189  8EC0              mov es,ax
0000118B  BD0E00            mov bp,0xe
0000118E  BE7916            mov si,0x1679
00001191  B90512            mov cx,0x1205
00001194  E8351B            call 0x2ccc
00001197  2AE4              sub ah,ah
00001199  CD1A              int 0x1a
0000119B  89167F05          mov [0x57f],dx
0000119F  C7063C5A0000      mov word [0x5a3c],0x0
000011A5  C7063E5A0000      mov word [0x5a3e],0x0
000011AB  E86E48            call 0x5a1c
000011AE  2AE4              sub ah,ah
000011B0  CD1A              int 0x1a
000011B2  2B167F05          sub dx,[0x57f]
000011B6  83FA0A            cmp dx,byte +0xa
000011B9  72F0              jc 0x11ab
000011BB  E86349            call 0x5b21
000011BE  8B3E8105          mov di,[0x581]
000011C2  BE0E00            mov si,0xe
000011C5  B90512            mov cx,0x1205
000011C8  C606830500        mov byte [0x583],0x0
000011CD  E8CD1B            call 0x2d9d
000011D0  803E781600        cmp byte [0x1678],0x0
000011D5  740B              jz 0x11e2
000011D7  803E801F00        cmp byte [0x1f80],0x0
000011DC  7404              jz 0x11e2
000011DE  FE0E801F          dec byte [0x1f80]
000011E2  C3                ret
000011E3  B800B8            mov ax,0xb800
000011E6  8EC0              mov es,ax
000011E8  8B3E5F05          mov di,[0x55f]
000011EC  BEFA05            mov si,0x5fa
000011EF  8B0E6105          mov cx,[0x561]
000011F3  E8A71B            call 0x2d9d
000011F6  C3                ret
000011F7  0000              add [bx+si],al
000011F9  0000              add [bx+si],al
000011FB  0000              add [bx+si],al
000011FD  0000              add [bx+si],al
000011FF  002A              add [bp+si],ch
00001201  E4CD              in al,0xcd
00001203  1A8BC22B          sbb cl,[bp+di+0x2bc2]
00001207  06                push es
00001208  9F                lahf
00001209  06                push es
0000120A  3D0200            cmp ax,0x2
0000120D  7301              jnc 0x1210
0000120F  C3                ret
00001210  89169F06          mov [0x69f],dx
00001214  803E9B0600        cmp byte [0x69b],0x0
00001219  7513              jnz 0x122e
0000121B  E8A300            call 0x12c1
0000121E  E89601            call 0x13b7
00001221  8BD0              mov dx,ax
00001223  E89101            call 0x13b7
00001226  2BC2              sub ax,dx
00001228  3DEDF8            cmp ax,0xf8ed
0000122B  72F6              jc 0x1223
0000122D  C3                ret
0000122E  BA0102            mov dx,0x201
00001231  EC                in al,dx
00001232  2410              and al,0x10
00001234  A29A06            mov [0x69a],al
00001237  C6069E0603        mov byte [0x69e],0x3
0000123C  E87801            call 0x13b7
0000123F  A39C06            mov [0x69c],ax
00001242  EE                out dx,al
00001243  B9D007            mov cx,0x7d0
00001246  EC                in al,dx
00001247  A801              test al,0x1
00001249  7513              jnz 0x125e
0000124B  F6069E0601        test byte [0x69e],0x1
00001250  740C              jz 0x125e
00001252  80269E06FE        and byte [0x69e],0xfe
00001257  E84700            call 0x12a1
0000125A  881E9806          mov [0x698],bl
0000125E  A802              test al,0x2
00001260  7513              jnz 0x1275
00001262  F6069E0602        test byte [0x69e],0x2
00001267  740C              jz 0x1275
00001269  80269E06FD        and byte [0x69e],0xfd
0000126E  E83000            call 0x12a1
00001271  881E9906          mov [0x699],bl
00001275  F6069E0603        test byte [0x69e],0x3
0000127A  7424              jz 0x12a0
0000127C  E83801            call 0x13b7
0000127F  2B069C06          sub ax,[0x69c]
00001283  3D6419            cmp ax,0x1964
00001286  E0BE              loopne 0x1246
00001288  F6069E0601        test byte [0x69e],0x1
0000128D  7405              jz 0x1294
0000128F  C6069806FF        mov byte [0x698],0xff
00001294  F6069E0602        test byte [0x69e],0x2
00001299  7405              jz 0x12a0
0000129B  C6069906FF        mov byte [0x699],0xff
000012A0  C3                ret
000012A1  50                push ax
000012A2  E81201            call 0x13b7
000012A5  2B069C06          sub ax,[0x69c]
000012A9  8BD8              mov bx,ax
000012AB  58                pop ax
000012AC  81FBE6F5          cmp bx,0xf5e6
000012B0  7303              jnc 0x12b5
000012B2  B301              mov bl,0x1
000012B4  C3                ret
000012B5  81FBFAFA          cmp bx,0xfafa
000012B9  7303              jnc 0x12be
000012BB  2ADB              sub bl,bl
000012BD  C3                ret
000012BE  B3FF              mov bl,0xff
000012C0  C3                ret
000012C1  A0BA06            mov al,[0x6ba]
000012C4  803E9706FD        cmp byte [0x697],0xfd
000012C9  7408              jz 0x12d3
000012CB  2206BD06          and al,[0x6bd]
000012CF  2206BE06          and al,[0x6be]
000012D3  3480              xor al,0x80
000012D5  7402              jz 0x12d9
000012D7  B001              mov al,0x1
000012D9  A29906            mov [0x699],al
000012DC  A0B806            mov al,[0x6b8]
000012DF  803E9706FD        cmp byte [0x697],0xfd
000012E4  7408              jz 0x12ee
000012E6  2206BC06          and al,[0x6bc]
000012EA  2206BF06          and al,[0x6bf]
000012EE  3480              xor al,0x80
000012F0  7405              jz 0x12f7
000012F2  C6069906FF        mov byte [0x699],0xff
000012F7  A0B906            mov al,[0x6b9]
000012FA  803E9706FD        cmp byte [0x697],0xfd
000012FF  7408              jz 0x1309
00001301  2206BC06          and al,[0x6bc]
00001305  2206BD06          and al,[0x6bd]
00001309  3480              xor al,0x80
0000130B  7402              jz 0x130f
0000130D  B001              mov al,0x1
0000130F  A29806            mov [0x698],al
00001312  A0BB06            mov al,[0x6bb]
00001315  803E9706FD        cmp byte [0x697],0xfd
0000131A  7408              jz 0x1324
0000131C  2206BE06          and al,[0x6be]
00001320  2206BF06          and al,[0x6bf]
00001324  3480              xor al,0x80
00001326  7405              jz 0x132d
00001328  C6069806FF        mov byte [0x698],0xff
0000132D  A0B706            mov al,[0x6b7]
00001330  B103              mov cl,0x3
00001332  D2E8              shr al,cl
00001334  A29A06            mov [0x69a],al
00001337  C3                ret
00001338  A19306            mov ax,[0x693]
0000133B  3B069106          cmp ax,[0x691]
0000133F  7416              jz 0x1357
00001341  A39106            mov [0x691],ax
00001344  F606C00680        test byte [0x6c0],0x80
00001349  750D              jnz 0x1358
0000134B  A19306            mov ax,[0x693]
0000134E  3B06006E          cmp ax,[0x6e00]
00001352  7403              jz 0x1357
00001354  E8194B            call 0x5e70
00001357  C3                ret
00001358  F606C90680        test byte [0x6c9],0x80
0000135D  7401              jz 0x1360
0000135F  C3                ret
00001360  F606CC0680        test byte [0x6cc],0x80
00001365  7506              jnz 0x136d
00001367  C606801F09        mov byte [0x1f80],0x9
0000136C  C3                ret
0000136D  F606C10680        test byte [0x6c1],0x80
00001372  7431              jz 0x13a5
00001374  F606CB0680        test byte [0x6cb],0x80
00001379  7506              jnz 0x1381
0000137B  C6061C04FF        mov byte [0x41c],0xff
00001380  C3                ret
00001381  F606C80680        test byte [0x6c8],0x80
00001386  7506              jnz 0x138e
00001388  C6061B04FF        mov byte [0x41b],0xff
0000138D  C3                ret
0000138E  F606C70680        test byte [0x6c7],0x80
00001393  750F              jnz 0x13a4
00001395  F6160000          not byte [0x0]
00001399  803E000000        cmp byte [0x0],0x0
0000139E  7503              jnz 0x13a3
000013A0  E87E47            call 0x5b21
000013A3  C3                ret
000013A4  C3                ret
000013A5  E8D700            call 0x147f
000013A8  58                pop ax
000013A9  CB                retf
000013AA  B800F0            mov ax,0xf000
000013AD  8EC0              mov es,ax
000013AF  26A0FEFF          mov al,[es:0xfffe]
000013B3  A29706            mov [0x697],al
000013B6  C3                ret
000013B7  B000              mov al,0x0
000013B9  E643              out 0x43,al
000013BB  90                nop
000013BC  90                nop
000013BD  E440              in al,0x40
000013BF  8AE0              mov ah,al
000013C1  90                nop
000013C2  E440              in al,0x40
000013C4  86C4              xchg ah,al
000013C6  C3                ret
000013C7  E8EDFF            call 0x13b7
000013CA  8BD8              mov bx,ax
000013CC  2BC1              sub ax,cx
000013CE  8BCB              mov cx,bx
000013D0  3BC2              cmp ax,dx
000013D2  7301              jnc 0x13d5
000013D4  C3                ret
000013D5  3BD2              cmp dx,dx
000013D7  C3                ret
000013D8  BADA03            mov dx,0x3da
000013DB  EC                in al,dx
000013DC  2408              and al,0x8
000013DE  C3                ret
000013DF  0000              add [bx+si],al
000013E1  0000              add [bx+si],al
000013E3  0000              add [bx+si],al
000013E5  0000              add [bx+si],al
000013E7  005006            add [bx+si+0x6],dl
000013EA  57                push di
000013EB  51                push cx
000013EC  B81000            mov ax,0x10
000013EF  8EC0              mov es,ax
000013F1  FC                cld
000013F2  BFB706            mov di,0x6b7
000013F5  B91600            mov cx,0x16
000013F8  B080              mov al,0x80
000013FA  F3AA              rep stosb
000013FC  26A19306          mov ax,[es:0x693]
00001400  2D7000            sub ax,0x70
00001403  26A39106          mov [es:0x691],ax
00001407  B84000            mov ax,0x40
0000140A  8EC0              mov es,ax
0000140C  26A01200          mov al,[es:0x12]
00001410  2EA2E713          mov [cs:0x13e7],al
00001414  59                pop cx
00001415  5F                pop di
00001416  07                pop es
00001417  58                pop ax
00001418  C3                ret
00001419  2BC0              sub ax,ax
0000141B  8EC0              mov es,ax
0000141D  26A12400          mov ax,[es:0x24]
00001421  268B1E2600        mov bx,[es:0x26]
00001426  268B0E2001        mov cx,[es:0x120]
0000142B  268B162201        mov dx,[es:0x122]
00001430  2EA3DF13          mov [cs:0x13df],ax
00001434  2E891EE113        mov [cs:0x13e1],bx
00001439  2E890EE313        mov [cs:0x13e3],cx
0000143E  2E8916E513        mov [cs:0x13e5],dx
00001443  BBB314            mov bx,0x14b3
00001446  803E9706FD        cmp byte [0x697],0xfd
0000144B  7503              jnz 0x1450
0000144D  BBFB14            mov bx,0x14fb
00001450  FA                cli
00001451  26891E2400        mov [es:0x24],bx
00001456  268C0E2600        mov [es:0x26],cs
0000145B  803E9706FD        cmp byte [0x697],0xfd
00001460  751B              jnz 0x147d
00001462  26C70620015415    mov word [es:0x120],0x1554
00001469  268C0E2201        mov [es:0x122],cs
0000146E  B84000            mov ax,0x40
00001471  8EC0              mov es,ax
00001473  26A01800          mov al,[es:0x18]
00001477  0C01              or al,0x1
00001479  26A21800          mov [es:0x18],al
0000147D  FB                sti
0000147E  C3                ret
0000147F  2BC0              sub ax,ax
00001481  8EC0              mov es,ax
00001483  2EA1DF13          mov ax,[cs:0x13df]
00001487  2E8B1EE113        mov bx,[cs:0x13e1]
0000148C  2E8B0EE313        mov cx,[cs:0x13e3]
00001491  2E8B16E513        mov dx,[cs:0x13e5]
00001496  FA                cli
00001497  26A32400          mov [es:0x24],ax
0000149B  26891E2600        mov [es:0x26],bx
000014A0  803E9706FD        cmp byte [0x697],0xfd
000014A5  750A              jnz 0x14b1
000014A7  26890E2001        mov [es:0x120],cx
000014AC  2689162201        mov [es:0x122],dx
000014B1  FB                sti
000014B2  C3                ret
000014B3  50                push ax
000014B4  06                push es
000014B5  57                push di
000014B6  51                push cx
000014B7  BF1000            mov di,0x10
000014BA  8EC7              mov es,di
000014BC  E460              in al,0x60
000014BE  8AE0              mov ah,al
000014C0  247F              and al,0x7f
000014C2  F6C480            test ah,0x80
000014C5  7505              jnz 0x14cc
000014C7  26FF069306        inc word [es:0x693]
000014CC  BFA106            mov di,0x6a1
000014CF  B91600            mov cx,0x16
000014D2  FC                cld
000014D3  F2AE              repne scasb
000014D5  750C              jnz 0x14e3
000014D7  81EFA206          sub di,0x6a2
000014DB  80E480            and ah,0x80
000014DE  2688A5B706        mov [es:di+0x6b7],ah
000014E3  E461              in al,0x61
000014E5  8AE0              mov ah,al
000014E7  0C80              or al,0x80
000014E9  E661              out 0x61,al
000014EB  8AC4              mov al,ah
000014ED  E661              out 0x61,al
000014EF  E88000            call 0x1572
000014F2  59                pop cx
000014F3  5F                pop di
000014F4  07                pop es
000014F5  B020              mov al,0x20
000014F7  E620              out 0x20,al
000014F9  58                pop ax
000014FA  CF                iret
000014FB  FB                sti
000014FC  50                push ax
000014FD  06                push es
000014FE  57                push di
000014FF  51                push cx
00001500  BF1000            mov di,0x10
00001503  8EC7              mov es,di
00001505  8AE0              mov ah,al
00001507  247F              and al,0x7f
00001509  F6C480            test ah,0x80
0000150C  7505              jnz 0x1513
0000150E  26FF069306        inc word [es:0x693]
00001513  80FCFF            cmp ah,0xff
00001516  7418              jz 0x1530
00001518  80FC55            cmp ah,0x55
0000151B  7413              jz 0x1530
0000151D  06                push es
0000151E  BF4000            mov di,0x40
00001521  8EC7              mov es,di
00001523  268A0E1200        mov cl,[es:0x12]
00001528  07                pop es
00001529  2E3A0EE713        cmp cl,[cs:0x13e7]
0000152E  7405              jz 0x1535
00001530  E8B5FE            call 0x13e8
00001533  EB17              jmp short 0x154c
00001535  BFA106            mov di,0x6a1
00001538  B91600            mov cx,0x16
0000153B  FC                cld
0000153C  F2AE              repne scasb
0000153E  750C              jnz 0x154c
00001540  81EFA206          sub di,0x6a2
00001544  80E480            and ah,0x80
00001547  2688A5B706        mov [es:di+0x6b7],ah
0000154C  E82300            call 0x1572
0000154F  59                pop cx
00001550  5F                pop di
00001551  07                pop es
00001552  58                pop ax
00001553  CF                iret
00001554  CD09              int 0x9
00001556  CF                iret
00001557  B800F0            mov ax,0xf000
0000155A  8ED0              mov ss,ax
0000155C  B84000            mov ax,0x40
0000155F  8ED8              mov ds,ax
00001561  BB7200            mov bx,0x72
00001564  C7073412          mov word [bx],0x1234
00001568  B80000            mov ax,0x0
0000156B  8EC0              mov es,ax
0000156D  EA5BE000F0        jmp 0xf000:0xe05b
00001572  26A0C906          mov al,[es:0x6c9]
00001576  260A06B706        or al,[es:0x6b7]
0000157B  3C00              cmp al,0x0
0000157D  754A              jnz 0x15c9
0000157F  26F606CA0680      test byte [es:0x6ca],0x80
00001585  7506              jnz 0x158d
00001587  B020              mov al,0x20
00001589  E620              out 0x20,al
0000158B  EBCA              jmp short 0x1557
0000158D  26F606B90680      test byte [es:0x6b9],0x80
00001593  750F              jnz 0x15a4
00001595  26803E900601      cmp byte [es:0x690],0x1
0000159B  722C              jc 0x15c9
0000159D  26FE0E9006        dec byte [es:0x690]
000015A2  EB15              jmp short 0x15b9
000015A4  26F606BB0680      test byte [es:0x6bb],0x80
000015AA  751D              jnz 0x15c9
000015AC  26803E900607      cmp byte [es:0x690],0x7
000015B2  7315              jnc 0x15c9
000015B4  26FE069006        inc byte [es:0x690]
000015B9  52                push dx
000015BA  B002              mov al,0x2
000015BC  BAD403            mov dx,0x3d4
000015BF  EE                out dx,al
000015C0  26A09006          mov al,[es:0x690]
000015C4  0427              add al,0x27
000015C6  42                inc dx
000015C7  EE                out dx,al
000015C8  5A                pop dx
000015C9  C3                ret
000015CA  0000              add [bx+si],al
000015CC  0000              add [bx+si],al
000015CE  0000              add [bx+si],al
000015D0  8B1E0800          mov bx,[0x8]
000015D4  8A8F0E10          mov cl,[bx+0x100e]
000015D8  E82218            call 0x2dfd
000015DB  80E207            and dl,0x7
000015DE  3AD1              cmp dl,cl
000015E0  77F6              ja 0x15d8
000015E2  02970610          add dl,[bx+0x1006]
000015E6  3A162810          cmp dl,[0x1028]
000015EA  74EC              jz 0x15d8
000015EC  88162810          mov [0x1028],dl
000015F0  8ADA              mov bl,dl
000015F2  8A8FF00F          mov cl,[bx+0xff0]
000015F6  B288              mov dl,0x88
000015F8  F6C180            test cl,0x80
000015FB  7502              jnz 0x15ff
000015FD  B290              mov dl,0x90
000015FF  81E17F00          and cx,0x7f
00001603  D1E1              shl cx,1
00001605  D1E1              shl cx,1
00001607  C3                ret
00001608  833E040007        cmp word [0x4],byte +0x7
0000160D  7504              jnz 0x1613
0000160F  E8E81A            call 0x30fa
00001612  C3                ret
00001613  833E040000        cmp word [0x4],byte +0x0
00001618  7404              jz 0x161e
0000161A  E8A900            call 0x16c6
0000161D  C3                ret
0000161E  A07B05            mov al,[0x57b]
00001621  24F8              and al,0xf8
00001623  3C60              cmp al,0x60
00001625  7409              jz 0x1630
00001627  E82D00            call 0x1657
0000162A  722A              jc 0x1656
0000162C  E87E01            call 0x17ad
0000162F  C3                ret
00001630  803E500502        cmp byte [0x550],0x2
00001635  731E              jnc 0x1655
00001637  A27B05            mov [0x57b],al
0000163A  0432              add al,0x32
0000163C  A27C05            mov [0x57c],al
0000163F  803E500501        cmp byte [0x550],0x1
00001644  740D              jz 0x1653
00001646  C606500501        mov byte [0x550],0x1
0000164B  2AE4              sub ah,ah
0000164D  CD1A              int 0x1a
0000164F  89165605          mov [0x556],dx
00001653  F9                stc
00001654  C3                ret
00001655  F8                clc
00001656  C3                ret
00001657  8A0E7B05          mov cl,[0x57b]
0000165B  80C102            add cl,0x2
0000165E  80E1F8            and cl,0xf8
00001661  8B1E0800          mov bx,[0x8]
00001665  8A9F0610          mov bl,[bx+0x1006]
00001669  8A87F00F          mov al,[bx+0xff0]
0000166D  3C00              cmp al,0x0
0000166F  7507              jnz 0x1678
00001671  C6067C1200        mov byte [0x127c],0x0
00001676  F8                clc
00001677  C3                ret
00001678  43                inc bx
00001679  B588              mov ch,0x88
0000167B  A880              test al,0x80
0000167D  7502              jnz 0x1681
0000167F  B590              mov ch,0x90
00001681  3ACD              cmp cl,ch
00001683  75E4              jnz 0x1669
00001685  257F00            and ax,0x7f
00001688  D1E0              shl ax,1
0000168A  D1E0              shl ax,1
0000168C  8B167905          mov dx,[0x579]
00001690  81E2F8FF          and dx,0xfff8
00001694  3BD0              cmp dx,ax
00001696  72D1              jc 0x1669
00001698  8B167905          mov dx,[0x579]
0000169C  83EA0F            sub dx,byte +0xf
0000169F  81E2F8FF          and dx,0xfff8
000016A3  3BD0              cmp dx,ax
000016A5  77C2              ja 0x1669
000016A7  80ED02            sub ch,0x2
000016AA  882E7B05          mov [0x57b],ch
000016AE  80C532            add ch,0x32
000016B1  882E7C05          mov [0x57c],ch
000016B5  803E7C1200        cmp byte [0x127c],0x0
000016BA  7508              jnz 0x16c4
000016BC  C6067C1201        mov byte [0x127c],0x1
000016C1  E84A42            call 0x590e
000016C4  F9                stc
000016C5  C3                ret
000016C6  C606E03900        mov byte [0x39e0],0x0
000016CB  803E710501        cmp byte [0x571],0x1
000016D0  752A              jnz 0x16fc
000016D2  A15026            mov ax,[0x2650]
000016D5  2D0400            sub ax,0x4
000016D8  8A165226          mov dl,[0x2652]
000016DC  80EA08            sub dl,0x8
000016DF  BE0C00            mov si,0xc
000016E2  8B1E7905          mov bx,[0x579]
000016E6  8A367B05          mov dh,[0x57b]
000016EA  BF1800            mov di,0x18
000016ED  B9100E            mov cx,0xe10
000016F0  E83617            call 0x2e29
000016F3  7307              jnc 0x16fc
000016F5  C606510501        mov byte [0x551],0x1
000016FA  F8                clc
000016FB  C3                ret
000016FC  833E040003        cmp word [0x4],byte +0x3
00001701  750B              jnz 0x170e
00001703  E83D25            call 0x3c43
00001706  7306              jnc 0x170e
00001708  C6065C0501        mov byte [0x55c],0x1
0000170D  C3                ret
0000170E  8A0E7B05          mov cl,[0x57b]
00001712  80E1F8            and cl,0xf8
00001715  8B1E0400          mov bx,[0x4]
00001719  D1E3              shl bx,1
0000171B  8B9F6912          mov bx,[bx+0x1269]
0000171F  8AAF2910          mov ch,[bx+0x1029]
00001723  80FD00            cmp ch,0x0
00001726  7502              jnz 0x172a
00001728  F8                clc
00001729  C3                ret
0000172A  8A878910          mov al,[bx+0x1089]
0000172E  A27B12            mov [0x127b],al
00001731  D0E3              shl bl,1
00001733  8B87A911          mov ax,[bx+0x11a9]
00001737  A37912            mov [0x1279],ax
0000173A  8B87E910          mov ax,[bx+0x10e9]
0000173E  D0EB              shr bl,1
00001740  43                inc bx
00001741  3ACD              cmp cl,ch
00001743  75DA              jnz 0x171f
00001745  8B167905          mov dx,[0x579]
00001749  81E2F8FF          and dx,0xfff8
0000174D  3BD0              cmp dx,ax
0000174F  72CE              jc 0x171f
00001751  8B167905          mov dx,[0x579]
00001755  2B167912          sub dx,[0x1279]
00001759  7302              jnc 0x175d
0000175B  2BD2              sub dx,dx
0000175D  81E2FCFF          and dx,0xfffc
00001761  3BD0              cmp dx,ax
00001763  77BA              ja 0x171f
00001765  882E7B05          mov [0x57b],ch
00001769  80C532            add ch,0x32
0000176C  882E7C05          mov [0x57c],ch
00001770  A07B12            mov al,[0x127b]
00001773  A25C05            mov [0x55c],al
00001776  3C00              cmp al,0x0
00001778  7406              jz 0x1780
0000177A  81267905FCFF      and word [0x579],0xfffc
00001780  833E040004        cmp word [0x4],byte +0x4
00001785  7510              jnz 0x1797
00001787  4B                dec bx
00001788  83EB27            sub bx,byte +0x27
0000178B  720A              jc 0x1797
0000178D  83FB10            cmp bx,byte +0x10
00001790  7305              jnc 0x1797
00001792  43                inc bx
00001793  881EE039          mov [0x39e0],bl
00001797  F9                stc
00001798  C3                ret
00001799  B103              mov cl,0x3
0000179B  D3EB              shr bx,cl
0000179D  8AEB              mov ch,bl
0000179F  B103              mov cl,0x3
000017A1  D3EB              shr bx,cl
000017A3  8ACD              mov cl,ch
000017A5  80E107            and cl,0x7
000017A8  B580              mov ch,0x80
000017AA  D2ED              shr ch,cl
000017AC  C3                ret
000017AD  8A167B05          mov dl,[0x57b]
000017B1  80E2F8            and dl,0xf8
000017B4  2BDB              sub bx,bx
000017B6  80FA08            cmp dl,0x8
000017B9  740E              jz 0x17c9
000017BB  FEC3              inc bl
000017BD  80FA28            cmp dl,0x28
000017C0  7407              jz 0x17c9
000017C2  FEC3              inc bl
000017C4  80FA48            cmp dl,0x48
000017C7  7547              jnz 0x1810
000017C9  A17905            mov ax,[0x579]
000017CC  3B1E2F05          cmp bx,[0x52f]
000017D0  752A              jnz 0x17fc
000017D2  803E250503        cmp byte [0x525],0x3
000017D7  7723              ja 0x17fc
000017D9  80FB01            cmp bl,0x1
000017DC  7410              jz 0x17ee
000017DE  B90400            mov cx,0x4
000017E1  2A0E2505          sub cl,[0x525]
000017E5  D0E1              shl cl,1
000017E7  D0E1              shl cl,1
000017E9  03C1              add ax,cx
000017EB  EB0F              jmp short 0x17fc
000017ED  90                nop
000017EE  2AED              sub ch,ch
000017F0  8A0E2505          mov cl,[0x525]
000017F4  FEC1              inc cl
000017F6  D0E1              shl cl,1
000017F8  D0E1              shl cl,1
000017FA  2BC1              sub ax,cx
000017FC  8A9F2510          mov bl,[bx+0x1025]
00001800  8BF3              mov si,bx
00001802  8BD8              mov bx,ax
00001804  83C30A            add bx,byte +0xa
00001807  E88FFF            call 0x1799
0000180A  84A81610          test [bx+si+0x1016],ch
0000180E  7502              jnz 0x1812
00001810  F8                clc
00001811  C3                ret
00001812  88167B05          mov [0x57b],dl
00001816  80C232            add dl,0x32
00001819  88167C05          mov [0x57c],dl
0000181D  81267905F8FF      and word [0x579],0xfff8
00001823  C6065C0501        mov byte [0x55c],0x1
00001828  F9                stc
00001829  C3                ret
0000182A  0000              add [bx+si],al
0000182C  0000              add [bx+si],al
0000182E  0000              add [bx+si],al
00001830  C606651600        mov byte [0x1665],0x0
00001835  C606731600        mov byte [0x1673],0x0
0000183A  C606771600        mov byte [0x1677],0x0
0000183F  C606781600        mov byte [0x1678],0x0
00001844  C7066C160900      mov word [0x166c],0x9
0000184A  C3                ret
0000184B  803E731600        cmp byte [0x1673],0x0
00001850  740A              jz 0x185c
00001852  2AE4              sub ah,ah
00001854  CD1A              int 0x1a
00001856  3B16EC17          cmp dx,[0x17ec]
0000185A  7501              jnz 0x185d
0000185C  C3                ret
0000185D  8916EC17          mov [0x17ec],dx
00001861  803E771600        cmp byte [0x1677],0x0
00001866  7417              jz 0x187f
00001868  A17116            mov ax,[0x1671]
0000186B  25F8FF            and ax,0xfff8
0000186E  8B1E7905          mov bx,[0x579]
00001872  81E3F8FF          and bx,0xfff8
00001876  3BC3              cmp ax,bx
00001878  7505              jnz 0x187f
0000187A  C606741600        mov byte [0x1674],0x0
0000187F  FE06E917          inc byte [0x17e9]
00001883  833EEA1701        cmp word [0x17ea],byte +0x1
00001888  7704              ja 0x188e
0000188A  FF0EEA17          dec word [0x17ea]
0000188E  A17116            mov ax,[0x1671]
00001891  8B16EA17          mov dx,[0x17ea]
00001895  B103              mov cl,0x3
00001897  D2EA              shr dl,cl
00001899  803E741601        cmp byte [0x1674],0x1
0000189E  7215              jc 0x18b5
000018A0  750D              jnz 0x18af
000018A2  03C2              add ax,dx
000018A4  3D2F01            cmp ax,0x12f
000018A7  720C              jc 0x18b5
000018A9  B82E01            mov ax,0x12e
000018AC  EB07              jmp short 0x18b5
000018AE  90                nop
000018AF  2BC2              sub ax,dx
000018B1  7302              jnc 0x18b5
000018B3  2BC0              sub ax,ax
000018B5  A37116            mov [0x1671],ax
000018B8  8B1EDF17          mov bx,[0x17df]
000018BC  A0E917            mov al,[0x17e9]
000018BF  D0E8              shr al,1
000018C1  02067316          add al,[0x1673]
000018C5  8AD0              mov dl,al
000018C7  2A067616          sub al,[0x1676]
000018CB  7214              jc 0x18e1
000018CD  2AF8              sub bh,al
000018CF  7402              jz 0x18d3
000018D1  730E              jnc 0x18e1
000018D3  C606731600        mov byte [0x1673],0x0
000018D8  C606781600        mov byte [0x1678],0x0
000018DD  E84200            call 0x1922
000018E0  C3                ret
000018E1  88167316          mov [0x1673],dl
000018E5  8B0E7116          mov cx,[0x1671]
000018E9  891EE117          mov [0x17e1],bx
000018ED  E8C013            call 0x2cb0
000018F0  A3E717            mov [0x17e7],ax
000018F3  803EE91702        cmp byte [0x17e9],0x2
000018F8  7403              jz 0x18fd
000018FA  E82500            call 0x1922
000018FD  E87A02            call 0x1b7a
00001900  72DE              jc 0x18e0
00001902  8B3EE717          mov di,[0x17e7]
00001906  893EE517          mov [0x17e5],di
0000190A  8B0EE117          mov cx,[0x17e1]
0000190E  890EE317          mov [0x17e3],cx
00001912  B800B8            mov ax,0xb800
00001915  8EC0              mov es,ax
00001917  8B36DD17          mov si,[0x17dd]
0000191B  BDEE17            mov bp,0x17ee
0000191E  E8AB13            call 0x2ccc
00001921  C3                ret
00001922  B800B8            mov ax,0xb800
00001925  8EC0              mov es,ax
00001927  8B3EE517          mov di,[0x17e5]
0000192B  BEEE17            mov si,0x17ee
0000192E  8B0EE317          mov cx,[0x17e3]
00001932  E86814            call 0x2d9d
00001935  C3                ret
00001936  FE0E6A16          dec byte [0x166a]
0000193A  7401              jz 0x193d
0000193C  C3                ret
0000193D  C6066A160D        mov byte [0x166a],0xd
00001942  E893FA            call 0x13d8
00001945  75F5              jnz 0x193c
00001947  803E651600        cmp byte [0x1665],0x0
0000194C  7403              jz 0x1951
0000194E  E8B401            call 0x1b05
00001951  803E731600        cmp byte [0x1673],0x0
00001956  75E4              jnz 0x193c
00001958  803E651600        cmp byte [0x1665],0x0
0000195D  756E              jnz 0x19cd
0000195F  803E7B0560        cmp byte [0x57b],0x60
00001964  77D6              ja 0x193c
00001966  C606771600        mov byte [0x1677],0x0
0000196B  803E500501        cmp byte [0x550],0x1
00001970  7518              jnz 0x198a
00001972  803E180400        cmp byte [0x418],0x0
00001977  7511              jnz 0x198a
00001979  2AE4              sub ah,ah
0000197B  CD1A              int 0x1a
0000197D  2B165605          sub dx,[0x556]
00001981  83FA48            cmp dx,byte +0x48
00001984  7204              jc 0x198a
00001986  FE067716          inc byte [0x1677]
0000198A  E87014            call 0x2dfd
0000198D  803E771600        cmp byte [0x1677],0x0
00001992  7406              jz 0x199a
00001994  80E203            and dl,0x3
00001997  EB09              jmp short 0x19a2
00001999  90                nop
0000199A  80E20F            and dl,0xf
0000199D  80FA0C            cmp dl,0xc
000019A0  739A              jnc 0x193c
000019A2  88166916          mov [0x1669],dl
000019A6  E84101            call 0x1aea
000019A9  890E6616          mov [0x1666],cx
000019AD  88166816          mov [0x1668],dl
000019B1  E85101            call 0x1b05
000019B4  72D4              jc 0x198a
000019B6  C60665161D        mov byte [0x1665],0x1d
000019BB  8B1E0800          mov bx,[0x8]
000019BF  D0E3              shl bl,1
000019C1  8B871E18          mov ax,[bx+0x181e]
000019C5  A36C16            mov [0x166c],ax
000019C8  C606701601        mov byte [0x1670],0x1
000019CD  E83501            call 0x1b05
000019D0  720E              jc 0x19e0
000019D2  C606641600        mov byte [0x1664],0x0
000019D7  E87201            call 0x1b4c
000019DA  7305              jnc 0x19e1
000019DC  FE066416          inc byte [0x1664]
000019E0  C3                ret
000019E1  803E651610        cmp byte [0x1665],0x10
000019E6  7508              jnz 0x19f0
000019E8  2AE4              sub ah,ah
000019EA  CD1A              int 0x1a
000019EC  89166E16          mov [0x166e],dx
000019F0  803E65160F        cmp byte [0x1665],0xf
000019F5  757F              jnz 0x1a76
000019F7  2AE4              sub ah,ah
000019F9  CD1A              int 0x1a
000019FB  2B166E16          sub dx,[0x166e]
000019FF  3B166C16          cmp dx,[0x166c]
00001A03  7371              jnc 0x1a76
00001A05  803E701600        cmp byte [0x1670],0x0
00001A0A  7469              jz 0x1a75
00001A0C  803E731600        cmp byte [0x1673],0x0
00001A11  7562              jnz 0x1a75
00001A13  803E180400        cmp byte [0x418],0x0
00001A18  755B              jnz 0x1a75
00001A1A  FE0E7016          dec byte [0x1670]
00001A1E  C606781601        mov byte [0x1678],0x1
00001A23  A06816            mov al,[0x1668]
00001A26  A27316            mov [0x1673],al
00001A29  E8D113            call 0x2dfd
00001A2C  81E20F00          and dx,0xf
00001A30  03166616          add dx,[0x1666]
00001A34  89167116          mov [0x1671],dx
00001A38  B001              mov al,0x1
00001A3A  3B167905          cmp dx,[0x579]
00001A3E  7202              jc 0x1a42
00001A40  B0FF              mov al,0xff
00001A42  A27416            mov [0x1674],al
00001A45  E8B513            call 0x2dfd
00001A48  8ADA              mov bl,dl
00001A4A  81E30600          and bx,0x6
00001A4E  8B87C917          mov ax,[bx+0x17c9]
00001A52  A3DD17            mov [0x17dd],ax
00001A55  8B87D117          mov ax,[bx+0x17d1]
00001A59  A3DF17            mov [0x17df],ax
00001A5C  D0EB              shr bl,1
00001A5E  8A87D917          mov al,[bx+0x17d9]
00001A62  A27616            mov [0x1676],al
00001A65  C706EA172000      mov word [0x17ea],0x20
00001A6B  C606E91701        mov byte [0x17e9],0x1
00001A70  C606751600        mov byte [0x1675],0x0
00001A75  C3                ret
00001A76  FE0E6516          dec byte [0x1665]
00001A7A  8B0E6616          mov cx,[0x1666]
00001A7E  8A166816          mov dl,[0x1668]
00001A82  803E65160E        cmp byte [0x1665],0xe
00001A87  760A              jna 0x1a93
00001A89  02166516          add dl,[0x1665]
00001A8D  80EA0E            sub dl,0xe
00001A90  EB08              jmp short 0x1a9a
00001A92  90                nop
00001A93  80C20E            add dl,0xe
00001A96  2A166516          sub dl,[0x1665]
00001A9A  88166B16          mov [0x166b],dl
00001A9E  E80F12            call 0x2cb0
00001AA1  8BF8              mov di,ax
00001AA3  B800B8            mov ax,0xb800
00001AA6  8EC0              mov es,ax
00001AA8  FC                cld
00001AA9  B90400            mov cx,0x4
00001AAC  803E65160E        cmp byte [0x1665],0xe
00001AB1  7624              jna 0x1ad7
00001AB3  803E180400        cmp byte [0x418],0x0
00001AB8  7418              jz 0x1ad2
00001ABA  A06B16            mov al,[0x166b]
00001ABD  2A066816          sub al,[0x1668]
00001AC1  2AE4              sub ah,ah
00001AC3  B103              mov cl,0x3
00001AC5  D3E0              shl ax,cl
00001AC7  05E015            add ax,0x15e0
00001ACA  8BF0              mov si,ax
00001ACC  B90400            mov cx,0x4
00001ACF  F3A5              rep movsw
00001AD1  C3                ret
00001AD2  2BC0              sub ax,ax
00001AD4  F3AB              rep stosw
00001AD6  C3                ret
00001AD7  A06B16            mov al,[0x166b]
00001ADA  2A066816          sub al,[0x1668]
00001ADE  B40A              mov ah,0xa
00001AE0  F6E4              mul ah
00001AE2  058126            add ax,0x2681
00001AE5  8BF0              mov si,ax
00001AE7  F3A5              rep movsw
00001AE9  C3                ret
00001AEA  2AFF              sub bh,bh
00001AEC  8ADA              mov bl,dl
00001AEE  80E303            and bl,0x3
00001AF1  D0E3              shl bl,1
00001AF3  8B8F5816          mov cx,[bx+0x1658]
00001AF7  8ADA              mov bl,dl
00001AF9  D0EB              shr bl,1
00001AFB  D0EB              shr bl,1
00001AFD  80E303            and bl,0x3
00001B00  8A976016          mov dl,[bx+0x1660]
00001B04  C3                ret
00001B05  A16616            mov ax,[0x1666]
00001B08  8A166816          mov dl,[0x1668]
00001B0C  8B1E7905          mov bx,[0x579]
00001B10  8A367B05          mov dh,[0x57b]
00001B14  BE2000            mov si,0x20
00001B17  BF1800            mov di,0x18
00001B1A  B90F0E            mov cx,0xe0f
00001B1D  E80913            call 0x2e29
00001B20  7329              jnc 0x1b4b
00001B22  803E710501        cmp byte [0x571],0x1
00001B27  7521              jnz 0x1b4a
00001B29  803E5A0500        cmp byte [0x55a],0x0
00001B2E  751A              jnz 0x1b4a
00001B30  803E7B0560        cmp byte [0x57b],0x60
00001B35  7313              jnc 0x1b4a
00001B37  803E651605        cmp byte [0x1665],0x5
00001B3C  720C              jc 0x1b4a
00001B3E  803E651619        cmp byte [0x1665],0x19
00001B43  7305              jnc 0x1b4a
00001B45  C606510501        mov byte [0x551],0x1
00001B4A  F9                stc
00001B4B  C3                ret
00001B4C  A06916            mov al,[0x1669]
00001B4F  3C08              cmp al,0x8
00001B51  7325              jnc 0x1b78
00001B53  BB0200            mov bx,0x2
00001B56  A804              test al,0x4
00001B58  7402              jz 0x1b5c
00001B5A  D0E3              shl bl,1
00001B5C  8B87301F          mov ax,[bx+0x1f30]
00001B60  051000            add ax,0x10
00001B63  3B066616          cmp ax,[0x1666]
00001B67  720F              jc 0x1b78
00001B69  2D3000            sub ax,0x30
00001B6C  7302              jnc 0x1b70
00001B6E  2BC0              sub ax,ax
00001B70  3B066616          cmp ax,[0x1666]
00001B74  7702              ja 0x1b78
00001B76  F9                stc
00001B77  C3                ret
00001B78  F8                clc
00001B79  C3                ret
00001B7A  833E040000        cmp word [0x4],byte +0x0
00001B7F  7560              jnz 0x1be1
00001B81  8A167316          mov dl,[0x1673]
00001B85  80FA00            cmp dl,0x0
00001B88  7457              jz 0x1be1
00001B8A  8B0EDF17          mov cx,[0x17df]
00001B8E  86CD              xchg ch,cl
00001B90  BE1000            mov si,0x10
00001B93  A17116            mov ax,[0x1671]
00001B96  8B1E7905          mov bx,[0x579]
00001B9A  8A367B05          mov dh,[0x57b]
00001B9E  BF1800            mov di,0x18
00001BA1  B50E              mov ch,0xe
00001BA3  E88312            call 0x2e29
00001BA6  733A              jnc 0x1be2
00001BA8  E838F6            call 0x11e3
00001BAB  E874FD            call 0x1922
00001BAE  E82CF5            call 0x10dd
00001BB1  803E751600        cmp byte [0x1675],0x0
00001BB6  7527              jnz 0x1bdf
00001BB8  C606751601        mov byte [0x1675],0x1
00001BBD  E8A6F5            call 0x1166
00001BC0  B201              mov dl,0x1
00001BC2  803E7416FF        cmp byte [0x1674],0xff
00001BC7  7402              jz 0x1bcb
00001BC9  B2FF              mov dl,0xff
00001BCB  88167416          mov [0x1674],dl
00001BCF  C706EA176000      mov word [0x17ea],0x60
00001BD5  C606E91701        mov byte [0x17e9],0x1
00001BDA  C6065C0500        mov byte [0x55c],0x0
00001BDF  F9                stc
00001BE0  C3                ret
00001BE1  F8                clc
00001BE2  C3                ret
00001BE3  0000              add [bx+si],al
00001BE5  0000              add [bx+si],al
00001BE7  0000              add [bx+si],al
00001BE9  0000              add [bx+si],al
00001BEB  0000              add [bx+si],al
00001BED  0000              add [bx+si],al
00001BEF  002B              add [bp+di],ch
00001BF1  DB                db 0xdb
00001BF2  B40B              mov ah,0xb
00001BF4  CD10              int 0x10
00001BF6  833E060007        cmp word [0x6],byte +0x7
00001BFB  7515              jnz 0x1c12
00001BFD  803E530500        cmp byte [0x553],0x0
00001C02  740E              jz 0x1c12
00001C04  E88436            call 0x528b
00001C07  C70679059800      mov word [0x579],0x98
00001C0D  C6067B055F        mov byte [0x57b],0x5f
00001C12  B800B8            mov ax,0xb800
00001C15  8EC0              mov es,ax
00001C17  FC                cld
00001C18  C70639180000      mov word [0x1839],0x0
00001C1E  E84600            call 0x1c67
00001C21  E8FD3E            call 0x5b21
00001C24  E80A01            call 0x1d31
00001C27  833E040000        cmp word [0x4],byte +0x0
00001C2C  751B              jnz 0x1c49
00001C2E  803E530500        cmp byte [0x553],0x0
00001C33  7411              jz 0x1c46
00001C35  833E060007        cmp word [0x6],byte +0x7
00001C3A  7505              jnz 0x1c41
00001C3C  E8D436            call 0x5313
00001C3F  EB08              jmp short 0x1c49
00001C41  E86C1C            call 0x38b0
00001C44  EB03              jmp short 0x1c49
00001C46  E82D01            call 0x1d76
00001C49  833E040007        cmp word [0x4],byte +0x7
00001C4E  740A              jz 0x1c5a
00001C50  B8AAAA            mov ax,0xaaaa
00001C53  833E040002        cmp word [0x4],byte +0x2
00001C58  7503              jnz 0x1c5d
00001C5A  B85555            mov ax,0x5555
00001C5D  A33918            mov [0x1839],ax
00001C60  E80400            call 0x1c67
00001C63  E8BB3E            call 0x5b21
00001C66  C3                ret
00001C67  E82C3C            call 0x5896
00001C6A  C70635180100      mov word [0x1835],0x1
00001C70  C606371808        mov byte [0x1837],0x8
00001C75  8B0E7905          mov cx,[0x579]
00001C79  8A167B05          mov dl,[0x57b]
00001C7D  83C10C            add cx,byte +0xc
00001C80  81E1F0FF          and cx,0xfff0
00001C84  80C208            add dl,0x8
00001C87  C606381800        mov byte [0x1838],0x0
00001C8C  E8083C            call 0x5897
00001C8F  890E3218          mov [0x1832],cx
00001C93  88163418          mov [0x1834],dl
00001C97  E81610            call 0x2cb0
00001C9A  8BF8              mov di,ax
00001C9C  8A1E3718          mov bl,[0x1837]
00001CA0  A13918            mov ax,[0x1839]
00001CA3  8B0E3518          mov cx,[0x1835]
00001CA7  D1E9              shr cx,1
00001CA9  D1E9              shr cx,1
00001CAB  D1E9              shr cx,1
00001CAD  F3AB              rep stosw
00001CAF  8B0E3518          mov cx,[0x1835]
00001CB3  D1E9              shr cx,1
00001CB5  D1E9              shr cx,1
00001CB7  81E1FE00          and cx,0xfe
00001CBB  2BF9              sub di,cx
00001CBD  81F70020          xor di,0x2000
00001CC1  F7C70020          test di,0x2000
00001CC5  7503              jnz 0x1cca
00001CC7  83C750            add di,byte +0x50
00001CCA  FECB              dec bl
00001CCC  75D2              jnz 0x1ca0
00001CCE  803E38180F        cmp byte [0x1838],0xf
00001CD3  7501              jnz 0x1cd6
00001CD5  C3                ret
00001CD6  8306351820        add word [0x1835],byte +0x20
00001CDB  8006371810        add byte [0x1837],0x10
00001CE0  8B0E3218          mov cx,[0x1832]
00001CE4  8A163418          mov dl,[0x1834]
00001CE8  83E910            sub cx,byte +0x10
00001CEB  7307              jnc 0x1cf4
00001CED  2BC9              sub cx,cx
00001CEF  800E381801        or byte [0x1838],0x1
00001CF4  A13518            mov ax,[0x1835]
00001CF7  03C1              add ax,cx
00001CF9  3D4001            cmp ax,0x140
00001CFC  720D              jc 0x1d0b
00001CFE  B84001            mov ax,0x140
00001D01  2BC1              sub ax,cx
00001D03  A33518            mov [0x1835],ax
00001D06  800E381802        or byte [0x1838],0x2
00001D0B  80EA08            sub dl,0x8
00001D0E  7307              jnc 0x1d17
00001D10  2AD2              sub dl,dl
00001D12  800E381804        or byte [0x1838],0x4
00001D17  A03718            mov al,[0x1837]
00001D1A  02C2              add al,dl
00001D1C  7204              jc 0x1d22
00001D1E  3CC8              cmp al,0xc8
00001D20  720C              jc 0x1d2e
00001D22  B0C8              mov al,0xc8
00001D24  2AC2              sub al,dl
00001D26  A23718            mov [0x1837],al
00001D29  800E381808        or byte [0x1838],0x8
00001D2E  E95BFF            jmp 0x1c8c
00001D31  803E9706FD        cmp byte [0x697],0xfd
00001D36  7410              jz 0x1d48
00001D38  B40B              mov ah,0xb
00001D3A  B701              mov bh,0x1
00001D3C  8B360400          mov si,[0x4]
00001D40  8A9C5318          mov bl,[si+0x1853]
00001D44  CD10              int 0x10
00001D46  EB1F              jmp short 0x1d67
00001D48  8B360400          mov si,[0x4]
00001D4C  B301              mov bl,0x1
00001D4E  8ABC3B18          mov bh,[si+0x183b]
00001D52  E81900            call 0x1d6e
00001D55  B302              mov bl,0x2
00001D57  8ABC4318          mov bh,[si+0x1843]
00001D5B  E81000            call 0x1d6e
00001D5E  B303              mov bl,0x3
00001D60  8ABC4B18          mov bh,[si+0x184b]
00001D64  E80700            call 0x1d6e
00001D67  B40B              mov ah,0xb
00001D69  2BDB              sub bx,bx
00001D6B  CD10              int 0x10
00001D6D  C3                ret
00001D6E  B80010            mov ax,0x1000
00001D71  56                push si
00001D72  CD10              int 0x10
00001D74  5E                pop si
00001D75  C3                ret
00001D76  833E060007        cmp word [0x6],byte +0x7
00001D7B  7504              jnz 0x1d81
00001D7D  E8C042            call 0x6040
00001D80  C3                ret
00001D81  E8513A            call 0x57d5
00001D84  B85B18            mov ax,0x185b
00001D87  803E520500        cmp byte [0x552],0x0
00001D8C  7438              jz 0x1dc6
00001D8E  8B1E301C          mov bx,[0x1c30]
00001D92  8306301C02        add word [0x1c30],byte +0x2
00001D97  81E30600          and bx,0x6
00001D9B  8B87261C          mov ax,[bx+0x1c26]
00001D9F  803E801F00        cmp byte [0x1f80],0x0
00001DA4  7404              jz 0x1daa
00001DA6  FE0E801F          dec byte [0x1f80]
00001DAA  803E5205DD        cmp byte [0x552],0xdd
00001DAF  7515              jnz 0x1dc6
00001DB1  833E080000        cmp word [0x8],byte +0x0
00001DB6  740E              jz 0x1dc6
00001DB8  803E801F01        cmp byte [0x1f80],0x1
00001DBD  7207              jc 0x1dc6
00001DBF  E81E3E            call 0x5be0
00001DC2  E85C3D            call 0x5b21
00001DC5  C3                ret
00001DC6  A32E1C            mov [0x1c2e],ax
00001DC9  C7061B1C8080      mov word [0x1c1b],0x8080
00001DCF  C6061D1C1C        mov byte [0x1c1d],0x1c
00001DD4  E84000            call 0x1e17
00001DD7  2AE4              sub ah,ah
00001DD9  CD1A              int 0x1a
00001DDB  89163018          mov [0x1830],dx
00001DDF  E8023A            call 0x57e4
00001DE2  2AE4              sub ah,ah
00001DE4  CD1A              int 0x1a
00001DE6  3B163018          cmp dx,[0x1830]
00001DEA  74F3              jz 0x1ddf
00001DEC  803E1D1C14        cmp byte [0x1c1d],0x14
00001DF1  770F              ja 0x1e02
00001DF3  2AFF              sub bh,bh
00001DF5  8A1E1D1C          mov bl,[0x1c1d]
00001DF9  80E306            and bl,0x6
00001DFC  8B871E1C          mov ax,[bx+0x1c1e]
00001E00  EB08              jmp short 0x1e0a
00001E02  A11B1C            mov ax,[0x1c1b]
00001E05  F9                stc
00001E06  D0D8              rcr al,1
00001E08  8AE0              mov ah,al
00001E0A  A31B1C            mov [0x1c1b],ax
00001E0D  FE0E1D1C          dec byte [0x1c1d]
00001E11  75C1              jnz 0x1dd4
00001E13  E80B3D            call 0x5b21
00001E16  C3                ret
00001E17  FC                cld
00001E18  1E                push ds
00001E19  07                pop es
00001E1A  8B362E1C          mov si,[0x1c2e]
00001E1E  BF0E00            mov di,0xe
00001E21  B96000            mov cx,0x60
00001E24  AD                lodsw
00001E25  23061B1C          and ax,[0x1c1b]
00001E29  AB                stosw
00001E2A  E2F8              loop 0x1e24
00001E2C  B800B8            mov ax,0xb800
00001E2F  8EC0              mov es,ax
00001E31  BE0E00            mov si,0xe
00001E34  BFD00E            mov di,0xed0
00001E37  B9080C            mov cx,0xc08
00001E3A  E8600F            call 0x2d9d
00001E3D  C3                ret
00001E3E  0000              add [bx+si],al
00001E40  C606BF1C00        mov byte [0x1cbf],0x0
00001E45  C706E11C0000      mov word [0x1ce1],0x0
00001E4B  C606C01C00        mov byte [0x1cc0],0x0
00001E50  C606C11C00        mov byte [0x1cc1],0x0
00001E55  C606B81C00        mov byte [0x1cb8],0x0
00001E5A  C606C81CB1        mov byte [0x1cc8],0xb1
00001E5F  E8EE35            call 0x5450
00001E62  C3                ret
00001E63  2AE4              sub ah,ah
00001E65  CD1A              int 0x1a
00001E67  8BCA              mov cx,dx
00001E69  2B16C91C          sub dx,[0x1cc9]
00001E6D  A1E11C            mov ax,[0x1ce1]
00001E70  250100            and ax,0x1
00001E73  050100            add ax,0x1
00001E76  3BD0              cmp dx,ax
00001E78  7301              jnc 0x1e7b
00001E7A  C3                ret
00001E7B  E85AF5            call 0x13d8
00001E7E  74FA              jz 0x1e7a
00001E80  890EC91C          mov [0x1cc9],cx
00001E84  FF06E11C          inc word [0x1ce1]
00001E88  803EC11C00        cmp byte [0x1cc1],0x0
00001E8D  7453              jz 0x1ee2
00001E8F  FE0EC11C          dec byte [0x1cc1]
00001E93  7534              jnz 0x1ec9
00001E95  E8893C            call 0x5b21
00001E98  803EB81C00        cmp byte [0x1cb8],0x0
00001E9D  7423              jz 0x1ec2
00001E9F  833E040000        cmp word [0x4],byte +0x0
00001EA4  7411              jz 0x1eb7
00001EA6  C6065205DD        mov byte [0x552],0xdd
00001EAB  C7067905A000      mov word [0x579],0xa0
00001EB1  C6067B0560        mov byte [0x57b],0x60
00001EB6  C3                ret
00001EB7  803E801F00        cmp byte [0x1f80],0x0
00001EBC  7404              jz 0x1ec2
00001EBE  FE0E801F          dec byte [0x1f80]
00001EC2  E81C02            call 0x20e1
00001EC5  E878FF            call 0x1e40
00001EC8  C3                ret
00001EC9  E85601            call 0x2022
00001ECC  B80401            mov ax,0x104
00001ECF  2A06C11C          sub al,[0x1cc1]
00001ED3  803ED01CFF        cmp byte [0x1cd0],0xff
00001ED8  7402              jz 0x1edc
00001EDA  B4FF              mov ah,0xff
00001EDC  E87A01            call 0x2059
00001EDF  E91901            jmp 0x1ffb
00001EE2  803EB81C00        cmp byte [0x1cb8],0x0
00001EE7  7423              jz 0x1f0c
00001EE9  8A16B81C          mov dl,[0x1cb8]
00001EED  833EB91C00        cmp word [0x1cb9],byte +0x0
00001EF2  740E              jz 0x1f02
00001EF4  FF0EB91C          dec word [0x1cb9]
00001EF8  E8020F            call 0x2dfd
00001EFB  80E201            and dl,0x1
00001EFE  7502              jnz 0x1f02
00001F00  B2FF              mov dl,0xff
00001F02  8816D01C          mov [0x1cd0],dl
00001F06  A1C61C            mov ax,[0x1cc6]
00001F09  E99F00            jmp 0x1fab
00001F0C  803EBF1C00        cmp byte [0x1cbf],0x0
00001F11  7562              jnz 0x1f75
00001F13  803EC01C00        cmp byte [0x1cc0],0x0
00001F18  753D              jnz 0x1f57
00001F1A  803E581D00        cmp byte [0x1d58],0x0
00001F1F  751C              jnz 0x1f3d
00001F21  803E7B05B4        cmp byte [0x57b],0xb4
00001F26  7214              jc 0x1f3c
00001F28  803E580500        cmp byte [0x558],0x0
00001F2D  750D              jnz 0x1f3c
00001F2F  E8CB0E            call 0x2dfd
00001F32  8B1E0800          mov bx,[0x8]
00001F36  3A97D11C          cmp dl,[bx+0x1cd1]
00001F3A  7201              jc 0x1f3d
00001F3C  C3                ret
00001F3D  B001              mov al,0x1
00001F3F  C706BA590000      mov word [0x59ba],0x0
00001F45  813E7905A000      cmp word [0x579],0xa0
00001F4B  7302              jnc 0x1f4f
00001F4D  B0FF              mov al,0xff
00001F4F  A2D01C            mov [0x1cd0],al
00001F52  C606C01C04        mov byte [0x1cc0],0x4
00001F57  FE0EC01C          dec byte [0x1cc0]
00001F5B  7508              jnz 0x1f65
00001F5D  C606BF1C01        mov byte [0x1cbf],0x1
00001F62  EB11              jmp short 0x1f75
00001F64  90                nop
00001F65  E8BA00            call 0x2022
00001F68  A0C01C            mov al,[0x1cc0]
00001F6B  8A26D01C          mov ah,[0x1cd0]
00001F6F  E8E700            call 0x2059
00001F72  E98600            jmp 0x1ffb
00001F75  C606581D00        mov byte [0x1d58],0x0
00001F7A  A1C61C            mov ax,[0x1cc6]
00001F7D  803E7B05B4        cmp byte [0x57b],0xb4
00001F82  7227              jc 0x1fab
00001F84  803E580500        cmp byte [0x558],0x0
00001F89  7520              jnz 0x1fab
00001F8B  E86F0E            call 0x2dfd
00001F8E  8B1E0800          mov bx,[0x8]
00001F92  3A97D91C          cmp dl,[bx+0x1cd9]
00001F96  7713              ja 0x1fab
00001F98  3B067905          cmp ax,[0x579]
00001F9C  7708              ja 0x1fa6
00001F9E  C606D01C01        mov byte [0x1cd0],0x1
00001FA3  EB06              jmp short 0x1fab
00001FA5  90                nop
00001FA6  C606D01CFF        mov byte [0x1cd0],0xff
00001FAB  803ED01C01        cmp byte [0x1cd0],0x1
00001FB0  723D              jc 0x1fef
00001FB2  742E              jz 0x1fe2
00001FB4  2D0800            sub ax,0x8
00001FB7  7336              jnc 0x1fef
00001FB9  2BC0              sub ax,ax
00001FBB  803EB81C00        cmp byte [0x1cb8],0x0
00001FC0  740A              jz 0x1fcc
00001FC2  833EB91C00        cmp word [0x1cb9],byte +0x0
00001FC7  7526              jnz 0x1fef
00001FC9  EB0F              jmp short 0x1fda
00001FCB  90                nop
00001FCC  803E7B05B4        cmp byte [0x57b],0xb4
00001FD1  7207              jc 0x1fda
00001FD3  803E580500        cmp byte [0x558],0x0
00001FD8  7415              jz 0x1fef
00001FDA  C606C11C04        mov byte [0x1cc1],0x4
00001FDF  EB0E              jmp short 0x1fef
00001FE1  90                nop
00001FE2  050800            add ax,0x8
00001FE5  3D1E01            cmp ax,0x11e
00001FE8  7205              jc 0x1fef
00001FEA  B81E01            mov ax,0x11e
00001FED  EBCC              jmp short 0x1fbb
00001FEF  A3C61C            mov [0x1cc6],ax
00001FF2  E82D00            call 0x2022
00001FF5  C706C41C040F      mov word [0x1cc4],0xf04
00001FFB  8B0EC61C          mov cx,[0x1cc6]
00001FFF  8A16C81C          mov dl,[0x1cc8]
00002003  E8AA0C            call 0x2cb0
00002006  A3CD1C            mov [0x1ccd],ax
00002009  803EC01C03        cmp byte [0x1cc0],0x3
0000200E  7403              jz 0x2013
00002010  E8CE00            call 0x20e1
00002013  E8DF00            call 0x20f5
00002016  7209              jc 0x2021
00002018  A1CD1C            mov ax,[0x1ccd]
0000201B  A3BD1C            mov [0x1cbd],ax
0000201E  E87A00            call 0x209b
00002021  C3                ret
00002022  2AFF              sub bh,bh
00002024  803EB81C00        cmp byte [0x1cb8],0x0
00002029  7410              jz 0x203b
0000202B  FE06CF1C          inc byte [0x1ccf]
0000202F  8A1ECF1C          mov bl,[0x1ccf]
00002033  80E306            and bl,0x6
00002036  80CB08            or bl,0x8
00002039  7516              jnz 0x2051
0000203B  8006CF1C02        add byte [0x1ccf],0x2
00002040  8A1ECF1C          mov bl,[0x1ccf]
00002044  80E302            and bl,0x2
00002047  803ED01C01        cmp byte [0x1cd0],0x1
0000204C  7503              jnz 0x2051
0000204E  80CB04            or bl,0x4
00002051  8B87C815          mov ax,[bx+0x15c8]
00002055  A3BB1C            mov [0x1cbb],ax
00002058  C3                ret
00002059  B9040F            mov cx,0xf04
0000205C  2AC8              sub cl,al
0000205E  890EC41C          mov [0x1cc4],cx
00002062  80FCFF            cmp ah,0xff
00002065  7411              jz 0x2078
00002067  2AE4              sub ah,ah
00002069  D0E0              shl al,1
0000206B  0106BB1C          add [0x1cbb],ax
0000206F  C706C61C0000      mov word [0x1cc6],0x0
00002075  EB0F              jmp short 0x2086
00002077  90                nop
00002078  2AE4              sub ah,ah
0000207A  D0E0              shl al,1
0000207C  D0E0              shl al,1
0000207E  D0E0              shl al,1
00002080  052001            add ax,0x120
00002083  A3C61C            mov [0x1cc6],ax
00002086  1E                push ds
00002087  07                pop es
00002088  8B36BB1C          mov si,[0x1cbb]
0000208C  BF0E00            mov di,0xe
0000208F  B004              mov al,0x4
00002091  E8DC0C            call 0x2d70
00002094  C706BB1C0E00      mov word [0x1cbb],0xe
0000209A  C3                ret
0000209B  8B0EC41C          mov cx,[0x1cc4]
0000209F  890EC21C          mov [0x1cc2],cx
000020A3  B800B8            mov ax,0xb800
000020A6  803EB81C00        cmp byte [0x1cb8],0x0
000020AB  7511              jnz 0x20be
000020AD  8EC0              mov es,ax
000020AF  8B3EBD1C          mov di,[0x1cbd]
000020B3  8B36BB1C          mov si,[0x1cbb]
000020B7  BD401C            mov bp,0x1c40
000020BA  E80F0C            call 0x2ccc
000020BD  C3                ret
000020BE  1E                push ds
000020BF  8ED8              mov ds,ax
000020C1  07                pop es
000020C2  06                push es
000020C3  1E                push ds
000020C4  268B36BD1C        mov si,[es:0x1cbd]
000020C9  BF401C            mov di,0x1c40
000020CC  E8FB0C            call 0x2dca
000020CF  07                pop es
000020D0  1F                pop ds
000020D1  8B36BB1C          mov si,[0x1cbb]
000020D5  8B3EBD1C          mov di,[0x1cbd]
000020D9  8B0EC41C          mov cx,[0x1cc4]
000020DD  E8BD0C            call 0x2d9d
000020E0  C3                ret
000020E1  B800B8            mov ax,0xb800
000020E4  8EC0              mov es,ax
000020E6  8B3EBD1C          mov di,[0x1cbd]
000020EA  BE401C            mov si,0x1c40
000020ED  8B0EC21C          mov cx,[0x1cc2]
000020F1  E8A90C            call 0x2d9d
000020F4  C3                ret
000020F5  803EB81C00        cmp byte [0x1cb8],0x0
000020FA  7538              jnz 0x2134
000020FC  A0BF1C            mov al,[0x1cbf]
000020FF  0A06C01C          or al,[0x1cc0]
00002103  0A06C11C          or al,[0x1cc1]
00002107  742B              jz 0x2134
00002109  803E7B05A3        cmp byte [0x57b],0xa3
0000210E  7224              jc 0x2134
00002110  803E580500        cmp byte [0x558],0x0
00002115  751D              jnz 0x2134
00002117  A1C61C            mov ax,[0x1cc6]
0000211A  052000            add ax,0x20
0000211D  3B067905          cmp ax,[0x579]
00002121  7211              jc 0x2134
00002123  2D3800            sub ax,0x38
00002126  7302              jnc 0x212a
00002128  2BC0              sub ax,ax
0000212A  3B067905          cmp ax,[0x579]
0000212E  7704              ja 0x2134
00002130  E80300            call 0x2136
00002133  C3                ret
00002134  F8                clc
00002135  C3                ret
00002136  833E040006        cmp word [0x4],byte +0x6
0000213B  750C              jnz 0x2149
0000213D  A07B05            mov al,[0x57b]
00002140  A2C81C            mov [0x1cc8],al
00002143  A17905            mov ax,[0x579]
00002146  A3C61C            mov [0x1cc6],ax
00002149  A1C61C            mov ax,[0x1cc6]
0000214C  03067905          add ax,[0x579]
00002150  D1E8              shr ax,1
00002152  3D1801            cmp ax,0x118
00002155  7203              jc 0x215a
00002157  B81701            mov ax,0x117
0000215A  A3C61C            mov [0x1cc6],ax
0000215D  B301              mov bl,0x1
0000215F  3DA000            cmp ax,0xa0
00002162  770A              ja 0x216e
00002164  B3FF              mov bl,0xff
00002166  BAA100            mov dx,0xa1
00002169  2BD0              sub dx,ax
0000216B  EB06              jmp short 0x2173
0000216D  90                nop
0000216E  2D9F00            sub ax,0x9f
00002171  8BD0              mov dx,ax
00002173  881EB81C          mov [0x1cb8],bl
00002177  C606BF1C01        mov byte [0x1cbf],0x1
0000217C  C606C11C00        mov byte [0x1cc1],0x0
00002181  B103              mov cl,0x3
00002183  D3EA              shr dx,cl
00002185  8916B91C          mov [0x1cb9],dx
00002189  833E040006        cmp word [0x4],byte +0x6
0000218E  752D              jnz 0x21bd
00002190  E850F0            call 0x11e3
00002193  A0B81C            mov al,[0x1cb8]
00002196  50                push ax
00002197  C606B81C00        mov byte [0x1cb8],0x0
0000219C  C706C41C040F      mov word [0x1cc4],0xf04
000021A2  A1C815            mov ax,[0x15c8]
000021A5  A3BB1C            mov [0x1cbb],ax
000021A8  8B0EC61C          mov cx,[0x1cc6]
000021AC  8A16C81C          mov dl,[0x1cc8]
000021B0  E8FD0A            call 0x2cb0
000021B3  A3BD1C            mov [0x1cbd],ax
000021B6  E8E2FE            call 0x209b
000021B9  58                pop ax
000021BA  A2B81C            mov [0x1cb8],al
000021BD  E821FF            call 0x20e1
000021C0  E820F0            call 0x11e3
000021C3  B80000            mov ax,0x0
000021C6  813E7905A000      cmp word [0x579],0xa0
000021CC  7303              jnc 0x21d1
000021CE  B82201            mov ax,0x122
000021D1  A37905            mov [0x579],ax
000021D4  833E040000        cmp word [0x4],byte +0x0
000021D9  7503              jnz 0x21de
000021DB  E82FE5            call 0x70d
000021DE  F9                stc
000021DF  C3                ret
000021E0  A0BF1C            mov al,[0x1cbf]
000021E3  0A06C01C          or al,[0x1cc0]
000021E7  0A06C11C          or al,[0x1cc1]
000021EB  741C              jz 0x2209
000021ED  A17D32            mov ax,[0x327d]
000021F0  8A167F32          mov dl,[0x327f]
000021F4  BE1000            mov si,0x10
000021F7  8B1EC61C          mov bx,[0x1cc6]
000021FB  8A36C81C          mov dh,[0x1cc8]
000021FF  BF2000            mov di,0x20
00002202  B91E0F            mov cx,0xf1e
00002205  E8210C            call 0x2e29
00002208  C3                ret
00002209  F8                clc
0000220A  C3                ret
0000220B  0000              add [bx+si],al
0000220D  0000              add [bx+si],al
0000220F  00C6              add dh,al
00002211  06                push es
00002212  59                pop cx
00002213  1D00C3            sbb ax,0xc300
00002216  2AE4              sub ah,ah
00002218  CD1A              int 0x1a
0000221A  3B165A1D          cmp dx,[0x1d5a]
0000221E  7501              jnz 0x2221
00002220  C3                ret
00002221  8BCA              mov cx,dx
00002223  E8B2F1            call 0x13d8
00002226  74F8              jz 0x2220
00002228  890E5A1D          mov [0x1d5a],cx
0000222C  E8C800            call 0x22f7
0000222F  72EF              jc 0x2220
00002231  803E591D00        cmp byte [0x1d59],0x0
00002236  7535              jnz 0x226d
00002238  803E7B0586        cmp byte [0x57b],0x86
0000223D  740F              jz 0x224e
0000223F  803E7B058E        cmp byte [0x57b],0x8e
00002244  7408              jz 0x224e
00002246  E8B40B            call 0x2dfd
00002249  80FA05            cmp dl,0x5
0000224C  77D2              ja 0x2220
0000224E  E87FF3            call 0x15d0
00002251  80C203            add dl,0x3
00002254  88165E1D          mov [0x1d5e],dl
00002258  E8A20B            call 0x2dfd
0000225B  81E20700          and dx,0x7
0000225F  03CA              add cx,dx
00002261  83C106            add cx,byte +0x6
00002264  890E5C1D          mov [0x1d5c],cx
00002268  C606591D1B        mov byte [0x1d59],0x1b
0000226D  FE0E591D          dec byte [0x1d59]
00002271  8B0E5C1D          mov cx,[0x1d5c]
00002275  8A165E1D          mov dl,[0x1d5e]
00002279  803E591D0D        cmp byte [0x1d59],0xd
0000227E  7611              jna 0x2291
00002280  0216591D          add dl,[0x1d59]
00002284  80EA0F            sub dl,0xf
00002287  BB021B            mov bx,0x1b02
0000228A  2A3E591D          sub bh,[0x1d59]
0000228E  EB0F              jmp short 0x229f
00002290  90                nop
00002291  80C20C            add dl,0xc
00002294  2A16591D          sub dl,[0x1d59]
00002298  BB0200            mov bx,0x2
0000229B  023E591D          add bh,[0x1d59]
0000229F  891E641D          mov [0x1d64],bx
000022A3  88165F1D          mov [0x1d5f],dl
000022A7  E8060A            call 0x2cb0
000022AA  A3621D            mov [0x1d62],ax
000022AD  E82C00            call 0x22dc
000022B0  E84400            call 0x22f7
000022B3  7207              jc 0x22bc
000022B5  803E591D00        cmp byte [0x1d59],0x0
000022BA  7501              jnz 0x22bd
000022BC  C3                ret
000022BD  B800B8            mov ax,0xb800
000022C0  8EC0              mov es,ax
000022C2  8B3E621D          mov di,[0x1d62]
000022C6  BEF01C            mov si,0x1cf0
000022C9  893E601D          mov [0x1d60],di
000022CD  8B0E641D          mov cx,[0x1d64]
000022D1  890E661D          mov [0x1d66],cx
000022D5  BD241D            mov bp,0x1d24
000022D8  E8F109            call 0x2ccc
000022DB  C3                ret
000022DC  803E591D1A        cmp byte [0x1d59],0x1a
000022E1  7413              jz 0x22f6
000022E3  B800B8            mov ax,0xb800
000022E6  8EC0              mov es,ax
000022E8  8B3E601D          mov di,[0x1d60]
000022EC  BE241D            mov si,0x1d24
000022EF  8B0E661D          mov cx,[0x1d66]
000022F3  E8A70A            call 0x2d9d
000022F6  C3                ret
000022F7  803E591D00        cmp byte [0x1d59],0x0
000022FC  7502              jnz 0x2300
000022FE  F8                clc
000022FF  C3                ret
00002300  8B0E641D          mov cx,[0x1d64]
00002304  86E9              xchg cl,ch
00002306  A15C1D            mov ax,[0x1d5c]
00002309  8A165F1D          mov dl,[0x1d5f]
0000230D  BE1000            mov si,0x10
00002310  8B1E7905          mov bx,[0x579]
00002314  8A367B05          mov dh,[0x57b]
00002318  BF1800            mov di,0x18
0000231B  B50E              mov ch,0xe
0000231D  E8090B            call 0x2e29
00002320  7305              jnc 0x2327
00002322  C606581D01        mov byte [0x1d58],0x1
00002327  C3                ret
00002328  0000              add [bx+si],al
0000232A  0000              add [bx+si],al
0000232C  0000              add [bx+si],al
0000232E  0000              add [bx+si],al
00002330  C7066C1F0000      mov word [0x1f6c],0x0
00002336  2BC0              sub ax,ax
00002338  B201              mov dl,0x1
0000233A  813E7905A000      cmp word [0x579],0xa0
00002340  7705              ja 0x2347
00002342  B82C01            mov ax,0x12c
00002345  B2FF              mov dl,0xff
00002347  A3301F            mov [0x1f30],ax
0000234A  A3321F            mov [0x1f32],ax
0000234D  A3341F            mov [0x1f34],ax
00002350  88163C1F          mov [0x1f3c],dl
00002354  88163D1F          mov [0x1f3d],dl
00002358  88163E1F          mov [0x1f3e],dl
0000235C  C606481F01        mov byte [0x1f48],0x1
00002361  C606491F01        mov byte [0x1f49],0x1
00002366  C6064A1F01        mov byte [0x1f4a],0x1
0000236B  C606501F00        mov byte [0x1f50],0x0
00002370  C606511F00        mov byte [0x1f51],0x0
00002375  C606521F00        mov byte [0x1f52],0x0
0000237A  C3                ret
0000237B  2AE4              sub ah,ah
0000237D  CD1A              int 0x1a
0000237F  3B16651F          cmp dx,[0x1f65]
00002383  7501              jnz 0x2386
00002385  C3                ret
00002386  8916651F          mov [0x1f65],dx
0000238A  803E5A0500        cmp byte [0x55a],0x0
0000238F  75F4              jnz 0x2385
00002391  8B1E6C1F          mov bx,[0x1f6c]
00002395  43                inc bx
00002396  83FB03            cmp bx,byte +0x3
00002399  7203              jc 0x239e
0000239B  BB0000            mov bx,0x0
0000239E  891E6C1F          mov [0x1f6c],bx
000023A2  E8B902            call 0x265e
000023A5  72DE              jc 0x2385
000023A7  E8BD01            call 0x2567
000023AA  72D9              jc 0x2385
000023AC  8B1E6C1F          mov bx,[0x1f6c]
000023B0  80BF501F00        cmp byte [bx+0x1f50],0x0
000023B5  7434              jz 0x23eb
000023B7  2AE4              sub ah,ah
000023B9  CD1A              int 0x1a
000023BB  8B1E6C1F          mov bx,[0x1f6c]
000023BF  D0E3              shl bl,1
000023C1  2B97531F          sub dx,[bx+0x1f53]
000023C5  83FA36            cmp dx,byte +0x36
000023C8  72BB              jc 0x2385
000023CA  B201              mov dl,0x1
000023CC  B80000            mov ax,0x0
000023CF  813E7905A000      cmp word [0x579],0xa0
000023D5  7705              ja 0x23dc
000023D7  B82C01            mov ax,0x12c
000023DA  B2FF              mov dl,0xff
000023DC  8987301F          mov [bx+0x1f30],ax
000023E0  D0EB              shr bl,1
000023E2  C687501F00        mov byte [bx+0x1f50],0x0
000023E7  88973C1F          mov [bx+0x1f3c],dl
000023EB  8A973C1F          mov dl,[bx+0x1f3c]
000023EF  88973F1F          mov [bx+0x1f3f],dl
000023F3  803E641600        cmp byte [0x1664],0x0
000023F8  7409              jz 0x2403
000023FA  C706691F0C00      mov word [0x1f69],0xc
00002400  EB16              jmp short 0x2418
00002402  90                nop
00002403  B80800            mov ax,0x8
00002406  803E7B0560        cmp byte [0x57b],0x60
0000240B  7602              jna 0x240f
0000240D  D0E8              shr al,1
0000240F  A3691F            mov [0x1f69],ax
00002412  3B1E2F05          cmp bx,[0x52f]
00002416  750D              jnz 0x2425
00002418  80BF3C1F00        cmp byte [bx+0x1f3c],0x0
0000241D  7506              jnz 0x2425
0000241F  E8DB09            call 0x2dfd
00002422  EB66              jmp short 0x248a
00002424  90                nop
00002425  803E5C0500        cmp byte [0x55c],0x0
0000242A  743A              jz 0x2466
0000242C  8A87361F          mov al,[bx+0x1f36]
00002430  3A067B05          cmp al,[0x57b]
00002434  7730              ja 0x2466
00002436  0410              add al,0x10
00002438  3A067B05          cmp al,[0x57b]
0000243C  7228              jc 0x2466
0000243E  E8BC09            call 0x2dfd
00002441  8B360800          mov si,[0x8]
00002445  3A946E1F          cmp dl,[si+0x1f6e]
00002449  771B              ja 0x2466
0000244B  C706691F0C00      mov word [0x1f69],0xc
00002451  B001              mov al,0x1
00002453  D0E3              shl bl,1
00002455  8B8F301F          mov cx,[bx+0x1f30]
00002459  D0EB              shr bl,1
0000245B  3B0E7905          cmp cx,[0x579]
0000245F  7202              jc 0x2463
00002461  B0FF              mov al,0xff
00002463  EB2D              jmp short 0x2492
00002465  90                nop
00002466  B118              mov cl,0x18
00002468  803E7B0560        cmp byte [0x57b],0x60
0000246D  760B              jna 0x247a
0000246F  B128              mov cl,0x28
00002471  80BF3C1F00        cmp byte [bx+0x1f3c],0x0
00002476  7502              jnz 0x247a
00002478  B110              mov cl,0x10
0000247A  E88009            call 0x2dfd
0000247D  3AD1              cmp dl,cl
0000247F  7715              ja 0x2496
00002481  B000              mov al,0x0
00002483  80BF3C1F00        cmp byte [bx+0x1f3c],0x0
00002488  7508              jnz 0x2492
0000248A  8AC2              mov al,dl
0000248C  2401              and al,0x1
0000248E  7502              jnz 0x2492
00002490  B0FF              mov al,0xff
00002492  88873C1F          mov [bx+0x1f3c],al
00002496  8A973C1F          mov dl,[bx+0x1f3c]
0000249A  D0E3              shl bl,1
0000249C  8B87301F          mov ax,[bx+0x1f30]
000024A0  80FA01            cmp dl,0x1
000024A3  721D              jc 0x24c2
000024A5  7511              jnz 0x24b8
000024A7  0306691F          add ax,[0x1f69]
000024AB  3D2F01            cmp ax,0x12f
000024AE  7212              jc 0x24c2
000024B0  B82E01            mov ax,0x12e
000024B3  B2FF              mov dl,0xff
000024B5  EB0B              jmp short 0x24c2
000024B7  90                nop
000024B8  2B06691F          sub ax,[0x1f69]
000024BC  7304              jnc 0x24c2
000024BE  2BC0              sub ax,ax
000024C0  B201              mov dl,0x1
000024C2  8987301F          mov [bx+0x1f30],ax
000024C6  D0EB              shr bl,1
000024C8  88973C1F          mov [bx+0x1f3c],dl
000024CC  8A97361F          mov dl,[bx+0x1f36]
000024D0  8BC8              mov cx,ax
000024D2  E8DB07            call 0x2cb0
000024D5  A34B1F            mov [0x1f4b],ax
000024D8  8B1E6C1F          mov bx,[0x1f6c]
000024DC  80BF481F00        cmp byte [bx+0x1f48],0x0
000024E1  750D              jnz 0x24f0
000024E3  8A873C1F          mov al,[bx+0x1f3c]
000024E7  0A873F1F          or al,[bx+0x1f3f]
000024EB  7403              jz 0x24f0
000024ED  E85D00            call 0x254d
000024F0  E86B01            call 0x265e
000024F3  7205              jc 0x24fa
000024F5  E86F00            call 0x2567
000024F8  7301              jnc 0x24fb
000024FA  C3                ret
000024FB  8B1E6C1F          mov bx,[0x1f6c]
000024FF  C687481F00        mov byte [bx+0x1f48],0x0
00002504  80BF3C1F00        cmp byte [bx+0x1f3c],0x0
00002509  750D              jnz 0x2518
0000250B  80BF3F1F00        cmp byte [bx+0x1f3f],0x0
00002510  743A              jz 0x254c
00002512  BE301E            mov si,0x1e30
00002515  EB1C              jmp short 0x2533
00002517  90                nop
00002518  BE501E            mov si,0x1e50
0000251B  FE874D1F          inc byte [bx+0x1f4d]
0000251F  F6874D1F01        test byte [bx+0x1f4d],0x1
00002524  7503              jnz 0x2529
00002526  83C620            add si,byte +0x20
00002529  80BF3C1F01        cmp byte [bx+0x1f3c],0x1
0000252E  7403              jz 0x2533
00002530  83C640            add si,byte +0x40
00002533  D0E3              shl bl,1
00002535  8B3E4B1F          mov di,[0x1f4b]
00002539  89BF421F          mov [bx+0x1f42],di
0000253D  B800B8            mov ax,0xb800
00002540  8EC0              mov es,ax
00002542  8BAF591F          mov bp,[bx+0x1f59]
00002546  B90208            mov cx,0x802
00002549  E8E907            call 0x2d35
0000254C  C3                ret
0000254D  8B1E6C1F          mov bx,[0x1f6c]
00002551  D0E3              shl bl,1
00002553  B800B8            mov ax,0xb800
00002556  8EC0              mov es,ax
00002558  8BBF421F          mov di,[bx+0x1f42]
0000255C  8BB7591F          mov si,[bx+0x1f59]
00002560  B90208            mov cx,0x802
00002563  E83708            call 0x2d9d
00002566  C3                ret
00002567  8B1E6C1F          mov bx,[0x1f6c]
0000256B  8A97361F          mov dl,[bx+0x1f36]
0000256F  D0E3              shl bl,1
00002571  8B87301F          mov ax,[bx+0x1f30]
00002575  BE1000            mov si,0x10
00002578  8B1E7905          mov bx,[0x579]
0000257C  8A367B05          mov dh,[0x57b]
00002580  BF1800            mov di,0x18
00002583  B9080E            mov cx,0xe08
00002586  E8A008            call 0x2e29
00002589  7203              jc 0x258e
0000258B  E9CF00            jmp 0x265d
0000258E  8B1E6C1F          mov bx,[0x1f6c]
00002592  80BF501F00        cmp byte [bx+0x1f50],0x0
00002597  7573              jnz 0x260c
00002599  803E7C0526        cmp byte [0x57c],0x26
0000259E  726C              jc 0x260c
000025A0  803E5C0500        cmp byte [0x55c],0x0
000025A5  7467              jz 0x260e
000025A7  C6065C0500        mov byte [0x55c],0x0
000025AC  C6065B0511        mov byte [0x55b],0x11
000025B1  C606710501        mov byte [0x571],0x1
000025B6  C6066E0500        mov byte [0x56e],0x0
000025BB  8B1E6C1F          mov bx,[0x1f6c]
000025BF  D0E3              shl bl,1
000025C1  8BBF421F          mov di,[bx+0x1f42]
000025C5  83BF301F10        cmp word [bx+0x1f30],byte +0x10
000025CA  7203              jc 0x25cf
000025CC  83EF04            sub di,byte +0x4
000025CF  893E671F          mov [0x1f67],di
000025D3  B800B8            mov ax,0xb800
000025D6  8EC0              mov es,ax
000025D8  BE701D            mov si,0x1d70
000025DB  BD0E00            mov bp,0xe
000025DE  B90608            mov cx,0x806
000025E1  E8E806            call 0x2ccc
000025E4  2AE4              sub ah,ah
000025E6  CD1A              int 0x1a
000025E8  8916651F          mov [0x1f65],dx
000025EC  E8A134            call 0x5a90
000025EF  2AE4              sub ah,ah
000025F1  CD1A              int 0x1a
000025F3  2B16651F          sub dx,[0x1f65]
000025F7  83FA08            cmp dx,byte +0x8
000025FA  72F0              jc 0x25ec
000025FC  E82235            call 0x5b21
000025FF  8B3E671F          mov di,[0x1f67]
00002603  BE0E00            mov si,0xe
00002606  B90608            mov cx,0x806
00002609  E89107            call 0x2d9d
0000260C  F9                stc
0000260D  C3                ret
0000260E  2AE4              sub ah,ah
00002610  CD1A              int 0x1a
00002612  8B1E6C1F          mov bx,[0x1f6c]
00002616  C687501F01        mov byte [bx+0x1f50],0x1
0000261B  C6873C1F01        mov byte [bx+0x1f3c],0x1
00002620  D0E3              shl bl,1
00002622  8997531F          mov [bx+0x1f53],dx
00002626  E8BAEB            call 0x11e3
00002629  8B1E6C1F          mov bx,[0x1f6c]
0000262D  D0E3              shl bl,1
0000262F  8BB75F1F          mov si,[bx+0x1f5f]
00002633  8BBF421F          mov di,[bx+0x1f42]
00002637  B800B8            mov ax,0xb800
0000263A  8EC0              mov es,ax
0000263C  BD0E00            mov bp,0xe
0000263F  B90208            mov cx,0x802
00002642  E88706            call 0x2ccc
00002645  E8DCEA            call 0x1124
00002648  8B1E6C1F          mov bx,[0x1f6c]
0000264C  8A87391F          mov al,[bx+0x1f39]
00002650  E8B300            call 0x2706
00002653  B8E803            mov ax,0x3e8
00002656  BBEE02            mov bx,0x2ee
00002659  E8DF32            call 0x593b
0000265C  F9                stc
0000265D  C3                ret
0000265E  803E731600        cmp byte [0x1673],0x0
00002663  7502              jnz 0x2667
00002665  F8                clc
00002666  C3                ret
00002667  8B1E6C1F          mov bx,[0x1f6c]
0000266B  8A97361F          mov dl,[bx+0x1f36]
0000266F  D0E3              shl bl,1
00002671  8B87301F          mov ax,[bx+0x1f30]
00002675  BE1000            mov si,0x10
00002678  8BFE              mov di,si
0000267A  8B1E7116          mov bx,[0x1671]
0000267E  8A367316          mov dh,[0x1673]
00002682  B9080C            mov cx,0xc08
00002685  E8A107            call 0x2e29
00002688  C3                ret
00002689  0000              add [bx+si],al
0000268B  0000              add [bx+si],al
0000268D  0000              add [bx+si],al
0000268F  001E07B9          add [0xb907],bl
00002693  07                pop es
00002694  00BE821F          add [bp+0x1f82],bh
00002698  AC                lodsb
00002699  BB0700            mov bx,0x7
0000269C  2BD9              sub bx,cx
0000269E  3A87891F          cmp al,[bx+0x1f89]
000026A2  E1F4              loope 0x2698
000026A4  7701              ja 0x26a7
000026A6  C3                ret
000026A7  BE821F            mov si,0x1f82
000026AA  BF891F            mov di,0x1f89
000026AD  B90700            mov cx,0x7
000026B0  F3A4              rep movsb
000026B2  C3                ret
000026B3  A0801F            mov al,[0x1f80]
000026B6  3A06811F          cmp al,[0x1f81]
000026BA  7501              jnz 0x26bd
000026BC  C3                ret
000026BD  A2811F            mov [0x1f81],al
000026C0  2AE4              sub ah,ah
000026C2  B104              mov cl,0x4
000026C4  D3E0              shl ax,cl
000026C6  052027            add ax,0x2720
000026C9  8BF0              mov si,ax
000026CB  B800B8            mov ax,0xb800
000026CE  8EC0              mov es,ax
000026D0  BF6012            mov di,0x1260
000026D3  B90108            mov cx,0x801
000026D6  E8C406            call 0x2d9d
000026D9  C3                ret
000026DA  BF821F            mov di,0x1f82
000026DD  E80800            call 0x26e8
000026E0  C3                ret
000026E1  BF891F            mov di,0x1f89
000026E4  E80100            call 0x26e8
000026E7  C3                ret
000026E8  1E                push ds
000026E9  07                pop es
000026EA  B90700            mov cx,0x7
000026ED  2AC0              sub al,al
000026EF  F3AA              rep stosb
000026F1  C3                ret
000026F2  BB891F            mov bx,0x1f89
000026F5  BFCA12            mov di,0x12ca
000026F8  E83E00            call 0x2739
000026FB  C3                ret
000026FC  BB821F            mov bx,0x1f82
000026FF  BF3C14            mov di,0x143c
00002702  E83400            call 0x2739
00002705  C3                ret
00002706  B90600            mov cx,0x6
00002709  8BD9              mov bx,cx
0000270B  B400              mov ah,0x0
0000270D  0287811F          add al,[bx+0x1f81]
00002711  37                aaa
00002712  8887811F          mov [bx+0x1f81],al
00002716  8AC4              mov al,ah
00002718  E2EF              loop 0x2709
0000271A  E8DFFF            call 0x26fc
0000271D  C3                ret
0000271E  51                push cx
0000271F  50                push ax
00002720  53                push bx
00002721  F8                clc
00002722  9C                pushf
00002723  B90700            mov cx,0x7
00002726  9D                popf
00002727  8BD9              mov bx,cx
00002729  4B                dec bx
0000272A  8A01              mov al,[bx+di]
0000272C  1200              adc al,[bx+si]
0000272E  37                aaa
0000272F  8801              mov [bx+di],al
00002731  9C                pushf
00002732  E2F2              loop 0x2726
00002734  9D                popf
00002735  5B                pop bx
00002736  58                pop ax
00002737  59                pop cx
00002738  C3                ret
00002739  B800B8            mov ax,0xb800
0000273C  8EC0              mov es,ax
0000273E  893E901F          mov [0x1f90],di
00002742  891E931F          mov [0x1f93],bx
00002746  C606921F00        mov byte [0x1f92],0x0
0000274B  8B1E931F          mov bx,[0x1f93]
0000274F  8A07              mov al,[bx]
00002751  2AE4              sub ah,ah
00002753  B104              mov cl,0x4
00002755  D3E0              shl ax,cl
00002757  052027            add ax,0x2720
0000275A  8BF0              mov si,ax
0000275C  8B3E901F          mov di,[0x1f90]
00002760  B90108            mov cx,0x801
00002763  E83706            call 0x2d9d
00002766  8306901F02        add word [0x1f90],byte +0x2
0000276B  FF06931F          inc word [0x1f93]
0000276F  FE06921F          inc byte [0x1f92]
00002773  803E921F07        cmp byte [0x1f92],0x7
00002778  740E              jz 0x2788
0000277A  803E921F03        cmp byte [0x1f92],0x3
0000277F  75CA              jnz 0x274b
00002781  8306901F02        add word [0x1f90],byte +0x2
00002786  EBC3              jmp short 0x274b
00002788  C3                ret
00002789  0000              add [bx+si],al
0000278B  0000              add [bx+si],al
0000278D  0000              add [bx+si],al
0000278F  00B800B8          add [bx+si-0x4800],bh
00002793  8EC0              mov es,ax
00002795  833E040002        cmp word [0x4],byte +0x2
0000279A  7552              jnz 0x27ee
0000279C  FC                cld
0000279D  2BFF              sub di,di
0000279F  B8AAAA            mov ax,0xaaaa
000027A2  B95000            mov cx,0x50
000027A5  F3AB              rep stosw
000027A7  BF0020            mov di,0x2000
000027AA  B95000            mov cx,0x50
000027AD  F3AB              rep stosw
000027AF  C70654260000      mov word [0x2654],0x0
000027B5  E84506            call 0x2dfd
000027B8  81E21800          and dx,0x18
000027BC  3A165326          cmp dl,[0x2653]
000027C0  74F3              jz 0x27b5
000027C2  88165326          mov [0x2653],dl
000027C6  8B1E5426          mov bx,[0x2654]
000027CA  88975626          mov [bx+0x2656],dl
000027CE  81C22020          add dx,0x2020
000027D2  8BF2              mov si,dx
000027D4  8BFB              mov di,bx
000027D6  D1E7              shl di,1
000027D8  81C7A000          add di,0xa0
000027DC  B90104            mov cx,0x401
000027DF  E8BB05            call 0x2d9d
000027E2  FF065426          inc word [0x2654]
000027E6  833E542628        cmp word [0x2654],byte +0x28
000027EB  72C8              jc 0x27b5
000027ED  C3                ret
000027EE  833E040007        cmp word [0x4],byte +0x7
000027F3  7504              jnz 0x27f9
000027F5  E81708            call 0x300f
000027F8  C3                ret
000027F9  833E040006        cmp word [0x4],byte +0x6
000027FE  753E              jnz 0x283e
00002800  2BC0              sub ax,ax
00002802  E89B01            call 0x29a0
00002805  BB7025            mov bx,0x2570
00002808  B84A06            mov ax,0x64a
0000280B  E81603            call 0x2b24
0000280E  C70650264800      mov word [0x2650],0x48
00002814  C606522638        mov byte [0x2652],0x38
00002819  B8D20D            mov ax,0xdd2
0000281C  E83901            call 0x2958
0000281F  B8F60D            mov ax,0xdf6
00002822  E84B01            call 0x2970
00002825  BEA01F            mov si,0x1fa0
00002828  BF7E06            mov di,0x67e
0000282B  B90210            mov cx,0x1002
0000282E  E86C05            call 0x2d9d
00002831  BB4423            mov bx,0x2344
00002834  B8840B            mov ax,0xb84
00002837  E8EA02            call 0x2b24
0000283A  E80A23            call 0x4b47
0000283D  C3                ret
0000283E  833E040005        cmp word [0x4],byte +0x5
00002843  7548              jnz 0x288d
00002845  B84006            mov ax,0x640
00002848  E85501            call 0x29a0
0000284B  BB7025            mov bx,0x2570
0000284E  B8B60C            mov ax,0xcb6
00002851  E8D002            call 0x2b24
00002854  C7065026F800      mov word [0x2650],0xf8
0000285A  C606522660        mov byte [0x2652],0x60
0000285F  B80E14            mov ax,0x140e
00002862  E8F300            call 0x2958
00002865  B83414            mov ax,0x1434
00002868  E80501            call 0x2970
0000286B  B83E14            mov ax,0x143e
0000286E  E8FF00            call 0x2970
00002871  B8A016            mov ax,0x16a0
00002874  E81101            call 0x2988
00002877  BB4423            mov bx,0x2344
0000287A  B88411            mov ax,0x1184
0000287D  E8A402            call 0x2b24
00002880  BEE01F            mov si,0x1fe0
00002883  BFD60D            mov di,0xdd6
00002886  B90210            mov cx,0x1002
00002889  E81105            call 0x2d9d
0000288C  C3                ret
0000288D  833E040004        cmp word [0x4],byte +0x4
00002892  752A              jnz 0x28be
00002894  B84006            mov ax,0x640
00002897  E80601            call 0x29a0
0000289A  BB7025            mov bx,0x2570
0000289D  B8BA0C            mov ax,0xcba
000028A0  E88102            call 0x2b24
000028A3  C70650260801      mov word [0x2650],0x108
000028A9  C606522660        mov byte [0x2652],0x60
000028AE  B83914            mov ax,0x1439
000028B1  E8A400            call 0x2958
000028B4  B8C016            mov ax,0x16c0
000028B7  E88B00            call 0x2945
000028BA  E8E116            call 0x3f9e
000028BD  C3                ret
000028BE  833E040003        cmp word [0x4],byte +0x3
000028C3  7544              jnz 0x2909
000028C5  B84006            mov ax,0x640
000028C8  E8D500            call 0x29a0
000028CB  BB7025            mov bx,0x2570
000028CE  B8900C            mov ax,0xc90
000028D1  E85002            call 0x2b24
000028D4  C70650266000      mov word [0x2650],0x60
000028DA  C606522660        mov byte [0x2652],0x60
000028DF  B80C14            mov ax,0x140c
000028E2  E87300            call 0x2958
000028E5  B81814            mov ax,0x1418
000028E8  E88500            call 0x2970
000028EB  BB4423            mov bx,0x2344
000028EE  B88411            mov ax,0x1184
000028F1  E83002            call 0x2b24
000028F4  BB4423            mov bx,0x2344
000028F7  B8A211            mov ax,0x11a2
000028FA  E82702            call 0x2b24
000028FD  BB2426            mov bx,0x2624
00002900  2BC0              sub ax,ax
00002902  E81F02            call 0x2b24
00002905  E8D312            call 0x3bdb
00002908  C3                ret
00002909  B84006            mov ax,0x640
0000290C  E89100            call 0x29a0
0000290F  BB7025            mov bx,0x2570
00002912  B8A00C            mov ax,0xca0
00002915  E80C02            call 0x2b24
00002918  C7065026A000      mov word [0x2650],0xa0
0000291E  C606522660        mov byte [0x2652],0x60
00002923  B80614            mov ax,0x1406
00002926  E82F00            call 0x2958
00002929  BB4423            mov bx,0x2344
0000292C  B8C411            mov ax,0x11c4
0000292F  E8F201            call 0x2b24
00002932  B82214            mov ax,0x1422
00002935  E83800            call 0x2970
00002938  B89016            mov ax,0x1690
0000293B  E84A00            call 0x2988
0000293E  B8B616            mov ax,0x16b6
00002941  E80100            call 0x2945
00002944  C3                ret
00002945  A33426            mov [0x2634],ax
00002948  BB8423            mov bx,0x2384
0000294B  E8D601            call 0x2b24
0000294E  A13426            mov ax,[0x2634]
00002951  BB8C23            mov bx,0x238c
00002954  E8CD01            call 0x2b24
00002957  C3                ret
00002958  A33426            mov [0x2634],ax
0000295B  BE0800            mov si,0x8
0000295E  A13426            mov ax,[0x2634]
00002961  8B9C3426          mov bx,[si+0x2634]
00002965  56                push si
00002966  E8BB01            call 0x2b24
00002969  5E                pop si
0000296A  83EE02            sub si,byte +0x2
0000296D  75EF              jnz 0x295e
0000296F  C3                ret
00002970  A33426            mov [0x2634],ax
00002973  BE0A00            mov si,0xa
00002976  A13426            mov ax,[0x2634]
00002979  8B9C3C26          mov bx,[si+0x263c]
0000297D  56                push si
0000297E  E8A301            call 0x2b24
00002981  5E                pop si
00002982  83EE02            sub si,byte +0x2
00002985  75EF              jnz 0x2976
00002987  C3                ret
00002988  A33426            mov [0x2634],ax
0000298B  BE0800            mov si,0x8
0000298E  A13426            mov ax,[0x2634]
00002991  8B9C4626          mov bx,[si+0x2646]
00002995  56                push si
00002996  E88B01            call 0x2b24
00002999  5E                pop si
0000299A  83EE02            sub si,byte +0x2
0000299D  75EF              jnz 0x298e
0000299F  C3                ret
000029A0  A37E26            mov [0x267e],ax
000029A3  BB1C25            mov bx,0x251c
000029A6  E87B01            call 0x2b24
000029A9  2BC0              sub ax,ax
000029AB  FC                cld
000029AC  8B3E7E26          mov di,[0x267e]
000029B0  81C78402          add di,0x284
000029B4  B92400            mov cx,0x24
000029B7  F3AB              rep stosw
000029B9  8B3E7E26          mov di,[0x267e]
000029BD  81C78411          add di,0x1184
000029C1  B92400            mov cx,0x24
000029C4  F3AB              rep stosw
000029C6  8B3E7E26          mov di,[0x267e]
000029CA  81C78422          add di,0x2284
000029CE  B02A              mov al,0x2a
000029D0  E80E00            call 0x29e1
000029D3  8B3E7E26          mov di,[0x267e]
000029D7  81C7CB22          add di,0x22cb
000029DB  B0A8              mov al,0xa8
000029DD  E80100            call 0x29e1
000029E0  C3                ret
000029E1  B95F00            mov cx,0x5f
000029E4  268805            mov [es:di],al
000029E7  81F70020          xor di,0x2000
000029EB  F7C70020          test di,0x2000
000029EF  7503              jnz 0x29f4
000029F1  83C750            add di,byte +0x50
000029F4  E2EE              loop 0x29e4
000029F6  C3                ret
000029F7  0000              add [bx+si],al
000029F9  0000              add [bx+si],al
000029FB  0000              add [bx+si],al
000029FD  0000              add [bx+si],al
000029FF  00B800B8          add [bx+si-0x4800],bh
00002A03  8EC0              mov es,ax
00002A05  FC                cld
00002A06  2BFF              sub di,di
00002A08  B8AAAA            mov ax,0xaaaa
00002A0B  B9A00F            mov cx,0xfa0
00002A0E  F3AB              rep stosw
00002A10  BF0020            mov di,0x2000
00002A13  B9A00F            mov cx,0xfa0
00002A16  F3AB              rep stosw
00002A18  E88301            call 0x2b9e
00002A1B  BBA028            mov bx,0x28a0
00002A1E  2BC0              sub ax,ax
00002A20  E80101            call 0x2b24
00002A23  E84200            call 0x2a68
00002A26  E85B02            call 0x2c84
00002A29  E85F01            call 0x2b8b
00002A2C  E85100            call 0x2a80
00002A2F  C3                ret
00002A30  B800B8            mov ax,0xb800
00002A33  8EC0              mov es,ax
00002A35  FC                cld
00002A36  2BFF              sub di,di
00002A38  B8AAAA            mov ax,0xaaaa
00002A3B  B9A00F            mov cx,0xfa0
00002A3E  F3AB              rep stosw
00002A40  BF0020            mov di,0x2000
00002A43  B9A00F            mov cx,0xfa0
00002A46  F3AB              rep stosw
00002A48  E85301            call 0x2b9e
00002A4B  BBA028            mov bx,0x28a0
00002A4E  2BC0              sub ax,ax
00002A50  E8D100            call 0x2b24
00002A53  E81200            call 0x2a68
00002A56  A10800            mov ax,[0x8]
00002A59  50                push ax
00002A5A  C70608000100      mov word [0x8],0x1
00002A60  E82102            call 0x2c84
00002A63  58                pop ax
00002A64  A30800            mov [0x8],ax
00002A67  C3                ret
00002A68  8B1EF86D          mov bx,[0x6df8]
00002A6C  81E30300          and bx,0x3
00002A70  D0E3              shl bl,1
00002A72  8BB7D12A          mov si,[bx+0x2ad1]
00002A76  BF0219            mov di,0x1902
00002A79  B90108            mov cx,0x801
00002A7C  E81E03            call 0x2d9d
00002A7F  C3                ret
00002A80  BB0F00            mov bx,0xf
00002A83  C687151000        mov byte [bx+0x1015],0x0
00002A88  4B                dec bx
00002A89  75F8              jnz 0x2a83
00002A8B  BF4001            mov di,0x140
00002A8E  B780              mov bh,0x80
00002A90  C706CA2A0000      mov word [0x2aca],0x0
00002A96  E82D00            call 0x2ac6
00002A99  BF4006            mov di,0x640
00002A9C  B730              mov bh,0x30
00002A9E  C706CA2A0500      mov word [0x2aca],0x5
00002AA4  E81F00            call 0x2ac6
00002AA7  BF400B            mov di,0xb40
00002AAA  B700              mov bh,0x0
00002AAC  C706CA2A0A00      mov word [0x2aca],0xa
00002AB2  E81100            call 0x2ac6
00002AB5  C606250510        mov byte [0x525],0x10
00002ABA  C7062F050000      mov word [0x52f],0x0
00002AC0  C606310501        mov byte [0x531],0x1
00002AC5  C3                ret
00002AC6  883EC92A          mov [0x2ac9],bh
00002ACA  C606C42A00        mov byte [0x2ac4],0x0
00002ACF  57                push di
00002AD0  06                push es
00002AD1  8B1E0800          mov bx,[0x8]
00002AD5  8A9FBA2A          mov bl,[bx+0x2aba]
00002AD9  8A3EC92A          mov bh,[0x2ac9]
00002ADD  B81000            mov ax,0x10
00002AE0  8EC0              mov es,ax
00002AE2  BFD704            mov di,0x4d7
00002AE5  E895DB            call 0x67d
00002AE8  07                pop es
00002AE9  5F                pop di
00002AEA  57                push di
00002AEB  BED704            mov si,0x4d7
00002AEE  B90210            mov cx,0x1002
00002AF1  E8A902            call 0x2d9d
00002AF4  2AFF              sub bh,bh
00002AF6  8A1EC42A          mov bl,[0x2ac4]
00002AFA  8ACB              mov cl,bl
00002AFC  D0EB              shr bl,1
00002AFE  D0EB              shr bl,1
00002B00  F6D1              not cl
00002B02  80E103            and cl,0x3
00002B05  D0E1              shl cl,1
00002B07  A04005            mov al,[0x540]
00002B0A  D2E0              shl al,cl
00002B0C  8B36CA2A          mov si,[0x2aca]
00002B10  08801610          or [bx+si+0x1016],al
00002B14  5F                pop di
00002B15  83C704            add di,byte +0x4
00002B18  FE06C42A          inc byte [0x2ac4]
00002B1C  803EC42A14        cmp byte [0x2ac4],0x14
00002B21  72AC              jc 0x2acf
00002B23  C3                ret
00002B24  8B0F              mov cx,[bx]
00002B26  890EC72A          mov [0x2ac7],cx
00002B2A  A3CC2A            mov [0x2acc],ax
00002B2D  83C302            add bx,byte +0x2
00002B30  8B37              mov si,[bx]
00002B32  81FEFFFF          cmp si,0xffff
00002B36  7501              jnz 0x2b39
00002B38  C3                ret
00002B39  8B7F02            mov di,[bx+0x2]
00002B3C  033ECC2A          add di,[0x2acc]
00002B40  FC                cld
00002B41  882ED02A          mov [0x2ad0],ch
00002B45  2AED              sub ch,ch
00002B47  890ECE2A          mov [0x2ace],cx
00002B4B  8B0ECE2A          mov cx,[0x2ace]
00002B4F  F3A4              rep movsb
00002B51  2B3ECE2A          sub di,[0x2ace]
00002B55  81F70020          xor di,0x2000
00002B59  F7C70020          test di,0x2000
00002B5D  7503              jnz 0x2b62
00002B5F  83C750            add di,byte +0x50
00002B62  FE0ED02A          dec byte [0x2ad0]
00002B66  75E3              jnz 0x2b4b
00002B68  83C304            add bx,byte +0x4
00002B6B  8B0EC72A          mov cx,[0x2ac7]
00002B6F  EBBF              jmp short 0x2b30
00002B71  C606C42A04        mov byte [0x2ac4],0x4
00002B76  BE8026            mov si,0x2680
00002B79  B90510            mov cx,0x1005
00002B7C  57                push di
00002B7D  E81D02            call 0x2d9d
00002B80  5F                pop di
00002B81  83C714            add di,byte +0x14
00002B84  FE0EC42A          dec byte [0x2ac4]
00002B88  75EC              jnz 0x2b76
00002B8A  C3                ret
00002B8B  BFC503            mov di,0x3c5
00002B8E  E8E0FF            call 0x2b71
00002B91  BFC508            mov di,0x8c5
00002B94  E8DAFF            call 0x2b71
00002B97  BFC50D            mov di,0xdc5
00002B9A  E8D4FF            call 0x2b71
00002B9D  C3                ret
00002B9E  C706C22A3E10      mov word [0x2ac2],0x103e
00002BA4  8306C22A02        add word [0x2ac2],byte +0x2
00002BA9  8B3EC22A          mov di,[0x2ac2]
00002BAD  81FF9010          cmp di,0x1090
00002BB1  731F              jnc 0x2bd2
00002BB3  E84702            call 0x2dfd
00002BB6  81E23000          and dx,0x30
00002BBA  3A16C42A          cmp dl,[0x2ac4]
00002BBE  74F3              jz 0x2bb3
00002BC0  8816C42A          mov [0x2ac4],dl
00002BC4  81C20429          add dx,0x2904
00002BC8  8BF2              mov si,dx
00002BCA  B90108            mov cx,0x801
00002BCD  E8CD01            call 0x2d9d
00002BD0  EBD2              jmp short 0x2ba4
00002BD2  BF8011            mov di,0x1180
00002BD5  B85556            mov ax,0x5655
00002BD8  B90005            mov cx,0x500
00002BDB  FC                cld
00002BDC  F3AB              rep stosw
00002BDE  BF8031            mov di,0x3180
00002BE1  B90005            mov cx,0x500
00002BE4  F3AB              rep stosw
00002BE6  C706C22A4429      mov word [0x2ac2],0x2944
00002BEC  C606C42A09        mov byte [0x2ac4],0x9
00002BF1  E80902            call 0x2dfd
00002BF4  81E27607          and dx,0x776
00002BF8  81C2C012          add dx,0x12c0
00002BFC  8BFA              mov di,dx
00002BFE  8B36C22A          mov si,[0x2ac2]
00002C02  B90105            mov cx,0x501
00002C05  E89501            call 0x2d9d
00002C08  FE0EC42A          dec byte [0x2ac4]
00002C0C  75E3              jnz 0x2bf1
00002C0E  8306C22A0A        add word [0x2ac2],byte +0xa
00002C13  813EC22A6C29      cmp word [0x2ac2],0x296c
00002C19  72D1              jc 0x2bec
00002C1B  C606C42A05        mov byte [0x2ac4],0x5
00002C20  E8DA01            call 0x2dfd
00002C23  81E23E00          and dx,0x3e
00002C27  81C2983A          add dx,0x3a98
00002C2B  8BFA              mov di,dx
00002C2D  BE6C29            mov si,0x296c
00002C30  B90105            mov cx,0x501
00002C33  E86701            call 0x2d9d
00002C36  FE0EC42A          dec byte [0x2ac4]
00002C3A  75E4              jnz 0x2c20
00002C3C  C3                ret
00002C3D  893EC22A          mov [0x2ac2],di
00002C41  B003              mov al,0x3
00002C43  81FF2017          cmp di,0x1720
00002C47  7202              jc 0x2c4b
00002C49  FEC8              dec al
00002C4B  A2C42A            mov [0x2ac4],al
00002C4E  8106C22AE001      add word [0x2ac2],0x1e0
00002C54  BE7629            mov si,0x2976
00002C57  B9050C            mov cx,0xc05
00002C5A  E84001            call 0x2d9d
00002C5D  8B3EC22A          mov di,[0x2ac2]
00002C61  8106C22A4001      add word [0x2ac2],0x140
00002C67  BEEE29            mov si,0x29ee
00002C6A  B90408            mov cx,0x804
00002C6D  E82D01            call 0x2d9d
00002C70  FE0EC42A          dec byte [0x2ac4]
00002C74  75E7              jnz 0x2c5d
00002C76  8B3EC22A          mov di,[0x2ac2]
00002C7A  BE2E2A            mov si,0x2a2e
00002C7D  B9040B            mov cx,0xb04
00002C80  E81A01            call 0x2d9d
00002C83  C3                ret
00002C84  8B1E0800          mov bx,[0x8]
00002C88  8A9FB22A          mov bl,[bx+0x2ab2]
00002C8C  891EC52A          mov [0x2ac5],bx
00002C90  8BBF862A          mov di,[bx+0x2a86]
00002C94  83FF00            cmp di,byte +0x0
00002C97  7501              jnz 0x2c9a
00002C99  C3                ret
00002C9A  E8A0FF            call 0x2c3d
00002C9D  8B1EC52A          mov bx,[0x2ac5]
00002CA1  83C302            add bx,byte +0x2
00002CA4  EBE6              jmp short 0x2c8c
00002CA6  C3                ret
00002CA7  0000              add [bx+si],al
00002CA9  0000              add [bx+si],al
00002CAB  0000              add [bx+si],al
00002CAD  0000              add [bx+si],al
00002CAF  008AC2B4          add [bp+si-0x4b3e],cl
00002CB3  28F6              sub dh,dh
00002CB5  E4F6              in al,0xf6
00002CB7  C20174            ret 0x7401
00002CBA  0305              add ax,[di]
00002CBC  D81F              fcomp dword [bx]
00002CBE  8BD1              mov dx,cx
00002CC0  D1EA              shr dx,1
00002CC2  D1EA              shr dx,1
00002CC4  03C2              add ax,dx
00002CC6  80E103            and cl,0x3
00002CC9  D0E1              shl cl,1
00002CCB  C3                ret
00002CCC  FC                cld
00002CCD  880EE02A          mov [0x2ae0],cl
00002CD1  882EE22A          mov [0x2ae2],ch
00002CD5  2AED              sub ch,ch
00002CD7  BAF00F            mov dx,0xff0
00002CDA  8A0EE02A          mov cl,[0x2ae0]
00002CDE  BAC030            mov dx,0x30c0
00002CE1  268B1D            mov bx,[es:di]
00002CE4  3E895E00          mov [ds:bp+0x0],bx
00002CE8  AD                lodsw
00002CE9  A3E32A            mov [0x2ae3],ax
00002CEC  84E2              test dl,ah
00002CEE  7502              jnz 0x2cf2
00002CF0  0AE2              or ah,dl
00002CF2  84E6              test dh,ah
00002CF4  7502              jnz 0x2cf8
00002CF6  0AE6              or ah,dh
00002CF8  84C2              test dl,al
00002CFA  7502              jnz 0x2cfe
00002CFC  0AC2              or al,dl
00002CFE  84C6              test dh,al
00002D00  7502              jnz 0x2d04
00002D02  0AC6              or al,dh
00002D04  81F2CC33          xor dx,0x33cc
00002D08  F6C603            test dh,0x3
00002D0B  75DF              jnz 0x2cec
00002D0D  23C3              and ax,bx
00002D0F  0B06E32A          or ax,[0x2ae3]
00002D13  AB                stosw
00002D14  83C502            add bp,byte +0x2
00002D17  E2C5              loop 0x2cde
00002D19  2B3EE02A          sub di,[0x2ae0]
00002D1D  2B3EE02A          sub di,[0x2ae0]
00002D21  81F70020          xor di,0x2000
00002D25  F7C70020          test di,0x2000
00002D29  7503              jnz 0x2d2e
00002D2B  83C750            add di,byte +0x50
00002D2E  FE0EE22A          dec byte [0x2ae2]
00002D32  75A6              jnz 0x2cda
00002D34  C3                ret
00002D35  FC                cld
00002D36  880EE02A          mov [0x2ae0],cl
00002D3A  882EE22A          mov [0x2ae2],ch
00002D3E  2AED              sub ch,ch
00002D40  8A0EE02A          mov cl,[0x2ae0]
00002D44  268B1D            mov bx,[es:di]
00002D47  3E895E00          mov [ds:bp+0x0],bx
00002D4B  AD                lodsw
00002D4C  23C3              and ax,bx
00002D4E  AB                stosw
00002D4F  83C502            add bp,byte +0x2
00002D52  E2F0              loop 0x2d44
00002D54  2B3EE02A          sub di,[0x2ae0]
00002D58  2B3EE02A          sub di,[0x2ae0]
00002D5C  81F70020          xor di,0x2000
00002D60  F7C70020          test di,0x2000
00002D64  7503              jnz 0x2d69
00002D66  83C750            add di,byte +0x50
00002D69  FE0EE22A          dec byte [0x2ae2]
00002D6D  75D1              jnz 0x2d40
00002D6F  C3                ret
00002D70  FC                cld
00002D71  8936E92A          mov [0x2ae9],si
00002D75  880EE02A          mov [0x2ae0],cl
00002D79  882EE22A          mov [0x2ae2],ch
00002D7D  D0E0              shl al,1
00002D7F  A2EB2A            mov [0x2aeb],al
00002D82  2AED              sub ch,ch
00002D84  8A0EE02A          mov cl,[0x2ae0]
00002D88  F3A5              rep movsw
00002D8A  8A0EEB2A          mov cl,[0x2aeb]
00002D8E  010EE92A          add [0x2ae9],cx
00002D92  8B36E92A          mov si,[0x2ae9]
00002D96  FE0EE22A          dec byte [0x2ae2]
00002D9A  75E8              jnz 0x2d84
00002D9C  C3                ret
00002D9D  FC                cld
00002D9E  880EE02A          mov [0x2ae0],cl
00002DA2  882EE22A          mov [0x2ae2],ch
00002DA6  2AED              sub ch,ch
00002DA8  8A0EE02A          mov cl,[0x2ae0]
00002DAC  F3A5              rep movsw
00002DAE  2B3EE02A          sub di,[0x2ae0]
00002DB2  2B3EE02A          sub di,[0x2ae0]
00002DB6  81F70020          xor di,0x2000
00002DBA  F7C70020          test di,0x2000
00002DBE  7503              jnz 0x2dc3
00002DC0  83C750            add di,byte +0x50
00002DC3  FE0EE22A          dec byte [0x2ae2]
00002DC7  75DF              jnz 0x2da8
00002DC9  C3                ret
00002DCA  FC                cld
00002DCB  26880EE02A        mov [es:0x2ae0],cl
00002DD0  26882EE22A        mov [es:0x2ae2],ch
00002DD5  2AED              sub ch,ch
00002DD7  268A0EE02A        mov cl,[es:0x2ae0]
00002DDC  F3A5              rep movsw
00002DDE  262B36E02A        sub si,[es:0x2ae0]
00002DE3  262B36E02A        sub si,[es:0x2ae0]
00002DE8  81F60020          xor si,0x2000
00002DEC  F7C60020          test si,0x2000
00002DF0  7503              jnz 0x2df5
00002DF2  83C650            add si,byte +0x50
00002DF5  26FE0EE22A        dec byte [es:0x2ae2]
00002DFA  75DB              jnz 0x2dd7
00002DFC  C3                ret
00002DFD  8B16E52A          mov dx,[0x2ae5]
00002E01  32D6              xor dl,dh
00002E03  D0EA              shr dl,1
00002E05  D0EA              shr dl,1
00002E07  D11EE52A          rcr word [0x2ae5],1
00002E0B  8B16E52A          mov dx,[0x2ae5]
00002E0F  C3                ret
00002E10  B000              mov al,0x0
00002E12  E643              out 0x43,al
00002E14  90                nop
00002E15  90                nop
00002E16  E440              in al,0x40
00002E18  8AE0              mov ah,al
00002E1A  90                nop
00002E1B  E440              in al,0x40
00002E1D  3D0000            cmp ax,0x0
00002E20  7503              jnz 0x2e25
00002E22  B859FA            mov ax,0xfa59
00002E25  A3E52A            mov [0x2ae5],ax
00002E28  C3                ret
00002E29  03C6              add ax,si
00002E2B  3BC3              cmp ax,bx
00002E2D  7220              jc 0x2e4f
00002E2F  2BC6              sub ax,si
00002E31  2BC7              sub ax,di
00002E33  7302              jnc 0x2e37
00002E35  2BC0              sub ax,ax
00002E37  3BC3              cmp ax,bx
00002E39  7714              ja 0x2e4f
00002E3B  02D1              add dl,cl
00002E3D  3AD6              cmp dl,dh
00002E3F  720E              jc 0x2e4f
00002E41  2AD1              sub dl,cl
00002E43  2AD5              sub dl,ch
00002E45  7302              jnc 0x2e49
00002E47  2AD2              sub dl,dl
00002E49  3AD6              cmp dl,dh
00002E4B  7702              ja 0x2e4f
00002E4D  F9                stc
00002E4E  C3                ret
00002E4F  F8                clc
00002E50  C3                ret
00002E51  0000              add [bx+si],al
00002E53  0000              add [bx+si],al
00002E55  0000              add [bx+si],al
00002E57  0000              add [bx+si],al
00002E59  0000              add [bx+si],al
00002E5B  0000              add [bx+si],al
00002E5D  0000              add [bx+si],al
00002E5F  00833E8D          add [bp+di-0x72c2],al
00002E63  2E087201          or [cs:bp+si+0x1],dh
00002E67  C3                ret
00002E68  803E9A0600        cmp byte [0x69a],0x0
00002E6D  75F8              jnz 0x2e67
00002E6F  C706922EFFFF      mov word [0x2e92],0xffff
00002E75  C606912EFF        mov byte [0x2e91],0xff
00002E7A  B90700            mov cx,0x7
00002E7D  8BD9              mov bx,cx
00002E7F  4B                dec bx
00002E80  A07B05            mov al,[0x57b]
00002E83  2A87D42B          sub al,[bx+0x2bd4]
00002E87  7302              jnc 0x2e8b
00002E89  F6D0              not al
00002E8B  3A06912E          cmp al,[0x2e91]
00002E8F  7707              ja 0x2e98
00002E91  A2912E            mov [0x2e91],al
00002E94  891E922E          mov [0x2e92],bx
00002E98  E2E3              loop 0x2e7d
00002E9A  813E922EFFFF      cmp word [0x2e92],0xffff
00002EA0  7506              jnz 0x2ea8
00002EA2  C706922E0000      mov word [0x2e92],0x0
00002EA8  8B1E8D2E          mov bx,[0x2e8d]
00002EAC  8B36922E          mov si,[0x2e92]
00002EB0  8A84D42B          mov al,[si+0x2bd4]
00002EB4  88876A2B          mov [bx+0x2b6a],al
00002EB8  A2982E            mov [0x2e98],al
00002EBB  A17905            mov ax,[0x579]
00002EBE  D0E3              shl bl,1
00002EC0  3D0801            cmp ax,0x108
00002EC3  7203              jc 0x2ec8
00002EC5  B80701            mov ax,0x107
00002EC8  25FC0F            and ax,0xffc
00002ECB  89875A2B          mov [bx+0x2b5a],ax
00002ECF  A3962E            mov [0x2e96],ax
00002ED2  B90800            mov cx,0x8
00002ED5  8BD9              mov bx,cx
00002ED7  4B                dec bx
00002ED8  3B1E8D2E          cmp bx,[0x2e8d]
00002EDC  7429              jz 0x2f07
00002EDE  80BF722B00        cmp byte [bx+0x2b72],0x0
00002EE3  7422              jz 0x2f07
00002EE5  51                push cx
00002EE6  8A976A2B          mov dl,[bx+0x2b6a]
00002EEA  D0E3              shl bl,1
00002EEC  8B875A2B          mov ax,[bx+0x2b5a]
00002EF0  8B1E962E          mov bx,[0x2e96]
00002EF4  8A36982E          mov dh,[0x2e98]
00002EF8  BE1800            mov si,0x18
00002EFB  8BFE              mov di,si
00002EFD  B90F0F            mov cx,0xf0f
00002F00  E826FF            call 0x2e29
00002F03  59                pop cx
00002F04  7301              jnc 0x2f07
00002F06  C3                ret
00002F07  E2CC              loop 0x2ed5
00002F09  E8D7E2            call 0x11e3
00002F0C  803EF27000        cmp byte [0x70f2],0x0
00002F11  7403              jz 0x2f16
00002F13  E81533            call 0x622b
00002F16  8B1E8D2E          mov bx,[0x2e8d]
00002F1A  891E942E          mov [0x2e94],bx
00002F1E  C687722B01        mov byte [bx+0x2b72],0x1
00002F23  8A976A2B          mov dl,[bx+0x2b6a]
00002F27  D0E3              shl bl,1
00002F29  8B8F5A2B          mov cx,[bx+0x2b5a]
00002F2D  E880FD            call 0x2cb0
00002F30  8BF8              mov di,ax
00002F32  BEF02A            mov si,0x2af0
00002F35  B800B8            mov ax,0xb800
00002F38  8EC0              mov es,ax
00002F3A  B9030F            mov cx,0xf03
00002F3D  E85DFE            call 0x2d9d
00002F40  C7068D2EFFFF      mov word [0x2e8d],0xffff
00002F46  2BDB              sub bx,bx
00002F48  B40B              mov ah,0xb
00002F4A  CD10              int 0x10
00002F4C  E8EF1E            call 0x4e3e
00002F4F  803EF27000        cmp byte [0x70f2],0x0
00002F54  7403              jz 0x2f59
00002F56  E8A132            call 0x61fa
00002F59  E8E9E1            call 0x1145
00002F5C  B8E803            mov ax,0x3e8
00002F5F  BBA504            mov bx,0x4a5
00002F62  E8D629            call 0x593b
00002F65  C3                ret
00002F66  2AE4              sub ah,ah
00002F68  CD1A              int 0x1a
00002F6A  3B168F2E          cmp dx,[0x2e8f]
00002F6E  7501              jnz 0x2f71
00002F70  C3                ret
00002F71  89168F2E          mov [0x2e8f],dx
00002F75  833E8D2E08        cmp word [0x2e8d],byte +0x8
00002F7A  7230              jc 0x2fac
00002F7C  B90800            mov cx,0x8
00002F7F  8BD9              mov bx,cx
00002F81  4B                dec bx
00002F82  80BF722B00        cmp byte [bx+0x2b72],0x0
00002F87  7421              jz 0x2faa
00002F89  51                push cx
00002F8A  8A976A2B          mov dl,[bx+0x2b6a]
00002F8E  D0E3              shl bl,1
00002F90  8B875A2B          mov ax,[bx+0x2b5a]
00002F94  BE1800            mov si,0x18
00002F97  8BFE              mov di,si
00002F99  8B1E7905          mov bx,[0x579]
00002F9D  8A367B05          mov dh,[0x57b]
00002FA1  B90F0E            mov cx,0xe0f
00002FA4  E882FE            call 0x2e29
00002FA7  59                pop cx
00002FA8  7209              jc 0x2fb3
00002FAA  E2D3              loop 0x2f7f
00002FAC  C706942EFFFF      mov word [0x2e94],0xffff
00002FB2  C3                ret
00002FB3  8BD9              mov bx,cx
00002FB5  4B                dec bx
00002FB6  3B1E942E          cmp bx,[0x2e94]
00002FBA  74F6              jz 0x2fb2
00002FBC  53                push bx
00002FBD  E823E2            call 0x11e3
00002FC0  803EF27000        cmp byte [0x70f2],0x0
00002FC5  7403              jz 0x2fca
00002FC7  E86132            call 0x622b
00002FCA  5B                pop bx
00002FCB  C687722B00        mov byte [bx+0x2b72],0x0
00002FD0  8A976A2B          mov dl,[bx+0x2b6a]
00002FD4  891E8D2E          mov [0x2e8d],bx
00002FD8  D0E3              shl bl,1
00002FDA  8B8F5A2B          mov cx,[bx+0x2b5a]
00002FDE  E8CFFC            call 0x2cb0
00002FE1  8BF8              mov di,ax
00002FE3  BE7A2B            mov si,0x2b7a
00002FE6  B800B8            mov ax,0xb800
00002FE9  8EC0              mov es,ax
00002FEB  B9030F            mov cx,0xf03
00002FEE  E8ACFD            call 0x2d9d
00002FF1  803EF27000        cmp byte [0x70f2],0x0
00002FF6  7403              jz 0x2ffb
00002FF8  E8FF31            call 0x61fa
00002FFB  E847E1            call 0x1145
00002FFE  BB0100            mov bx,0x1
00003001  B40B              mov ah,0xb
00003003  CD10              int 0x10
00003005  B8E803            mov ax,0x3e8
00003008  BB4903            mov bx,0x349
0000300B  E82D29            call 0x593b
0000300E  C3                ret
0000300F  2BC0              sub ax,ax
00003011  BB242E            mov bx,0x2e24
00003014  E80DFB            call 0x2b24
00003017  C6068A2EBF        mov byte [0x2e8a],0xbf
0000301C  C7068B2E0000      mov word [0x2e8b],0x0
00003022  C706882E2000      mov word [0x2e88],0x20
00003028  2BDB              sub bx,bx
0000302A  803E8A2EBF        cmp byte [0x2e8a],0xbf
0000302F  7408              jz 0x3039
00003031  E8C9FD            call 0x2dfd
00003034  8ADA              mov bl,dl
00003036  80E302            and bl,0x2
00003039  8B0E882E          mov cx,[0x2e88]
0000303D  8A168A2E          mov dl,[0x2e8a]
00003041  53                push bx
00003042  E89E00            call 0x30e3
00003045  5B                pop bx
00003046  8B368B2E          mov si,[0x2e8b]
0000304A  A1882E            mov ax,[0x2e88]
0000304D  B104              mov cl,0x4
0000304F  D3E8              shr ax,cl
00003051  2D0200            sub ax,0x2
00003054  7302              jnc 0x3058
00003056  2BC0              sub ax,ax
00003058  3D1200            cmp ax,0x12
0000305B  7203              jc 0x3060
0000305D  B81100            mov ax,0x11
00003060  8A94DB2B          mov dl,[si+0x2bdb]
00003064  2AF6              sub dh,dh
00003066  03C2              add ax,dx
00003068  8BF0              mov si,ax
0000306A  889CE22B          mov [si+0x2be2],bl
0000306E  8306882E10        add word [0x2e88],byte +0x10
00003073  813E882E1101      cmp word [0x2e88],0x111
00003079  72AD              jc 0x3028
0000307B  FF068B2E          inc word [0x2e8b]
0000307F  802E8A2E18        sub byte [0x2e8a],0x18
00003084  803E8A2E2F        cmp byte [0x2e8a],0x2f
00003089  7397              jnc 0x3022
0000308B  B8FFFF            mov ax,0xffff
0000308E  A38D2E            mov [0x2e8d],ax
00003091  A3942E            mov [0x2e94],ax
00003094  2BC0              sub ax,ax
00003096  A3722B            mov [0x2b72],ax
00003099  A3742B            mov [0x2b74],ax
0000309C  A3762B            mov [0x2b76],ax
0000309F  A3782B            mov [0x2b78],ax
000030A2  8B0E1404          mov cx,[0x414]
000030A6  83F900            cmp cx,byte +0x0
000030A9  7505              jnz 0x30b0
000030AB  41                inc cx
000030AC  890E1404          mov [0x414],cx
000030B0  83F908            cmp cx,byte +0x8
000030B3  7603              jna 0x30b8
000030B5  B90800            mov cx,0x8
000030B8  8BD9              mov bx,cx
000030BA  4B                dec bx
000030BB  C687722B01        mov byte [bx+0x2b72],0x1
000030C0  B2B0              mov dl,0xb0
000030C2  88976A2B          mov [bx+0x2b6a],dl
000030C6  51                push cx
000030C7  D0E3              shl bl,1
000030C9  8B8F4A2B          mov cx,[bx+0x2b4a]
000030CD  898F5A2B          mov [bx+0x2b5a],cx
000030D1  E8DCFB            call 0x2cb0
000030D4  8BF8              mov di,ax
000030D6  BEF02A            mov si,0x2af0
000030D9  B9030F            mov cx,0xf03
000030DC  E8BEFC            call 0x2d9d
000030DF  59                pop cx
000030E0  E2D6              loop 0x30b8
000030E2  C3                ret
000030E3  53                push bx
000030E4  E8C9FB            call 0x2cb0
000030E7  8BF8              mov di,ax
000030E9  B800B8            mov ax,0xb800
000030EC  8EC0              mov es,ax
000030EE  5B                pop bx
000030EF  8BB7202E          mov si,[bx+0x2e20]
000030F3  B90208            mov cx,0x802
000030F6  E8A4FC            call 0x2d9d
000030F9  C3                ret
000030FA  A07B05            mov al,[0x57b]
000030FD  2C05              sub al,0x5
000030FF  24F8              and al,0xf8
00003101  B90700            mov cx,0x7
00003104  8BD9              mov bx,cx
00003106  4B                dec bx
00003107  3A87D42B          cmp al,[bx+0x2bd4]
0000310B  7404              jz 0x3111
0000310D  E2F5              loop 0x3104
0000310F  EB3C              jmp short 0x314d
00003111  8AE8              mov ch,al
00003113  A17905            mov ax,[0x579]
00003116  050700            add ax,0x7
00003119  B104              mov cl,0x4
0000311B  D3E8              shr ax,cl
0000311D  2D0200            sub ax,0x2
00003120  7302              jnc 0x3124
00003122  2BC0              sub ax,ax
00003124  3D1200            cmp ax,0x12
00003127  7203              jc 0x312c
00003129  B81100            mov ax,0x11
0000312C  8A97DB2B          mov dl,[bx+0x2bdb]
00003130  2AF6              sub dh,dh
00003132  03C2              add ax,dx
00003134  8BF0              mov si,ax
00003136  80BCE22B00        cmp byte [si+0x2be2],0x0
0000313B  7510              jnz 0x314d
0000313D  80C505            add ch,0x5
00003140  882E7B05          mov [0x57b],ch
00003144  80C532            add ch,0x32
00003147  882E7C05          mov [0x57c],ch
0000314B  F9                stc
0000314C  C3                ret
0000314D  F8                clc
0000314E  C3                ret
0000314F  002A              add [bp+si],ch
00003151  E4CD              in al,0xcd
00003153  1A8B1E04          sbb cl,[bp+di+0x41e]
00003157  00D0              add al,dl
00003159  E38B              jcxz 0x30e6
0000315B  8F                db 0x8f
0000315C  F2328BC22B        repne xor cl,[bp+di+0x2bc2]
00003161  06                push es
00003162  8C32              mov [bp+si],segr6
00003164  3BC1              cmp ax,cx
00003166  7301              jnc 0x3169
00003168  C3                ret
00003169  89168C32          mov [0x328c],dx
0000316D  E84A02            call 0x33ba
00003170  72F6              jc 0x3168
00003172  E86BF0            call 0x21e0
00003175  72F1              jc 0x3168
00003177  FE06EA32          inc byte [0x32ea]
0000317B  E87FFC            call 0x2dfd
0000317E  A0EA32            mov al,[0x32ea]
00003181  22C2              and al,dl
00003183  3006EB32          xor [0x32eb],al
00003187  A17D32            mov ax,[0x327d]
0000318A  2B067905          sub ax,[0x579]
0000318E  B2FF              mov dl,0xff
00003190  7304              jnc 0x3196
00003192  F7D0              not ax
00003194  B201              mov dl,0x1
00003196  8816ED32          mov [0x32ed],dl
0000319A  8A1E7F32          mov bl,[0x327f]
0000319E  80C314            add bl,0x14
000031A1  2A1E7B05          sub bl,[0x57b]
000031A5  B2FF              mov dl,0xff
000031A7  7304              jnc 0x31ad
000031A9  F6D3              not bl
000031AB  B201              mov dl,0x1
000031AD  8816EE32          mov [0x32ee],dl
000031B1  D1E8              shr ax,1
000031B3  D1E8              shr ax,1
000031B5  D0EB              shr bl,1
000031B7  02C3              add al,bl
000031B9  A2EC32            mov [0x32ec],al
000031BC  8B1E8A32          mov bx,[0x328a]
000031C0  83FB27            cmp bx,byte +0x27
000031C3  7207              jc 0x31cc
000031C5  BB2600            mov bx,0x26
000031C8  891E8A32          mov [0x328a],bx
000031CC  80BF8E3200        cmp byte [bx+0x328e],0x0
000031D1  7578              jnz 0x324b
000031D3  FF0E8A32          dec word [0x328a]
000031D7  2AE4              sub ah,ah
000031D9  CD1A              int 0x1a
000031DB  2B161004          sub dx,[0x410]
000031DF  B103              mov cl,0x3
000031E1  D3EA              shr dx,cl
000031E3  A0EC32            mov al,[0x32ec]
000031E6  2AC2              sub al,dl
000031E8  7302              jnc 0x31ec
000031EA  2AC0              sub al,al
000031EC  3A06EB32          cmp al,[0x32eb]
000031F0  7220              jc 0x3212
000031F2  C606813201        mov byte [0x3281],0x1
000031F7  E803FC            call 0x2dfd
000031FA  80FA00            cmp dl,0x0
000031FD  740C              jz 0x320b
000031FF  80FA07            cmp dl,0x7
00003202  770B              ja 0x320f
00003204  80E201            and dl,0x1
00003207  7502              jnz 0x320b
00003209  B2FF              mov dl,0xff
0000320B  88168032          mov [0x3280],dl
0000320F  E99A00            jmp 0x32ac
00003212  A0EB32            mov al,[0x32eb]
00003215  242F              and al,0x2f
00003217  751F              jnz 0x3238
00003219  E8E1FB            call 0x2dfd
0000321C  80E201            and dl,0x1
0000321F  7502              jnz 0x3223
00003221  B2FF              mov dl,0xff
00003223  88168032          mov [0x3280],dl
00003227  E8D3FB            call 0x2dfd
0000322A  80E201            and dl,0x1
0000322D  7502              jnz 0x3231
0000322F  B2FF              mov dl,0xff
00003231  88168132          mov [0x3281],dl
00003235  EB75              jmp short 0x32ac
00003237  90                nop
00003238  2407              and al,0x7
0000323A  7570              jnz 0x32ac
0000323C  A0ED32            mov al,[0x32ed]
0000323F  A28032            mov [0x3280],al
00003242  A0EE32            mov al,[0x32ee]
00003245  A28132            mov [0x3281],al
00003248  EB62              jmp short 0x32ac
0000324A  90                nop
0000324B  C606813201        mov byte [0x3281],0x1
00003250  8BC3              mov ax,bx
00003252  B103              mov cl,0x3
00003254  D3E0              shl ax,cl
00003256  39067D32          cmp [0x327d],ax
0000325A  740D              jz 0x3269
0000325C  B201              mov dl,0x1
0000325E  7202              jc 0x3262
00003260  B2FF              mov dl,0xff
00003262  88168032          mov [0x3280],dl
00003266  EB44              jmp short 0x32ac
00003268  90                nop
00003269  C606803200        mov byte [0x3280],0x0
0000326E  803E7F32A5        cmp byte [0x327f],0xa5
00003273  7537              jnz 0x32ac
00003275  C606813200        mov byte [0x3281],0x0
0000327A  833E7A3206        cmp word [0x327a],byte +0x6
0000327F  7407              jz 0x3288
00003281  833E7A3212        cmp word [0x327a],byte +0x12
00003286  7524              jnz 0x32ac
00003288  53                push bx
00003289  BEE831            mov si,0x31e8
0000328C  8B3E8232          mov di,[0x3282]
00003290  B9021E            mov cx,0x1e02
00003293  B800B8            mov ax,0xb800
00003296  8EC0              mov es,ax
00003298  E802FB            call 0x2d9d
0000329B  5B                pop bx
0000329C  FE8F8E32          dec byte [bx+0x328e]
000032A0  8A878E32          mov al,[bx+0x328e]
000032A4  E8D801            call 0x347f
000032A7  C606863201        mov byte [0x3286],0x1
000032AC  8B0E7D32          mov cx,[0x327d]
000032B0  8A167F32          mov dl,[0x327f]
000032B4  890EEF32          mov [0x32ef],cx
000032B8  8816F132          mov [0x32f1],dl
000032BC  803E803201        cmp byte [0x3280],0x1
000032C1  7217              jc 0x32da
000032C3  750E              jnz 0x32d3
000032C5  83C108            add cx,byte +0x8
000032C8  81F93101          cmp cx,0x131
000032CC  720C              jc 0x32da
000032CE  B93001            mov cx,0x130
000032D1  EB07              jmp short 0x32da
000032D3  83E908            sub cx,byte +0x8
000032D6  7302              jnc 0x32da
000032D8  2BC9              sub cx,cx
000032DA  81E1F8FF          and cx,0xfff8
000032DE  890E7D32          mov [0x327d],cx
000032E2  803E813201        cmp byte [0x3281],0x1
000032E7  7215              jc 0x32fe
000032E9  750C              jnz 0x32f7
000032EB  80C202            add dl,0x2
000032EE  80FAA6            cmp dl,0xa6
000032F1  720B              jc 0x32fe
000032F3  B2A5              mov dl,0xa5
000032F5  EB07              jmp short 0x32fe
000032F7  80EA02            sub dl,0x2
000032FA  7302              jnc 0x32fe
000032FC  2AD2              sub dl,dl
000032FE  88167F32          mov [0x327f],dl
00003302  E8ABF9            call 0x2cb0
00003305  A38432            mov [0x3284],ax
00003308  E8AF00            call 0x33ba
0000330B  731B              jnc 0x3328
0000330D  C606803200        mov byte [0x3280],0x0
00003312  C606813200        mov byte [0x3281],0x0
00003317  8B0EEF32          mov cx,[0x32ef]
0000331B  890E7D32          mov [0x327d],cx
0000331F  8A16F132          mov dl,[0x32f1]
00003323  88167F32          mov [0x327f],dl
00003327  C3                ret
00003328  E8B5EE            call 0x21e0
0000332B  72E0              jc 0x330d
0000332D  E87000            call 0x33a0
00003330  83067A3202        add word [0x327a],byte +0x2
00003335  E80100            call 0x3339
00003338  C3                ret
00003339  8B1E7A32          mov bx,[0x327a]
0000333D  8B876032          mov ax,[bx+0x3260]
00003341  3D0000            cmp ax,0x0
00003344  7505              jnz 0x334b
00003346  A37A32            mov [0x327a],ax
00003349  EBEE              jmp short 0x3339
0000334B  8BF0              mov si,ax
0000334D  8B3E8432          mov di,[0x3284]
00003351  893E8232          mov [0x3282],di
00003355  BDE831            mov bp,0x31e8
00003358  B800B8            mov ax,0xb800
0000335B  8EC0              mov es,ax
0000335D  B9021E            mov cx,0x1e02
00003360  C606863200        mov byte [0x3286],0x0
00003365  FC                cld
00003366  882E8932          mov [0x3289],ch
0000336A  2AED              sub ch,ch
0000336C  890E8732          mov [0x3287],cx
00003370  8B0E8732          mov cx,[0x3287]
00003374  268B1D            mov bx,[es:di]
00003377  3E895E00          mov [ds:bp+0x0],bx
0000337B  AD                lodsw
0000337C  0BC3              or ax,bx
0000337E  AB                stosw
0000337F  83C502            add bp,byte +0x2
00003382  E2F0              loop 0x3374
00003384  2B3E8732          sub di,[0x3287]
00003388  2B3E8732          sub di,[0x3287]
0000338C  81F70020          xor di,0x2000
00003390  F7C70020          test di,0x2000
00003394  7503              jnz 0x3399
00003396  83C750            add di,byte +0x50
00003399  FE0E8932          dec byte [0x3289]
0000339D  75D1              jnz 0x3370
0000339F  C3                ret
000033A0  803E863200        cmp byte [0x3286],0x0
000033A5  7512              jnz 0x33b9
000033A7  B800B8            mov ax,0xb800
000033AA  8EC0              mov es,ax
000033AC  BEE831            mov si,0x31e8
000033AF  8B3E8232          mov di,[0x3282]
000033B3  B9021E            mov cx,0x1e02
000033B6  E8E4F9            call 0x2d9d
000033B9  C3                ret
000033BA  803EB81C00        cmp byte [0x1cb8],0x0
000033BF  7542              jnz 0x3403
000033C1  833E040006        cmp word [0x4],byte +0x6
000033C6  750B              jnz 0x33d3
000033C8  803EBD4400        cmp byte [0x44bd],0x0
000033CD  7404              jz 0x33d3
000033CF  E8DE13            call 0x47b0
000033D2  C3                ret
000033D3  A17D32            mov ax,[0x327d]
000033D6  8A167F32          mov dl,[0x327f]
000033DA  BE1000            mov si,0x10
000033DD  8B1E7905          mov bx,[0x579]
000033E1  8A367B05          mov dh,[0x57b]
000033E5  BF1800            mov di,0x18
000033E8  B91E0E            mov cx,0xe1e
000033EB  E83BFA            call 0x2e29
000033EE  7313              jnc 0x3403
000033F0  833E040004        cmp word [0x4],byte +0x4
000033F5  7507              jnz 0x33fe
000033F7  803EE13900        cmp byte [0x39e1],0x0
000033FC  7503              jnz 0x3401
000033FE  E871D4            call 0x872
00003401  F9                stc
00003402  C3                ret
00003403  F8                clc
00003404  C3                ret
00003405  FC                cld
00003406  2BC0              sub ax,ax
00003408  1E                push ds
00003409  07                pop es
0000340A  BF8E32            mov di,0x328e
0000340D  B91400            mov cx,0x14
00003410  F3AB              rep stosw
00003412  C706B632FF00      mov word [0x32b6],0xff
00003418  C7067A320000      mov word [0x327a],0x0
0000341E  C7067D320000      mov word [0x327d],0x0
00003424  C6067F32A0        mov byte [0x327f],0xa0
00003429  C606863201        mov byte [0x3286],0x1
0000342E  C606803200        mov byte [0x3280],0x0
00003433  C606813200        mov byte [0x3281],0x0
00003438  E8C2F9            call 0x2dfd
0000343B  8816EB32          mov [0x32eb],dl
0000343F  C606EA326C        mov byte [0x32ea],0x6c
00003444  C3                ret
00003445  803E7B05B4        cmp byte [0x57b],0xb4
0000344A  7232              jc 0x347e
0000344C  803E6E0500        cmp byte [0x56e],0x0
00003451  742B              jz 0x347e
00003453  A17905            mov ax,[0x579]
00003456  050C00            add ax,0xc
00003459  B103              mov cl,0x3
0000345B  D3E8              shr ax,cl
0000345D  3D2700            cmp ax,0x27
00003460  771C              ja 0x347e
00003462  3B06B632          cmp ax,[0x32b6]
00003466  7416              jz 0x347e
00003468  A3B632            mov [0x32b6],ax
0000346B  8BD8              mov bx,ax
0000346D  8A878E32          mov al,[bx+0x328e]
00003471  3C04              cmp al,0x4
00003473  7309              jnc 0x347e
00003475  FEC0              inc al
00003477  88878E32          mov [bx+0x328e],al
0000347B  E80100            call 0x347f
0000347E  C3                ret
0000347F  B40A              mov ah,0xa
00003481  F6E4              mul ah
00003483  05B832            add ax,0x32b8
00003486  8BF0              mov si,ax
00003488  8BFB              mov di,bx
0000348A  D1E7              shl di,1
0000348C  81C7001E          add di,0x1e00
00003490  B800B8            mov ax,0xb800
00003493  8EC0              mov es,ax
00003495  B90105            mov cx,0x501
00003498  E802F9            call 0x2d9d
0000349B  C3                ret
0000349C  0000              add [bx+si],al
0000349E  0000              add [bx+si],al
000034A0  C70611350000      mov word [0x3511],0x0
000034A6  C6061B3500        mov byte [0x351b],0x0
000034AB  8B1E1135          mov bx,[0x3511]
000034AF  80BFA73400        cmp byte [bx+0x34a7],0x0
000034B4  7403              jz 0x34b9
000034B6  E9F400            jmp 0x35ad
000034B9  8BF3              mov si,bx
000034BB  D1E6              shl si,1
000034BD  8B844734          mov ax,[si+0x3447]
000034C1  8A977734          mov dl,[bx+0x3477]
000034C5  BF0000            mov di,0x0
000034C8  83FB0C            cmp bx,byte +0xc
000034CB  7203              jc 0x34d0
000034CD  BF0200            mov di,0x2
000034D0  8BB51335          mov si,[di+0x3513]
000034D4  8B8D1735          mov cx,[di+0x3517]
000034D8  8B1E7905          mov bx,[0x579]
000034DC  8A367B05          mov dh,[0x57b]
000034E0  BF1800            mov di,0x18
000034E3  B50E              mov ch,0xe
000034E5  E841F9            call 0x2e29
000034E8  73CC              jnc 0x34b6
000034EA  8B1E1135          mov bx,[0x3511]
000034EE  83FB0C            cmp bx,byte +0xc
000034F1  727C              jc 0x356f
000034F3  803E530500        cmp byte [0x553],0x0
000034F8  7575              jnz 0x356f
000034FA  803EF30500        cmp byte [0x5f3],0x0
000034FF  756E              jnz 0x356f
00003501  C606520501        mov byte [0x552],0x1
00003506  8B0E7905          mov cx,[0x579]
0000350A  83E908            sub cx,byte +0x8
0000350D  7302              jnc 0x3511
0000350F  2BC9              sub cx,cx
00003511  81F91701          cmp cx,0x117
00003515  7203              jc 0x351a
00003517  B91601            mov cx,0x116
0000351A  8A167B05          mov dl,[0x57b]
0000351E  80FAB5            cmp dl,0xb5
00003521  7202              jc 0x3525
00003523  B2B4              mov dl,0xb4
00003525  E888F7            call 0x2cb0
00003528  8BF8              mov di,ax
0000352A  BE5033            mov si,0x3350
0000352D  B800B8            mov ax,0xb800
00003530  8EC0              mov es,ax
00003532  B90512            mov cx,0x1205
00003535  E865F8            call 0x2d9d
00003538  E85C22            call 0x5797
0000353B  2AE4              sub ah,ah
0000353D  CD1A              int 0x1a
0000353F  89160935          mov [0x3509],dx
00003543  52                push dx
00003544  E85F22            call 0x57a6
00003547  E88EDE            call 0x13d8
0000354A  74F8              jz 0x3544
0000354C  E85722            call 0x57a6
0000354F  5A                pop dx
00003550  BB0100            mov bx,0x1
00003553  F6C201            test dl,0x1
00003556  7502              jnz 0x355a
00003558  B30F              mov bl,0xf
0000355A  B40B              mov ah,0xb
0000355C  CD10              int 0x10
0000355E  E84522            call 0x57a6
00003561  2AE4              sub ah,ah
00003563  CD1A              int 0x1a
00003565  2B160935          sub dx,[0x3509]
00003569  83FA0D            cmp dx,byte +0xd
0000356C  72D5              jc 0x3543
0000356E  C3                ret
0000356F  FE061B35          inc byte [0x351b]
00003573  B8DC05            mov ax,0x5dc
00003576  BB2504            mov bx,0x425
00003579  E8BF23            call 0x593b
0000357C  803E1B3501        cmp byte [0x351b],0x1
00003581  7503              jnz 0x3586
00003583  E85DDC            call 0x11e3
00003586  8B1E1135          mov bx,[0x3511]
0000358A  E83402            call 0x37c1
0000358D  8B1E1135          mov bx,[0x3511]
00003591  C687A73401        mov byte [bx+0x34a7],0x1
00003596  83FB0C            cmp bx,byte +0xc
00003599  7312              jnc 0x35ad
0000359B  FE0E1034          dec byte [0x3410]
0000359F  750C              jnz 0x35ad
000035A1  803EF30500        cmp byte [0x5f3],0x0
000035A6  7505              jnz 0x35ad
000035A8  C606530501        mov byte [0x553],0x1
000035AD  FF061135          inc word [0x3511]
000035B1  833E113518        cmp word [0x3511],byte +0x18
000035B6  7303              jnc 0x35bb
000035B8  E9F0FE            jmp 0x34ab
000035BB  803E1B3500        cmp byte [0x351b],0x0
000035C0  7405              jz 0x35c7
000035C2  E87800            call 0x363d
000035C5  F9                stc
000035C6  C3                ret
000035C7  F8                clc
000035C8  C3                ret
000035C9  C70611340000      mov word [0x3411],0x0
000035CF  C70615340000      mov word [0x3415],0x0
000035D5  C60610340C        mov byte [0x3410],0xc
000035DA  B91800            mov cx,0x18
000035DD  8BD9              mov bx,cx
000035DF  4B                dec bx
000035E0  C6878F3401        mov byte [bx+0x348f],0x1
000035E5  C687A73400        mov byte [bx+0x34a7],0x0
000035EA  8A87F134          mov al,[bx+0x34f1]
000035EE  88877734          mov [bx+0x3477],al
000035F2  C6872F3401        mov byte [bx+0x342f],0x1
000035F7  E803F8            call 0x2dfd
000035FA  80E201            and dl,0x1
000035FD  7502              jnz 0x3601
000035FF  F6D2              not dl
00003601  88971734          mov [bx+0x3417],dl
00003605  D1E3              shl bx,1
00003607  E8F3F7            call 0x2dfd
0000360A  2AF6              sub dh,dh
0000360C  89974734          mov [bx+0x3447],dx
00003610  E2CB              loop 0x35dd
00003612  8B1E0800          mov bx,[0x8]
00003616  8A8F1C35          mov cl,[bx+0x351c]
0000361A  2AED              sub ch,ch
0000361C  E8DEF7            call 0x2dfd
0000361F  80E20F            and dl,0xf
00003622  80FA0C            cmp dl,0xc
00003625  73F5              jnc 0x361c
00003627  8ADA              mov bl,dl
00003629  80C30C            add bl,0xc
0000362C  2AFF              sub bh,bh
0000362E  80BFA73400        cmp byte [bx+0x34a7],0x0
00003633  75E7              jnz 0x361c
00003635  C687A73401        mov byte [bx+0x34a7],0x1
0000363A  E2E0              loop 0x361c
0000363C  C3                ret
0000363D  B90C00            mov cx,0xc
00003640  8BD9              mov bx,cx
00003642  83C30B            add bx,byte +0xb
00003645  80BFA73400        cmp byte [bx+0x34a7],0x0
0000364A  7426              jz 0x3672
0000364C  2BC0              sub ax,ax
0000364E  B201              mov dl,0x1
00003650  8887A734          mov [bx+0x34a7],al
00003654  813E7905A000      cmp word [0x579],0xa0
0000365A  7705              ja 0x3661
0000365C  B82E01            mov ax,0x12e
0000365F  B2FF              mov dl,0xff
00003661  88971734          mov [bx+0x3417],dl
00003665  D0E3              shl bl,1
00003667  89874734          mov [bx+0x3447],ax
0000366B  FE0E1B35          dec byte [0x351b]
0000366F  75CC              jnz 0x363d
00003671  C3                ret
00003672  E2CC              loop 0x3640
00003674  C3                ret
00003675  2AE4              sub ah,ah
00003677  CD1A              int 0x1a
00003679  3B160935          cmp dx,[0x3509]
0000367D  7501              jnz 0x3680
0000367F  C3                ret
00003680  89160B35          mov [0x350b],dx
00003684  FF061534          inc word [0x3415]
00003688  8B1E1534          mov bx,[0x3415]
0000368C  83FB18            cmp bx,byte +0x18
0000368F  7213              jc 0x36a4
00003691  2BDB              sub bx,bx
00003693  891E1534          mov [0x3415],bx
00003697  813611340C00      xor word [0x3411],0xc
0000369D  8306133408        add word [0x3413],byte +0x8
000036A2  EB13              jmp short 0x36b7
000036A4  83FB0C            cmp bx,byte +0xc
000036A7  7514              jnz 0x36bd
000036A9  803E9706FD        cmp byte [0x697],0xfd
000036AE  7507              jnz 0x36b7
000036B0  803E7B0530        cmp byte [0x57b],0x30
000036B5  7206              jc 0x36bd
000036B7  A10B35            mov ax,[0x350b]
000036BA  A30935            mov [0x3509],ax
000036BD  8BF3              mov si,bx
000036BF  D1E6              shl si,1
000036C1  80BFA73400        cmp byte [bx+0x34a7],0x0
000036C6  75B7              jnz 0x367f
000036C8  E832F7            call 0x2dfd
000036CB  80FA10            cmp dl,0x10
000036CE  7719              ja 0x36e9
000036D0  80E201            and dl,0x1
000036D3  7502              jnz 0x36d7
000036D5  F6D2              not dl
000036D7  88971734          mov [bx+0x3417],dl
000036DB  E81FF7            call 0x2dfd
000036DE  80E201            and dl,0x1
000036E1  7502              jnz 0x36e5
000036E3  F6D2              not dl
000036E5  88972F34          mov [bx+0x342f],dl
000036E9  B90400            mov cx,0x4
000036EC  83FB0C            cmp bx,byte +0xc
000036EF  7202              jc 0x36f3
000036F1  D0E9              shr cl,1
000036F3  8B844734          mov ax,[si+0x3447]
000036F7  80BF173401        cmp byte [bx+0x3417],0x1
000036FC  740D              jz 0x370b
000036FE  2BC1              sub ax,cx
00003700  7318              jnc 0x371a
00003702  2BC0              sub ax,ax
00003704  C687173401        mov byte [bx+0x3417],0x1
00003709  EB0F              jmp short 0x371a
0000370B  03C1              add ax,cx
0000370D  3D2F01            cmp ax,0x12f
00003710  7208              jc 0x371a
00003712  B82E01            mov ax,0x12e
00003715  C6871734FF        mov byte [bx+0x3417],0xff
0000371A  89844734          mov [si+0x3447],ax
0000371E  8A877734          mov al,[bx+0x3477]
00003722  80BF2F3401        cmp byte [bx+0x342f],0x1
00003727  7413              jz 0x373c
00003729  FEC8              dec al
0000372B  3A87F134          cmp al,[bx+0x34f1]
0000372F  731F              jnc 0x3750
00003731  8A87F134          mov al,[bx+0x34f1]
00003735  C6872F3401        mov byte [bx+0x342f],0x1
0000373A  EB14              jmp short 0x3750
0000373C  FEC0              inc al
0000373E  8A97F134          mov dl,[bx+0x34f1]
00003742  80C218            add dl,0x18
00003745  3AC2              cmp al,dl
00003747  7607              jna 0x3750
00003749  8AC2              mov al,dl
0000374B  C6872F34FF        mov byte [bx+0x342f],0xff
00003750  88877734          mov [bx+0x3477],al
00003754  8AD0              mov dl,al
00003756  8B8C4734          mov cx,[si+0x3447]
0000375A  E853F5            call 0x2cb0
0000375D  A3EF34            mov [0x34ef],ax
00003760  8B1E1534          mov bx,[0x3415]
00003764  E85A00            call 0x37c1
00003767  8B1E1534          mov bx,[0x3415]
0000376B  8BF3              mov si,bx
0000376D  D1E6              shl si,1
0000376F  8B3EEF34          mov di,[0x34ef]
00003773  89BCBF34          mov [si+0x34bf],di
00003777  C6878F3400        mov byte [bx+0x348f],0x0
0000377C  B800B8            mov ax,0xb800
0000377F  8EC0              mov es,ax
00003781  83FB0C            cmp bx,byte +0xc
00003784  7219              jc 0x379f
00003786  8BF3              mov si,bx
00003788  B103              mov cl,0x3
0000378A  D3E6              shl si,cl
0000378C  03361334          add si,[0x3413]
00003790  81E61800          and si,0x18
00003794  81C63033          add si,0x3330
00003798  B90202            mov cx,0x202
0000379B  E8FFF5            call 0x2d9d
0000379E  C3                ret
0000379F  8B361134          mov si,[0x3411]
000037A3  F6C301            test bl,0x1
000037A6  7504              jnz 0x37ac
000037A8  81F60C00          xor si,0xc
000037AC  80BF173401        cmp byte [bx+0x3417],0x1
000037B1  7403              jz 0x37b6
000037B3  83C618            add si,byte +0x18
000037B6  81C60033          add si,0x3300
000037BA  B90106            mov cx,0x601
000037BD  E8DDF5            call 0x2d9d
000037C0  C3                ret
000037C1  80BF8F3400        cmp byte [bx+0x348f],0x0
000037C6  751C              jnz 0x37e4
000037C8  D1E3              shl bx,1
000037CA  BE0434            mov si,0x3404
000037CD  8BBFBF34          mov di,[bx+0x34bf]
000037D1  B800B8            mov ax,0xb800
000037D4  8EC0              mov es,ax
000037D6  B90106            mov cx,0x601
000037D9  83FB18            cmp bx,byte +0x18
000037DC  7203              jc 0x37e1
000037DE  B90202            mov cx,0x202
000037E1  E8B9F5            call 0x2d9d
000037E4  C3                ret
000037E5  2AE4              sub ah,ah
000037E7  CD1A              int 0x1a
000037E9  8BC2              mov ax,dx
000037EB  2B060F35          sub ax,[0x350f]
000037EF  3D0800            cmp ax,0x8
000037F2  7256              jc 0x384a
000037F4  FF060D35          inc word [0x350d]
000037F8  8B1E0D35          mov bx,[0x350d]
000037FC  83FB28            cmp bx,byte +0x28
000037FF  720A              jc 0x380b
00003801  2BDB              sub bx,bx
00003803  891E0D35          mov [0x350d],bx
00003807  89160F35          mov [0x350f],dx
0000380B  8BFB              mov di,bx
0000380D  D1E7              shl di,1
0000380F  803E7B0507        cmp byte [0x57b],0x7
00003814  7713              ja 0x3829
00003816  A17905            mov ax,[0x579]
00003819  B102              mov cl,0x2
0000381B  D3E8              shr ax,cl
0000381D  40                inc ax
0000381E  2BC7              sub ax,di
00003820  7302              jnc 0x3824
00003822  F7D0              not ax
00003824  3D0400            cmp ax,0x4
00003827  7221              jc 0x384a
00003829  81C7A000          add di,0xa0
0000382D  8A875626          mov al,[bx+0x2656]
00003831  0408              add al,0x8
00003833  88875626          mov [bx+0x2656],al
00003837  251800            and ax,0x18
0000383A  052020            add ax,0x2020
0000383D  8BF0              mov si,ax
0000383F  B800B8            mov ax,0xb800
00003842  8EC0              mov es,ax
00003844  B90104            mov cx,0x401
00003847  E853F5            call 0x2d9d
0000384A  C3                ret
0000384B  0000              add [bx+si],al
0000384D  0000              add [bx+si],al
0000384F  002A              add [bp+si],ch
00003851  E4CD              in al,0xcd
00003853  1A8BC22B          sbb cl,[bp+di+0x2bc2]
00003857  06                push es
00003858  DA35              fidiv dword [di]
0000385A  3D0600            cmp ax,0x6
0000385D  7301              jnc 0x3860
0000385F  C3                ret
00003860  8916DA35          mov [0x35da],dx
00003864  8306D83502        add word [0x35d8],byte +0x2
00003869  8B1ED835          mov bx,[0x35d8]
0000386D  81E30600          and bx,0x6
00003871  8BB7D035          mov si,[bx+0x35d0]
00003875  BFC915            mov di,0x15c9
00003878  B800B8            mov ax,0xb800
0000387B  8EC0              mov es,ax
0000387D  B9020A            mov cx,0xa02
00003880  E81AF5            call 0x2d9d
00003883  B8E400            mov ax,0xe4
00003886  B28A              mov dl,0x8a
00003888  BE1000            mov si,0x10
0000388B  8B1E7905          mov bx,[0x579]
0000388F  8A367B05          mov dh,[0x57b]
00003893  BF1800            mov di,0x18
00003896  B90A0E            mov cx,0xe0a
00003899  E88DF5            call 0x2e29
0000389C  7305              jnc 0x38a3
0000389E  C606540501        mov byte [0x554],0x1
000038A3  C3                ret
000038A4  0000              add [bx+si],al
000038A6  0000              add [bx+si],al
000038A8  0000              add [bx+si],al
000038AA  0000              add [bx+si],al
000038AC  0000              add [bx+si],al
000038AE  0000              add [bx+si],al
000038B0  833E060007        cmp word [0x6],byte +0x7
000038B5  7503              jnz 0x38ba
000038B7  EB1A              jmp short 0x38d3
000038B9  90                nop
000038BA  FF061404          inc word [0x414]
000038BE  C606180401        mov byte [0x418],0x1
000038C3  BAAAAA            mov dx,0xaaaa
000038C6  E8CD01            call 0x3a96
000038C9  2BC0              sub ax,ax
000038CB  C6069F3600        mov byte [0x369f],0x0
000038D0  E8D901            call 0x3aac
000038D3  2AE4              sub ah,ah
000038D5  CD1A              int 0x1a
000038D7  833E060007        cmp word [0x6],byte +0x7
000038DC  7511              jnz 0x38ef
000038DE  2B161204          sub dx,[0x412]
000038E2  B8302A            mov ax,0x2a30
000038E5  2BC2              sub ax,dx
000038E7  7302              jnc 0x38eb
000038E9  2BC0              sub ax,ax
000038EB  D1E8              shr ax,1
000038ED  EB1F              jmp short 0x390e
000038EF  2B161004          sub dx,[0x410]
000038F3  B84605            mov ax,0x546
000038F6  833E060006        cmp word [0x6],byte +0x6
000038FB  7502              jnz 0x38ff
000038FD  D1E0              shl ax,1
000038FF  2BC2              sub ax,dx
00003901  7302              jnc 0x3905
00003903  2BC0              sub ax,ax
00003905  833E060006        cmp word [0x6],byte +0x6
0000390A  7402              jz 0x390e
0000390C  D1E0              shl ax,1
0000390E  A39736            mov [0x3697],ax
00003911  E8E001            call 0x3af4
00003914  8B1E0600          mov bx,[0x6]
00003918  D0E3              shl bl,1
0000391A  8BB7CC36          mov si,[bx+0x36cc]
0000391E  BF8D36            mov di,0x368d
00003921  E8FAED            call 0x271e
00003924  833E060007        cmp word [0x6],byte +0x7
00003929  7543              jnz 0x396e
0000392B  8B1E0800          mov bx,[0x8]
0000392F  D0E3              shl bl,1
00003931  8BC3              mov ax,bx
00003933  8B8FDC36          mov cx,[bx+0x36dc]
00003937  833E8D2E08        cmp word [0x2e8d],byte +0x8
0000393C  7305              jnc 0x3943
0000393E  D1E1              shl cx,1
00003940  051000            add ax,0x10
00003943  A30C37            mov [0x370c],ax
00003946  BE8D36            mov si,0x368d
00003949  BF821F            mov di,0x1f82
0000394C  51                push cx
0000394D  E8CEED            call 0x271e
00003950  59                pop cx
00003951  E2F3              loop 0x3946
00003953  E8A400            call 0x39fa
00003956  C6069E3638        mov byte [0x369e],0x38
0000395B  C606993601        mov byte [0x3699],0x1
00003960  C70622374400      mov word [0x3722],0x44
00003966  E8D100            call 0x3a3a
00003969  E80001            call 0x3a6c
0000396C  EB39              jmp short 0x39a7
0000396E  BE8D36            mov si,0x368d
00003971  BF821F            mov di,0x1f82
00003974  E8A7ED            call 0x271e
00003977  C606993602        mov byte [0x3699],0x2
0000397C  C70622371E00      mov word [0x3722],0x1e
00003982  BAFFFF            mov dx,0xffff
00003985  E80E01            call 0x3a96
00003988  B88C0A            mov ax,0xa8c
0000398B  2B069736          sub ax,[0x3697]
0000398F  B104              mov cl,0x4
00003991  D3E8              shr ax,cl
00003993  24F0              and al,0xf0
00003995  A29E36            mov [0x369e],al
00003998  B428              mov ah,0x28
0000399A  F6E4              mul ah
0000399C  C6069F3601        mov byte [0x369f],0x1
000039A1  E80801            call 0x3aac
000039A4  E89300            call 0x3a3a
000039A7  2AE4              sub ah,ah
000039A9  CD1A              int 0x1a
000039AB  89169536          mov [0x3695],dx
000039AF  833E060007        cmp word [0x6],byte +0x7
000039B4  7505              jnz 0x39bb
000039B6  E8AA21            call 0x5b63
000039B9  EB03              jmp short 0x39be
000039BB  E8771E            call 0x5835
000039BE  E85B00            call 0x3a1c
000039C1  2B169536          sub dx,[0x3695]
000039C5  3B162237          cmp dx,[0x3722]
000039C9  72E4              jc 0x39af
000039CB  2BDB              sub bx,bx
000039CD  B40B              mov ah,0xb
000039CF  CD10              int 0x10
000039D1  833E060007        cmp word [0x6],byte +0x7
000039D6  7404              jz 0x39dc
000039D8  E84621            call 0x5b21
000039DB  C3                ret
000039DC  B800B8            mov ax,0xb800
000039DF  8EC0              mov es,ax
000039E1  BE0E00            mov si,0xe
000039E4  BFE408            mov di,0x8e4
000039E7  B90408            mov cx,0x804
000039EA  E8B0F3            call 0x2d9d
000039ED  BE4E00            mov si,0x4e
000039F0  BF940C            mov di,0xc94
000039F3  B91408            mov cx,0x814
000039F6  E8A4F3            call 0x2d9d
000039F9  C3                ret
000039FA  1E                push ds
000039FB  07                pop es
000039FC  B800B8            mov ax,0xb800
000039FF  8ED8              mov ds,ax
00003A01  B90408            mov cx,0x804
00003A04  BF0E00            mov di,0xe
00003A07  BEE408            mov si,0x8e4
00003A0A  E8BDF3            call 0x2dca
00003A0D  B91408            mov cx,0x814
00003A10  BF4E00            mov di,0x4e
00003A13  BE940C            mov si,0xc94
00003A16  E8B1F3            call 0x2dca
00003A19  06                push es
00003A1A  1F                pop ds
00003A1B  C3                ret
00003A1C  2AE4              sub ah,ah
00003A1E  CD1A              int 0x1a
00003A20  52                push dx
00003A21  E8B4D9            call 0x13d8
00003A24  74FB              jz 0x3a21
00003A26  5A                pop dx
00003A27  52                push dx
00003A28  2BDB              sub bx,bx
00003A2A  F7C20400          test dx,0x4
00003A2E  7504              jnz 0x3a34
00003A30  8A1E9936          mov bl,[0x3699]
00003A34  B40B              mov ah,0xb
00003A36  CD10              int 0x10
00003A38  5A                pop dx
00003A39  C3                ret
00003A3A  B402              mov ah,0x2
00003A3C  8A369E36          mov dh,[0x369e]
00003A40  B103              mov cl,0x3
00003A42  D2EE              shr dh,cl
00003A44  B212              mov dl,0x12
00003A46  2AFF              sub bh,bh
00003A48  CD10              int 0x10
00003A4A  C706A0360300      mov word [0x36a0],0x3
00003A50  8B1EA036          mov bx,[0x36a0]
00003A54  8A878D36          mov al,[bx+0x368d]
00003A58  0430              add al,0x30
00003A5A  B40E              mov ah,0xe
00003A5C  B303              mov bl,0x3
00003A5E  CD10              int 0x10
00003A60  FF06A036          inc word [0x36a0]
00003A64  833EA03607        cmp word [0x36a0],byte +0x7
00003A69  72E5              jc 0x3a50
00003A6B  C3                ret
00003A6C  B402              mov ah,0x2
00003A6E  B20A              mov dl,0xa
00003A70  8AF2              mov dh,dl
00003A72  2BDB              sub bx,bx
00003A74  CD10              int 0x10
00003A76  8B1E0C37          mov bx,[0x370c]
00003A7A  8B87EC36          mov ax,[bx+0x36ec]
00003A7E  A32037            mov [0x3720],ax
00003A81  2BDB              sub bx,bx
00003A83  B40E              mov ah,0xe
00003A85  8A870E37          mov al,[bx+0x370e]
00003A89  53                push bx
00003A8A  B303              mov bl,0x3
00003A8C  CD10              int 0x10
00003A8E  5B                pop bx
00003A8F  43                inc bx
00003A90  83FB14            cmp bx,byte +0x14
00003A93  72EE              jc 0x3a83
00003A95  C3                ret
00003A96  FC                cld
00003A97  B81000            mov ax,0x10
00003A9A  8EC0              mov es,ax
00003A9C  BF0E00            mov di,0xe
00003A9F  BEE035            mov si,0x35e0
00003AA2  B91E00            mov cx,0x1e
00003AA5  AD                lodsw
00003AA6  23C2              and ax,dx
00003AA8  AB                stosw
00003AA9  E2FA              loop 0x3aa5
00003AAB  C3                ret
00003AAC  A39A36            mov [0x369a],ax
00003AAF  B800B8            mov ax,0xb800
00003AB2  8EC0              mov es,ax
00003AB4  E8721D            call 0x5829
00003AB7  B8801B            mov ax,0x1b80
00003ABA  BB1C36            mov bx,0x361c
00003ABD  A39C36            mov [0x369c],ax
00003AC0  E861F0            call 0x2b24
00003AC3  803E9F3600        cmp byte [0x369f],0x0
00003AC8  7418              jz 0x3ae2
00003ACA  E89C1D            call 0x5869
00003ACD  2AE4              sub ah,ah
00003ACF  CD1A              int 0x1a
00003AD1  89169536          mov [0x3695],dx
00003AD5  2AE4              sub ah,ah
00003AD7  CD1A              int 0x1a
00003AD9  2B169536          sub dx,[0x3695]
00003ADD  83FA02            cmp dx,byte +0x2
00003AE0  72F3              jc 0x3ad5
00003AE2  A19C36            mov ax,[0x369c]
00003AE5  2D8002            sub ax,0x280
00003AE8  7206              jc 0x3af0
00003AEA  3B069A36          cmp ax,[0x369a]
00003AEE  73CA              jnc 0x3aba
00003AF0  E82E20            call 0x5b21
00003AF3  C3                ret
00003AF4  A38B36            mov [0x368b],ax
00003AF7  2BC0              sub ax,ax
00003AF9  A38D36            mov [0x368d],ax
00003AFC  A38F36            mov [0x368f],ax
00003AFF  A39136            mov [0x3691],ax
00003B02  A39336            mov [0x3693],ax
00003B05  BB8436            mov bx,0x3684
00003B08  BA0010            mov dx,0x1000
00003B0B  85168B36          test [0x368b],dx
00003B0F  7408              jz 0x3b19
00003B11  8BF3              mov si,bx
00003B13  BF8D36            mov di,0x368d
00003B16  E805EC            call 0x271e
00003B19  83EB07            sub bx,byte +0x7
00003B1C  D1EA              shr dx,1
00003B1E  73EB              jnc 0x3b0b
00003B20  C3                ret
00003B21  0000              add [bx+si],al
00003B23  0000              add [bx+si],al
00003B25  0000              add [bx+si],al
00003B27  0000              add [bx+si],al
00003B29  0000              add [bx+si],al
00003B2B  0000              add [bx+si],al
00003B2D  0000              add [bx+si],al
00003B2F  00C6              add dh,al
00003B31  06                push es
00003B32  AF                scasw
00003B33  37                aaa
00003B34  03B80100          add di,[bx+si+0x1]
00003B38  A3B037            mov [0x37b0],ax
00003B3B  A3B237            mov [0x37b2],ax
00003B3E  A3B437            mov [0x37b4],ax
00003B41  C3                ret
00003B42  2AE4              sub ah,ah
00003B44  CD1A              int 0x1a
00003B46  3B16B837          cmp dx,[0x37b8]
00003B4A  7501              jnz 0x3b4d
00003B4C  C3                ret
00003B4D  8916B837          mov [0x37b8],dx
00003B51  C706B6370400      mov word [0x37b6],0x4
00003B57  8B1EB637          mov bx,[0x37b6]
00003B5B  83BFB03700        cmp word [bx+0x37b0],byte +0x0
00003B60  7439              jz 0x3b9b
00003B62  8B87A337          mov ax,[bx+0x37a3]
00003B66  B218              mov dl,0x18
00003B68  BE1000            mov si,0x10
00003B6B  8B1E7905          mov bx,[0x579]
00003B6F  8A367B05          mov dh,[0x57b]
00003B73  BF1800            mov di,0x18
00003B76  B9100E            mov cx,0xe10
00003B79  E8ADF2            call 0x2e29
00003B7C  731D              jnc 0x3b9b
00003B7E  B8000C            mov ax,0xc00
00003B81  BBFD08            mov bx,0x8fd
00003B84  E8B41D            call 0x593b
00003B87  E859D6            call 0x11e3
00003B8A  E8AB02            call 0x3e38
00003B8D  8B1EB637          mov bx,[0x37b6]
00003B91  E80F00            call 0x3ba3
00003B94  E88DD5            call 0x1124
00003B97  E87A02            call 0x3e14
00003B9A  C3                ret
00003B9B  832EB63702        sub word [0x37b6],byte +0x2
00003BA0  73B5              jnc 0x3b57
00003BA2  C3                ret
00003BA3  C787B0370000      mov word [bx+0x37b0],0x0
00003BA9  1E                push ds
00003BAA  07                pop es
00003BAB  FC                cld
00003BAC  B8AAAA            mov ax,0xaaaa
00003BAF  BF0E00            mov di,0xe
00003BB2  8BF7              mov si,di
00003BB4  B92000            mov cx,0x20
00003BB7  F3AB              rep stosw
00003BB9  8BBFA937          mov di,[bx+0x37a9]
00003BBD  B800B8            mov ax,0xb800
00003BC0  8EC0              mov es,ax
00003BC2  B90210            mov cx,0x1002
00003BC5  E8D5F1            call 0x2d9d
00003BC8  FE0EAF37          dec byte [0x37af]
00003BCC  750C              jnz 0x3bda
00003BCE  803E520500        cmp byte [0x552],0x0
00003BD3  7505              jnz 0x3bda
00003BD5  C606530501        mov byte [0x553],0x1
00003BDA  C3                ret
00003BDB  B800B8            mov ax,0xb800
00003BDE  8EC0              mov es,ax
00003BE0  C706A0376A06      mov word [0x37a0],0x66a
00003BE6  B91000            mov cx,0x10
00003BE9  2BC0              sub ax,ax
00003BEB  8BD8              mov bx,ax
00003BED  A2A237            mov [0x37a2],al
00003BF0  2AE4              sub ah,ah
00003BF2  053037            add ax,0x3730
00003BF5  8BF0              mov si,ax
00003BF7  8B3EA037          mov di,[0x37a0]
00003BFB  03FB              add di,bx
00003BFD  51                push cx
00003BFE  B90108            mov cx,0x801
00003C01  53                push bx
00003C02  E898F1            call 0x2d9d
00003C05  5B                pop bx
00003C06  59                pop cx
00003C07  83C302            add bx,byte +0x2
00003C0A  83FB1E            cmp bx,byte +0x1e
00003C0D  720F              jc 0x3c1e
00003C0F  7504              jnz 0x3c15
00003C11  B020              mov al,0x20
00003C13  EBD8              jmp short 0x3bed
00003C15  8106A0374001      add word [0x37a0],0x140
00003C1B  E2CC              loop 0x3be9
00003C1D  C3                ret
00003C1E  803EA23750        cmp byte [0x37a2],0x50
00003C23  7411              jz 0x3c36
00003C25  F6C101            test cl,0x1
00003C28  750C              jnz 0x3c36
00003C2A  E8D0F1            call 0x2dfd
00003C2D  80FA40            cmp dl,0x40
00003C30  7204              jc 0x3c36
00003C32  B010              mov al,0x10
00003C34  EBB7              jmp short 0x3bed
00003C36  E8C4F1            call 0x2dfd
00003C39  8AC2              mov al,dl
00003C3B  2AC3              sub al,bl
00003C3D  2430              and al,0x30
00003C3F  0430              add al,0x30
00003C41  EBAA              jmp short 0x3bed
00003C43  A17905            mov ax,[0x579]
00003C46  25FCFF            and ax,0xfffc
00003C49  3DA400            cmp ax,0xa4
00003C4C  7231              jc 0x3c7f
00003C4E  3D1801            cmp ax,0x118
00003C51  772C              ja 0x3c7f
00003C53  8A167B05          mov dl,[0x57b]
00003C57  80EA02            sub dl,0x2
00003C5A  80E2F8            and dl,0xf8
00003C5D  F6C208            test dl,0x8
00003C60  741D              jz 0x3c7f
00003C62  80FA28            cmp dl,0x28
00003C65  7218              jc 0x3c7f
00003C67  80FAA0            cmp dl,0xa0
00003C6A  7713              ja 0x3c7f
00003C6C  A37905            mov [0x579],ax
00003C6F  80C202            add dl,0x2
00003C72  88167B05          mov [0x57b],dl
00003C76  80C232            add dl,0x32
00003C79  88167C05          mov [0x57c],dl
00003C7D  F9                stc
00003C7E  C3                ret
00003C7F  F8                clc
00003C80  C3                ret
00003C81  0000              add [bx+si],al
00003C83  0000              add [bx+si],al
00003C85  0000              add [bx+si],al
00003C87  0000              add [bx+si],al
00003C89  0000              add [bx+si],al
00003C8B  0000              add [bx+si],al
00003C8D  0000              add [bx+si],al
00003C8F  00C6              add dh,al
00003C91  06                push es
00003C92  663908            cmp [bx+si],ecx
00003C95  C6066A3901        mov byte [0x396a],0x1
00003C9A  C606673900        mov byte [0x3967],0x0
00003C9F  C6066D3902        mov byte [0x396d],0x2
00003CA4  C70664391801      mov word [0x3964],0x118
00003CAA  C7066B390000      mov word [0x396b],0x0
00003CB0  C3                ret
00003CB1  2AE4              sub ah,ah
00003CB3  CD1A              int 0x1a
00003CB5  8BC2              mov ax,dx
00003CB7  2B06C839          sub ax,[0x39c8]
00003CBB  3D0200            cmp ax,0x2
00003CBE  7301              jnc 0x3cc1
00003CC0  C3                ret
00003CC1  8916C839          mov [0x39c8],dx
00003CC5  E88A01            call 0x3e52
00003CC8  72F6              jc 0x3cc0
00003CCA  E8A101            call 0x3e6e
00003CCD  7303              jnc 0x3cd2
00003CCF  E9BE00            jmp 0x3d90
00003CD2  8B1E0800          mov bx,[0x8]
00003CD6  D0E3              shl bl,1
00003CD8  8B87CC39          mov ax,[bx+0x39cc]
00003CDC  A3C639            mov [0x39c6],ax
00003CDF  A16439            mov ax,[0x3964]
00003CE2  A3C339            mov [0x39c3],ax
00003CE5  8A166639          mov dl,[0x3966]
00003CE9  8816C539          mov [0x39c5],dl
00003CED  80FA08            cmp dl,0x8
00003CF0  7533              jnz 0x3d25
00003CF2  25F8FF            and ax,0xfff8
00003CF5  8B167905          mov dx,[0x579]
00003CF9  81E2F8FF          and dx,0xfff8
00003CFD  3BC2              cmp ax,dx
00003CFF  750C              jnz 0x3d0d
00003D01  C606673901        mov byte [0x3967],0x1
00003D06  C6066E3901        mov byte [0x396e],0x1
00003D0B  EB18              jmp short 0x3d25
00003D0D  A16439            mov ax,[0x3964]
00003D10  720A              jc 0x3d1c
00003D12  2B06C639          sub ax,[0x39c6]
00003D16  7308              jnc 0x3d20
00003D18  2BC0              sub ax,ax
00003D1A  EB04              jmp short 0x3d20
00003D1C  0306C639          add ax,[0x39c6]
00003D20  A36439            mov [0x3964],ax
00003D23  EB54              jmp short 0x3d79
00003D25  A06639            mov al,[0x3966]
00003D28  FE066E39          inc byte [0x396e]
00003D2C  8A166E39          mov dl,[0x396e]
00003D30  D0EA              shr dl,1
00003D32  D0EA              shr dl,1
00003D34  80E203            and dl,0x3
00003D37  80C202            add dl,0x2
00003D3A  803E673901        cmp byte [0x3967],0x1
00003D3F  7411              jz 0x3d52
00003D41  2AC2              sub al,dl
00003D43  7204              jc 0x3d49
00003D45  3C09              cmp al,0x9
00003D47  732D              jnc 0x3d76
00003D49  B008              mov al,0x8
00003D4B  C606673900        mov byte [0x3967],0x0
00003D50  EB24              jmp short 0x3d76
00003D52  02C2              add al,dl
00003D54  3A067B05          cmp al,[0x57b]
00003D58  7717              ja 0x3d71
00003D5A  8B1E6439          mov bx,[0x3964]
00003D5E  2B1E7905          sub bx,[0x579]
00003D62  7302              jnc 0x3d66
00003D64  F7D3              not bx
00003D66  83FB30            cmp bx,byte +0x30
00003D69  7706              ja 0x3d71
00003D6B  3CA0              cmp al,0xa0
00003D6D  7207              jc 0x3d76
00003D6F  B09F              mov al,0x9f
00003D71  C6066739FF        mov byte [0x3967],0xff
00003D76  A26639            mov [0x3966],al
00003D79  E8D600            call 0x3e52
00003D7C  730D              jnc 0x3d8b
00003D7E  A1C339            mov ax,[0x39c3]
00003D81  A36439            mov [0x3964],ax
00003D84  A0C539            mov al,[0x39c5]
00003D87  A26639            mov [0x3966],al
00003D8A  C3                ret
00003D8B  E8E000            call 0x3e6e
00003D8E  735E              jnc 0x3dee
00003D90  803E530500        cmp byte [0x553],0x0
00003D95  7401              jz 0x3d98
00003D97  C3                ret
00003D98  8B0E7905          mov cx,[0x579]
00003D9C  83E90C            sub cx,byte +0xc
00003D9F  7302              jnc 0x3da3
00003DA1  2BC9              sub cx,cx
00003DA3  81F90F01          cmp cx,0x10f
00003DA7  7203              jc 0x3dac
00003DA9  B90E01            mov cx,0x10e
00003DAC  8A167B05          mov dl,[0x57b]
00003DB0  80EA04            sub dl,0x4
00003DB3  7302              jnc 0x3db7
00003DB5  2AD2              sub dl,dl
00003DB7  E8F6EE            call 0x2cb0
00003DBA  8BF8              mov di,ax
00003DBC  B800B8            mov ax,0xb800
00003DBF  8EC0              mov es,ax
00003DC1  BEC037            mov si,0x37c0
00003DC4  BD0E00            mov bp,0xe
00003DC7  B90615            mov cx,0x1506
00003DCA  E8FFEE            call 0x2ccc
00003DCD  E82419            call 0x56f4
00003DD0  2AE4              sub ah,ah
00003DD2  CD1A              int 0x1a
00003DD4  8916C839          mov [0x39c8],dx
00003DD8  E82919            call 0x5704
00003DDB  2AE4              sub ah,ah
00003DDD  CD1A              int 0x1a
00003DDF  2B16C839          sub dx,[0x39c8]
00003DE3  83FA09            cmp dx,byte +0x9
00003DE6  72F0              jc 0x3dd8
00003DE8  C606520501        mov byte [0x552],0x1
00003DED  C3                ret
00003DEE  8B0E6439          mov cx,[0x3964]
00003DF2  8A166639          mov dl,[0x3966]
00003DF6  E8B7EE            call 0x2cb0
00003DF9  A3CA39            mov [0x39ca],ax
00003DFC  E83900            call 0x3e38
00003DFF  FE0E6D39          dec byte [0x396d]
00003E03  750B              jnz 0x3e10
00003E05  C6066D3902        mov byte [0x396d],0x2
00003E0A  81366B395400      xor word [0x396b],0x54
00003E10  E80100            call 0x3e14
00003E13  C3                ret
00003E14  B800B8            mov ax,0xb800
00003E17  8EC0              mov es,ax
00003E19  8B3ECA39          mov di,[0x39ca]
00003E1D  893E6839          mov [0x3968],di
00003E21  BD6F39            mov bp,0x396f
00003E24  C6066A3900        mov byte [0x396a],0x0
00003E29  8B366B39          mov si,[0x396b]
00003E2D  81C6BC38          add si,0x38bc
00003E31  B9030E            mov cx,0xe03
00003E34  E895EE            call 0x2ccc
00003E37  C3                ret
00003E38  B800B8            mov ax,0xb800
00003E3B  8EC0              mov es,ax
00003E3D  803E6A3900        cmp byte [0x396a],0x0
00003E42  750D              jnz 0x3e51
00003E44  8B3E6839          mov di,[0x3968]
00003E48  BE6F39            mov si,0x396f
00003E4B  B9030E            mov cx,0xe03
00003E4E  E84CEF            call 0x2d9d
00003E51  C3                ret
00003E52  A16439            mov ax,[0x3964]
00003E55  8A166639          mov dl,[0x3966]
00003E59  BE1800            mov si,0x18
00003E5C  8B1E7D32          mov bx,[0x327d]
00003E60  8A367F32          mov dh,[0x327f]
00003E64  BF1000            mov di,0x10
00003E67  B90E1E            mov cx,0x1e0e
00003E6A  E8BCEF            call 0x2e29
00003E6D  C3                ret
00003E6E  A16439            mov ax,[0x3964]
00003E71  8A166639          mov dl,[0x3966]
00003E75  BE1800            mov si,0x18
00003E78  8BFE              mov di,si
00003E7A  8B1E7905          mov bx,[0x579]
00003E7E  8A367B05          mov dh,[0x57b]
00003E82  B90E0E            mov cx,0xe0e
00003E85  E8A1EF            call 0x2e29
00003E88  C3                ret
00003E89  0000              add [bx+si],al
00003E8B  0000              add [bx+si],al
00003E8D  0000              add [bx+si],al
00003E8F  00803EE1          add [bx+si-0x1ec2],al
00003E93  3900              cmp [bx+si],ax
00003E95  740D              jz 0x3ea4
00003E97  2AE4              sub ah,ah
00003E99  CD1A              int 0x1a
00003E9B  3B16163D          cmp dx,[0x3d16]
00003E9F  7418              jz 0x3eb9
00003EA1  E99100            jmp 0x3f35
00003EA4  803E840500        cmp byte [0x584],0x0
00003EA9  750E              jnz 0x3eb9
00003EAB  803E9A0600        cmp byte [0x69a],0x0
00003EB0  7507              jnz 0x3eb9
00003EB2  803EE03900        cmp byte [0x39e0],0x0
00003EB7  7501              jnz 0x3eba
00003EB9  C3                ret
00003EBA  E8A801            call 0x4065
00003EBD  72FA              jc 0x3eb9
00003EBF  2AE4              sub ah,ah
00003EC1  CD1A              int 0x1a
00003EC3  8BC2              mov ax,dx
00003EC5  2B06183D          sub ax,[0x3d18]
00003EC9  3D0C00            cmp ax,0xc
00003ECC  72EB              jc 0x3eb9
00003ECE  8916183D          mov [0x3d18],dx
00003ED2  C6065C0500        mov byte [0x55c],0x0
00003ED7  8A1EE039          mov bl,[0x39e0]
00003EDB  FECB              dec bl
00003EDD  2AFF              sub bh,bh
00003EDF  8BF3              mov si,bx
00003EE1  B102              mov cl,0x2
00003EE3  D3E6              shl si,cl
00003EE5  8B845A3C          mov ax,[si+0x3c5a]
00003EE9  A3E239            mov [0x39e2],ax
00003EEC  2BC0              sub ax,ax
00003EEE  80FB03            cmp bl,0x3
00003EF1  7302              jnc 0x3ef5
00003EF3  B080              mov al,0x80
00003EF5  A3E439            mov [0x39e4],ax
00003EF8  8A9FE33C          mov bl,[bx+0x3ce3]
00003EFC  8BF3              mov si,bx
00003EFE  B102              mov cl,0x2
00003F00  D3E6              shl si,cl
00003F02  8B845A3C          mov ax,[si+0x3c5a]
00003F06  A3E639            mov [0x39e6],ax
00003F09  2BC0              sub ax,ax
00003F0B  80FB03            cmp bl,0x3
00003F0E  7302              jnc 0x3f12
00003F10  B080              mov al,0x80
00003F12  A3E839            mov [0x39e8],ax
00003F15  8A875010          mov al,[bx+0x1050]
00003F19  A2053D            mov [0x3d05],al
00003F1C  D0E3              shl bl,1
00003F1E  8B873711          mov ax,[bx+0x1137]
00003F22  050800            add ax,0x8
00003F25  A3033D            mov [0x3d03],ax
00003F28  E8B8D2            call 0x11e3
00003F2B  C606E1390E        mov byte [0x39e1],0xe
00003F30  C6069A0610        mov byte [0x69a],0x10
00003F35  803EBF1C00        cmp byte [0x1cbf],0x0
00003F3A  7503              jnz 0x3f3f
00003F3C  E861F4            call 0x33a0
00003F3F  802EE13902        sub byte [0x39e1],0x2
00003F44  2AFF              sub bh,bh
00003F46  8A1EE139          mov bl,[0x39e1]
00003F4A  80FB08            cmp bl,0x8
00003F4D  7209              jc 0x3f58
00003F4F  8B3EE239          mov di,[0x39e2]
00003F53  A1E439            mov ax,[0x39e4]
00003F56  EB18              jmp short 0x3f70
00003F58  8B3EE639          mov di,[0x39e6]
00003F5C  A0053D            mov al,[0x3d05]
00003F5F  A27B05            mov [0x57b],al
00003F62  0432              add al,0x32
00003F64  A27C05            mov [0x57c],al
00003F67  A1033D            mov ax,[0x3d03]
00003F6A  A37905            mov [0x579],ax
00003F6D  A1E839            mov ax,[0x39e8]
00003F70  0387063D          add ax,[bx+0x3d06]
00003F74  8BF0              mov si,ax
00003F76  B800B8            mov ax,0xb800
00003F79  8EC0              mov es,ax
00003F7B  B90210            mov cx,0x1002
00003F7E  E81CEE            call 0x2d9d
00003F81  803EBF1C00        cmp byte [0x1cbf],0x0
00003F86  7503              jnz 0x3f8b
00003F88  E8AEF3            call 0x3339
00003F8B  2AE4              sub ah,ah
00003F8D  CD1A              int 0x1a
00003F8F  8916163D          mov [0x3d16],dx
00003F93  803EE13900        cmp byte [0x39e1],0x0
00003F98  7503              jnz 0x3f9d
00003F9A  E875D1            call 0x1112
00003F9D  C3                ret
00003F9E  B800B8            mov ax,0xb800
00003FA1  8EC0              mov es,ax
00003FA3  C606E03900        mov byte [0x39e0],0x0
00003FA8  C606E13900        mov byte [0x39e1],0x0
00003FAD  C706BF3C0605      mov word [0x3cbf],0x506
00003FB3  C706C13C0000      mov word [0x3cc1],0x0
00003FB9  8B1EC13C          mov bx,[0x3cc1]
00003FBD  8A8FAE3C          mov cl,[bx+0x3cae]
00003FC1  2BDB              sub bx,bx
00003FC3  8AEB              mov ch,bl
00003FC5  BEEA3A            mov si,0x3aea
00003FC8  E832EE            call 0x2dfd
00003FCB  80FA30            cmp dl,0x30
00003FCE  770B              ja 0x3fdb
00003FD0  BEF83A            mov si,0x3af8
00003FD3  F6C204            test dl,0x4
00003FD6  7503              jnz 0x3fdb
00003FD8  BE023B            mov si,0x3b02
00003FDB  8B3EBF3C          mov di,[0x3cbf]
00003FDF  03FB              add di,bx
00003FE1  51                push cx
00003FE2  53                push bx
00003FE3  B90108            mov cx,0x801
00003FE6  E8B4ED            call 0x2d9d
00003FE9  5B                pop bx
00003FEA  59                pop cx
00003FEB  83C302            add bx,byte +0x2
00003FEE  E2D5              loop 0x3fc5
00003FF0  8106BF3C4001      add word [0x3cbf],0x140
00003FF6  FF06C13C          inc word [0x3cc1]
00003FFA  833EC13C11        cmp word [0x3cc1],byte +0x11
00003FFF  72B8              jc 0x3fb9
00004001  BB223C            mov bx,0x3c22
00004004  2BC0              sub ax,ax
00004006  E81BEB            call 0x2b24
00004009  BB3E3C            mov bx,0x3c3e
0000400C  2BC0              sub ax,ax
0000400E  E813EB            call 0x2b24
00004011  BB9A3C            mov bx,0x3c9a
00004014  2BC0              sub ax,ax
00004016  E80BEB            call 0x2b24
00004019  BB563C            mov bx,0x3c56
0000401C  2BC0              sub ax,ax
0000401E  E803EB            call 0x2b24
00004021  BEAA3C            mov si,0x3caa
00004024  BFEC08            mov di,0x8ec
00004027  B90201            mov cx,0x102
0000402A  BD0E00            mov bp,0xe
0000402D  E805ED            call 0x2d35
00004030  2BF6              sub si,si
00004032  8B1E0800          mov bx,[0x8]
00004036  B103              mov cl,0x3
00004038  22D9              and bl,cl
0000403A  D2E3              shl bl,cl
0000403C  8A87C33C          mov al,[bx+0x3cc3]
00004040  8AE0              mov ah,al
00004042  B104              mov cl,0x4
00004044  D2E8              shr al,cl
00004046  8884E33C          mov [si+0x3ce3],al
0000404A  C684F33C00        mov byte [si+0x3cf3],0x0
0000404F  80E40F            and ah,0xf
00004052  88A4E43C          mov [si+0x3ce4],ah
00004056  C684F43C00        mov byte [si+0x3cf4],0x0
0000405B  83C602            add si,byte +0x2
0000405E  43                inc bx
0000405F  83FE10            cmp si,byte +0x10
00004062  72D8              jc 0x403c
00004064  C3                ret
00004065  A17D32            mov ax,[0x327d]
00004068  8A167F32          mov dl,[0x327f]
0000406C  BE1000            mov si,0x10
0000406F  8B1E7905          mov bx,[0x579]
00004073  8A367B05          mov dh,[0x57b]
00004077  BF1800            mov di,0x18
0000407A  B91E0E            mov cx,0xe1e
0000407D  E8A9ED            call 0x2e29
00004080  C3                ret
00004081  0000              add [bx+si],al
00004083  0000              add [bx+si],al
00004085  0000              add [bx+si],al
00004087  0000              add [bx+si],al
00004089  0000              add [bx+si],al
0000408B  0000              add [bx+si],al
0000408D  0000              add [bx+si],al
0000408F  00B90400          add [bx+di+0x4],bh
00004093  8BD9              mov bx,cx
00004095  4B                dec bx
00004096  8BF3              mov si,bx
00004098  D1E6              shl si,1
0000409A  C687AE3E01        mov byte [bx+0x3eae],0x1
0000409F  C687B23E00        mov byte [bx+0x3eb2],0x0
000040A4  E8D001            call 0x4277
000040A7  E853ED            call 0x2dfd
000040AA  80E20F            and dl,0xf
000040AD  80C214            add dl,0x14
000040B0  8897B63E          mov [bx+0x3eb6],dl
000040B4  E2DD              loop 0x4093
000040B6  C706DA3E0000      mov word [0x3eda],0x0
000040BC  C606D83E04        mov byte [0x3ed8],0x4
000040C1  C3                ret
000040C2  2AE4              sub ah,ah
000040C4  CD1A              int 0x1a
000040C6  3B16DC3E          cmp dx,[0x3edc]
000040CA  7501              jnz 0x40cd
000040CC  C3                ret
000040CD  FF06DA3E          inc word [0x3eda]
000040D1  8B1EDA3E          mov bx,[0x3eda]
000040D5  83FB02            cmp bx,byte +0x2
000040D8  760B              jna 0x40e5
000040DA  83FB04            cmp bx,byte +0x4
000040DD  720A              jc 0x40e9
000040DF  2BDB              sub bx,bx
000040E1  891EDA3E          mov [0x3eda],bx
000040E5  8916DC3E          mov [0x3edc],dx
000040E9  8BF3              mov si,bx
000040EB  D1E6              shl si,1
000040ED  80BFB23E00        cmp byte [bx+0x3eb2],0x0
000040F2  75D8              jnz 0x40cc
000040F4  E8E401            call 0x42db
000040F7  7303              jnc 0x40fc
000040F9  EB29              jmp short 0x4124
000040FB  90                nop
000040FC  E8FD01            call 0x42fc
000040FF  72CB              jc 0x40cc
00004101  80BFB63E00        cmp byte [bx+0x3eb6],0x0
00004106  7510              jnz 0x4118
00004108  E86C01            call 0x4277
0000410B  E8EFEC            call 0x2dfd
0000410E  80E207            and dl,0x7
00004111  80C214            add dl,0x14
00004114  8897B63E          mov [bx+0x3eb6],dl
00004118  FE8FB63E          dec byte [bx+0x3eb6]
0000411C  E8BC01            call 0x42db
0000411F  7203              jc 0x4124
00004121  EB5E              jmp short 0x4181
00004123  90                nop
00004124  80BFAE3E00        cmp byte [bx+0x3eae],0x0
00004129  7507              jnz 0x4132
0000412B  80BFB63E14        cmp byte [bx+0x3eb6],0x14
00004130  7201              jc 0x4133
00004132  C3                ret
00004133  E8ADD0            call 0x11e3
00004136  E81B01            call 0x4254
00004139  8B1EDA3E          mov bx,[0x3eda]
0000413D  C687B23E01        mov byte [bx+0x3eb2],0x1
00004142  E8DFCF            call 0x1124
00004145  C6065C0500        mov byte [0x55c],0x0
0000414A  FE0ED83E          dec byte [0x3ed8]
0000414E  7505              jnz 0x4155
00004150  C606530501        mov byte [0x553],0x1
00004155  B004              mov al,0x4
00004157  2A06D83E          sub al,[0x3ed8]
0000415B  B102              mov cl,0x2
0000415D  D2E0              shl al,cl
0000415F  2AE4              sub ah,ah
00004161  055100            add ax,0x51
00004164  8BF8              mov di,ax
00004166  BD0E00            mov bp,0xe
00004169  BE203D            mov si,0x3d20
0000416C  B800B8            mov ax,0xb800
0000416F  8EC0              mov es,ax
00004171  B9020C            mov cx,0xc02
00004174  E8BEEB            call 0x2d35
00004177  B8E803            mov ax,0x3e8
0000417A  BBEE02            mov bx,0x2ee
0000417D  E8BB17            call 0x593b
00004180  C3                ret
00004181  E83001            call 0x42b4
00004184  8B3E0800          mov di,[0x8]
00004188  D1E7              shl di,1
0000418A  8BADDE3E          mov bp,[di+0x3ede]
0000418E  E88B01            call 0x431c
00004191  731D              jnc 0x41b0
00004193  80BFB63E02        cmp byte [bx+0x3eb6],0x2
00004198  7216              jc 0x41b0
0000419A  B001              mov al,0x1
0000419C  80BFB63E11        cmp byte [bx+0x3eb6],0x11
000041A1  7609              jna 0x41ac
000041A3  80BFB63E14        cmp byte [bx+0x3eb6],0x14
000041A8  7306              jnc 0x41b0
000041AA  FEC8              dec al
000041AC  8887B63E          mov [bx+0x3eb6],al
000041B0  8A87B63E          mov al,[bx+0x3eb6]
000041B4  3C01              cmp al,0x1
000041B6  7620              jna 0x41d8
000041B8  3C12              cmp al,0x12
000041BA  723C              jc 0x41f8
000041BC  B001              mov al,0x1
000041BE  83BCBA3E03        cmp word [si+0x3eba],byte +0x3
000041C3  7302              jnc 0x41c7
000041C5  B003              mov al,0x3
000041C7  0087D43E          add [bx+0x3ed4],al
000041CB  80BFB63E13        cmp byte [bx+0x3eb6],0x13
000041D0  7221              jc 0x41f3
000041D2  741A              jz 0x41ee
000041D4  2BC0              sub ax,ax
000041D6  EB2C              jmp short 0x4204
000041D8  B001              mov al,0x1
000041DA  83BCBA3E03        cmp word [si+0x3eba],byte +0x3
000041DF  7302              jnc 0x41e3
000041E1  B003              mov al,0x3
000041E3  0087D43E          add [bx+0x3ed4],al
000041E7  80BFB63E01        cmp byte [bx+0x3eb6],0x1
000041EC  7305              jnc 0x41f3
000041EE  B8B03D            mov ax,0x3db0
000041F1  EB11              jmp short 0x4204
000041F3  B8803D            mov ax,0x3d80
000041F6  EB0C              jmp short 0x4204
000041F8  D0E0              shl al,1
000041FA  8BF8              mov di,ax
000041FC  81E70200          and di,0x2
00004200  8B85E03D          mov ax,[di+0x3de0]
00004204  A3CA3E            mov [0x3eca],ax
00004207  8A97D43E          mov dl,[bx+0x3ed4]
0000420B  8B8CCC3E          mov cx,[si+0x3ecc]
0000420F  E89EEA            call 0x2cb0
00004212  A3E43D            mov [0x3de4],ax
00004215  E83C00            call 0x4254
00004218  8B1EDA3E          mov bx,[0x3eda]
0000421C  8BF3              mov si,bx
0000421E  D1E6              shl si,1
00004220  E8D900            call 0x42fc
00004223  7301              jnc 0x4226
00004225  C3                ret
00004226  833ECA3E00        cmp word [0x3eca],byte +0x0
0000422B  7506              jnz 0x4233
0000422D  C687AE3E01        mov byte [bx+0x3eae],0x1
00004232  C3                ret
00004233  C687AE3E00        mov byte [bx+0x3eae],0x0
00004238  8B3EE43D          mov di,[0x3de4]
0000423C  89BCA63E          mov [si+0x3ea6],di
00004240  B800B8            mov ax,0xb800
00004243  8EC0              mov es,ax
00004245  8BACC23E          mov bp,[si+0x3ec2]
00004249  B9020C            mov cx,0xc02
0000424C  8B36CA3E          mov si,[0x3eca]
00004250  E8E2EA            call 0x2d35
00004253  C3                ret
00004254  8B1EDA3E          mov bx,[0x3eda]
00004258  8BF3              mov si,bx
0000425A  D1E6              shl si,1
0000425C  80BFAE3E00        cmp byte [bx+0x3eae],0x0
00004261  7513              jnz 0x4276
00004263  8BBCA63E          mov di,[si+0x3ea6]
00004267  B9020C            mov cx,0xc02
0000426A  8BB4C23E          mov si,[si+0x3ec2]
0000426E  B800B8            mov ax,0xb800
00004271  8EC0              mov es,ax
00004273  E827EB            call 0x2d9d
00004276  C3                ret
00004277  C606D93E20        mov byte [0x3ed9],0x20
0000427C  E87EEB            call 0x2dfd
0000427F  81E20F00          and dx,0xf
00004283  2BFF              sub di,di
00004285  3BFE              cmp di,si
00004287  7406              jz 0x428f
00004289  3B95BA3E          cmp dx,[di+0x3eba]
0000428D  74ED              jz 0x427c
0000428F  83C702            add di,byte +0x2
00004292  83FF08            cmp di,byte +0x8
00004295  72EE              jc 0x4285
00004297  8994BA3E          mov [si+0x3eba],dx
0000429B  E81600            call 0x42b4
0000429E  803ED93E00        cmp byte [0x3ed9],0x0
000042A3  740E              jz 0x42b3
000042A5  BD3200            mov bp,0x32
000042A8  E87100            call 0x431c
000042AB  7306              jnc 0x42b3
000042AD  FE0ED93E          dec byte [0x3ed9]
000042B1  EBC9              jmp short 0x427c
000042B3  C3                ret
000042B4  8BBCBA3E          mov di,[si+0x3eba]
000042B8  8A855010          mov al,[di+0x1050]
000042BC  B20A              mov dl,0xa
000042BE  83FF03            cmp di,byte +0x3
000042C1  7302              jnc 0x42c5
000042C3  2AD2              sub dl,dl
000042C5  2AC2              sub al,dl
000042C7  0403              add al,0x3
000042C9  8887D43E          mov [bx+0x3ed4],al
000042CD  D1E7              shl di,1
000042CF  8B853711          mov ax,[di+0x1137]
000042D3  050800            add ax,0x8
000042D6  8984CC3E          mov [si+0x3ecc],ax
000042DA  C3                ret
000042DB  56                push si
000042DC  53                push bx
000042DD  8B84CC3E          mov ax,[si+0x3ecc]
000042E1  8A97D43E          mov dl,[bx+0x3ed4]
000042E5  BE1000            mov si,0x10
000042E8  8B1E7905          mov bx,[0x579]
000042EC  8A367B05          mov dh,[0x57b]
000042F0  BF1800            mov di,0x18
000042F3  B90C0E            mov cx,0xe0c
000042F6  E830EB            call 0x2e29
000042F9  5B                pop bx
000042FA  5E                pop si
000042FB  C3                ret
000042FC  56                push si
000042FD  53                push bx
000042FE  8B84CC3E          mov ax,[si+0x3ecc]
00004302  8A97D43E          mov dl,[bx+0x3ed4]
00004306  BE1000            mov si,0x10
00004309  8B1E7D32          mov bx,[0x327d]
0000430D  8A367F32          mov dh,[0x327f]
00004311  8BFE              mov di,si
00004313  B90C1E            mov cx,0x1e0c
00004316  E810EB            call 0x2e29
00004319  5B                pop bx
0000431A  5E                pop si
0000431B  C3                ret
0000431C  8B84CC3E          mov ax,[si+0x3ecc]
00004320  2B067905          sub ax,[0x579]
00004324  7302              jnc 0x4328
00004326  F7D0              not ax
00004328  8A97D43E          mov dl,[bx+0x3ed4]
0000432C  2A167B05          sub dl,[0x57b]
00004330  7302              jnc 0x4334
00004332  F6D2              not dl
00004334  2AF6              sub dh,dh
00004336  03C2              add ax,dx
00004338  3BC5              cmp ax,bp
0000433A  7202              jc 0x433e
0000433C  F8                clc
0000433D  C3                ret
0000433E  F9                stc
0000433F  C3                ret
00004340  2AE4              sub ah,ah
00004342  CD1A              int 0x1a
00004344  3B16B540          cmp dx,[0x40b5]
00004348  7501              jnz 0x434b
0000434A  C3                ret
0000434B  FE06FF40          inc byte [0x40ff]
0000434F  F606FF4003        test byte [0x40ff],0x3
00004354  7404              jz 0x435a
00004356  8916B540          mov [0x40b5],dx
0000435A  803EAA40A4        cmp byte [0x40aa],0xa4
0000435F  72E9              jc 0x434a
00004361  E8C901            call 0x452d
00004364  E8F001            call 0x4557
00004367  72E1              jc 0x434a
00004369  E891EA            call 0x2dfd
0000436C  80FA30            cmp dl,0x30
0000436F  772B              ja 0x439c
00004371  E88701            call 0x44fb
00004374  8B360800          mov si,[0x8]
00004378  D1E6              shl si,1
0000437A  8B84CE40          mov ax,[si+0x40ce]
0000437E  3906CC40          cmp [0x40cc],ax
00004382  7718              ja 0x439c
00004384  E8D615            call 0x595d
00004387  C706C840FF00      mov word [0x40c8],0xff
0000438D  A0CA40            mov al,[0x40ca]
00004390  A2B740            mov [0x40b7],al
00004393  A0CB40            mov al,[0x40cb]
00004396  A2B840            mov [0x40b8],al
00004399  E99200            jmp 0x442e
0000439C  833EC8400A        cmp word [0x40c8],byte +0xa
000043A1  770E              ja 0x43b1
000043A3  E857EA            call 0x2dfd
000043A6  80FA06            cmp dl,0x6
000043A9  7709              ja 0x43b4
000043AB  C706C840FF00      mov word [0x40c8],0xff
000043B1  EB4F              jmp short 0x4402
000043B3  90                nop
000043B4  8B1EC840          mov bx,[0x40c8]
000043B8  8BF3              mov si,bx
000043BA  D1E6              shl si,1
000043BC  2AD2              sub dl,dl
000043BE  A1B240            mov ax,[0x40b2]
000043C1  25FC0F            and ax,0xffc
000043C4  3B84DE40          cmp ax,[si+0x40de]
000043C8  7406              jz 0x43d0
000043CA  FEC2              inc dl
000043CC  7202              jc 0x43d0
000043CE  B2FF              mov dl,0xff
000043D0  8816B740          mov [0x40b7],dl
000043D4  2AD2              sub dl,dl
000043D6  A0B440            mov al,[0x40b4]
000043D9  24FE              and al,0xfe
000043DB  3A87F440          cmp al,[bx+0x40f4]
000043DF  7406              jz 0x43e7
000043E1  FEC2              inc dl
000043E3  7202              jc 0x43e7
000043E5  B2FF              mov dl,0xff
000043E7  8816B840          mov [0x40b8],dl
000043EB  0A16B740          or dl,[0x40b7]
000043EF  753D              jnz 0x442e
000043F1  E809EA            call 0x2dfd
000043F4  80FA10            cmp dl,0x10
000043F7  7735              ja 0x442e
000043F9  C706C840FF00      mov word [0x40c8],0xff
000043FF  E85B15            call 0x595d
00004402  E8F8E9            call 0x2dfd
00004405  80FA30            cmp dl,0x30
00004408  7719              ja 0x4423
0000440A  80E201            and dl,0x1
0000440D  7502              jnz 0x4411
0000440F  B2FF              mov dl,0xff
00004411  8816B740          mov [0x40b7],dl
00004415  E8E5E9            call 0x2dfd
00004418  80E201            and dl,0x1
0000441B  7502              jnz 0x441f
0000441D  B2FF              mov dl,0xff
0000441F  8816B840          mov [0x40b8],dl
00004423  E8D7E9            call 0x2dfd
00004426  81E2FF00          and dx,0xff
0000442A  8916C840          mov [0x40c8],dx
0000442E  A0B440            mov al,[0x40b4]
00004431  803EB84001        cmp byte [0x40b8],0x1
00004436  7221              jc 0x4459
00004438  750F              jnz 0x4449
0000443A  0402              add al,0x2
0000443C  3CA8              cmp al,0xa8
0000443E  7216              jc 0x4456
00004440  B0A7              mov al,0xa7
00004442  C606B840FF        mov byte [0x40b8],0xff
00004447  EB0D              jmp short 0x4456
00004449  2C02              sub al,0x2
0000444B  3C30              cmp al,0x30
0000444D  7307              jnc 0x4456
0000444F  B030              mov al,0x30
00004451  C606B84001        mov byte [0x40b8],0x1
00004456  A2B440            mov [0x40b4],al
00004459  A1B240            mov ax,[0x40b2]
0000445C  803EB74001        cmp byte [0x40b7],0x1
00004461  7223              jc 0x4486
00004463  7512              jnz 0x4477
00004465  050400            add ax,0x4
00004468  3D3601            cmp ax,0x136
0000446B  7216              jc 0x4483
0000446D  B83501            mov ax,0x135
00004470  C606B740FF        mov byte [0x40b7],0xff
00004475  EB0C              jmp short 0x4483
00004477  2D0400            sub ax,0x4
0000447A  7307              jnc 0x4483
0000447C  2BC0              sub ax,ax
0000447E  C606B74001        mov byte [0x40b7],0x1
00004483  A3B240            mov [0x40b2],ax
00004486  E8A400            call 0x452d
00004489  8B0EB240          mov cx,[0x40b2]
0000448D  8A16B440          mov dl,[0x40b4]
00004491  E81CE8            call 0x2cb0
00004494  A3BC40            mov [0x40bc],ax
00004497  B800B8            mov ax,0xb800
0000449A  8EC0              mov es,ax
0000449C  803EB94000        cmp byte [0x40b9],0x0
000044A1  750D              jnz 0x44b0
000044A3  BE2C3F            mov si,0x3f2c
000044A6  8B3EBA40          mov di,[0x40ba]
000044AA  B90105            mov cx,0x501
000044AD  E8EDE8            call 0x2d9d
000044B0  E8A400            call 0x4557
000044B3  7231              jc 0x44e6
000044B5  C606B94000        mov byte [0x40b9],0x0
000044BA  8306BE4002        add word [0x40be],byte +0x2
000044BF  8B1EBE40          mov bx,[0x40be]
000044C3  81E30600          and bx,0x6
000044C7  8BB7C040          mov si,[bx+0x40c0]
000044CB  803EB740FF        cmp byte [0x40b7],0xff
000044D0  7503              jnz 0x44d5
000044D2  83C61E            add si,byte +0x1e
000044D5  8B3EBC40          mov di,[0x40bc]
000044D9  893EBA40          mov [0x40ba],di
000044DD  BD2C3F            mov bp,0x3f2c
000044E0  B90105            mov cx,0x501
000044E3  E8E6E7            call 0x2ccc
000044E6  C3                ret
000044E7  803E710500        cmp byte [0x571],0x0
000044EC  750B              jnz 0x44f9
000044EE  A07B05            mov al,[0x57b]
000044F1  24F8              and al,0xf8
000044F3  3C88              cmp al,0x88
000044F5  7502              jnz 0x44f9
000044F7  F9                stc
000044F8  C3                ret
000044F9  F8                clc
000044FA  C3                ret
000044FB  A1B240            mov ax,[0x40b2]
000044FE  B201              mov dl,0x1
00004500  2B067905          sub ax,[0x579]
00004504  7304              jnc 0x450a
00004506  F7D0              not ax
00004508  B2FF              mov dl,0xff
0000450A  8816CA40          mov [0x40ca],dl
0000450E  A3CC40            mov [0x40cc],ax
00004511  A0B440            mov al,[0x40b4]
00004514  B201              mov dl,0x1
00004516  2A067B05          sub al,[0x57b]
0000451A  7304              jnc 0x4520
0000451C  F6D0              not al
0000451E  B2FF              mov dl,0xff
00004520  8816CB40          mov [0x40cb],dl
00004524  2AE4              sub ah,ah
00004526  D1E0              shl ax,1
00004528  0106CC40          add [0x40cc],ax
0000452C  C3                ret
0000452D  A1B240            mov ax,[0x40b2]
00004530  8A16B440          mov dl,[0x40b4]
00004534  BE0800            mov si,0x8
00004537  8B1E7905          mov bx,[0x579]
0000453B  8A367B05          mov dh,[0x57b]
0000453F  BF1800            mov di,0x18
00004542  B9050E            mov cx,0xe05
00004545  E8E1E8            call 0x2e29
00004548  730C              jnc 0x4556
0000454A  803E520500        cmp byte [0x552],0x0
0000454F  7505              jnz 0x4556
00004551  C606530501        mov byte [0x553],0x1
00004556  C3                ret
00004557  A1B240            mov ax,[0x40b2]
0000455A  8A16B440          mov dl,[0x40b4]
0000455E  BE0800            mov si,0x8
00004561  8B1E7D32          mov bx,[0x327d]
00004565  8A367F32          mov dh,[0x327f]
00004569  BF1000            mov di,0x10
0000456C  B9051E            mov cx,0x1e05
0000456F  E8B7E8            call 0x2e29
00004572  7305              jnc 0x4579
00004574  C606B840FF        mov byte [0x40b8],0xff
00004579  C3                ret
0000457A  B99000            mov cx,0x90
0000457D  B286              mov dl,0x86
0000457F  890EA840          mov [0x40a8],cx
00004583  8816AA40          mov [0x40aa],dl
00004587  E826E7            call 0x2cb0
0000458A  A3AB40            mov [0x40ab],ax
0000458D  E8C901            call 0x4759
00004590  C606AF4000        mov byte [0x40af],0x0
00004595  C606B14000        mov byte [0x40b1],0x0
0000459A  C606B94001        mov byte [0x40b9],0x1
0000459F  C606B84000        mov byte [0x40b8],0x0
000045A4  C706C840FF00      mov word [0x40c8],0xff
000045AA  C3                ret
000045AB  2AE4              sub ah,ah
000045AD  CD1A              int 0x1a
000045AF  3B16AD40          cmp dx,[0x40ad]
000045B3  7501              jnz 0x45b6
000045B5  C3                ret
000045B6  8916AD40          mov [0x40ad],dx
000045BA  803EAA40A4        cmp byte [0x40aa],0xa4
000045BF  73F4              jnc 0x45b5
000045C1  E8C201            call 0x4786
000045C4  7310              jnc 0x45d6
000045C6  E81EFF            call 0x44e7
000045C9  73EA              jnc 0x45b5
000045CB  C606710501        mov byte [0x571],0x1
000045D0  C6065B0510        mov byte [0x55b],0x10
000045D5  C3                ret
000045D6  E86501            call 0x473e
000045D9  736E              jnc 0x4649
000045DB  803EAF4000        cmp byte [0x40af],0x0
000045E0  7518              jnz 0x45fa
000045E2  A06E05            mov al,[0x56e]
000045E5  3C00              cmp al,0x0
000045E7  750E              jnz 0x45f7
000045E9  FEC0              inc al
000045EB  8B1EA840          mov bx,[0x40a8]
000045EF  3B1E7905          cmp bx,[0x579]
000045F3  7702              ja 0x45f7
000045F5  B0FF              mov al,0xff
000045F7  A2B040            mov [0x40b0],al
000045FA  C606AF4001        mov byte [0x40af],0x1
000045FF  B92000            mov cx,0x20
00004602  A17905            mov ax,[0x579]
00004605  B201              mov dl,0x1
00004607  803EB04001        cmp byte [0x40b0],0x1
0000460C  7507              jnz 0x4615
0000460E  2D0800            sub ax,0x8
00004611  B2FF              mov dl,0xff
00004613  EB03              jmp short 0x4618
00004615  050800            add ax,0x8
00004618  A37905            mov [0x579],ax
0000461B  88166E05          mov [0x56e],dl
0000461F  A07B05            mov al,[0x57b]
00004622  803E710501        cmp byte [0x571],0x1
00004627  7210              jc 0x4639
00004629  7504              jnz 0x462f
0000462B  2C03              sub al,0x3
0000462D  EB02              jmp short 0x4631
0000462F  0403              add al,0x3
00004631  A27B05            mov [0x57b],al
00004634  0432              add al,0x32
00004636  A27C05            mov [0x57c],al
00004639  51                push cx
0000463A  E80101            call 0x473e
0000463D  59                pop cx
0000463E  7302              jnc 0x4642
00004640  E2C0              loop 0x4602
00004642  E89ECB            call 0x11e3
00004645  E8CACA            call 0x1112
00004648  C3                ret
00004649  803EB14000        cmp byte [0x40b1],0x0
0000464E  7552              jnz 0x46a2
00004650  803EAF4000        cmp byte [0x40af],0x0
00004655  74F1              jz 0x4648
00004657  A1A840            mov ax,[0x40a8]
0000465A  803EB04001        cmp byte [0x40b0],0x1
0000465F  7505              jnz 0x4666
00004661  050800            add ax,0x8
00004664  EB03              jmp short 0x4669
00004666  2D0800            sub ax,0x8
00004669  A3A840            mov [0x40a8],ax
0000466C  E8CF00            call 0x473e
0000466F  7301              jnc 0x4672
00004671  C3                ret
00004672  B8000C            mov ax,0xc00
00004675  BB540B            mov bx,0xb54
00004678  E8C012            call 0x593b
0000467B  C606AF4000        mov byte [0x40af],0x0
00004680  8B0EA840          mov cx,[0x40a8]
00004684  8A16AA40          mov dl,[0x40aa]
00004688  E825E6            call 0x2cb0
0000468B  A3AB40            mov [0x40ab],ax
0000468E  E8E200            call 0x4773
00004691  E8C500            call 0x4759
00004694  A1A840            mov ax,[0x40a8]
00004697  3D7800            cmp ax,0x78
0000469A  7206              jc 0x46a2
0000469C  3DA800            cmp ax,0xa8
0000469F  7701              ja 0x46a2
000046A1  C3                ret
000046A2  C606B14001        mov byte [0x40b1],0x1
000046A7  803EBF1C00        cmp byte [0x1cbf],0x0
000046AC  7410              jz 0x46be
000046AE  E836FE            call 0x44e7
000046B1  730A              jnc 0x46bd
000046B3  C606710501        mov byte [0x571],0x1
000046B8  C6065B0510        mov byte [0x55b],0x10
000046BD  C3                ret
000046BE  2AE4              sub ah,ah
000046C0  CD1A              int 0x1a
000046C2  3B16AD40          cmp dx,[0x40ad]
000046C6  74DA              jz 0x46a2
000046C8  8916AD40          mov [0x40ad],dx
000046CC  803E000000        cmp byte [0x0],0x0
000046D1  7419              jz 0x46ec
000046D3  B0B6              mov al,0xb6
000046D5  E643              out 0x43,al
000046D7  A0AA40            mov al,[0x40aa]
000046DA  2AE4              sub ah,ah
000046DC  D1E0              shl ax,1
000046DE  D1E0              shl ax,1
000046E0  E642              out 0x42,al
000046E2  8AC4              mov al,ah
000046E4  E642              out 0x42,al
000046E6  E461              in al,0x61
000046E8  0C03              or al,0x3
000046EA  E661              out 0x61,al
000046EC  8A16AA40          mov dl,[0x40aa]
000046F0  80FAA4            cmp dl,0xa4
000046F3  7319              jnc 0x470e
000046F5  80C205            add dl,0x5
000046F8  8816AA40          mov [0x40aa],dl
000046FC  8B0EA840          mov cx,[0x40a8]
00004700  E8ADE5            call 0x2cb0
00004703  A3AB40            mov [0x40ab],ax
00004706  E86A00            call 0x4773
00004709  E84D00            call 0x4759
0000470C  EBB0              jmp short 0x46be
0000470E  E81014            call 0x5b21
00004711  E85F00            call 0x4773
00004714  BD1E40            mov bp,0x401e
00004717  FF0EA640          dec word [0x40a6]
0000471B  8B3EA640          mov di,[0x40a6]
0000471F  BE363F            mov si,0x3f36
00004722  B90411            mov cx,0x1104
00004725  E80DE6            call 0x2d35
00004728  A1A840            mov ax,[0x40a8]
0000472B  A3B240            mov [0x40b2],ax
0000472E  A0AA40            mov al,[0x40aa]
00004731  A2B440            mov [0x40b4],al
00004734  E8C4FD            call 0x44fb
00004737  A0CA40            mov al,[0x40ca]
0000473A  A2B740            mov [0x40b7],al
0000473D  C3                ret
0000473E  A1A840            mov ax,[0x40a8]
00004741  8A16AA40          mov dl,[0x40aa]
00004745  BE1800            mov si,0x18
00004748  8B1E7905          mov bx,[0x579]
0000474C  8A367B05          mov dh,[0x57b]
00004750  8BFE              mov di,si
00004752  B9100E            mov cx,0xe10
00004755  E8D1E6            call 0x2e29
00004758  C3                ret
00004759  B800B8            mov ax,0xb800
0000475C  8EC0              mov es,ax
0000475E  BD1E40            mov bp,0x401e
00004761  BEBE3F            mov si,0x3fbe
00004764  8B3EAB40          mov di,[0x40ab]
00004768  893EA640          mov [0x40a6],di
0000476C  B90310            mov cx,0x1003
0000476F  E8C3E5            call 0x2d35
00004772  C3                ret
00004773  B800B8            mov ax,0xb800
00004776  8EC0              mov es,ax
00004778  BE1E40            mov si,0x401e
0000477B  8B3EA640          mov di,[0x40a6]
0000477F  B90310            mov cx,0x1003
00004782  E818E6            call 0x2d9d
00004785  C3                ret
00004786  803E7F3266        cmp byte [0x327f],0x66
0000478B  7217              jc 0x47a4
0000478D  A1A840            mov ax,[0x40a8]
00004790  2D1400            sub ax,0x14
00004793  3B067D32          cmp ax,[0x327d]
00004797  770B              ja 0x47a4
00004799  053000            add ax,0x30
0000479C  3B067D32          cmp ax,[0x327d]
000047A0  7202              jc 0x47a4
000047A2  F9                stc
000047A3  C3                ret
000047A4  F8                clc
000047A5  C3                ret
000047A6  0000              add [bx+si],al
000047A8  0000              add [bx+si],al
000047AA  0000              add [bx+si],al
000047AC  0000              add [bx+si],al
000047AE  0000              add [bx+si],al
000047B0  A17D32            mov ax,[0x327d]
000047B3  8A167F32          mov dl,[0x327f]
000047B7  BE1000            mov si,0x10
000047BA  8B1E7905          mov bx,[0x579]
000047BE  83EB08            sub bx,byte +0x8
000047C1  7302              jnc 0x47c5
000047C3  2BDB              sub bx,bx
000047C5  8A367B05          mov dh,[0x57b]
000047C9  80C603            add dh,0x3
000047CC  BF2800            mov di,0x28
000047CF  B91E0E            mov cx,0xe1e
000047D2  E854E6            call 0x2e29
000047D5  C3                ret
000047D6  2AE4              sub ah,ah
000047D8  CD1A              int 0x1a
000047DA  8BC2              mov ax,dx
000047DC  2B06D744          sub ax,[0x44d7]
000047E0  8B360800          mov si,[0x8]
000047E4  D1E6              shl si,1
000047E6  3B84DC44          cmp ax,[si+0x44dc]
000047EA  7701              ja 0x47ed
000047EC  C3                ret
000047ED  8916D744          mov [0x44d7],dx
000047F1  803EB81C00        cmp byte [0x1cb8],0x0
000047F6  75F4              jnz 0x47ec
000047F8  C606FC4400        mov byte [0x44fc],0x0
000047FD  B90C00            mov cx,0xc
00004800  8BD9              mov bx,cx
00004802  4B                dec bx
00004803  D0E3              shl bl,1
00004805  83BF414400        cmp word [bx+0x4441],byte +0x0
0000480A  7471              jz 0x487d
0000480C  8B87F943          mov ax,[bx+0x43f9]
00004810  3A067B05          cmp al,[0x57b]
00004814  7547              jnz 0x485d
00004816  8B87E143          mov ax,[bx+0x43e1]
0000481A  2B067905          sub ax,[0x579]
0000481E  7302              jnc 0x4822
00004820  F7D0              not ax
00004822  8B360800          mov si,[0x8]
00004826  D1E6              shl si,1
00004828  3B84EC44          cmp ax,[si+0x44ec]
0000482C  772F              ja 0x485d
0000482E  83BF594402        cmp word [bx+0x4459],byte +0x2
00004833  7217              jc 0x484c
00004835  8B871144          mov ax,[bx+0x4411]
00004839  A3DA44            mov [0x44da],ax
0000483C  E84E00            call 0x488d
0000483F  E85F00            call 0x48a1
00004842  E8F4EA            call 0x3339
00004845  E8FDC8            call 0x1145
00004848  E8EBD8            call 0x2136
0000484B  C3                ret
0000484C  FF875944          inc word [bx+0x4459]
00004850  83BF594402        cmp word [bx+0x4459],byte +0x2
00004855  7219              jc 0x4870
00004857  FE06FC44          inc byte [0x44fc]
0000485B  EB13              jmp short 0x4870
0000485D  83BF594400        cmp word [bx+0x4459],byte +0x0
00004862  7419              jz 0x487d
00004864  E896E5            call 0x2dfd
00004867  80FA38            cmp dl,0x38
0000486A  7704              ja 0x4870
0000486C  FF8F5944          dec word [bx+0x4459]
00004870  51                push cx
00004871  53                push bx
00004872  E86200            call 0x48d7
00004875  5B                pop bx
00004876  E89D00            call 0x4916
00004879  E84500            call 0x48c1
0000487C  59                pop cx
0000487D  E20B              loop 0x488a
0000487F  803EFC4400        cmp byte [0x44fc],0x0
00004884  7403              jz 0x4889
00004886  E8080E            call 0x5691
00004889  C3                ret
0000488A  E973FF            jmp 0x4800
0000488D  803EBD4400        cmp byte [0x44bd],0x0
00004892  7409              jz 0x489d
00004894  E86C02            call 0x4b03
00004897  C606BD4400        mov byte [0x44bd],0x0
0000489C  C3                ret
0000489D  E843C9            call 0x11e3
000048A0  C3                ret
000048A1  1E                push ds
000048A2  07                pop es
000048A3  FC                cld
000048A4  BF0E00            mov di,0xe
000048A7  8BF7              mov si,di
000048A9  B8AAAA            mov ax,0xaaaa
000048AC  B94100            mov cx,0x41
000048AF  F3AB              rep stosw
000048B1  B800B8            mov ax,0xb800
000048B4  8EC0              mov es,ax
000048B6  8B3EDA44          mov di,[0x44da]
000048BA  B9050D            mov cx,0xd05
000048BD  E8DDE4            call 0x2d9d
000048C0  C3                ret
000048C1  803ED94400        cmp byte [0x44d9],0x0
000048C6  740A              jz 0x48d2
000048C8  803EBD4400        cmp byte [0x44bd],0x0
000048CD  7404              jz 0x48d3
000048CF  E84B02            call 0x4b1d
000048D2  C3                ret
000048D3  E86FC8            call 0x1145
000048D6  C3                ret
000048D7  C606D94400        mov byte [0x44d9],0x0
000048DC  8B87E143          mov ax,[bx+0x43e1]
000048E0  8B97F943          mov dx,[bx+0x43f9]
000048E4  2D1400            sub ax,0x14
000048E7  BE2800            mov si,0x28
000048EA  8B1E7905          mov bx,[0x579]
000048EE  8A367B05          mov dh,[0x57b]
000048F2  B9060E            mov cx,0xe06
000048F5  BF1800            mov di,0x18
000048F8  E82EE5            call 0x2e29
000048FB  7318              jnc 0x4915
000048FD  C606D94401        mov byte [0x44d9],0x1
00004902  E8D3CA            call 0x13d8
00004905  74FB              jz 0x4902
00004907  803EBD4400        cmp byte [0x44bd],0x0
0000490C  7404              jz 0x4912
0000490E  E8F201            call 0x4b03
00004911  C3                ret
00004912  E8CEC8            call 0x11e3
00004915  C3                ret
00004916  8B871144          mov ax,[bx+0x4411]
0000491A  8BB75944          mov si,[bx+0x4459]
0000491E  D1E6              shl si,1
00004920  81C60041          add si,0x4100
00004924  05A700            add ax,0xa7
00004927  81BF29449C42      cmp word [bx+0x4429],0x429c
0000492D  7406              jz 0x4935
0000492F  2D0600            sub ax,0x6
00004932  83C606            add si,byte +0x6
00004935  8BF8              mov di,ax
00004937  B800B8            mov ax,0xb800
0000493A  8EC0              mov es,ax
0000493C  B90101            mov cx,0x101
0000493F  E85BE4            call 0x2d9d
00004942  C3                ret
00004943  803EB81C00        cmp byte [0x1cb8],0x0
00004948  751C              jnz 0x4966
0000494A  803EBE4400        cmp byte [0x44be],0x0
0000494F  740B              jz 0x495c
00004951  A0BE44            mov al,[0x44be]
00004954  A29806            mov [0x698],al
00004957  C606990600        mov byte [0x699],0x0
0000495C  2AE4              sub ah,ah
0000495E  CD1A              int 0x1a
00004960  3B16D344          cmp dx,[0x44d3]
00004964  7501              jnz 0x4967
00004966  C3                ret
00004967  8916D344          mov [0x44d3],dx
0000496B  803E840500        cmp byte [0x584],0x0
00004970  7423              jz 0x4995
00004972  803EBD4400        cmp byte [0x44bd],0x0
00004977  741B              jz 0x4994
00004979  E88701            call 0x4b03
0000497C  E821EA            call 0x33a0
0000497F  E8A2C7            call 0x1124
00004982  E8B4E9            call 0x3339
00004985  C606BD4400        mov byte [0x44bd],0x0
0000498A  C606E04301        mov byte [0x43e0],0x1
0000498F  C606BE4400        mov byte [0x44be],0x0
00004994  C3                ret
00004995  803E9A0600        cmp byte [0x69a],0x0
0000499A  7403              jz 0x499f
0000499C  EB5B              jmp short 0x49f9
0000499E  90                nop
0000499F  B8FFFF            mov ax,0xffff
000049A2  A3C144            mov [0x44c1],ax
000049A5  A3BF44            mov [0x44bf],ax
000049A8  B90C00            mov cx,0xc
000049AB  8B367905          mov si,[0x579]
000049AF  8A167B05          mov dl,[0x57b]
000049B3  80C208            add dl,0x8
000049B6  8BD9              mov bx,cx
000049B8  4B                dec bx
000049B9  80BFC44401        cmp byte [bx+0x44c4],0x1
000049BE  7230              jc 0x49f0
000049C0  3A979944          cmp dl,[bx+0x4499]
000049C4  752A              jnz 0x49f0
000049C6  8BC6              mov ax,si
000049C8  D0E3              shl bl,1
000049CA  B6FF              mov dh,0xff
000049CC  2B878144          sub ax,[bx+0x4481]
000049D0  7304              jnc 0x49d6
000049D2  F7D0              not ax
000049D4  B601              mov dh,0x1
000049D6  3B06BF44          cmp ax,[0x44bf]
000049DA  7714              ja 0x49f0
000049DC  A3BF44            mov [0x44bf],ax
000049DF  8B87A544          mov ax,[bx+0x44a5]
000049E3  A3D144            mov [0x44d1],ax
000049E6  D0EB              shr bl,1
000049E8  891EC144          mov [0x44c1],bx
000049EC  8836C344          mov [0x44c3],dh
000049F0  E2C4              loop 0x49b6
000049F2  833EC1440C        cmp word [0x44c1],byte +0xc
000049F7  7227              jc 0x4a20
000049F9  803EBD4400        cmp byte [0x44bd],0x0
000049FE  740B              jz 0x4a0b
00004A00  E80001            call 0x4b03
00004A03  E83FC7            call 0x1145
00004A06  C6069A0610        mov byte [0x69a],0x10
00004A0B  C606BD4400        mov byte [0x44bd],0x0
00004A10  C606E04301        mov byte [0x43e0],0x1
00004A15  C606D04400        mov byte [0x44d0],0x0
00004A1A  C606BE4400        mov byte [0x44be],0x0
00004A1F  C3                ret
00004A20  833EBF4404        cmp word [0x44bf],byte +0x4
00004A25  7224              jc 0x4a4b
00004A27  833EBF4408        cmp word [0x44bf],byte +0x8
00004A2C  7705              ja 0x4a33
00004A2E  C606720504        mov byte [0x572],0x4
00004A33  A0C344            mov al,[0x44c3]
00004A36  A29806            mov [0x698],al
00004A39  A26E05            mov [0x56e],al
00004A3C  A2BE44            mov [0x44be],al
00004A3F  C606990600        mov byte [0x699],0x0
00004A44  C606710500        mov byte [0x571],0x0
00004A49  EBAE              jmp short 0x49f9
00004A4B  C606BE4400        mov byte [0x44be],0x0
00004A50  803EBD4400        cmp byte [0x44bd],0x0
00004A55  7506              jnz 0x4a5d
00004A57  E889C7            call 0x11e3
00004A5A  E8C7C6            call 0x1124
00004A5D  C606BD4401        mov byte [0x44bd],0x1
00004A62  2AC0              sub al,al
00004A64  8006D04430        add byte [0x44d0],0x30
00004A69  7302              jnc 0x4a6d
00004A6B  FEC0              inc al
00004A6D  A2D544            mov [0x44d5],al
00004A70  8B0E7905          mov cx,[0x579]
00004A74  81E1FC0F          and cx,0xffc
00004A78  8A167B05          mov dl,[0x57b]
00004A7C  80C203            add dl,0x3
00004A7F  813ED1440C41      cmp word [0x44d1],0x410c
00004A85  740E              jz 0x4a95
00004A87  83C108            add cx,byte +0x8
00004A8A  81F92701          cmp cx,0x127
00004A8E  720C              jc 0x4a9c
00004A90  B92601            mov cx,0x126
00004A93  EB07              jmp short 0x4a9c
00004A95  83E908            sub cx,byte +0x8
00004A98  7302              jnc 0x4a9c
00004A9A  2BC9              sub cx,cx
00004A9C  E811E2            call 0x2cb0
00004A9F  A3DC43            mov [0x43dc],ax
00004AA2  E833C9            call 0x13d8
00004AA5  74FB              jz 0x4aa2
00004AA7  E85900            call 0x4b03
00004AAA  803ED54400        cmp byte [0x44d5],0x0
00004AAF  744E              jz 0x4aff
00004AB1  8B1EC144          mov bx,[0x44c1]
00004AB5  80BFC44400        cmp byte [bx+0x44c4],0x0
00004ABA  7443              jz 0x4aff
00004ABC  FE8FC444          dec byte [bx+0x44c4]
00004AC0  7525              jnz 0x4ae7
00004AC2  53                push bx
00004AC3  B8FD08            mov ax,0x8fd
00004AC6  BB2307            mov bx,0x723
00004AC9  E86F0E            call 0x593b
00004ACC  5B                pop bx
00004ACD  C606980600        mov byte [0x698],0x0
00004AD2  C606BE4400        mov byte [0x44be],0x0
00004AD7  C6069A0610        mov byte [0x69a],0x10
00004ADC  FE0ED644          dec byte [0x44d6]
00004AE0  7505              jnz 0x4ae7
00004AE2  C606530501        mov byte [0x553],0x1
00004AE7  53                push bx
00004AE8  E8C5FC            call 0x47b0
00004AEB  5B                pop bx
00004AEC  730E              jnc 0x4afc
00004AEE  53                push bx
00004AEF  E8AEE8            call 0x33a0
00004AF2  5B                pop bx
00004AF3  E8D200            call 0x4bc8
00004AF6  E840E8            call 0x3339
00004AF9  EB04              jmp short 0x4aff
00004AFB  90                nop
00004AFC  E8C900            call 0x4bc8
00004AFF  E81B00            call 0x4b1d
00004B02  C3                ret
00004B03  803EE04300        cmp byte [0x43e0],0x0
00004B08  7512              jnz 0x4b1c
00004B0A  8B3EDE43          mov di,[0x43de]
00004B0E  BEA043            mov si,0x43a0
00004B11  B800B8            mov ax,0xb800
00004B14  8EC0              mov es,ax
00004B16  B9030A            mov cx,0xa03
00004B19  E881E2            call 0x2d9d
00004B1C  C3                ret
00004B1D  C606E04300        mov byte [0x43e0],0x0
00004B22  B800B8            mov ax,0xb800
00004B25  8EC0              mov es,ax
00004B27  8B3EDC43          mov di,[0x43dc]
00004B2B  893EDE43          mov [0x43de],di
00004B2F  BDA043            mov bp,0x43a0
00004B32  8B36D144          mov si,[0x44d1]
00004B36  803ED04480        cmp byte [0x44d0],0x80
00004B3B  7203              jc 0x4b40
00004B3D  83C63C            add si,byte +0x3c
00004B40  B9030A            mov cx,0xa03
00004B43  E8EFE1            call 0x2d35
00004B46  C3                ret
00004B47  1E                push ds
00004B48  07                pop es
00004B49  2BC0              sub ax,ax
00004B4B  BF4144            mov di,0x4441
00004B4E  B90C00            mov cx,0xc
00004B51  F3AB              rep stosw
00004B53  B800B8            mov ax,0xb800
00004B56  8EC0              mov es,ax
00004B58  8B1E0800          mov bx,[0x8]
00004B5C  8A8F7144          mov cl,[bx+0x4471]
00004B60  2AED              sub ch,ch
00004B62  E898E2            call 0x2dfd
00004B65  8ADA              mov bl,dl
00004B67  81E31E00          and bx,0x1e
00004B6B  80FB18            cmp bl,0x18
00004B6E  73F2              jnc 0x4b62
00004B70  83BF414400        cmp word [bx+0x4441],byte +0x0
00004B75  75EB              jnz 0x4b62
00004B77  C78759440000      mov word [bx+0x4459],0x0
00004B7D  C78741440100      mov word [bx+0x4441],0x1
00004B83  51                push cx
00004B84  8BB72944          mov si,[bx+0x4429]
00004B88  8BBF1144          mov di,[bx+0x4411]
00004B8C  B9050D            mov cx,0xd05
00004B8F  E80BE2            call 0x2d9d
00004B92  59                pop cx
00004B93  E2CD              loop 0x4b62
00004B95  B90C00            mov cx,0xc
00004B98  8BD9              mov bx,cx
00004B9A  4B                dec bx
00004B9B  8B360800          mov si,[0x8]
00004B9F  8A947944          mov dl,[si+0x4479]
00004BA3  8897C444          mov [bx+0x44c4],dl
00004BA7  51                push cx
00004BA8  E81D00            call 0x4bc8
00004BAB  59                pop cx
00004BAC  E2EA              loop 0x4b98
00004BAE  C606D04400        mov byte [0x44d0],0x0
00004BB3  C606BD4400        mov byte [0x44bd],0x0
00004BB8  C606E04301        mov byte [0x43e0],0x1
00004BBD  C606D6440C        mov byte [0x44d6],0xc
00004BC2  C606BE4400        mov byte [0x44be],0x0
00004BC7  C3                ret
00004BC8  E81D00            call 0x4be8
00004BCB  8BF8              mov di,ax
00004BCD  8A87C444          mov al,[bx+0x44c4]
00004BD1  2AE4              sub ah,ah
00004BD3  B105              mov cl,0x5
00004BD5  D3E0              shl ax,cl
00004BD7  05FC41            add ax,0x41fc
00004BDA  8BF0              mov si,ax
00004BDC  B90208            mov cx,0x802
00004BDF  B800B8            mov ax,0xb800
00004BE2  8EC0              mov es,ax
00004BE4  E8B6E1            call 0x2d9d
00004BE7  C3                ret
00004BE8  53                push bx
00004BE9  8A979944          mov dl,[bx+0x4499]
00004BED  D0E3              shl bl,1
00004BEF  8B8F8144          mov cx,[bx+0x4481]
00004BF3  E8BAE0            call 0x2cb0
00004BF6  5B                pop bx
00004BF7  C3                ret
00004BF8  0000              add [bx+si],al
00004BFA  0000              add [bx+si],al
00004BFC  0000              add [bx+si],al
00004BFE  0000              add [bx+si],al
00004C00  C3                ret
00004C01  C3                ret
00004C02  C3                ret
00004C03  C3                ret
00004C04  F8                clc
00004C05  C3                ret
00004C06  F8                clc
00004C07  C3                ret
00004C08  C3                ret
00004C09  0000              add [bx+si],al
00004C0B  0000              add [bx+si],al
00004C0D  0000              add [bx+si],al
00004C0F  002A              add [bp+si],ch
00004C11  E4CD              in al,0xcd
00004C13  1A3B              sbb bh,[bp+di]
00004C15  16                push ss
00004C16  B84575            mov ax,0x7545
00004C19  01C3              add bx,ax
00004C1B  FF06B645          inc word [0x45b6]
00004C1F  8B1EB645          mov bx,[0x45b6]
00004C23  83FB01            cmp bx,byte +0x1
00004C26  7410              jz 0x4c38
00004C28  83FB04            cmp bx,byte +0x4
00004C2B  740B              jz 0x4c38
00004C2D  83FB07            cmp bx,byte +0x7
00004C30  720A              jc 0x4c3c
00004C32  2BDB              sub bx,bx
00004C34  891EB645          mov [0x45b6],bx
00004C38  8916B845          mov [0x45b8],dx
00004C3C  E88E03            call 0x4fcd
00004C3F  E8EB03            call 0x502d
00004C42  7301              jnc 0x4c45
00004C44  C3                ret
00004C45  833E4F4500        cmp word [0x454f],byte +0x0
00004C4A  7440              jz 0x4c8c
00004C4C  2AE4              sub ah,ah
00004C4E  CD1A              int 0x1a
00004C50  2B164F45          sub dx,[0x454f]
00004C54  8B1E0800          mov bx,[0x8]
00004C58  D0E3              shl bl,1
00004C5A  8B87C745          mov ax,[bx+0x45c7]
00004C5E  833EB64500        cmp word [0x45b6],byte +0x0
00004C63  7502              jnz 0x4c67
00004C65  D1E0              shl ax,1
00004C67  3BD0              cmp dx,ax
00004C69  72D9              jc 0x4c44
00004C6B  C7064F450000      mov word [0x454f],0x0
00004C71  C6064E4501        mov byte [0x454e],0x1
00004C76  B82400            mov ax,0x24
00004C79  813E7905A000      cmp word [0x579],0xa0
00004C7F  7703              ja 0x4c84
00004C81  B80801            mov ax,0x108
00004C84  A34845            mov [0x4548],ax
00004C87  C6064A4500        mov byte [0x454a],0x0
00004C8C  E84101            call 0x4dd0
00004C8F  7308              jnc 0x4c99
00004C91  8B1EB645          mov bx,[0x45b6]
00004C95  E82303            call 0x4fbb
00004C98  C3                ret
00004C99  803E534500        cmp byte [0x4553],0x0
00004C9E  7418              jz 0x4cb8
00004CA0  FE0E5345          dec byte [0x4553]
00004CA4  750F              jnz 0x4cb5
00004CA6  B201              mov dl,0x1
00004CA8  803E4A45FF        cmp byte [0x454a],0xff
00004CAD  7402              jz 0x4cb1
00004CAF  B2FF              mov dl,0xff
00004CB1  88164A45          mov [0x454a],dl
00004CB5  EB5D              jmp short 0x4d14
00004CB7  90                nop
00004CB8  A04B45            mov al,[0x454b]
00004CBB  3A067B05          cmp al,[0x57b]
00004CBF  7753              ja 0x4d14
00004CC1  833EB64506        cmp word [0x45b6],byte +0x6
00004CC6  7507              jnz 0x4ccf
00004CC8  803E7B0528        cmp byte [0x57b],0x28
00004CCD  720D              jc 0x4cdc
00004CCF  E82BE1            call 0x2dfd
00004CD2  8B1E0800          mov bx,[0x8]
00004CD6  3A97BF45          cmp dl,[bx+0x45bf]
00004CDA  7738              ja 0x4d14
00004CDC  2AD2              sub dl,dl
00004CDE  A14845            mov ax,[0x4548]
00004CE1  25F80F            and ax,0xff8
00004CE4  8B0E7905          mov cx,[0x579]
00004CE8  81E1F80F          and cx,0xff8
00004CEC  3BC1              cmp ax,cx
00004CEE  7406              jz 0x4cf6
00004CF0  B201              mov dl,0x1
00004CF2  7202              jc 0x4cf6
00004CF4  B2FF              mov dl,0xff
00004CF6  88164A45          mov [0x454a],dl
00004CFA  803E7B0528        cmp byte [0x57b],0x28
00004CFF  7213              jc 0x4d14
00004D01  833EB64506        cmp word [0x45b6],byte +0x6
00004D06  750C              jnz 0x4d14
00004D08  B001              mov al,0x1
00004D0A  80FAFF            cmp dl,0xff
00004D0D  7402              jz 0x4d11
00004D0F  B0FF              mov al,0xff
00004D11  A24A45            mov [0x454a],al
00004D14  C706BC450800      mov word [0x45bc],0x8
00004D1A  803E534500        cmp byte [0x4553],0x0
00004D1F  7406              jz 0x4d27
00004D21  C706BC450400      mov word [0x45bc],0x4
00004D27  A14845            mov ax,[0x4548]
00004D2A  803E4A4501        cmp byte [0x454a],0x1
00004D2F  7315              jnc 0x4d46
00004D31  E8C9E0            call 0x2dfd
00004D34  80FA10            cmp dl,0x10
00004D37  7768              ja 0x4da1
00004D39  80E201            and dl,0x1
00004D3C  7502              jnz 0x4d40
00004D3E  B2FF              mov dl,0xff
00004D40  88164A45          mov [0x454a],dl
00004D44  EB5B              jmp short 0x4da1
00004D46  7518              jnz 0x4d60
00004D48  0306BC45          add ax,[0x45bc]
00004D4C  3D0B01            cmp ax,0x10b
00004D4F  7227              jc 0x4d78
00004D51  B80A01            mov ax,0x10a
00004D54  C6064A45FF        mov byte [0x454a],0xff
00004D59  C606534500        mov byte [0x4553],0x0
00004D5E  EB18              jmp short 0x4d78
00004D60  2B06BC45          sub ax,[0x45bc]
00004D64  7205              jc 0x4d6b
00004D66  3D2400            cmp ax,0x24
00004D69  770D              ja 0x4d78
00004D6B  B82500            mov ax,0x25
00004D6E  C6064A4501        mov byte [0x454a],0x1
00004D73  C606534500        mov byte [0x4553],0x0
00004D78  A34845            mov [0x4548],ax
00004D7B  8306514502        add word [0x4551],byte +0x2
00004D80  833E51450C        cmp word [0x4551],byte +0xc
00004D85  7206              jc 0x4d8d
00004D87  C70651450000      mov word [0x4551],0x0
00004D8D  803E534500        cmp byte [0x4553],0x0
00004D92  750D              jnz 0x4da1
00004D94  E866E0            call 0x2dfd
00004D97  80FA08            cmp dl,0x8
00004D9A  7705              ja 0x4da1
00004D9C  C6064A4500        mov byte [0x454a],0x0
00004DA1  8B0E4845          mov cx,[0x4548]
00004DA5  8A164B45          mov dl,[0x454b]
00004DA9  E804DF            call 0x2cb0
00004DAC  A3BA45            mov [0x45ba],ax
00004DAF  E87B02            call 0x502d
00004DB2  7301              jnc 0x4db5
00004DB4  C3                ret
00004DB5  E81800            call 0x4dd0
00004DB8  720E              jc 0x4dc8
00004DBA  E88D01            call 0x4f4a
00004DBD  E85001            call 0x4f10
00004DC0  C606BE4500        mov byte [0x45be],0x0
00004DC5  E8AD00            call 0x4e75
00004DC8  8B1EB645          mov bx,[0x45b6]
00004DCC  E8EC01            call 0x4fbb
00004DCF  C3                ret
00004DD0  A17905            mov ax,[0x579]
00004DD3  8A167B05          mov dl,[0x57b]
00004DD7  BE1800            mov si,0x18
00004DDA  8BFE              mov di,si
00004DDC  8B1E4845          mov bx,[0x4548]
00004DE0  8A364B45          mov dh,[0x454b]
00004DE4  B90E0C            mov cx,0xc0e
00004DE7  E83FE0            call 0x2e29
00004DEA  7351              jnc 0x4e3d
00004DEC  833EB64506        cmp word [0x45b6],byte +0x6
00004DF1  750D              jnz 0x4e00
00004DF3  C606530501        mov byte [0x553],0x1
00004DF8  E8E8C3            call 0x11e3
00004DFB  E84C01            call 0x4f4a
00004DFE  F9                stc
00004DFF  C3                ret
00004E00  E8E0C3            call 0x11e3
00004E03  E84401            call 0x4f4a
00004E06  E83CC3            call 0x1145
00004E09  C6065B0504        mov byte [0x55b],0x4
00004E0E  C606710501        mov byte [0x571],0x1
00004E13  C606760504        mov byte [0x576],0x4
00004E18  C606780508        mov byte [0x578],0x8
00004E1D  C606534504        mov byte [0x4553],0x4
00004E22  B201              mov dl,0x1
00004E24  A14845            mov ax,[0x4548]
00004E27  3B067905          cmp ax,[0x579]
00004E2B  7702              ja 0x4e2f
00004E2D  B2FF              mov dl,0xff
00004E2F  88164A45          mov [0x454a],dl
00004E33  B8E40C            mov ax,0xce4
00004E36  BB3B12            mov bx,0x123b
00004E39  E8FF0A            call 0x593b
00004E3C  F9                stc
00004E3D  C3                ret
00004E3E  C606BE4501        mov byte [0x45be],0x1
00004E43  A1B645            mov ax,[0x45b6]
00004E46  50                push ax
00004E47  C706B6450000      mov word [0x45b6],0x0
00004E4D  8B1EB645          mov bx,[0x45b6]
00004E51  E87901            call 0x4fcd
00004E54  833E4F4500        cmp word [0x454f],byte +0x0
00004E59  750A              jnz 0x4e65
00004E5B  E81700            call 0x4e75
00004E5E  8B1EB645          mov bx,[0x45b6]
00004E62  E85601            call 0x4fbb
00004E65  FF06B645          inc word [0x45b6]
00004E69  833EB64507        cmp word [0x45b6],byte +0x7
00004E6E  72DD              jc 0x4e4d
00004E70  58                pop ax
00004E71  A3B645            mov [0x45b6],ax
00004E74  C3                ret
00004E75  B90800            mov cx,0x8
00004E78  8BD9              mov bx,cx
00004E7A  4B                dec bx
00004E7B  80BF722B00        cmp byte [bx+0x2b72],0x0
00004E80  7421              jz 0x4ea3
00004E82  51                push cx
00004E83  8A976A2B          mov dl,[bx+0x2b6a]
00004E87  D0E3              shl bl,1
00004E89  8B875A2B          mov ax,[bx+0x2b5a]
00004E8D  BE1800            mov si,0x18
00004E90  8BFE              mov di,si
00004E92  8B1E4845          mov bx,[0x4548]
00004E96  8A364B45          mov dh,[0x454b]
00004E9A  B90F0C            mov cx,0xc0f
00004E9D  E889DF            call 0x2e29
00004EA0  59                pop cx
00004EA1  7203              jc 0x4ea6
00004EA3  E2D3              loop 0x4e78
00004EA5  C3                ret
00004EA6  51                push cx
00004EA7  803EBE4500        cmp byte [0x45be],0x0
00004EAC  750D              jnz 0x4ebb
00004EAE  E832C3            call 0x11e3
00004EB1  803EF27000        cmp byte [0x70f2],0x0
00004EB6  7403              jz 0x4ebb
00004EB8  E87013            call 0x622b
00004EBB  E88C00            call 0x4f4a
00004EBE  59                pop cx
00004EBF  8BD9              mov bx,cx
00004EC1  4B                dec bx
00004EC2  C687722B00        mov byte [bx+0x2b72],0x0
00004EC7  8A976A2B          mov dl,[bx+0x2b6a]
00004ECB  D0E3              shl bl,1
00004ECD  8B8F5A2B          mov cx,[bx+0x2b5a]
00004ED1  E8DCDD            call 0x2cb0
00004ED4  8BF8              mov di,ax
00004ED6  BE7A2B            mov si,0x2b7a
00004ED9  B800B8            mov ax,0xb800
00004EDC  8EC0              mov es,ax
00004EDE  B9030F            mov cx,0xf03
00004EE1  E8B9DE            call 0x2d9d
00004EE4  803EBE4500        cmp byte [0x45be],0x0
00004EE9  750D              jnz 0x4ef8
00004EEB  803EF27000        cmp byte [0x70f2],0x0
00004EF0  7403              jz 0x4ef5
00004EF2  E80513            call 0x61fa
00004EF5  E84DC2            call 0x1145
00004EF8  2BD2              sub dx,dx
00004EFA  833EB64506        cmp word [0x45b6],byte +0x6
00004EFF  740A              jz 0x4f0b
00004F01  2AE4              sub ah,ah
00004F03  CD1A              int 0x1a
00004F05  83FA00            cmp dx,byte +0x0
00004F08  7501              jnz 0x4f0b
00004F0A  4A                dec dx
00004F0B  89164F45          mov [0x454f],dx
00004F0F  C3                ret
00004F10  C6064E4500        mov byte [0x454e],0x0
00004F15  BE0045            mov si,0x4500
00004F18  803E4A4500        cmp byte [0x454a],0x0
00004F1D  741F              jz 0x4f3e
00004F1F  8B1E5145          mov bx,[0x4551]
00004F23  803E534500        cmp byte [0x4553],0x0
00004F28  7406              jz 0x4f30
00004F2A  80E302            and bl,0x2
00004F2D  80C30C            add bl,0xc
00004F30  803E4A45FF        cmp byte [0x454a],0xff
00004F35  7503              jnz 0x4f3a
00004F37  83C310            add bx,byte +0x10
00004F3A  8BB7604A          mov si,[bx+0x4a60]
00004F3E  8B3EBA45          mov di,[0x45ba]
00004F42  893E4C45          mov [0x454c],di
00004F46  E89600            call 0x4fdf
00004F49  C3                ret
00004F4A  803E4E4500        cmp byte [0x454e],0x0
00004F4F  7507              jnz 0x4f58
00004F51  8B3E4C45          mov di,[0x454c]
00004F55  E8B000            call 0x5008
00004F58  C3                ret
00004F59  C706B6450000      mov word [0x45b6],0x0
00004F5F  E89BDE            call 0x2dfd
00004F62  81E27F00          and dx,0x7f
00004F66  83C260            add dx,byte +0x60
00004F69  89164845          mov [0x4548],dx
00004F6D  C6064A4500        mov byte [0x454a],0x0
00004F72  C6064E4501        mov byte [0x454e],0x1
00004F77  C70651450000      mov word [0x4551],0x0
00004F7D  C606534500        mov byte [0x4553],0x0
00004F82  2BD2              sub dx,dx
00004F84  833EB64500        cmp word [0x45b6],byte +0x0
00004F89  750A              jnz 0x4f95
00004F8B  2AE4              sub ah,ah
00004F8D  CD1A              int 0x1a
00004F8F  83FA00            cmp dx,byte +0x0
00004F92  7501              jnz 0x4f95
00004F94  4A                dec dx
00004F95  89164F45          mov [0x454f],dx
00004F99  8B1EB645          mov bx,[0x45b6]
00004F9D  8A87D42B          mov al,[bx+0x2bd4]
00004FA1  0403              add al,0x3
00004FA3  A24B45            mov [0x454b],al
00004FA6  E81200            call 0x4fbb
00004FA9  FF06B645          inc word [0x45b6]
00004FAD  833EB64507        cmp word [0x45b6],byte +0x7
00004FB2  72AB              jc 0x4f5f
00004FB4  C706B6450000      mov word [0x45b6],0x0
00004FBA  C3                ret
00004FBB  1E                push ds
00004FBC  07                pop es
00004FBD  D0E3              shl bl,1
00004FBF  FC                cld
00004FC0  8BBFA845          mov di,[bx+0x45a8]
00004FC4  BE4845            mov si,0x4548
00004FC7  B90C00            mov cx,0xc
00004FCA  F3A4              rep movsb
00004FCC  C3                ret
00004FCD  1E                push ds
00004FCE  07                pop es
00004FCF  D0E3              shl bl,1
00004FD1  FC                cld
00004FD2  8BB7A845          mov si,[bx+0x45a8]
00004FD6  BF4845            mov di,0x4548
00004FD9  B90C00            mov cx,0xc
00004FDC  F3A4              rep movsb
00004FDE  C3                ret
00004FDF  B800B8            mov ax,0xb800
00004FE2  8EC0              mov es,ax
00004FE4  FC                cld
00004FE5  B60C              mov dh,0xc
00004FE7  B90300            mov cx,0x3
00004FEA  268B1D            mov bx,[es:di]
00004FED  AD                lodsw
00004FEE  0BC3              or ax,bx
00004FF0  AB                stosw
00004FF1  E2F7              loop 0x4fea
00004FF3  83EF06            sub di,byte +0x6
00004FF6  81F70020          xor di,0x2000
00004FFA  F7C70020          test di,0x2000
00004FFE  7503              jnz 0x5003
00005000  83C750            add di,byte +0x50
00005003  FECE              dec dh
00005005  75E0              jnz 0x4fe7
00005007  C3                ret
00005008  B800B8            mov ax,0xb800
0000500B  8EC0              mov es,ax
0000500D  FC                cld
0000500E  B60C              mov dh,0xc
00005010  B85555            mov ax,0x5555
00005013  B90300            mov cx,0x3
00005016  F3AB              rep stosw
00005018  83EF06            sub di,byte +0x6
0000501B  81F70020          xor di,0x2000
0000501F  F7C70020          test di,0x2000
00005023  7503              jnz 0x5028
00005025  83C750            add di,byte +0x50
00005028  FECE              dec dh
0000502A  75E7              jnz 0x5013
0000502C  C3                ret
0000502D  803EF27000        cmp byte [0x70f2],0x0
00005032  7502              jnz 0x5036
00005034  F8                clc
00005035  C3                ret
00005036  A1F370            mov ax,[0x70f3]
00005039  8A16F570          mov dl,[0x70f5]
0000503D  BE1000            mov si,0x10
00005040  8B1E4845          mov bx,[0x4548]
00005044  8A364B45          mov dh,[0x454b]
00005048  BF1800            mov di,0x18
0000504B  B9080C            mov cx,0xc08
0000504E  E8D8DD            call 0x2e29
00005051  C3                ret
00005052  0000              add [bx+si],al
00005054  0000              add [bx+si],al
00005056  0000              add [bx+si],al
00005058  0000              add [bx+si],al
0000505A  0000              add [bx+si],al
0000505C  0000              add [bx+si],al
0000505E  0000              add [bx+si],al
00005060  B800B8            mov ax,0xb800
00005063  8EC0              mov es,ax
00005065  A17905            mov ax,[0x579]
00005068  3D1701            cmp ax,0x117
0000506B  7203              jc 0x5070
0000506D  B81601            mov ax,0x116
00005070  2D1000            sub ax,0x10
00005073  7302              jnc 0x5077
00005075  2BC0              sub ax,ax
00005077  25F00F            and ax,0xff0
0000507A  A37905            mov [0x579],ax
0000507D  C6067B0514        mov byte [0x57b],0x14
00005082  2D8000            sub ax,0x80
00005085  7302              jnc 0x5089
00005087  F7D0              not ax
00005089  B103              mov cl,0x3
0000508B  D3E8              shr ax,cl
0000508D  3D0D00            cmp ax,0xd
00005090  7603              jna 0x5095
00005092  B80D00            mov ax,0xd
00005095  050200            add ax,0x2
00005098  A36A4D            mov [0x4d6a],ax
0000509B  C706D64D0A00      mov word [0x4dd6],0xa
000050A1  833ED64D0A        cmp word [0x4dd6],byte +0xa
000050A6  7403              jz 0x50ab
000050A8  E8B80A            call 0x5b63
000050AB  2AE4              sub ah,ah
000050AD  CD1A              int 0x1a
000050AF  8916804A          mov [0x4a80],dx
000050B3  A17905            mov ax,[0x579]
000050B6  8BC8              mov cx,ax
000050B8  81E1F00F          and cx,0xff0
000050BC  81F98000          cmp cx,0x80
000050C0  7504              jnz 0x50c6
000050C2  8BC1              mov ax,cx
000050C4  EB0C              jmp short 0x50d2
000050C6  7206              jc 0x50ce
000050C8  2B066A4D          sub ax,[0x4d6a]
000050CC  EB04              jmp short 0x50d2
000050CE  03066A4D          add ax,[0x4d6a]
000050D2  A37905            mov [0x579],ax
000050D5  803E7B0554        cmp byte [0x57b],0x54
000050DA  7201              jc 0x50dd
000050DC  C3                ret
000050DD  80067B0508        add byte [0x57b],0x8
000050E2  8B0E7905          mov cx,[0x579]
000050E6  83C104            add cx,byte +0x4
000050E9  8A167B05          mov dl,[0x57b]
000050ED  E8C0DB            call 0x2cb0
000050F0  8BF8              mov di,ax
000050F2  893ED84D          mov [0x4dd8],di
000050F6  BE8A4B            mov si,0x4b8a
000050F9  BD0E00            mov bp,0xe
000050FC  B90720            mov cx,0x2007
000050FF  E8CADB            call 0x2ccc
00005102  8B3ED84D          mov di,[0x4dd8]
00005106  81C7F300          add di,0xf3
0000510A  BE824A            mov si,0x4a82
0000510D  B9040D            mov cx,0xd04
00005110  E88ADC            call 0x2d9d
00005113  833ED64D0A        cmp word [0x4dd6],byte +0xa
00005118  7506              jnz 0x5120
0000511A  E81106            call 0x572e
0000511D  E8340A            call 0x5b54
00005120  E8400A            call 0x5b63
00005123  2AE4              sub ah,ah
00005125  CD1A              int 0x1a
00005127  2B16804A          sub dx,[0x4a80]
0000512B  3B16D64D          cmp dx,[0x4dd6]
0000512F  72EF              jc 0x5120
00005131  833ED64D0A        cmp word [0x4dd6],byte +0xa
00005136  7509              jnz 0x5141
00005138  E875E7            call 0x38b0
0000513B  2BDB              sub bx,bx
0000513D  B40B              mov ah,0xb
0000513F  CD10              int 0x10
00005141  C706D64D0200      mov word [0x4dd6],0x2
00005147  E957FF            jmp 0x50a1
0000514A  B90300            mov cx,0x3
0000514D  BB0300            mov bx,0x3
00005150  2BD9              sub bx,cx
00005152  D1E3              shl bx,1
00005154  8B87A44D          mov ax,[bx+0x4da4]
00005158  A36A4D            mov [0x4d6a],ax
0000515B  8B87AA4D          mov ax,[bx+0x4daa]
0000515F  A36C4D            mov [0x4d6c],ax
00005162  8B87984D          mov ax,[bx+0x4d98]
00005166  A3CC4D            mov [0x4dcc],ax
00005169  8B879E4D          mov ax,[bx+0x4d9e]
0000516D  A3CE4D            mov [0x4dce],ax
00005170  8B87B04D          mov ax,[bx+0x4db0]
00005174  A3D04D            mov [0x4dd0],ax
00005177  8B87B64D          mov ax,[bx+0x4db6]
0000517B  A3D24D            mov [0x4dd2],ax
0000517E  8B87BC4D          mov ax,[bx+0x4dbc]
00005182  A3D44D            mov [0x4dd4],ax
00005185  8B87924D          mov ax,[bx+0x4d92]
00005189  A3CA4D            mov [0x4dca],ax
0000518C  8B87C24D          mov ax,[bx+0x4dc2]
00005190  A3C84D            mov [0x4dc8],ax
00005193  51                push cx
00005194  E80400            call 0x519b
00005197  59                pop cx
00005198  E2B3              loop 0x514d
0000519A  C3                ret
0000519B  B90800            mov cx,0x8
0000519E  C606914D01        mov byte [0x4d91],0x1
000051A3  51                push cx
000051A4  E8BC09            call 0x5b63
000051A7  59                pop cx
000051A8  8BD9              mov bx,cx
000051AA  4B                dec bx
000051AB  D1E3              shl bx,1
000051AD  A1CC4D            mov ax,[0x4dcc]
000051B0  89874A4D          mov [bx+0x4d4a],ax
000051B4  A1CE4D            mov ax,[0x4dce]
000051B7  89875A4D          mov [bx+0x4d5a],ax
000051BB  E2E6              loop 0x51a3
000051BD  B800B8            mov ax,0xb800
000051C0  8EC0              mov es,ax
000051C2  C6066E4D00        mov byte [0x4d6e],0x0
000051C7  2AE4              sub ah,ah
000051C9  CD1A              int 0x1a
000051CB  8916804A          mov [0x4a80],dx
000051CF  B90800            mov cx,0x8
000051D2  51                push cx
000051D3  E88D09            call 0x5b63
000051D6  59                pop cx
000051D7  8BD9              mov bx,cx
000051D9  4B                dec bx
000051DA  D1E3              shl bx,1
000051DC  51                push cx
000051DD  53                push bx
000051DE  803E914D00        cmp byte [0x4d91],0x0
000051E3  7405              jz 0x51ea
000051E5  83F908            cmp cx,byte +0x8
000051E8  751B              jnz 0x5205
000051EA  8B8F4A4D          mov cx,[bx+0x4d4a]
000051EE  8B975A4D          mov dx,[bx+0x4d5a]
000051F2  E8BBDA            call 0x2cb0
000051F5  8BF8              mov di,ax
000051F7  8B36CA4D          mov si,[0x4dca]
000051FB  BD0E00            mov bp,0xe
000051FE  8B0ED44D          mov cx,[0x4dd4]
00005202  E8C7DA            call 0x2ccc
00005205  5B                pop bx
00005206  59                pop cx
00005207  E82000            call 0x522a
0000520A  E2C6              loop 0x51d2
0000520C  E85409            call 0x5b63
0000520F  2AE4              sub ah,ah
00005211  CD1A              int 0x1a
00005213  2B16804A          sub dx,[0x4a80]
00005217  3B16C84D          cmp dx,[0x4dc8]
0000521B  72EF              jc 0x520c
0000521D  C606914D00        mov byte [0x4d91],0x0
00005222  803E6E4D00        cmp byte [0x4d6e],0x0
00005227  749E              jz 0x51c7
00005229  C3                ret
0000522A  8B874A4D          mov ax,[bx+0x4d4a]
0000522E  83BF6F4D01        cmp word [bx+0x4d6f],byte +0x1
00005233  7225              jc 0x525a
00005235  7513              jnz 0x524a
00005237  03066A4D          add ax,[0x4d6a]
0000523B  3B06D04D          cmp ax,[0x4dd0]
0000523F  7615              jna 0x5256
00005241  A1D04D            mov ax,[0x4dd0]
00005244  FE066E4D          inc byte [0x4d6e]
00005248  EB0C              jmp short 0x5256
0000524A  2B066A4D          sub ax,[0x4d6a]
0000524E  7306              jnc 0x5256
00005250  2BC0              sub ax,ax
00005252  FE066E4D          inc byte [0x4d6e]
00005256  89874A4D          mov [bx+0x4d4a],ax
0000525A  8B875A4D          mov ax,[bx+0x4d5a]
0000525E  83BF7F4D01        cmp word [bx+0x4d7f],byte +0x1
00005263  7225              jc 0x528a
00005265  7513              jnz 0x527a
00005267  03066C4D          add ax,[0x4d6c]
0000526B  3B06D24D          cmp ax,[0x4dd2]
0000526F  7615              jna 0x5286
00005271  A1D24D            mov ax,[0x4dd2]
00005274  FE066E4D          inc byte [0x4d6e]
00005278  EB0C              jmp short 0x5286
0000527A  2B066C4D          sub ax,[0x4d6c]
0000527E  7306              jnc 0x5286
00005280  2BC0              sub ax,ax
00005282  FE066E4D          inc byte [0x4d6e]
00005286  89875A4D          mov [bx+0x4d5a],ax
0000528A  C3                ret
0000528B  E8C608            call 0x5b54
0000528E  803E9706FD        cmp byte [0x697],0xfd
00005293  7407              jz 0x529c
00005295  B40B              mov ah,0xb
00005297  BB0101            mov bx,0x101
0000529A  CD10              int 0x10
0000529C  E8C1FD            call 0x5060
0000529F  E8A8FE            call 0x514a
000052A2  E81A09            call 0x5bbf
000052A5  803E801F09        cmp byte [0x1f80],0x9
000052AA  7304              jnc 0x52b0
000052AC  FE06801F          inc byte [0x1f80]
000052B0  833E080007        cmp word [0x8],byte +0x7
000052B5  7304              jnc 0x52bb
000052B7  FF060800          inc word [0x8]
000052BB  C70614040000      mov word [0x414],0x0
000052C1  2AE4              sub ah,ah
000052C3  CD1A              int 0x1a
000052C5  89161204          mov [0x412],dx
000052C9  E85508            call 0x5b21
000052CC  C3                ret
000052CD  0000              add [bx+si],al
000052CF  00803E00          add [bx+si+0x3e],al
000052D3  0000              add [bx+si],al
000052D5  743B              jz 0x5312
000052D7  2AE4              sub ah,ah
000052D9  CD1A              int 0x1a
000052DB  3B16C452          cmp dx,[0x52c4]
000052DF  7431              jz 0x5312
000052E1  8916C452          mov [0x52c4],dx
000052E5  8B1EC652          mov bx,[0x52c6]
000052E9  8306C65202        add word [0x52c6],byte +0x2
000052EE  8B87CA52          mov ax,[bx+0x52ca]
000052F2  3B06C852          cmp ax,[0x52c8]
000052F6  7504              jnz 0x52fc
000052F8  E82608            call 0x5b21
000052FB  C3                ret
000052FC  A3C852            mov [0x52c8],ax
000052FF  B0B6              mov al,0xb6
00005301  E643              out 0x43,al
00005303  A1C852            mov ax,[0x52c8]
00005306  E642              out 0x42,al
00005308  8AC4              mov al,ah
0000530A  E642              out 0x42,al
0000530C  E461              in al,0x61
0000530E  0C03              or al,0x3
00005310  E661              out 0x61,al
00005312  C3                ret
00005313  833E080002        cmp word [0x8],byte +0x2
00005318  724D              jc 0x5367
0000531A  C70616500000      mov word [0x5016],0x0
00005320  2AE4              sub ah,ah
00005322  CD1A              int 0x1a
00005324  8916C052          mov [0x52c0],dx
00005328  8916C252          mov [0x52c2],dx
0000532C  8916C452          mov [0x52c4],dx
00005330  C706C6520000      mov word [0x52c6],0x0
00005336  C706C8520000      mov word [0x52c8],0x0
0000533C  E82900            call 0x5368
0000533F  813616500200      xor word [0x5016],0x2
00005345  E888FF            call 0x52d0
00005348  2AE4              sub ah,ah
0000534A  CD1A              int 0x1a
0000534C  8BC2              mov ax,dx
0000534E  2B06C052          sub ax,[0x52c0]
00005352  3D0500            cmp ax,0x5
00005355  72EE              jc 0x5345
00005357  8916C052          mov [0x52c0],dx
0000535B  2B16C252          sub dx,[0x52c2]
0000535F  83FA28            cmp dx,byte +0x28
00005362  72D8              jc 0x533c
00005364  E8BA07            call 0x5b21
00005367  C3                ret
00005368  B800B8            mov ax,0xb800
0000536B  8EC0              mov es,ax
0000536D  8B1E0800          mov bx,[0x8]
00005371  D1E3              shl bx,1
00005373  8B87AE52          mov ax,[bx+0x52ae]
00005377  A31050            mov [0x5010],ax
0000537A  8B1E1050          mov bx,[0x5010]
0000537E  8B3F              mov di,[bx]
00005380  83FF00            cmp di,byte +0x0
00005383  7501              jnz 0x5386
00005385  C3                ret
00005386  8B5F02            mov bx,[bx+0x2]
00005389  331E1650          xor bx,[0x5016]
0000538D  81E30200          and bx,0x2
00005391  8BB71250          mov si,[bx+0x5012]
00005395  B90423            mov cx,0x2304
00005398  E802DA            call 0x2d9d
0000539B  E832FF            call 0x52d0
0000539E  8306105004        add word [0x5010],byte +0x4
000053A3  EBD5              jmp short 0x537a
000053A5  0000              add [bx+si],al
000053A7  0000              add [bx+si],al
000053A9  0000              add [bx+si],al
000053AB  0000              add [bx+si],al
000053AD  0000              add [bx+si],al
000053AF  00803E00          add [bx+si+0x3e],al
000053B3  0000              add [bx+si],al
000053B5  743E              jz 0x53f5
000053B7  2AE4              sub ah,ah
000053B9  CD1A              int 0x1a
000053BB  3B162253          cmp dx,[0x5322]
000053BF  7434              jz 0x53f5
000053C1  89162253          mov [0x5322],dx
000053C5  8B1E2053          mov bx,[0x5320]
000053C9  8A9F8C53          mov bl,[bx+0x538c]
000053CD  80FB66            cmp bl,0x66
000053D0  740B              jz 0x53dd
000053D2  2AFF              sub bh,bh
000053D4  FF062053          inc word [0x5320]
000053D8  83FB00            cmp bx,byte +0x0
000053DB  7504              jnz 0x53e1
000053DD  E84107            call 0x5b21
000053E0  C3                ret
000053E1  B0B6              mov al,0xb6
000053E3  E643              out 0x43,al
000053E5  8B872453          mov ax,[bx+0x5324]
000053E9  E642              out 0x42,al
000053EB  8AC4              mov al,ah
000053ED  E642              out 0x42,al
000053EF  E461              in al,0x61
000053F1  0C03              or al,0x3
000053F3  E661              out 0x61,al
000053F5  C3                ret
000053F6  0000              add [bx+si],al
000053F8  0000              add [bx+si],al
000053FA  0000              add [bx+si],al
000053FC  0000              add [bx+si],al
000053FE  0000              add [bx+si],al
00005400  B800B8            mov ax,0xb800
00005403  8EC0              mov es,ax
00005405  8B1E0800          mov bx,[0x8]
00005409  81E30700          and bx,0x7
0000540D  D1E3              shl bx,1
0000540F  8BC3              mov ax,bx
00005411  8B9F0859          mov bx,[bx+0x5908]
00005415  B103              mov cl,0x3
00005417  D3E0              shl ax,cl
00005419  A31859            mov [0x5918],ax
0000541C  8B3F              mov di,[bx]
0000541E  81FFFFFF          cmp di,0xffff
00005422  7423              jz 0x5447
00005424  E8D6D9            call 0x2dfd
00005427  81E20E00          and dx,0xe
0000542B  03161859          add dx,[0x5918]
0000542F  8BF2              mov si,dx
00005431  8BB48858          mov si,[si+0x5888]
00005435  8B8C5858          mov cx,[si+0x5858]
00005439  8BB44C58          mov si,[si+0x584c]
0000543D  53                push bx
0000543E  E85CD9            call 0x2d9d
00005441  5B                pop bx
00005442  83C302            add bx,byte +0x2
00005445  EBD5              jmp short 0x541c
00005447  C3                ret
00005448  0000              add [bx+si],al
0000544A  0000              add [bx+si],al
0000544C  0000              add [bx+si],al
0000544E  0000              add [bx+si],al
00005450  C6060F5B0C        mov byte [0x5b0f],0xc
00005455  C7060C5B0100      mov word [0x5b0c],0x1
0000545B  C706125BFF01      mov word [0x5b12],0x1ff
00005461  C7060A5B0F00      mov word [0x5b0a],0xf
00005467  C6060E5B01        mov byte [0x5b0e],0x1
0000546C  C3                ret
0000546D  803E000000        cmp byte [0x0],0x0
00005472  7431              jz 0x54a5
00005474  803EB81C00        cmp byte [0x1cb8],0x0
00005479  747D              jz 0x54f8
0000547B  2AE4              sub ah,ah
0000547D  CD1A              int 0x1a
0000547F  803E0F5B00        cmp byte [0x5b0f],0x0
00005484  7520              jnz 0x54a6
00005486  3B16105B          cmp dx,[0x5b10]
0000548A  7419              jz 0x54a5
0000548C  8916105B          mov [0x5b10],dx
00005490  B0B6              mov al,0xb6
00005492  E643              out 0x43,al
00005494  A1125B            mov ax,[0x5b12]
00005497  25FF01            and ax,0x1ff
0000549A  05C800            add ax,0xc8
0000549D  E8E903            call 0x5889
000054A0  832E125B4B        sub word [0x5b12],byte +0x4b
000054A5  C3                ret
000054A6  3B16105B          cmp dx,[0x5b10]
000054AA  7408              jz 0x54b4
000054AC  8916105B          mov [0x5b10],dx
000054B0  FE0E0F5B          dec byte [0x5b0f]
000054B4  FE0E0E5B          dec byte [0x5b0e]
000054B8  753D              jnz 0x54f7
000054BA  B001              mov al,0x1
000054BC  803E9706FD        cmp byte [0x697],0xfd
000054C1  7402              jz 0x54c5
000054C3  D0E0              shl al,1
000054C5  A20E5B            mov [0x5b0e],al
000054C8  E832D9            call 0x2dfd
000054CB  80FA04            cmp dl,0x4
000054CE  7704              ja 0x54d4
000054D0  FF060C5B          inc word [0x5b0c]
000054D4  F7060C5B0100      test word [0x5b0c],0x1
000054DA  7405              jz 0x54e1
000054DC  83060A5B07        add word [0x5b0a],byte +0x7
000054E1  B0B6              mov al,0xb6
000054E3  E643              out 0x43,al
000054E5  E815D9            call 0x2dfd
000054E8  8BC2              mov ax,dx
000054EA  23060A5B          and ax,[0x5b0a]
000054EE  25FF01            and ax,0x1ff
000054F1  059001            add ax,0x190
000054F4  E89203            call 0x5889
000054F7  C3                ret
000054F8  2AE4              sub ah,ah
000054FA  CD1A              int 0x1a
000054FC  803E205900        cmp byte [0x5920],0x0
00005501  741F              jz 0x5522
00005503  3B162159          cmp dx,[0x5921]
00005507  7459              jz 0x5562
00005509  89162159          mov [0x5921],dx
0000550D  FE0E2059          dec byte [0x5920]
00005511  740B              jz 0x551e
00005513  B0B6              mov al,0xb6
00005515  E643              out 0x43,al
00005517  A12359            mov ax,[0x5923]
0000551A  E86C03            call 0x5889
0000551D  C3                ret
0000551E  E80006            call 0x5b21
00005521  C3                ret
00005522  3B162559          cmp dx,[0x5925]
00005526  743A              jz 0x5562
00005528  BE0300            mov si,0x3
0000552B  A0BF1C            mov al,[0x1cbf]
0000552E  0A06075B          or al,[0x5b07]
00005532  7515              jnz 0x5549
00005534  BE0100            mov si,0x1
00005537  833E040000        cmp word [0x4],byte +0x0
0000553C  750B              jnz 0x5549
0000553E  4E                dec si
0000553F  803E731600        cmp byte [0x1673],0x0
00005544  7403              jz 0x5549
00005546  BE0200            mov si,0x2
00005549  8BFE              mov di,si
0000554B  D1E7              shl di,1
0000554D  A08405            mov al,[0x584]
00005550  0A06075B          or al,[0x5b07]
00005554  750D              jnz 0x5563
00005556  8BC2              mov ax,dx
00005558  2B062559          sub ax,[0x5925]
0000555C  3B85F259          cmp ax,[di+0x59f2]
00005560  7301              jnc 0x5563
00005562  C3                ret
00005563  89162559          mov [0x5925],dx
00005567  803EBF1C00        cmp byte [0x1cbf],0x0
0000556C  750B              jnz 0x5579
0000556E  803E075B00        cmp byte [0x5b07],0x0
00005573  7429              jz 0x559e
00005575  FE0E075B          dec byte [0x5b07]
00005579  C7062E590012      mov word [0x592e],0x1200
0000557F  8B1EBA59          mov bx,[0x59ba]
00005583  83FB06            cmp bx,byte +0x6
00005586  7206              jc 0x558e
00005588  2BDB              sub bx,bx
0000558A  891EBA59          mov [0x59ba],bx
0000558E  8306BA5902        add word [0x59ba],byte +0x2
00005593  8B87445A          mov ax,[bx+0x5a44]
00005597  A32A59            mov [0x592a],ax
0000559A  E88B05            call 0x5b28
0000559D  C3                ret
0000559E  83FE02            cmp si,byte +0x2
000055A1  7518              jnz 0x55bb
000055A3  A07316            mov al,[0x1673]
000055A6  2AE4              sub ah,ah
000055A8  B104              mov cl,0x4
000055AA  D3E0              shl ax,cl
000055AC  050002            add ax,0x200
000055AF  A32A59            mov [0x592a],ax
000055B2  C7062E590018      mov word [0x592e],0x1800
000055B8  E9D200            jmp 0x568d
000055BB  8B85025A          mov ax,[di+0x5a02]
000055BF  A32E59            mov [0x592e],ax
000055C2  D02E2759          shr byte [0x5927],1
000055C6  735B              jnc 0x5623
000055C8  C7062E590010      mov word [0x592e],0x1000
000055CE  C606275980        mov byte [0x5927],0x80
000055D3  FE062859          inc byte [0x5928]
000055D7  A02859            mov al,[0x5928]
000055DA  2284FA59          and al,[si+0x59fa]
000055DE  7536              jnz 0x5616
000055E0  8A940A5A          mov dl,[si+0x5a0a]
000055E4  00162959          add [0x5929],dl
000055E8  E812D8            call 0x2dfd
000055EB  3A940C5A          cmp dl,[si+0x5a0c]
000055EF  7707              ja 0x55f8
000055F1  80E207            and dl,0x7
000055F4  88162D59          mov [0x592d],dl
000055F8  E802D8            call 0x2dfd
000055FB  81E2FF00          and dx,0xff
000055FF  D1E2              shl dx,1
00005601  B101              mov cl,0x1
00005603  F6C202            test dl,0x2
00005606  7406              jz 0x560e
00005608  B1FF              mov cl,0xff
0000560A  81C20003          add dx,0x300
0000560E  89162A59          mov [0x592a],dx
00005612  880E2C59          mov [0x592c],cl
00005616  8A262959          mov ah,[0x5929]
0000561A  22A4FC59          and ah,[si+0x59fc]
0000561E  0AC4              or al,ah
00005620  A22859            mov [0x5928],al
00005623  803E2C59FF        cmp byte [0x592c],0xff
00005628  7416              jz 0x5640
0000562A  8306545A02        add word [0x5a54],byte +0x2
0000562F  8B1E545A          mov bx,[0x5a54]
00005633  81E30E00          and bx,0xe
00005637  8B87445A          mov ax,[bx+0x5a44]
0000563B  A32A59            mov [0x592a],ax
0000563E  EB13              jmp short 0x5653
00005640  813E2A59C800      cmp word [0x592a],0xc8
00005646  7706              ja 0x564e
00005648  C7062A590005      mov word [0x592a],0x500
0000564E  832E2A5919        sub word [0x592a],byte +0x19
00005653  803E840500        cmp byte [0x584],0x0
00005658  740D              jz 0x5667
0000565A  C7062E590020      mov word [0x592e],0x2000
00005660  C6062C59FF        mov byte [0x592c],0xff
00005665  7526              jnz 0x568d
00005667  8A1E2859          mov bl,[0x5928]
0000566B  2AFF              sub bh,bh
0000566D  039DFE59          add bx,[di+0x59fe]
00005671  8A87C259          mov al,[bx+0x59c2]
00005675  22062759          and al,[0x5927]
00005679  7512              jnz 0x568d
0000567B  803E2D5900        cmp byte [0x592d],0x0
00005680  740E              jz 0x5690
00005682  FE0E2D59          dec byte [0x592d]
00005686  8B85065A          mov ax,[di+0x5a06]
0000568A  A32E59            mov [0x592e],ax
0000568D  E89804            call 0x5b28
00005690  C3                ret
00005691  E88D04            call 0x5b21
00005694  B40B              mov ah,0xb
00005696  BB0400            mov bx,0x4
00005699  CD10              int 0x10
0000569B  2AE4              sub ah,ah
0000569D  CD1A              int 0x1a
0000569F  8916E25A          mov [0x5ae2],dx
000056A3  C706E45A0000      mov word [0x5ae4],0x0
000056A9  B002              mov al,0x2
000056AB  803E9706FD        cmp byte [0x697],0xfd
000056B0  7502              jnz 0x56b4
000056B2  D0E8              shr al,1
000056B4  A2065B            mov [0x5b06],al
000056B7  803E000000        cmp byte [0x0],0x0
000056BC  741A              jz 0x56d8
000056BE  FF06E45A          inc word [0x5ae4]
000056C2  8B1EE45A          mov bx,[0x5ae4]
000056C6  8A0E065B          mov cl,[0x5b06]
000056CA  D3EB              shr bx,cl
000056CC  81E31F00          and bx,0x1f
000056D0  E461              in al,0x61
000056D2  3287E65A          xor al,[bx+0x5ae6]
000056D6  E661              out 0x61,al
000056D8  2AE4              sub ah,ah
000056DA  CD1A              int 0x1a
000056DC  2B16E25A          sub dx,[0x5ae2]
000056E0  83FA02            cmp dx,byte +0x2
000056E3  72D2              jc 0x56b7
000056E5  B40B              mov ah,0xb
000056E7  2BDB              sub bx,bx
000056E9  CD10              int 0x10
000056EB  C606075B0C        mov byte [0x5b07],0xc
000056F0  E82E04            call 0x5b21
000056F3  C3                ret
000056F4  B80002            mov ax,0x200
000056F7  803E9706FD        cmp byte [0x697],0xfd
000056FC  7502              jnz 0x5700
000056FE  D1E0              shl ax,1
00005700  A3D05A            mov [0x5ad0],ax
00005703  C3                ret
00005704  FF06D05A          inc word [0x5ad0]
00005708  8B1ED05A          mov bx,[0x5ad0]
0000570C  8BD3              mov dx,bx
0000570E  B109              mov cl,0x9
00005710  D3EA              shr dx,cl
00005712  8ACA              mov cl,dl
00005714  80E10F            and cl,0xf
00005717  D3EB              shr bx,cl
00005719  81E30F00          and bx,0xf
0000571D  8A97D25A          mov dl,[bx+0x5ad2]
00005721  22160000          and dl,[0x0]
00005725  E461              in al,0x61
00005727  24FC              and al,0xfc
00005729  0AC2              or al,dl
0000572B  E661              out 0x61,al
0000572D  C3                ret
0000572E  C706CB5AF401      mov word [0x5acb],0x1f4
00005734  E83700            call 0x576e
00005737  832ECB5A1E        sub word [0x5acb],byte +0x1e
0000573C  813ECB5AC800      cmp word [0x5acb],0xc8
00005742  77F0              ja 0x5734
00005744  C706CB5AF401      mov word [0x5acb],0x1f4
0000574A  E82100            call 0x576e
0000574D  832ECB5A14        sub word [0x5acb],byte +0x14
00005752  813ECB5A2C01      cmp word [0x5acb],0x12c
00005758  77F0              ja 0x574a
0000575A  E81100            call 0x576e
0000575D  8306CB5A1E        add word [0x5acb],byte +0x1e
00005762  813ECB5A2003      cmp word [0x5acb],0x320
00005768  72F0              jc 0x575a
0000576A  E8B403            call 0x5b21
0000576D  C3                ret
0000576E  B90010            mov cx,0x1000
00005771  803E9706FD        cmp byte [0x697],0xfd
00005776  7502              jnz 0x577a
00005778  D1E9              shr cx,1
0000577A  E2FE              loop 0x577a
0000577C  803E000000        cmp byte [0x0],0x0
00005781  7413              jz 0x5796
00005783  B0B6              mov al,0xb6
00005785  E643              out 0x43,al
00005787  A1CB5A            mov ax,[0x5acb]
0000578A  E642              out 0x42,al
0000578C  8AC4              mov al,ah
0000578E  E642              out 0x42,al
00005790  E461              in al,0x61
00005792  0C03              or al,0x3
00005794  E661              out 0x61,al
00005796  C3                ret
00005797  E88703            call 0x5b21
0000579A  C606CF5A00        mov byte [0x5acf],0x0
0000579F  C706CD5A0800      mov word [0x5acd],0x8
000057A5  C3                ret
000057A6  FE06CF5A          inc byte [0x5acf]
000057AA  2AD2              sub dl,dl
000057AC  A0CF5A            mov al,[0x5acf]
000057AF  243F              and al,0x3f
000057B1  7504              jnz 0x57b7
000057B3  FF06CD5A          inc word [0x5acd]
000057B7  8B1ECD5A          mov bx,[0x5acd]
000057BB  B102              mov cl,0x2
000057BD  D3EB              shr bx,cl
000057BF  80E31F            and bl,0x1f
000057C2  3AC3              cmp al,bl
000057C4  7202              jc 0x57c8
000057C6  B202              mov dl,0x2
000057C8  22160000          and dl,[0x0]
000057CC  E461              in al,0x61
000057CE  24FD              and al,0xfd
000057D0  0AC2              or al,dl
000057D2  E661              out 0x61,al
000057D4  C3                ret
000057D5  C706855A0000      mov word [0x5a85],0x0
000057DB  2AE4              sub ah,ah
000057DD  CD1A              int 0x1a
000057DF  8916835A          mov [0x5a83],dx
000057E3  C3                ret
000057E4  803E000000        cmp byte [0x0],0x0
000057E9  743D              jz 0x5828
000057EB  2AE4              sub ah,ah
000057ED  CD1A              int 0x1a
000057EF  8BC2              mov ax,dx
000057F1  2B06835A          sub ax,[0x5a83]
000057F5  3D0200            cmp ax,0x2
000057F8  722E              jc 0x5828
000057FA  8916835A          mov [0x5a83],dx
000057FE  8B1E855A          mov bx,[0x5a85]
00005802  8306855A02        add word [0x5a85],byte +0x2
00005807  803E520500        cmp byte [0x552],0x0
0000580C  740D              jz 0x581b
0000580E  8B87A35A          mov ax,[bx+0x5aa3]
00005812  3D0000            cmp ax,0x0
00005815  7508              jnz 0x581f
00005817  E80703            call 0x5b21
0000581A  C3                ret
0000581B  8B87875A          mov ax,[bx+0x5a87]
0000581F  50                push ax
00005820  B0B6              mov al,0xb6
00005822  E643              out 0x43,al
00005824  58                pop ax
00005825  E86100            call 0x5889
00005828  C3                ret
00005829  C706625A0000      mov word [0x5a62],0x0
0000582F  C606825A00        mov byte [0x5a82],0x0
00005834  C3                ret
00005835  803E000000        cmp byte [0x0],0x0
0000583A  740A              jz 0x5846
0000583C  2AE4              sub ah,ah
0000583E  CD1A              int 0x1a
00005840  3B16805A          cmp dx,[0x5a80]
00005844  7501              jnz 0x5847
00005846  C3                ret
00005847  8916805A          mov [0x5a80],dx
0000584B  FE06825A          inc byte [0x5a82]
0000584F  B0B6              mov al,0xb6
00005851  E643              out 0x43,al
00005853  8B1E625A          mov bx,[0x5a62]
00005857  F606825A01        test byte [0x5a82],0x1
0000585C  7503              jnz 0x5861
0000585E  83C302            add bx,byte +0x2
00005861  8B87645A          mov ax,[bx+0x5a64]
00005865  E82100            call 0x5889
00005868  C3                ret
00005869  803E000000        cmp byte [0x0],0x0
0000586E  7418              jz 0x5888
00005870  53                push bx
00005871  50                push ax
00005872  B0B6              mov al,0xb6
00005874  E643              out 0x43,al
00005876  8B1E625A          mov bx,[0x5a62]
0000587A  8306625A02        add word [0x5a62],byte +0x2
0000587F  8B87645A          mov ax,[bx+0x5a64]
00005883  E80300            call 0x5889
00005886  58                pop ax
00005887  5B                pop bx
00005888  C3                ret
00005889  E642              out 0x42,al
0000588B  8AC4              mov al,ah
0000588D  E642              out 0x42,al
0000588F  E461              in al,0x61
00005891  0C03              or al,0x3
00005893  E661              out 0x61,al
00005895  C3                ret
00005896  C3                ret
00005897  803E000000        cmp byte [0x0],0x0
0000589C  741E              jz 0x58bc
0000589E  50                push ax
0000589F  51                push cx
000058A0  52                push dx
000058A1  B0B6              mov al,0xb6
000058A3  E643              out 0x43,al
000058A5  8B1E565A          mov bx,[0x5a56]
000058A9  81E30600          and bx,0x6
000058AD  8306565A02        add word [0x5a56],byte +0x2
000058B2  8B875A5A          mov ax,[bx+0x5a5a]
000058B6  E8D0FF            call 0x5889
000058B9  5A                pop dx
000058BA  59                pop cx
000058BB  58                pop ax
000058BC  C3                ret
000058BD  C606275980        mov byte [0x5927],0x80
000058C2  C606285900        mov byte [0x5928],0x0
000058C7  C606295900        mov byte [0x5929],0x0
000058CC  C7062A590005      mov word [0x592a],0x500
000058D2  C6062C59FF        mov byte [0x592c],0xff
000058D7  C6062D5900        mov byte [0x592d],0x0
000058DC  C606205900        mov byte [0x5920],0x0
000058E1  C606075B00        mov byte [0x5b07],0x0
000058E6  C706085B0000      mov word [0x5b08],0x0
000058EC  C7060C5B0100      mov word [0x5b0c],0x1
000058F2  C6060E5B01        mov byte [0x5b0e],0x1
000058F7  C3                ret
000058F8  803EBF1C00        cmp byte [0x1cbf],0x0
000058FD  7509              jnz 0x5908
000058FF  BB9003            mov bx,0x390
00005902  B90018            mov cx,0x1800
00005905  E89B00            call 0x59a3
00005908  C6067C1200        mov byte [0x127c],0x0
0000590D  C3                ret
0000590E  803EBF1C00        cmp byte [0x1cbf],0x0
00005913  7509              jnz 0x591e
00005915  BB0004            mov bx,0x400
00005918  B90018            mov cx,0x1800
0000591B  E88500            call 0x59a3
0000591E  C3                ret
0000591F  BBD007            mov bx,0x7d0
00005922  B90018            mov cx,0x1800
00005925  E87B00            call 0x59a3
00005928  BB6E0A            mov bx,0xa6e
0000592B  B90018            mov cx,0x1800
0000592E  E87200            call 0x59a3
00005931  BBEC0D            mov bx,0xdec
00005934  B90018            mov cx,0x1800
00005937  E86900            call 0x59a3
0000593A  C3                ret
0000593B  803E000000        cmp byte [0x0],0x0
00005940  741A              jz 0x595c
00005942  891E2359          mov [0x5923],bx
00005946  50                push ax
00005947  B0B6              mov al,0xb6
00005949  E643              out 0x43,al
0000594B  58                pop ax
0000594C  E83AFF            call 0x5889
0000594F  C606205902        mov byte [0x5920],0x2
00005954  2AE4              sub ah,ah
00005956  CD1A              int 0x1a
00005958  89162159          mov [0x5921],dx
0000595C  C3                ret
0000595D  803E000000        cmp byte [0x0],0x0
00005962  741A              jz 0x597e
00005964  803E205900        cmp byte [0x5920],0x0
00005969  7513              jnz 0x597e
0000596B  E88FD4            call 0x2dfd
0000596E  8BC2              mov ax,dx
00005970  257F00            and ax,0x7f
00005973  05AA00            add ax,0xaa
00005976  8BD8              mov bx,ax
00005978  051E00            add ax,0x1e
0000597B  E8BDFF            call 0x593b
0000597E  C3                ret
0000597F  803E000000        cmp byte [0x0],0x0
00005984  741C              jz 0x59a2
00005986  B80012            mov ax,0x1200
00005989  BB1213            mov bx,0x1312
0000598C  0306085B          add ax,[0x5b08]
00005990  031E085B          add bx,[0x5b08]
00005994  8106085B5E01      add word [0x5b08],0x15e
0000599A  E89EFF            call 0x593b
0000599D  C606075B18        mov byte [0x5b07],0x18
000059A2  C3                ret
000059A3  803E000000        cmp byte [0x0],0x0
000059A8  7420              jz 0x59ca
000059AA  B0B6              mov al,0xb6
000059AC  E643              out 0x43,al
000059AE  8BC3              mov ax,bx
000059B0  E642              out 0x42,al
000059B2  8AC4              mov al,ah
000059B4  E642              out 0x42,al
000059B6  E461              in al,0x61
000059B8  0C03              or al,0x3
000059BA  E661              out 0x61,al
000059BC  803E9706FD        cmp byte [0x697],0xfd
000059C1  7502              jnz 0x59c5
000059C3  D1E9              shr cx,1
000059C5  E2FE              loop 0x59c5
000059C7  E85701            call 0x5b21
000059CA  C3                ret
000059CB  E461              in al,0x61
000059CD  24FE              and al,0xfe
000059CF  E661              out 0x61,al
000059D1  2AE4              sub ah,ah
000059D3  CD1A              int 0x1a
000059D5  8916405A          mov [0x5a40],dx
000059D9  C706425A0000      mov word [0x5a42],0x0
000059DF  A1425A            mov ax,[0x5a42]
000059E2  B106              mov cl,0x6
000059E4  D3E8              shr ax,cl
000059E6  7501              jnz 0x59e9
000059E8  40                inc ax
000059E9  8BC8              mov cx,ax
000059EB  51                push cx
000059EC  2AE4              sub ah,ah
000059EE  CD1A              int 0x1a
000059F0  59                pop cx
000059F1  2B16405A          sub dx,[0x5a40]
000059F5  83FA02            cmp dx,byte +0x2
000059F8  72F1              jc 0x59eb
000059FA  83FA07            cmp dx,byte +0x7
000059FD  7319              jnc 0x5a18
000059FF  E2EA              loop 0x59eb
00005A01  E8F9D3            call 0x2dfd
00005A04  80E202            and dl,0x2
00005A07  22160000          and dl,[0x0]
00005A0B  E461              in al,0x61
00005A0D  32C2              xor al,dl
00005A0F  E661              out 0x61,al
00005A11  8306425A07        add word [0x5a42],byte +0x7
00005A16  EBC7              jmp short 0x59df
00005A18  E80601            call 0x5b21
00005A1B  C3                ret
00005A1C  803E000000        cmp byte [0x0],0x0
00005A21  7411              jz 0x5a34
00005A23  E891B9            call 0x13b7
00005A26  8B1E165A          mov bx,[0x5a16]
00005A2A  2BD8              sub bx,ax
00005A2C  7207              jc 0x5a35
00005A2E  81FB6002          cmp bx,0x260
00005A32  7701              ja 0x5a35
00005A34  C3                ret
00005A35  A3165A            mov [0x5a16],ax
00005A38  B0B6              mov al,0xb6
00005A3A  E643              out 0x43,al
00005A3C  FF06185A          inc word [0x5a18]
00005A40  8B1E185A          mov bx,[0x5a18]
00005A44  81E31E00          and bx,0x1e
00005A48  A13C5A            mov ax,[0x5a3c]
00005A4B  25FF03            and ax,0x3ff
00005A4E  3D8001            cmp ax,0x180
00005A51  7206              jc 0x5a59
00005A53  B98001            mov cx,0x180
00005A56  2BC8              sub cx,ax
00005A58  91                xchg ax,cx
00005A59  D1E8              shr ax,1
00005A5B  D1E8              shr ax,1
00005A5D  03871A5A          add ax,[bx+0x5a1a]
00005A61  BB0100            mov bx,0x1
00005A64  803E9706FD        cmp byte [0x697],0xfd
00005A69  7502              jnz 0x5a6d
00005A6B  D0E3              shl bl,1
00005A6D  011E3E5A          add [0x5a3e],bx
00005A71  D1E3              shl bx,1
00005A73  D1E3              shl bx,1
00005A75  011E3C5A          add [0x5a3c],bx
00005A79  8B163E5A          mov dx,[0x5a3e]
00005A7D  B103              mov cl,0x3
00005A7F  D3EA              shr dx,cl
00005A81  03C2              add ax,dx
00005A83  E642              out 0x42,al
00005A85  8AC4              mov al,ah
00005A87  E642              out 0x42,al
00005A89  E461              in al,0x61
00005A8B  0C03              or al,0x3
00005A8D  E661              out 0x61,al
00005A8F  C3                ret
00005A90  803E000000        cmp byte [0x0],0x0
00005A95  740A              jz 0x5aa1
00005A97  2AE4              sub ah,ah
00005A99  CD1A              int 0x1a
00005A9B  3B16145A          cmp dx,[0x5a14]
00005A9F  7501              jnz 0x5aa2
00005AA1  C3                ret
00005AA2  8916145A          mov [0x5a14],dx
00005AA6  B0B6              mov al,0xb6
00005AA8  E643              out 0x43,al
00005AAA  E850D3            call 0x2dfd
00005AAD  8BC2              mov ax,dx
00005AAF  257000            and ax,0x70
00005AB2  050002            add ax,0x200
00005AB5  E642              out 0x42,al
00005AB7  8AC4              mov al,ah
00005AB9  E642              out 0x42,al
00005ABB  E461              in al,0x61
00005ABD  0C03              or al,0x3
00005ABF  E661              out 0x61,al
00005AC1  C3                ret
00005AC2  C706125A3803      mov word [0x5a12],0x338
00005AC8  2AE4              sub ah,ah
00005ACA  CD1A              int 0x1a
00005ACC  8916105A          mov [0x5a10],dx
00005AD0  E8E4B8            call 0x13b7
00005AD3  A30E5A            mov [0x5a0e],ax
00005AD6  E8DEB8            call 0x13b7
00005AD9  8BD0              mov dx,ax
00005ADB  2B060E5A          sub ax,[0x5a0e]
00005ADF  3D409C            cmp ax,0x9c40
00005AE2  722C              jc 0x5b10
00005AE4  89160E5A          mov [0x5a0e],dx
00005AE8  803E000000        cmp byte [0x0],0x0
00005AED  7421              jz 0x5b10
00005AEF  B0B6              mov al,0xb6
00005AF1  E643              out 0x43,al
00005AF3  E807D3            call 0x2dfd
00005AF6  8BC2              mov ax,dx
00005AF8  25FF07            and ax,0x7ff
00005AFB  0306125A          add ax,[0x5a12]
00005AFF  832E125A02        sub word [0x5a12],byte +0x2
00005B04  E642              out 0x42,al
00005B06  8AC4              mov al,ah
00005B08  E642              out 0x42,al
00005B0A  E461              in al,0x61
00005B0C  0C03              or al,0x3
00005B0E  E661              out 0x61,al
00005B10  2AE4              sub ah,ah
00005B12  CD1A              int 0x1a
00005B14  2B16105A          sub dx,[0x5a10]
00005B18  83FA02            cmp dx,byte +0x2
00005B1B  72B9              jc 0x5ad6
00005B1D  E80100            call 0x5b21
00005B20  C3                ret
00005B21  E461              in al,0x61
00005B23  24FC              and al,0xfc
00005B25  E661              out 0x61,al
00005B27  C3                ret
00005B28  B0B6              mov al,0xb6
00005B2A  E643              out 0x43,al
00005B2C  A12A59            mov ax,[0x592a]
00005B2F  E642              out 0x42,al
00005B31  8AC4              mov al,ah
00005B33  E642              out 0x42,al
00005B35  E461              in al,0x61
00005B37  0C03              or al,0x3
00005B39  E661              out 0x61,al
00005B3B  E879B8            call 0x13b7
00005B3E  8BC8              mov cx,ax
00005B40  E874B8            call 0x13b7
00005B43  8BD1              mov dx,cx
00005B45  2BD0              sub dx,ax
00005B47  3B162E59          cmp dx,[0x592e]
00005B4B  72F3              jc 0x5b40
00005B4D  E461              in al,0x61
00005B4F  24FC              and al,0xfc
00005B51  E661              out 0x61,al
00005B53  C3                ret
00005B54  C706BE590000      mov word [0x59be],0x0
00005B5A  2AE4              sub ah,ah
00005B5C  CD1A              int 0x1a
00005B5E  8916C059          mov [0x59c0],dx
00005B62  C3                ret
00005B63  803E000000        cmp byte [0x0],0x0
00005B68  740F              jz 0x5b79
00005B6A  2AE4              sub ah,ah
00005B6C  CD1A              int 0x1a
00005B6E  8BC2              mov ax,dx
00005B70  2B06C059          sub ax,[0x59c0]
00005B74  3D0200            cmp ax,0x2
00005B77  7301              jnc 0x5b7a
00005B79  C3                ret
00005B7A  8916C059          mov [0x59c0],dx
00005B7E  8B1EBE59          mov bx,[0x59be]
00005B82  81E3FE00          and bx,0xfe
00005B86  81FB8600          cmp bx,0x86
00005B8A  7206              jc 0x5b92
00005B8C  2BDB              sub bx,bx
00005B8E  891EBE59          mov [0x59be],bx
00005B92  8306BE5902        add word [0x59be],byte +0x2
00005B97  8B873459          mov ax,[bx+0x5934]
00005B9B  8B0EBC59          mov cx,[0x59bc]
00005B9F  A3BC59            mov [0x59bc],ax
00005BA2  3BC1              cmp ax,cx
00005BA4  7504              jnz 0x5baa
00005BA6  E878FF            call 0x5b21
00005BA9  C3                ret
00005BAA  8BC8              mov cx,ax
00005BAC  B0B6              mov al,0xb6
00005BAE  E643              out 0x43,al
00005BB0  8BC1              mov ax,cx
00005BB2  E642              out 0x42,al
00005BB4  8AC4              mov al,ah
00005BB6  E642              out 0x42,al
00005BB8  E461              in al,0x61
00005BBA  0C03              or al,0x3
00005BBC  E661              out 0x61,al
00005BBE  C3                ret
00005BBF  803E000000        cmp byte [0x0],0x0
00005BC4  740A              jz 0x5bd0
00005BC6  E89AFF            call 0x5b63
00005BC9  833EBE597C        cmp word [0x59be],byte +0x7c
00005BCE  72EF              jc 0x5bbf
00005BD0  C3                ret
00005BD1  0000              add [bx+si],al
00005BD3  0000              add [bx+si],al
00005BD5  0000              add [bx+si],al
00005BD7  0000              add [bx+si],al
00005BD9  0000              add [bx+si],al
00005BDB  0000              add [bx+si],al
00005BDD  0000              add [bx+si],al
00005BDF  002A              add [bp+si],ch
00005BE1  E4CD              in al,0xcd
00005BE3  1A891666          sbb cl,[bx+di+0x6616]
00005BE7  5F                pop di
00005BE8  C706605F0000      mov word [0x5f60],0x0
00005BEE  B800B8            mov ax,0xb800
00005BF1  8EC0              mov es,ax
00005BF3  8B1E605F          mov bx,[0x5f60]
00005BF7  8306605F02        add word [0x5f60],byte +0x2
00005BFC  81E30200          and bx,0x2
00005C00  8BB7625F          mov si,[bx+0x5f62]
00005C04  BF740A            mov di,0xa74
00005C07  B90444            mov cx,0x4404
00005C0A  E890D1            call 0x2d9d
00005C0D  E8D4FB            call 0x57e4
00005C10  2AE4              sub ah,ah
00005C12  CD1A              int 0x1a
00005C14  8BC2              mov ax,dx
00005C16  2B06665F          sub ax,[0x5f66]
00005C1A  3D0400            cmp ax,0x4
00005C1D  72EE              jc 0x5c0d
00005C1F  8916665F          mov [0x5f66],dx
00005C23  833E605F04        cmp word [0x5f60],byte +0x4
00005C28  750C              jnz 0x5c36
00005C2A  BE685F            mov si,0x5f68
00005C2D  BF6806            mov di,0x668
00005C30  B90410            mov cx,0x1004
00005C33  E867D1            call 0x2d9d
00005C36  8B1E605F          mov bx,[0x5f60]
00005C3A  83EB08            sub bx,byte +0x8
00005C3D  7212              jc 0x5c51
00005C3F  83FB06            cmp bx,byte +0x6
00005C42  730D              jnc 0x5c51
00005C44  BEE85F            mov si,0x5fe8
00005C47  8BBFE460          mov di,[bx+0x60e4]
00005C4B  B90615            mov cx,0x1506
00005C4E  E84CD1            call 0x2d9d
00005C51  833E605F10        cmp word [0x5f60],byte +0x10
00005C56  7296              jc 0x5bee
00005C58  E8C6FE            call 0x5b21
00005C5B  C3                ret
00005C5C  0000              add [bx+si],al
00005C5E  0000              add [bx+si],al
00005C60  CD11              int 0x11
00005C62  2430              and al,0x30
00005C64  3C30              cmp al,0x30
00005C66  752D              jnz 0x5c95
00005C68  B800B8            mov ax,0xb800
00005C6B  8ED8              mov ds,ax
00005C6D  B8AA55            mov ax,0x55aa
00005C70  A30000            mov [0x0],ax
00005C73  A10000            mov ax,[0x0]
00005C76  3DAA55            cmp ax,0x55aa
00005C79  751B              jnz 0x5c96
00005C7B  BEF060            mov si,0x60f0
00005C7E  E81D00            call 0x5c9e
00005C81  B84000            mov ax,0x40
00005C84  8ED8              mov ds,ax
00005C86  A11000            mov ax,[0x10]
00005C89  24CF              and al,0xcf
00005C8B  0C10              or al,0x10
00005C8D  A31000            mov [0x10],ax
00005C90  B80400            mov ax,0x4
00005C93  CD10              int 0x10
00005C95  C3                ret
00005C96  BE1261            mov si,0x6112
00005C99  E80200            call 0x5c9e
00005C9C  EBFE              jmp short 0x5c9c
00005C9E  B81000            mov ax,0x10
00005CA1  8ED8              mov ds,ax
00005CA3  E88501            call 0x5e2b
00005CA6  C3                ret
00005CA7  0000              add [bx+si],al
00005CA9  0000              add [bx+si],al
00005CAB  0000              add [bx+si],al
00005CAD  0000              add [bx+si],al
00005CAF  00FC              add ah,bh
00005CB1  C70604000000      mov word [0x4],0x0
00005CB7  E876BB            call 0x1830
00005CBA  E873C6            call 0x2330
00005CBD  E870CD            call 0x2a30
00005CC0  B800B8            mov ax,0xb800
00005CC3  8EC0              mov es,ax
00005CC5  BE5261            mov si,0x6152
00005CC8  B90B1D            mov cx,0x1d0b
00005CCB  BFBD00            mov di,0xbd
00005CCE  E8CCD0            call 0x2d9d
00005CD1  BED063            mov si,0x63d0
00005CD4  B90E16            mov cx,0x160e
00005CD7  BF9E06            mov di,0x69e
00005CDA  E8C0D0            call 0x2d9d
00005CDD  BE3866            mov si,0x6638
00005CE0  B9030C            mov cx,0xc03
00005CE3  BF780A            mov di,0xa78
00005CE6  E8B4D0            call 0x2d9d
00005CE9  BE8066            mov si,0x6680
00005CEC  B90E08            mov cx,0x80e
00005CEF  BFA80C            mov di,0xca8
00005CF2  E8A8D0            call 0x2d9d
00005CF5  BE6067            mov si,0x6760
00005CF8  B90C0B            mov cx,0xb0c
00005CFB  BF6E1D            mov di,0x1d6e
00005CFE  E89CD0            call 0x2d9d
00005D01  BE6868            mov si,0x6868
00005D04  B90408            mov cx,0x804
00005D07  BFEC1D            mov di,0x1dec
00005D0A  E890D0            call 0x2d9d
00005D0D  C7068D6A0000      mov word [0x6a8d],0x0
00005D13  E82501            call 0x5e3b
00005D16  C70679050000      mov word [0x579],0x0
00005D1C  E8EEA9            call 0x70d
00005D1F  C6067B0560        mov byte [0x57b],0x60
00005D24  C6067C0592        mov byte [0x57c],0x92
00005D29  E8C6C9            call 0x26f2
00005D2C  E8CDC9            call 0x26fc
00005D2F  C606801F09        mov byte [0x1f80],0x9
00005D34  C606811FFF        mov byte [0x1f81],0xff
00005D39  E877C9            call 0x26b3
00005D3C  E801C1            call 0x1e40
00005D3F  C606980600        mov byte [0x698],0x0
00005D44  C606990600        mov byte [0x699],0x0
00005D49  C6068A6A00        mov byte [0x6a8a],0x0
00005D4E  A19306            mov ax,[0x693]
00005D51  A35061            mov [0x6150],ax
00005D54  2AE4              sub ah,ah
00005D56  CD1A              int 0x1a
00005D58  89168B6A          mov [0x6a8b],dx
00005D5C  89162253          mov [0x5322],dx
00005D60  8916936A          mov [0x6a93],dx
00005D64  83EA30            sub dx,byte +0x30
00005D67  8916886A          mov [0x6a88],dx
00005D6B  C70620530000      mov word [0x5320],0x0
00005D71  2AE4              sub ah,ah
00005D73  CD1A              int 0x1a
00005D75  8BC2              mov ax,dx
00005D77  2B06936A          sub ax,[0x6a93]
00005D7B  3D2400            cmp ax,0x24
00005D7E  7209              jc 0x5d89
00005D80  8916936A          mov [0x6a93],dx
00005D84  52                push dx
00005D85  E8B300            call 0x5e3b
00005D88  5A                pop dx
00005D89  2B168B6A          sub dx,[0x6a8b]
00005D8D  A1DA56            mov ax,[0x56da]
00005D90  803E1A0400        cmp byte [0x41a],0x0
00005D95  7409              jz 0x5da0
00005D97  054800            add ax,0x48
00005D9A  3BD0              cmp dx,ax
00005D9C  73B6              jnc 0x5d54
00005D9E  EB07              jmp short 0x5da7
00005DA0  050600            add ax,0x6
00005DA3  3BD0              cmp dx,ax
00005DA5  772C              ja 0x5dd3
00005DA7  E806F6            call 0x53b0
00005DAA  E82700            call 0x5dd4
00005DAD  803E9B0600        cmp byte [0x69b],0x0
00005DB2  7416              jz 0x5dca
00005DB4  BA0102            mov dx,0x201
00005DB7  EC                in al,dx
00005DB8  2410              and al,0x10
00005DBA  7407              jz 0x5dc3
00005DBC  C6068A6A01        mov byte [0x6a8a],0x1
00005DC1  EB07              jmp short 0x5dca
00005DC3  803E8A6A00        cmp byte [0x6a8a],0x0
00005DC8  7509              jnz 0x5dd3
00005DCA  A15061            mov ax,[0x6150]
00005DCD  3B069306          cmp ax,[0x693]
00005DD1  749E              jz 0x5d71
00005DD3  C3                ret
00005DD4  833E790520        cmp word [0x579],byte +0x20
00005DD9  7707              ja 0x5de2
00005DDB  C606980601        mov byte [0x698],0x1
00005DE0  EB3A              jmp short 0x5e1c
00005DE2  813E79052001      cmp word [0x579],0x120
00005DE8  7207              jc 0x5df1
00005DEA  C6069806FF        mov byte [0x698],0xff
00005DEF  EB2B              jmp short 0x5e1c
00005DF1  2AE4              sub ah,ah
00005DF3  CD1A              int 0x1a
00005DF5  8BC2              mov ax,dx
00005DF7  2B06886A          sub ax,[0x6a88]
00005DFB  3D1200            cmp ax,0x12
00005DFE  721C              jc 0x5e1c
00005E00  8916886A          mov [0x6a88],dx
00005E04  E8F6CF            call 0x2dfd
00005E07  C606980600        mov byte [0x698],0x0
00005E0C  80FAA0            cmp dl,0xa0
00005E0F  770B              ja 0x5e1c
00005E11  80E201            and dl,0x1
00005E14  7502              jnz 0x5e18
00005E16  B2FF              mov dl,0xff
00005E18  88169806          mov [0x698],dl
00005E1C  E8B9B5            call 0x13d8
00005E1F  7409              jz 0x5e2a
00005E21  C70672050400      mov word [0x572],0x4
00005E27  E8BBAA            call 0x8e5
00005E2A  C3                ret
00005E2B  AC                lodsb
00005E2C  3C00              cmp al,0x0
00005E2E  740A              jz 0x5e3a
00005E30  56                push si
00005E31  B302              mov bl,0x2
00005E33  B40E              mov ah,0xe
00005E35  CD10              int 0x10
00005E37  5E                pop si
00005E38  EBF1              jmp short 0x5e2b
00005E3A  C3                ret
00005E3B  B800B8            mov ax,0xb800
00005E3E  8EC0              mov es,ax
00005E40  83068D6A02        add word [0x6a8d],byte +0x2
00005E45  8B1E8D6A          mov bx,[0x6a8d]
00005E49  81E30200          and bx,0x2
00005E4D  8BB78F6A          mov si,[bx+0x6a8f]
00005E51  B90A0C            mov cx,0xc0a
00005E54  BF381D            mov di,0x1d38
00005E57  E843CF            call 0x2d9d
00005E5A  C3                ret
00005E5B  B200              mov dl,0x0
00005E5D  8AFA              mov bh,dl
00005E5F  B402              mov ah,0x2
00005E61  CD10              int 0x10
00005E63  C3                ret
00005E64  0000              add [bx+si],al
00005E66  0000              add [bx+si],al
00005E68  0000              add [bx+si],al
00005E6A  0000              add [bx+si],al
00005E6C  0000              add [bx+si],al
00005E6E  0000              add [bx+si],al
00005E70  E8AEFC            call 0x5b21
00005E73  2AE4              sub ah,ah
00005E75  CD1A              int 0x1a
00005E77  8916FC6D          mov [0x6dfc],dx
00005E7B  890EFE6D          mov [0x6dfe],cx
00005E7F  1E                push ds
00005E80  1E                push ds
00005E81  07                pop es
00005E82  B800B8            mov ax,0xb800
00005E85  8ED8              mov ds,ax
00005E87  BECA0D            mov si,0xdca
00005E8A  BF0E00            mov di,0xe
00005E8D  B92010            mov cx,0x1020
00005E90  E837CF            call 0x2dca
00005E93  1F                pop ds
00005E94  BA050B            mov dx,0xb05
00005E97  B700              mov bh,0x0
00005E99  B402              mov ah,0x2
00005E9B  CD10              int 0x10
00005E9D  BE916D            mov si,0x6d91
00005EA0  FC                cld
00005EA1  E887FF            call 0x5e2b
00005EA4  BA050C            mov dx,0xc05
00005EA7  B700              mov bh,0x0
00005EA9  B402              mov ah,0x2
00005EAB  CD10              int 0x10
00005EAD  BEB26D            mov si,0x6db2
00005EB0  803E9B0600        cmp byte [0x69b],0x0
00005EB5  7403              jz 0x5eba
00005EB7  BED36D            mov si,0x6dd3
00005EBA  FC                cld
00005EBB  E86DFF            call 0x5e2b
00005EBE  E8D600            call 0x5f97
00005EC1  B800B8            mov ax,0xb800
00005EC4  8EC0              mov es,ax
00005EC6  BE0E00            mov si,0xe
00005EC9  BFCA0D            mov di,0xdca
00005ECC  B92010            mov cx,0x1020
00005ECF  E8CBCE            call 0x2d9d
00005ED2  B401              mov ah,0x1
00005ED4  8B0EFE6D          mov cx,[0x6dfe]
00005ED8  8B16FC6D          mov dx,[0x6dfc]
00005EDC  CD1A              int 0x1a
00005EDE  A19306            mov ax,[0x693]
00005EE1  A3006E            mov [0x6e00],ax
00005EE4  C3                ret
00005EE5  E839FC            call 0x5b21
00005EE8  E8E200            call 0x5fcd
00005EEB  C7068F6D0000      mov word [0x6d8f],0x0
00005EF1  E8BD00            call 0x5fb1
00005EF4  A19306            mov ax,[0x693]
00005EF7  3B069306          cmp ax,[0x693]
00005EFB  74FA              jz 0x5ef7
00005EFD  F606C10680        test byte [0x6c1],0x80
00005F02  740E              jz 0x5f12
00005F04  F606C20680        test byte [0x6c2],0x80
00005F09  75E9              jnz 0x5ef4
00005F0B  C6069B0600        mov byte [0x69b],0x0
00005F10  EB0A              jmp short 0x5f1c
00005F12  E8D000            call 0x5fe5
00005F15  72D1              jc 0x5ee8
00005F17  C6069B0601        mov byte [0x69b],0x1
00005F1C  B90500            mov cx,0x5
00005F1F  51                push cx
00005F20  E88E00            call 0x5fb1
00005F23  59                pop cx
00005F24  E2F9              loop 0x5f1f
00005F26  A19306            mov ax,[0x693]
00005F29  3B069306          cmp ax,[0x693]
00005F2D  74FA              jz 0x5f29
00005F2F  2BC0              sub ax,ax
00005F31  F606C30680        test byte [0x6c3],0x80
00005F36  7418              jz 0x5f50
00005F38  40                inc ax
00005F39  F606C40680        test byte [0x6c4],0x80
00005F3E  7410              jz 0x5f50
00005F40  40                inc ax
00005F41  F606C50680        test byte [0x6c5],0x80
00005F46  7408              jz 0x5f50
00005F48  40                inc ax
00005F49  F606C60680        test byte [0x6c6],0x80
00005F4E  75D6              jnz 0x5f26
00005F50  A3F86D            mov [0x6df8],ax
00005F53  B90500            mov cx,0x5
00005F56  51                push cx
00005F57  E85700            call 0x5fb1
00005F5A  59                pop cx
00005F5B  E2F9              loop 0x5f56
00005F5D  803E9B0600        cmp byte [0x69b],0x0
00005F62  741A              jz 0x5f7e
00005F64  C7068F6D2000      mov word [0x6d8f],0x20
00005F6A  E84400            call 0x5fb1
00005F6D  E84100            call 0x5fb1
00005F70  C7068F6D1800      mov word [0x6d8f],0x18
00005F76  E83800            call 0x5fb1
00005F79  E83500            call 0x5fb1
00005F7C  EB15              jmp short 0x5f93
00005F7E  C7068F6D1C00      mov word [0x6d8f],0x1c
00005F84  E82A00            call 0x5fb1
00005F87  E82700            call 0x5fb1
00005F8A  C7068F6D1600      mov word [0x6d8f],0x16
00005F90  E81E00            call 0x5fb1
00005F93  E80100            call 0x5f97
00005F96  C3                ret
00005F97  803E9B0600        cmp byte [0x69b],0x0
00005F9C  7409              jz 0x5fa7
00005F9E  BA0102            mov dx,0x201
00005FA1  EC                in al,dx
00005FA2  2410              and al,0x10
00005FA4  75F8              jnz 0x5f9e
00005FA6  C3                ret
00005FA7  A19306            mov ax,[0x693]
00005FAA  3B069306          cmp ax,[0x693]
00005FAE  74FA              jz 0x5faa
00005FB0  C3                ret
00005FB1  8B1E8F6D          mov bx,[0x6d8f]
00005FB5  8B97636D          mov dx,[bx+0x6d63]
00005FB9  E89FFE            call 0x5e5b
00005FBC  8B1E8F6D          mov bx,[0x6d8f]
00005FC0  83068F6D02        add word [0x6d8f],byte +0x2
00005FC5  8BB7376D          mov si,[bx+0x6d37]
00005FC9  E85FFE            call 0x5e2b
00005FCC  C3                ret
00005FCD  FC                cld
00005FCE  B800B8            mov ax,0xb800
00005FD1  8EC0              mov es,ax
00005FD3  2BC0              sub ax,ax
00005FD5  8BF8              mov di,ax
00005FD7  B9A00F            mov cx,0xfa0
00005FDA  F3AB              rep stosw
00005FDC  BF0020            mov di,0x2000
00005FDF  B9A00F            mov cx,0xfa0
00005FE2  F3AB              rep stosw
00005FE4  C3                ret
00005FE5  CD11              int 0x11
00005FE7  A90010            test ax,0x1000
00005FEA  740A              jz 0x5ff6
00005FEC  E82000            call 0x600f
00005FEF  731D              jnc 0x600e
00005FF1  E81B00            call 0x600f
00005FF4  7318              jnc 0x600e
00005FF6  C7068F6D2400      mov word [0x6d8f],0x24
00005FFC  B90400            mov cx,0x4
00005FFF  E8AFFF            call 0x5fb1
00006002  E2FB              loop 0x5fff
00006004  A19306            mov ax,[0x693]
00006007  3B069306          cmp ax,[0x693]
0000600B  74FA              jz 0x6007
0000600D  F9                stc
0000600E  C3                ret
0000600F  BA0102            mov dx,0x201
00006012  EE                out dx,al
00006013  2AE4              sub ah,ah
00006015  CD1A              int 0x1a
00006017  8916FA6D          mov [0x6dfa],dx
0000601B  BA0102            mov dx,0x201
0000601E  EC                in al,dx
0000601F  A803              test al,0x3
00006021  7502              jnz 0x6025
00006023  F8                clc
00006024  C3                ret
00006025  2AE4              sub ah,ah
00006027  CD1A              int 0x1a
00006029  2B16FA6D          sub dx,[0x6dfa]
0000602D  83FA12            cmp dx,byte +0x12
00006030  72E9              jc 0x601b
00006032  F9                stc
00006033  C3                ret
00006034  0000              add [bx+si],al
00006036  0000              add [bx+si],al
00006038  0000              add [bx+si],al
0000603A  0000              add [bx+si],al
0000603C  0000              add [bx+si],al
0000603E  0000              add [bx+si],al
00006040  FC                cld
00006041  1E                push ds
00006042  07                pop es
00006043  BF0E00            mov di,0xe
00006046  B92400            mov cx,0x24
00006049  2BC0              sub ax,ax
0000604B  F3AB              rep stosw
0000604D  C706246F2500      mov word [0x6f24],0x25
00006053  B800B8            mov ax,0xb800
00006056  8EC0              mov es,ax
00006058  E87DB3            call 0x13d8
0000605B  74FB              jz 0x6058
0000605D  BE0E00            mov si,0xe
00006060  8B3E246F          mov di,[0x6f24]
00006064  B9030C            mov cx,0xc03
00006067  E833CD            call 0x2d9d
0000606A  8106246FE001      add word [0x6f24],0x1e0
00006070  BE106E            mov si,0x6e10
00006073  8B3E246F          mov di,[0x6f24]
00006077  B9030C            mov cx,0xc03
0000607A  E820CD            call 0x2d9d
0000607D  2AE4              sub ah,ah
0000607F  CD1A              int 0x1a
00006081  3B16266F          cmp dx,[0x6f26]
00006085  74F6              jz 0x607d
00006087  8916266F          mov [0x6f26],dx
0000608B  803E000000        cmp byte [0x0],0x0
00006090  7415              jz 0x60a7
00006092  B0B6              mov al,0xb6
00006094  E643              out 0x43,al
00006096  A1246F            mov ax,[0x6f24]
00006099  D1E8              shr ax,1
0000609B  E642              out 0x42,al
0000609D  8AC4              mov al,ah
0000609F  E642              out 0x42,al
000060A1  E461              in al,0x61
000060A3  0C03              or al,0x3
000060A5  E661              out 0x61,al
000060A7  813E246F401A      cmp word [0x6f24],0x1a40
000060AD  72A9              jc 0x6058
000060AF  BE586E            mov si,0x6e58
000060B2  8B3E246F          mov di,[0x6f24]
000060B6  B90611            mov cx,0x1106
000060B9  E8E1CC            call 0x2d9d
000060BC  2AE4              sub ah,ah
000060BE  CD1A              int 0x1a
000060C0  3B16286F          cmp dx,[0x6f28]
000060C4  74F6              jz 0x60bc
000060C6  8916286F          mov [0x6f28],dx
000060CA  803E000000        cmp byte [0x0],0x0
000060CF  7415              jz 0x60e6
000060D1  B0B6              mov al,0xb6
000060D3  E643              out 0x43,al
000060D5  B8000C            mov ax,0xc00
000060D8  F6C201            test dl,0x1
000060DB  7403              jz 0x60e0
000060DD  B8540B            mov ax,0xb54
000060E0  E642              out 0x42,al
000060E2  8AC4              mov al,ah
000060E4  E642              out 0x42,al
000060E6  2B16266F          sub dx,[0x6f26]
000060EA  83FA12            cmp dx,byte +0x12
000060ED  72CD              jc 0x60bc
000060EF  E82FFA            call 0x5b21
000060F2  C3                ret
000060F3  0000              add [bx+si],al
000060F5  0000              add [bx+si],al
000060F7  0000              add [bx+si],al
000060F9  0000              add [bx+si],al
000060FB  0000              add [bx+si],al
000060FD  0000              add [bx+si],al
000060FF  00C6              add dh,al
00006101  06                push es
00006102  F27000            bnd jo 0x6105
00006105  C3                ret
00006106  2AE4              sub ah,ah
00006108  CD1A              int 0x1a
0000610A  3B16EE70          cmp dx,[0x70ee]
0000610E  7501              jnz 0x6111
00006110  C3                ret
00006111  8916EE70          mov [0x70ee],dx
00006115  E88E01            call 0x62a6
00006118  730F              jnc 0x6129
0000611A  E8C6B0            call 0x11e3
0000611D  E80B01            call 0x622b
00006120  E822B0            call 0x1145
00006123  C606F27000        mov byte [0x70f2],0x0
00006128  C3                ret
00006129  803EF27000        cmp byte [0x70f2],0x0
0000612E  756E              jnz 0x619e
00006130  E8CACC            call 0x2dfd
00006133  8BDA              mov bx,dx
00006135  81E31F00          and bx,0x1f
00006139  80FB10            cmp bl,0x10
0000613C  7228              jc 0x6166
0000613E  80EB10            sub bl,0x10
00006141  80FB09            cmp bl,0x9
00006144  77EA              ja 0x6130
00006146  B201              mov dl,0x1
00006148  80FB05            cmp bl,0x5
0000614B  7202              jc 0x614f
0000614D  B2FF              mov dl,0xff
0000614F  8816F670          mov [0x70f6],dl
00006153  C606F57006        mov byte [0x70f5],0x6
00006158  D0E3              shl bl,1
0000615A  8B87B870          mov ax,[bx+0x70b8]
0000615E  050400            add ax,0x4
00006161  A3F370            mov [0x70f3],ax
00006164  EB22              jmp short 0x6188
00006166  B80C00            mov ax,0xc
00006169  B201              mov dl,0x1
0000616B  F6C308            test bl,0x8
0000616E  7405              jz 0x6175
00006170  B82001            mov ax,0x120
00006173  B2FF              mov dl,0xff
00006175  A3F370            mov [0x70f3],ax
00006178  8816F670          mov [0x70f6],dl
0000617C  80E307            and bl,0x7
0000617F  8A87B070          mov al,[bx+0x70b0]
00006183  0408              add al,0x8
00006185  A2F570            mov [0x70f5],al
00006188  C606F27001        mov byte [0x70f2],0x1
0000618D  C606F77001        mov byte [0x70f7],0x1
00006192  C706F0700000      mov word [0x70f0],0x0
00006198  C706EC70FFFF      mov word [0x70ec],0xffff
0000619E  813EF070A000      cmp word [0x70f0],0xa0
000061A4  7305              jnc 0x61ab
000061A6  8306F07004        add word [0x70f0],byte +0x4
000061AB  8006F57002        add byte [0x70f5],0x2
000061B0  803EF570BF        cmp byte [0x70f5],0xbf
000061B5  771D              ja 0x61d4
000061B7  803EF67001        cmp byte [0x70f6],0x1
000061BC  7409              jz 0x61c7
000061BE  832EF37005        sub word [0x70f3],byte +0x5
000061C3  720F              jc 0x61d4
000061C5  EB16              jmp short 0x61dd
000061C7  8306F37005        add word [0x70f3],byte +0x5
000061CC  813EF3702C01      cmp word [0x70f3],0x12c
000061D2  7209              jc 0x61dd
000061D4  C606F27000        mov byte [0x70f2],0x0
000061D9  E84F00            call 0x622b
000061DC  C3                ret
000061DD  8B0EF370          mov cx,[0x70f3]
000061E1  8A16F570          mov dl,[0x70f5]
000061E5  E8C8CA            call 0x2cb0
000061E8  A3FA70            mov [0x70fa],ax
000061EB  E8B800            call 0x62a6
000061EE  72E4              jc 0x61d4
000061F0  E85200            call 0x6245
000061F3  E83500            call 0x622b
000061F6  E80100            call 0x61fa
000061F9  C3                ret
000061FA  B800B8            mov ax,0xb800
000061FD  8EC0              mov es,ax
000061FF  C606F77000        mov byte [0x70f7],0x0
00006204  A1F070            mov ax,[0x70f0]
00006207  25E001            and ax,0x1e0
0000620A  05306F            add ax,0x6f30
0000620D  803EF670FF        cmp byte [0x70f6],0xff
00006212  7403              jz 0x6217
00006214  05C000            add ax,0xc0
00006217  8BF0              mov si,ax
00006219  8B3EFA70          mov di,[0x70fa]
0000621D  893EF870          mov [0x70f8],di
00006221  BDCC70            mov bp,0x70cc
00006224  B90208            mov cx,0x802
00006227  E8A2CA            call 0x2ccc
0000622A  C3                ret
0000622B  803EF77000        cmp byte [0x70f7],0x0
00006230  7512              jnz 0x6244
00006232  B800B8            mov ax,0xb800
00006235  8EC0              mov es,ax
00006237  BECC70            mov si,0x70cc
0000623A  8B3EF870          mov di,[0x70f8]
0000623E  B90208            mov cx,0x802
00006241  E859CB            call 0x2d9d
00006244  C3                ret
00006245  A0F570            mov al,[0x70f5]
00006248  2C08              sub al,0x8
0000624A  24F8              and al,0xf8
0000624C  B90700            mov cx,0x7
0000624F  8BD9              mov bx,cx
00006251  4B                dec bx
00006252  3A87D42B          cmp al,[bx+0x2bd4]
00006256  7403              jz 0x625b
00006258  E2F5              loop 0x624f
0000625A  C3                ret
0000625B  A1F370            mov ax,[0x70f3]
0000625E  B104              mov cl,0x4
00006260  D3E8              shr ax,cl
00006262  2D0200            sub ax,0x2
00006265  72F3              jc 0x625a
00006267  3D1000            cmp ax,0x10
0000626A  73EE              jnc 0x625a
0000626C  8BF8              mov di,ax
0000626E  8A97DB2B          mov dl,[bx+0x2bdb]
00006272  2AF6              sub dh,dh
00006274  03C2              add ax,dx
00006276  3B06EC70          cmp ax,[0x70ec]
0000627A  74DE              jz 0x625a
0000627C  A3EC70            mov [0x70ec],ax
0000627F  8BF0              mov si,ax
00006281  80B4E22B02        xor byte [si+0x2be2],0x2
00006286  8A84E22B          mov al,[si+0x2be2]
0000628A  2AE4              sub ah,ah
0000628C  D1E7              shl di,1
0000628E  8B8DFC70          mov cx,[di+0x70fc]
00006292  8A972071          mov dl,[bx+0x7120]
00006296  50                push ax
00006297  51                push cx
00006298  52                push dx
00006299  E88FFF            call 0x622b
0000629C  5A                pop dx
0000629D  59                pop cx
0000629E  5B                pop bx
0000629F  E841CE            call 0x30e3
000062A2  E855FF            call 0x61fa
000062A5  C3                ret
000062A6  803EF27000        cmp byte [0x70f2],0x0
000062AB  7502              jnz 0x62af
000062AD  F8                clc
000062AE  C3                ret
000062AF  A1F370            mov ax,[0x70f3]
000062B2  8A16F570          mov dl,[0x70f5]
000062B6  BE1000            mov si,0x10
000062B9  8B1E7905          mov bx,[0x579]
000062BD  8A367B05          mov dh,[0x57b]
000062C1  BF1800            mov di,0x18
000062C4  B9080E            mov cx,0xe08
000062C7  E85FCB            call 0x2e29
000062CA  731E              jnc 0x62ea
000062CC  C606710501        mov byte [0x571],0x1
000062D1  C606760502        mov byte [0x576],0x2
000062D6  C606780520        mov byte [0x578],0x20
000062DB  C6065B0508        mov byte [0x55b],0x8
000062E0  B81D09            mov ax,0x91d
000062E3  BBE40C            mov bx,0xce4
000062E6  E852F6            call 0x593b
000062E9  F9                stc
000062EA  C3                ret
