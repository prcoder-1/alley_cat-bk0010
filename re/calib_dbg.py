exec(open('calib.py').read().split("base=pc.cs0")[0])
print('ticks',pc.ticks,'cycles',cm.cycles,'state',pc.dsw(4),'IP %04X:%04X'%(pc.r(UC_X86_REG_CS),pc.r(UC_X86_REG_IP)),'41a',pc.dsb(0x41a))
pc.screenshot(OUT+'/c.png')
