# Сколько итераций главного цикла двора делает PC 4,77 МГц за тик BIOS
from pcemu import *
pc = PC(tick_insns=10**9)   # тики даёт модель тактов, а не счёт инструкций
cm = CycleModel(pc)
TICK = 262144
def run_cycles(n):
    end = cm.cycles + n
    while cm.cycles < end:
        before = cm.cycles
        pc.run(200)
        # тики по тактам
        while cm.cycles - pc_tick[0] >= TICK:
            pc_tick[0] += TICK; pc.ticks += 1
            pc.mu.mem_write(0x46C, pc.ticks.to_bytes(4,'little'))
            if pc.key_queue and (pc.r(UC_X86_REG_FLAGS) & 0x200):
                pc.port60 = pc.key_queue.pop(0); pc.raise_int(9)
pc_tick=[0]
base=pc.cs0*16
cnt={'loop':0,'cat':0,'catupd':0,'rope':0}
ON=[False]
def h(mu,a,s,u):
    if ON[0]: cnt[u]+=1
pc.mu.hook_add(UC_HOOK_CODE,h,'loop',base+0x155,base+0x155)
pc.mu.hook_add(UC_HOOK_CODE,h,'catupd',base+0x926,base+0x926)
pc.mu.hook_add(UC_HOOK_CODE,h,'rope',base+0x5D0,base+0x5D0)
def ticks(t): run_cycles(int(t*TICK))
ticks(40); pc.key_queue.append(0x39); ticks(3); pc.key_queue.append(0xB9); ticks(10)
for k in (0x31,0x23,0x39):
    pc.key_queue.append(k); ticks(3); pc.key_queue.append(k|0x80); ticks(10)
ticks(30)
ON[0]=True
t0=pc.ticks; ticks(100)
print('idle: per tick loop=%.1f catupd=%.2f rope steps=%.2f'%(cnt['loop']/100,cnt['catupd']/100,cnt['rope']/100))
for k in cnt: cnt[k]=0
pc.key_queue.append(0x4D); ticks(60)
print('walking right: per tick loop=%.1f catupd=%.2f rope=%.2f'%(cnt['loop']/60,cnt['catupd']/60,cnt['rope']/60), 'catX',pc.dsw(0x579))
