from pcemu import *
pc = PC()
pc.run_ticks(40); pc.key(0x39); pc.run_ticks(10); pc.key(0x31); pc.run_ticks(10); pc.key(0x23); pc.run_ticks(10); pc.key(0x39)
for i in range(10):
    pc.run_ticks(5)
    print(pc.ticks, 'iter',pc.dsb(0x40f), 'cs:ip %04X:%04X'%(pc.r(UC_X86_REG_CS),pc.r(UC_X86_REG_IP)), 'sp %04X'%pc.r(UC_X86_REG_SP))
