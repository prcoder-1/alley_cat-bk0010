import pickle, sys
from PIL import Image, ImageDraw
DS=open('cat_data.bin','rb').read()
PAL=[(255,0,255),(0,200,200),(160,0,160),(255,255,255)]   # фон 0 рисуем ярко-розовым
PAL=[(0,0,0),(85,255,255),(255,85,255),(255,255,255)]
def sprite(addr, rows, wbytes, stride=None):
    stride = stride or wbytes
    im=Image.new('RGB',(wbytes*4,rows))
    for r in range(rows):
        for b in range(wbytes):
            v=DS[addr+r*stride+b]
            for p in range(4):
                im.putpixel((b*4+p,r),PAL[(v>>(6-2*p))&3])
    return im
def atlas(items, out, scale=3, cols=8):
    cells=[]
    for (a,rows,wb,label) in items:
        im=sprite(a,rows,wb).resize((wb*4*scale,rows*scale),Image.NEAREST)
        cells.append((im,label))
    cw=max(c[0].width for c in cells)+8; ch=max(c[0].height for c in cells)+14
    W=cols*cw; H=((len(cells)+cols-1)//cols)*ch
    m=Image.new('RGB',(W,H),(60,60,60)); d=ImageDraw.Draw(m)
    for i,(im,l) in enumerate(cells):
        x=(i%cols)*cw; y=(i//cols)*ch
        m.paste(im,(x+4,y+12)); d.text((x+2,y),l,fill=(255,255,0))
    m.save(out)
if __name__=='__main__':
    bl,_=pickle.load(open('trace.pkl','rb'))
    items=[]; seen=set()
    for k in sorted(bl, key=lambda k:abs(k[1])):
        kind,si,cx=k
        if si<0 or kind=='LIST' or kind=='OR' or si<0x60: continue
        rows,words=cx>>8,cx&0xFF
        key=(si,rows,words)
        if key in seen: continue
        seen.add(key)
        items.append((si,rows,words*2 if kind!='LIN' else words*2,'%s %04X %dx%d'%(kind[0],si,words*8,rows)))
    atlas(items, sys.argv[1] if len(sys.argv)>1 else '/tmp/atlas.png')
    print(len(items))
