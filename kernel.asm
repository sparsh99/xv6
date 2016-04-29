
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4 0f                	in     $0xf,%al

8010000c <entry>:
8010000c:	0f 20 e0             	mov    %cr4,%eax
8010000f:	83 c8 10             	or     $0x10,%eax
80100012:	0f 22 e0             	mov    %eax,%cr4
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
8010001a:	0f 22 d8             	mov    %eax,%cr3
8010001d:	0f 20 c0             	mov    %cr0,%eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
80100025:	0f 22 c0             	mov    %eax,%cr0
80100028:	bc 50 c6 10 80       	mov    $0x8010c650,%esp
8010002d:	b8 28 38 10 80       	mov    $0x80103828,%eax
80100032:	ff e0                	jmp    *%eax

80100034 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100034:	55                   	push   %ebp
80100035:	89 e5                	mov    %esp,%ebp
80100037:	83 ec 28             	sub    $0x28,%esp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
8010003a:	c7 44 24 04 bc 84 10 	movl   $0x801084bc,0x4(%esp)
80100041:	80 
80100042:	c7 04 24 60 c6 10 80 	movl   $0x8010c660,(%esp)
80100049:	e8 28 4f 00 00       	call   80104f76 <initlock>

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
8010004e:	c7 05 70 05 11 80 64 	movl   $0x80110564,0x80110570
80100055:	05 11 80 
  bcache.head.next = &bcache.head;
80100058:	c7 05 74 05 11 80 64 	movl   $0x80110564,0x80110574
8010005f:	05 11 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100062:	c7 45 f4 94 c6 10 80 	movl   $0x8010c694,-0xc(%ebp)
80100069:	eb 3a                	jmp    801000a5 <binit+0x71>
    b->next = bcache.head.next;
8010006b:	8b 15 74 05 11 80    	mov    0x80110574,%edx
80100071:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100074:	89 50 10             	mov    %edx,0x10(%eax)
    b->prev = &bcache.head;
80100077:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010007a:	c7 40 0c 64 05 11 80 	movl   $0x80110564,0xc(%eax)
    b->dev = -1;
80100081:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100084:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
    bcache.head.next->prev = b;
8010008b:	a1 74 05 11 80       	mov    0x80110574,%eax
80100090:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100093:	89 50 0c             	mov    %edx,0xc(%eax)
    bcache.head.next = b;
80100096:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100099:	a3 74 05 11 80       	mov    %eax,0x80110574

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
8010009e:	81 45 f4 18 02 00 00 	addl   $0x218,-0xc(%ebp)
801000a5:	81 7d f4 64 05 11 80 	cmpl   $0x80110564,-0xc(%ebp)
801000ac:	72 bd                	jb     8010006b <binit+0x37>
    b->prev = &bcache.head;
    b->dev = -1;
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
}
801000ae:	c9                   	leave  
801000af:	c3                   	ret    

801000b0 <bget>:
// Look through buffer cache for block on device dev.
// If not found, allocate a buffer.
// In either case, return B_BUSY buffer.
static struct buf*
bget(uint dev, uint blockno)
{
801000b0:	55                   	push   %ebp
801000b1:	89 e5                	mov    %esp,%ebp
801000b3:	83 ec 28             	sub    $0x28,%esp
  struct buf *b;

  acquire(&bcache.lock);
801000b6:	c7 04 24 60 c6 10 80 	movl   $0x8010c660,(%esp)
801000bd:	e8 d6 4e 00 00       	call   80104f98 <acquire>

 loop:
  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000c2:	a1 74 05 11 80       	mov    0x80110574,%eax
801000c7:	89 45 f4             	mov    %eax,-0xc(%ebp)
801000ca:	eb 63                	jmp    8010012f <bget+0x7f>
    if(b->dev == dev && b->blockno == blockno){
801000cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000cf:	8b 40 04             	mov    0x4(%eax),%eax
801000d2:	3b 45 08             	cmp    0x8(%ebp),%eax
801000d5:	75 4f                	jne    80100126 <bget+0x76>
801000d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000da:	8b 40 08             	mov    0x8(%eax),%eax
801000dd:	3b 45 0c             	cmp    0xc(%ebp),%eax
801000e0:	75 44                	jne    80100126 <bget+0x76>
      if(!(b->flags & B_BUSY)){
801000e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000e5:	8b 00                	mov    (%eax),%eax
801000e7:	83 e0 01             	and    $0x1,%eax
801000ea:	85 c0                	test   %eax,%eax
801000ec:	75 23                	jne    80100111 <bget+0x61>
        b->flags |= B_BUSY;
801000ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000f1:	8b 00                	mov    (%eax),%eax
801000f3:	83 c8 01             	or     $0x1,%eax
801000f6:	89 c2                	mov    %eax,%edx
801000f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000fb:	89 10                	mov    %edx,(%eax)
        release(&bcache.lock);
801000fd:	c7 04 24 60 c6 10 80 	movl   $0x8010c660,(%esp)
80100104:	e8 f6 4e 00 00       	call   80104fff <release>
        return b;
80100109:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010010c:	e9 93 00 00 00       	jmp    801001a4 <bget+0xf4>
      }
      sleep(b, &bcache.lock);
80100111:	c7 44 24 04 60 c6 10 	movl   $0x8010c660,0x4(%esp)
80100118:	80 
80100119:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010011c:	89 04 24             	mov    %eax,(%esp)
8010011f:	e8 7b 4b 00 00       	call   80104c9f <sleep>
      goto loop;
80100124:	eb 9c                	jmp    801000c2 <bget+0x12>

  acquire(&bcache.lock);

 loop:
  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
80100126:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100129:	8b 40 10             	mov    0x10(%eax),%eax
8010012c:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010012f:	81 7d f4 64 05 11 80 	cmpl   $0x80110564,-0xc(%ebp)
80100136:	75 94                	jne    801000cc <bget+0x1c>
  }

  // Not cached; recycle some non-busy and clean buffer.
  // "clean" because B_DIRTY and !B_BUSY means log.c
  // hasn't yet committed the changes to the buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100138:	a1 70 05 11 80       	mov    0x80110570,%eax
8010013d:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100140:	eb 4d                	jmp    8010018f <bget+0xdf>
    if((b->flags & B_BUSY) == 0 && (b->flags & B_DIRTY) == 0){
80100142:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100145:	8b 00                	mov    (%eax),%eax
80100147:	83 e0 01             	and    $0x1,%eax
8010014a:	85 c0                	test   %eax,%eax
8010014c:	75 38                	jne    80100186 <bget+0xd6>
8010014e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100151:	8b 00                	mov    (%eax),%eax
80100153:	83 e0 04             	and    $0x4,%eax
80100156:	85 c0                	test   %eax,%eax
80100158:	75 2c                	jne    80100186 <bget+0xd6>
      b->dev = dev;
8010015a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010015d:	8b 55 08             	mov    0x8(%ebp),%edx
80100160:	89 50 04             	mov    %edx,0x4(%eax)
      b->blockno = blockno;
80100163:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100166:	8b 55 0c             	mov    0xc(%ebp),%edx
80100169:	89 50 08             	mov    %edx,0x8(%eax)
      b->flags = B_BUSY;
8010016c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010016f:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
      release(&bcache.lock);
80100175:	c7 04 24 60 c6 10 80 	movl   $0x8010c660,(%esp)
8010017c:	e8 7e 4e 00 00       	call   80104fff <release>
      return b;
80100181:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100184:	eb 1e                	jmp    801001a4 <bget+0xf4>
  }

  // Not cached; recycle some non-busy and clean buffer.
  // "clean" because B_DIRTY and !B_BUSY means log.c
  // hasn't yet committed the changes to the buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100186:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100189:	8b 40 0c             	mov    0xc(%eax),%eax
8010018c:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010018f:	81 7d f4 64 05 11 80 	cmpl   $0x80110564,-0xc(%ebp)
80100196:	75 aa                	jne    80100142 <bget+0x92>
      b->flags = B_BUSY;
      release(&bcache.lock);
      return b;
    }
  }
  panic("bget: no buffers");
80100198:	c7 04 24 c3 84 10 80 	movl   $0x801084c3,(%esp)
8010019f:	e8 96 03 00 00       	call   8010053a <panic>
}
801001a4:	c9                   	leave  
801001a5:	c3                   	ret    

801001a6 <bread>:

// Return a B_BUSY buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801001a6:	55                   	push   %ebp
801001a7:	89 e5                	mov    %esp,%ebp
801001a9:	83 ec 28             	sub    $0x28,%esp
  struct buf *b;

  b = bget(dev, blockno);
801001ac:	8b 45 0c             	mov    0xc(%ebp),%eax
801001af:	89 44 24 04          	mov    %eax,0x4(%esp)
801001b3:	8b 45 08             	mov    0x8(%ebp),%eax
801001b6:	89 04 24             	mov    %eax,(%esp)
801001b9:	e8 f2 fe ff ff       	call   801000b0 <bget>
801001be:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(!(b->flags & B_VALID)) {
801001c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801001c4:	8b 00                	mov    (%eax),%eax
801001c6:	83 e0 02             	and    $0x2,%eax
801001c9:	85 c0                	test   %eax,%eax
801001cb:	75 0b                	jne    801001d8 <bread+0x32>
    iderw(b);
801001cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801001d0:	89 04 24             	mov    %eax,(%esp)
801001d3:	e8 ce 26 00 00       	call   801028a6 <iderw>
  }
  return b;
801001d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801001db:	c9                   	leave  
801001dc:	c3                   	ret    

801001dd <bwrite>:

// Write b's contents to disk.  Must be B_BUSY.
void
bwrite(struct buf *b)
{
801001dd:	55                   	push   %ebp
801001de:	89 e5                	mov    %esp,%ebp
801001e0:	83 ec 18             	sub    $0x18,%esp
  if((b->flags & B_BUSY) == 0)
801001e3:	8b 45 08             	mov    0x8(%ebp),%eax
801001e6:	8b 00                	mov    (%eax),%eax
801001e8:	83 e0 01             	and    $0x1,%eax
801001eb:	85 c0                	test   %eax,%eax
801001ed:	75 0c                	jne    801001fb <bwrite+0x1e>
    panic("bwrite");
801001ef:	c7 04 24 d4 84 10 80 	movl   $0x801084d4,(%esp)
801001f6:	e8 3f 03 00 00       	call   8010053a <panic>
  b->flags |= B_DIRTY;
801001fb:	8b 45 08             	mov    0x8(%ebp),%eax
801001fe:	8b 00                	mov    (%eax),%eax
80100200:	83 c8 04             	or     $0x4,%eax
80100203:	89 c2                	mov    %eax,%edx
80100205:	8b 45 08             	mov    0x8(%ebp),%eax
80100208:	89 10                	mov    %edx,(%eax)
  iderw(b);
8010020a:	8b 45 08             	mov    0x8(%ebp),%eax
8010020d:	89 04 24             	mov    %eax,(%esp)
80100210:	e8 91 26 00 00       	call   801028a6 <iderw>
}
80100215:	c9                   	leave  
80100216:	c3                   	ret    

80100217 <brelse>:

// Release a B_BUSY buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
80100217:	55                   	push   %ebp
80100218:	89 e5                	mov    %esp,%ebp
8010021a:	83 ec 18             	sub    $0x18,%esp
  if((b->flags & B_BUSY) == 0)
8010021d:	8b 45 08             	mov    0x8(%ebp),%eax
80100220:	8b 00                	mov    (%eax),%eax
80100222:	83 e0 01             	and    $0x1,%eax
80100225:	85 c0                	test   %eax,%eax
80100227:	75 0c                	jne    80100235 <brelse+0x1e>
    panic("brelse");
80100229:	c7 04 24 db 84 10 80 	movl   $0x801084db,(%esp)
80100230:	e8 05 03 00 00       	call   8010053a <panic>

  acquire(&bcache.lock);
80100235:	c7 04 24 60 c6 10 80 	movl   $0x8010c660,(%esp)
8010023c:	e8 57 4d 00 00       	call   80104f98 <acquire>

  b->next->prev = b->prev;
80100241:	8b 45 08             	mov    0x8(%ebp),%eax
80100244:	8b 40 10             	mov    0x10(%eax),%eax
80100247:	8b 55 08             	mov    0x8(%ebp),%edx
8010024a:	8b 52 0c             	mov    0xc(%edx),%edx
8010024d:	89 50 0c             	mov    %edx,0xc(%eax)
  b->prev->next = b->next;
80100250:	8b 45 08             	mov    0x8(%ebp),%eax
80100253:	8b 40 0c             	mov    0xc(%eax),%eax
80100256:	8b 55 08             	mov    0x8(%ebp),%edx
80100259:	8b 52 10             	mov    0x10(%edx),%edx
8010025c:	89 50 10             	mov    %edx,0x10(%eax)
  b->next = bcache.head.next;
8010025f:	8b 15 74 05 11 80    	mov    0x80110574,%edx
80100265:	8b 45 08             	mov    0x8(%ebp),%eax
80100268:	89 50 10             	mov    %edx,0x10(%eax)
  b->prev = &bcache.head;
8010026b:	8b 45 08             	mov    0x8(%ebp),%eax
8010026e:	c7 40 0c 64 05 11 80 	movl   $0x80110564,0xc(%eax)
  bcache.head.next->prev = b;
80100275:	a1 74 05 11 80       	mov    0x80110574,%eax
8010027a:	8b 55 08             	mov    0x8(%ebp),%edx
8010027d:	89 50 0c             	mov    %edx,0xc(%eax)
  bcache.head.next = b;
80100280:	8b 45 08             	mov    0x8(%ebp),%eax
80100283:	a3 74 05 11 80       	mov    %eax,0x80110574

  b->flags &= ~B_BUSY;
80100288:	8b 45 08             	mov    0x8(%ebp),%eax
8010028b:	8b 00                	mov    (%eax),%eax
8010028d:	83 e0 fe             	and    $0xfffffffe,%eax
80100290:	89 c2                	mov    %eax,%edx
80100292:	8b 45 08             	mov    0x8(%ebp),%eax
80100295:	89 10                	mov    %edx,(%eax)
  wakeup(b);
80100297:	8b 45 08             	mov    0x8(%ebp),%eax
8010029a:	89 04 24             	mov    %eax,(%esp)
8010029d:	e8 e8 4a 00 00       	call   80104d8a <wakeup>

  release(&bcache.lock);
801002a2:	c7 04 24 60 c6 10 80 	movl   $0x8010c660,(%esp)
801002a9:	e8 51 4d 00 00       	call   80104fff <release>
}
801002ae:	c9                   	leave  
801002af:	c3                   	ret    

801002b0 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
801002b0:	55                   	push   %ebp
801002b1:	89 e5                	mov    %esp,%ebp
801002b3:	83 ec 14             	sub    $0x14,%esp
801002b6:	8b 45 08             	mov    0x8(%ebp),%eax
801002b9:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801002bd:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
801002c1:	89 c2                	mov    %eax,%edx
801002c3:	ec                   	in     (%dx),%al
801002c4:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
801002c7:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
801002cb:	c9                   	leave  
801002cc:	c3                   	ret    

801002cd <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
801002cd:	55                   	push   %ebp
801002ce:	89 e5                	mov    %esp,%ebp
801002d0:	83 ec 08             	sub    $0x8,%esp
801002d3:	8b 55 08             	mov    0x8(%ebp),%edx
801002d6:	8b 45 0c             	mov    0xc(%ebp),%eax
801002d9:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
801002dd:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801002e0:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
801002e4:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
801002e8:	ee                   	out    %al,(%dx)
}
801002e9:	c9                   	leave  
801002ea:	c3                   	ret    

801002eb <cli>:
  asm volatile("movw %0, %%gs" : : "r" (v));
}

static inline void
cli(void)
{
801002eb:	55                   	push   %ebp
801002ec:	89 e5                	mov    %esp,%ebp
  asm volatile("cli");
801002ee:	fa                   	cli    
}
801002ef:	5d                   	pop    %ebp
801002f0:	c3                   	ret    

801002f1 <printint>:
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
801002f1:	55                   	push   %ebp
801002f2:	89 e5                	mov    %esp,%ebp
801002f4:	56                   	push   %esi
801002f5:	53                   	push   %ebx
801002f6:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
801002f9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801002fd:	74 1c                	je     8010031b <printint+0x2a>
801002ff:	8b 45 08             	mov    0x8(%ebp),%eax
80100302:	c1 e8 1f             	shr    $0x1f,%eax
80100305:	0f b6 c0             	movzbl %al,%eax
80100308:	89 45 10             	mov    %eax,0x10(%ebp)
8010030b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010030f:	74 0a                	je     8010031b <printint+0x2a>
    x = -xx;
80100311:	8b 45 08             	mov    0x8(%ebp),%eax
80100314:	f7 d8                	neg    %eax
80100316:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100319:	eb 06                	jmp    80100321 <printint+0x30>
  else
    x = xx;
8010031b:	8b 45 08             	mov    0x8(%ebp),%eax
8010031e:	89 45 f0             	mov    %eax,-0x10(%ebp)

  i = 0;
80100321:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
80100328:	8b 4d f4             	mov    -0xc(%ebp),%ecx
8010032b:	8d 41 01             	lea    0x1(%ecx),%eax
8010032e:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100331:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80100334:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100337:	ba 00 00 00 00       	mov    $0x0,%edx
8010033c:	f7 f3                	div    %ebx
8010033e:	89 d0                	mov    %edx,%eax
80100340:	0f b6 80 04 90 10 80 	movzbl -0x7fef6ffc(%eax),%eax
80100347:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
  }while((x /= base) != 0);
8010034b:	8b 75 0c             	mov    0xc(%ebp),%esi
8010034e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100351:	ba 00 00 00 00       	mov    $0x0,%edx
80100356:	f7 f6                	div    %esi
80100358:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010035b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010035f:	75 c7                	jne    80100328 <printint+0x37>

  if(sign)
80100361:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100365:	74 10                	je     80100377 <printint+0x86>
    buf[i++] = '-';
80100367:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010036a:	8d 50 01             	lea    0x1(%eax),%edx
8010036d:	89 55 f4             	mov    %edx,-0xc(%ebp)
80100370:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)

  while(--i >= 0)
80100375:	eb 18                	jmp    8010038f <printint+0x9e>
80100377:	eb 16                	jmp    8010038f <printint+0x9e>
    consputc(buf[i]);
80100379:	8d 55 e0             	lea    -0x20(%ebp),%edx
8010037c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010037f:	01 d0                	add    %edx,%eax
80100381:	0f b6 00             	movzbl (%eax),%eax
80100384:	0f be c0             	movsbl %al,%eax
80100387:	89 04 24             	mov    %eax,(%esp)
8010038a:	e8 dc 03 00 00       	call   8010076b <consputc>
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
8010038f:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
80100393:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80100397:	79 e0                	jns    80100379 <printint+0x88>
    consputc(buf[i]);
}
80100399:	83 c4 30             	add    $0x30,%esp
8010039c:	5b                   	pop    %ebx
8010039d:	5e                   	pop    %esi
8010039e:	5d                   	pop    %ebp
8010039f:	c3                   	ret    

801003a0 <cprintf>:
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
801003a0:	55                   	push   %ebp
801003a1:	89 e5                	mov    %esp,%ebp
801003a3:	83 ec 38             	sub    $0x38,%esp
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
801003a6:	a1 f4 b5 10 80       	mov    0x8010b5f4,%eax
801003ab:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(locking)
801003ae:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
801003b2:	74 0c                	je     801003c0 <cprintf+0x20>
    acquire(&cons.lock);
801003b4:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
801003bb:	e8 d8 4b 00 00       	call   80104f98 <acquire>

  if (fmt == 0)
801003c0:	8b 45 08             	mov    0x8(%ebp),%eax
801003c3:	85 c0                	test   %eax,%eax
801003c5:	75 0c                	jne    801003d3 <cprintf+0x33>
    panic("null fmt");
801003c7:	c7 04 24 e2 84 10 80 	movl   $0x801084e2,(%esp)
801003ce:	e8 67 01 00 00       	call   8010053a <panic>

  argp = (uint*)(void*)(&fmt + 1);
801003d3:	8d 45 0c             	lea    0xc(%ebp),%eax
801003d6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801003d9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801003e0:	e9 21 01 00 00       	jmp    80100506 <cprintf+0x166>
    if(c != '%'){
801003e5:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
801003e9:	74 10                	je     801003fb <cprintf+0x5b>
      consputc(c);
801003eb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801003ee:	89 04 24             	mov    %eax,(%esp)
801003f1:	e8 75 03 00 00       	call   8010076b <consputc>
      continue;
801003f6:	e9 07 01 00 00       	jmp    80100502 <cprintf+0x162>
    }
    c = fmt[++i] & 0xff;
801003fb:	8b 55 08             	mov    0x8(%ebp),%edx
801003fe:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100402:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100405:	01 d0                	add    %edx,%eax
80100407:	0f b6 00             	movzbl (%eax),%eax
8010040a:	0f be c0             	movsbl %al,%eax
8010040d:	25 ff 00 00 00       	and    $0xff,%eax
80100412:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(c == 0)
80100415:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
80100419:	75 05                	jne    80100420 <cprintf+0x80>
      break;
8010041b:	e9 06 01 00 00       	jmp    80100526 <cprintf+0x186>
    switch(c){
80100420:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100423:	83 f8 70             	cmp    $0x70,%eax
80100426:	74 4f                	je     80100477 <cprintf+0xd7>
80100428:	83 f8 70             	cmp    $0x70,%eax
8010042b:	7f 13                	jg     80100440 <cprintf+0xa0>
8010042d:	83 f8 25             	cmp    $0x25,%eax
80100430:	0f 84 a6 00 00 00    	je     801004dc <cprintf+0x13c>
80100436:	83 f8 64             	cmp    $0x64,%eax
80100439:	74 14                	je     8010044f <cprintf+0xaf>
8010043b:	e9 aa 00 00 00       	jmp    801004ea <cprintf+0x14a>
80100440:	83 f8 73             	cmp    $0x73,%eax
80100443:	74 57                	je     8010049c <cprintf+0xfc>
80100445:	83 f8 78             	cmp    $0x78,%eax
80100448:	74 2d                	je     80100477 <cprintf+0xd7>
8010044a:	e9 9b 00 00 00       	jmp    801004ea <cprintf+0x14a>
    case 'd':
      printint(*argp++, 10, 1);
8010044f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100452:	8d 50 04             	lea    0x4(%eax),%edx
80100455:	89 55 f0             	mov    %edx,-0x10(%ebp)
80100458:	8b 00                	mov    (%eax),%eax
8010045a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
80100461:	00 
80100462:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
80100469:	00 
8010046a:	89 04 24             	mov    %eax,(%esp)
8010046d:	e8 7f fe ff ff       	call   801002f1 <printint>
      break;
80100472:	e9 8b 00 00 00       	jmp    80100502 <cprintf+0x162>
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
80100477:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010047a:	8d 50 04             	lea    0x4(%eax),%edx
8010047d:	89 55 f0             	mov    %edx,-0x10(%ebp)
80100480:	8b 00                	mov    (%eax),%eax
80100482:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80100489:	00 
8010048a:	c7 44 24 04 10 00 00 	movl   $0x10,0x4(%esp)
80100491:	00 
80100492:	89 04 24             	mov    %eax,(%esp)
80100495:	e8 57 fe ff ff       	call   801002f1 <printint>
      break;
8010049a:	eb 66                	jmp    80100502 <cprintf+0x162>
    case 's':
      if((s = (char*)*argp++) == 0)
8010049c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010049f:	8d 50 04             	lea    0x4(%eax),%edx
801004a2:	89 55 f0             	mov    %edx,-0x10(%ebp)
801004a5:	8b 00                	mov    (%eax),%eax
801004a7:	89 45 ec             	mov    %eax,-0x14(%ebp)
801004aa:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801004ae:	75 09                	jne    801004b9 <cprintf+0x119>
        s = "(null)";
801004b0:	c7 45 ec eb 84 10 80 	movl   $0x801084eb,-0x14(%ebp)
      for(; *s; s++)
801004b7:	eb 17                	jmp    801004d0 <cprintf+0x130>
801004b9:	eb 15                	jmp    801004d0 <cprintf+0x130>
        consputc(*s);
801004bb:	8b 45 ec             	mov    -0x14(%ebp),%eax
801004be:	0f b6 00             	movzbl (%eax),%eax
801004c1:	0f be c0             	movsbl %al,%eax
801004c4:	89 04 24             	mov    %eax,(%esp)
801004c7:	e8 9f 02 00 00       	call   8010076b <consputc>
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
801004cc:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
801004d0:	8b 45 ec             	mov    -0x14(%ebp),%eax
801004d3:	0f b6 00             	movzbl (%eax),%eax
801004d6:	84 c0                	test   %al,%al
801004d8:	75 e1                	jne    801004bb <cprintf+0x11b>
        consputc(*s);
      break;
801004da:	eb 26                	jmp    80100502 <cprintf+0x162>
    case '%':
      consputc('%');
801004dc:	c7 04 24 25 00 00 00 	movl   $0x25,(%esp)
801004e3:	e8 83 02 00 00       	call   8010076b <consputc>
      break;
801004e8:	eb 18                	jmp    80100502 <cprintf+0x162>
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
801004ea:	c7 04 24 25 00 00 00 	movl   $0x25,(%esp)
801004f1:	e8 75 02 00 00       	call   8010076b <consputc>
      consputc(c);
801004f6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801004f9:	89 04 24             	mov    %eax,(%esp)
801004fc:	e8 6a 02 00 00       	call   8010076b <consputc>
      break;
80100501:	90                   	nop

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100502:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100506:	8b 55 08             	mov    0x8(%ebp),%edx
80100509:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010050c:	01 d0                	add    %edx,%eax
8010050e:	0f b6 00             	movzbl (%eax),%eax
80100511:	0f be c0             	movsbl %al,%eax
80100514:	25 ff 00 00 00       	and    $0xff,%eax
80100519:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010051c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
80100520:	0f 85 bf fe ff ff    	jne    801003e5 <cprintf+0x45>
      consputc(c);
      break;
    }
  }

  if(locking)
80100526:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
8010052a:	74 0c                	je     80100538 <cprintf+0x198>
    release(&cons.lock);
8010052c:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
80100533:	e8 c7 4a 00 00       	call   80104fff <release>
}
80100538:	c9                   	leave  
80100539:	c3                   	ret    

8010053a <panic>:

void
panic(char *s)
{
8010053a:	55                   	push   %ebp
8010053b:	89 e5                	mov    %esp,%ebp
8010053d:	83 ec 48             	sub    $0x48,%esp
  int i;
  uint pcs[10];
  
  cli();
80100540:	e8 a6 fd ff ff       	call   801002eb <cli>
  cons.locking = 0;
80100545:	c7 05 f4 b5 10 80 00 	movl   $0x0,0x8010b5f4
8010054c:	00 00 00 
  cprintf("cpu%d: panic: ", cpu->id);
8010054f:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80100555:	0f b6 00             	movzbl (%eax),%eax
80100558:	0f b6 c0             	movzbl %al,%eax
8010055b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010055f:	c7 04 24 f2 84 10 80 	movl   $0x801084f2,(%esp)
80100566:	e8 35 fe ff ff       	call   801003a0 <cprintf>
  cprintf(s);
8010056b:	8b 45 08             	mov    0x8(%ebp),%eax
8010056e:	89 04 24             	mov    %eax,(%esp)
80100571:	e8 2a fe ff ff       	call   801003a0 <cprintf>
  cprintf("\n");
80100576:	c7 04 24 01 85 10 80 	movl   $0x80108501,(%esp)
8010057d:	e8 1e fe ff ff       	call   801003a0 <cprintf>
  getcallerpcs(&s, pcs);
80100582:	8d 45 cc             	lea    -0x34(%ebp),%eax
80100585:	89 44 24 04          	mov    %eax,0x4(%esp)
80100589:	8d 45 08             	lea    0x8(%ebp),%eax
8010058c:	89 04 24             	mov    %eax,(%esp)
8010058f:	e8 bd 4a 00 00       	call   80105051 <getcallerpcs>
  for(i=0; i<10; i++)
80100594:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010059b:	eb 1b                	jmp    801005b8 <panic+0x7e>
    cprintf(" %p", pcs[i]);
8010059d:	8b 45 f4             	mov    -0xc(%ebp),%eax
801005a0:	8b 44 85 cc          	mov    -0x34(%ebp,%eax,4),%eax
801005a4:	89 44 24 04          	mov    %eax,0x4(%esp)
801005a8:	c7 04 24 03 85 10 80 	movl   $0x80108503,(%esp)
801005af:	e8 ec fd ff ff       	call   801003a0 <cprintf>
  cons.locking = 0;
  cprintf("cpu%d: panic: ", cpu->id);
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
801005b4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801005b8:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
801005bc:	7e df                	jle    8010059d <panic+0x63>
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
801005be:	c7 05 a0 b5 10 80 01 	movl   $0x1,0x8010b5a0
801005c5:	00 00 00 
  for(;;)
    ;
801005c8:	eb fe                	jmp    801005c8 <panic+0x8e>

801005ca <cgaputc>:
#define CRTPORT 0x3d4
static ushort *crt = (ushort*)P2V(0xb8000);  // CGA memory

static void
cgaputc(int c)
{
801005ca:	55                   	push   %ebp
801005cb:	89 e5                	mov    %esp,%ebp
801005cd:	83 ec 28             	sub    $0x28,%esp
  int pos;
  
  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
801005d0:	c7 44 24 04 0e 00 00 	movl   $0xe,0x4(%esp)
801005d7:	00 
801005d8:	c7 04 24 d4 03 00 00 	movl   $0x3d4,(%esp)
801005df:	e8 e9 fc ff ff       	call   801002cd <outb>
  pos = inb(CRTPORT+1) << 8;
801005e4:	c7 04 24 d5 03 00 00 	movl   $0x3d5,(%esp)
801005eb:	e8 c0 fc ff ff       	call   801002b0 <inb>
801005f0:	0f b6 c0             	movzbl %al,%eax
801005f3:	c1 e0 08             	shl    $0x8,%eax
801005f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  outb(CRTPORT, 15);
801005f9:	c7 44 24 04 0f 00 00 	movl   $0xf,0x4(%esp)
80100600:	00 
80100601:	c7 04 24 d4 03 00 00 	movl   $0x3d4,(%esp)
80100608:	e8 c0 fc ff ff       	call   801002cd <outb>
  pos |= inb(CRTPORT+1);
8010060d:	c7 04 24 d5 03 00 00 	movl   $0x3d5,(%esp)
80100614:	e8 97 fc ff ff       	call   801002b0 <inb>
80100619:	0f b6 c0             	movzbl %al,%eax
8010061c:	09 45 f4             	or     %eax,-0xc(%ebp)

  if(c == '\n')
8010061f:	83 7d 08 0a          	cmpl   $0xa,0x8(%ebp)
80100623:	75 30                	jne    80100655 <cgaputc+0x8b>
    pos += 80 - pos%80;
80100625:	8b 4d f4             	mov    -0xc(%ebp),%ecx
80100628:	ba 67 66 66 66       	mov    $0x66666667,%edx
8010062d:	89 c8                	mov    %ecx,%eax
8010062f:	f7 ea                	imul   %edx
80100631:	c1 fa 05             	sar    $0x5,%edx
80100634:	89 c8                	mov    %ecx,%eax
80100636:	c1 f8 1f             	sar    $0x1f,%eax
80100639:	29 c2                	sub    %eax,%edx
8010063b:	89 d0                	mov    %edx,%eax
8010063d:	c1 e0 02             	shl    $0x2,%eax
80100640:	01 d0                	add    %edx,%eax
80100642:	c1 e0 04             	shl    $0x4,%eax
80100645:	29 c1                	sub    %eax,%ecx
80100647:	89 ca                	mov    %ecx,%edx
80100649:	b8 50 00 00 00       	mov    $0x50,%eax
8010064e:	29 d0                	sub    %edx,%eax
80100650:	01 45 f4             	add    %eax,-0xc(%ebp)
80100653:	eb 35                	jmp    8010068a <cgaputc+0xc0>
  else if(c == BACKSPACE){
80100655:	81 7d 08 00 01 00 00 	cmpl   $0x100,0x8(%ebp)
8010065c:	75 0c                	jne    8010066a <cgaputc+0xa0>
    if(pos > 0) --pos;
8010065e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80100662:	7e 26                	jle    8010068a <cgaputc+0xc0>
80100664:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
80100668:	eb 20                	jmp    8010068a <cgaputc+0xc0>
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
8010066a:	8b 0d 00 90 10 80    	mov    0x80109000,%ecx
80100670:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100673:	8d 50 01             	lea    0x1(%eax),%edx
80100676:	89 55 f4             	mov    %edx,-0xc(%ebp)
80100679:	01 c0                	add    %eax,%eax
8010067b:	8d 14 01             	lea    (%ecx,%eax,1),%edx
8010067e:	8b 45 08             	mov    0x8(%ebp),%eax
80100681:	0f b6 c0             	movzbl %al,%eax
80100684:	80 cc 07             	or     $0x7,%ah
80100687:	66 89 02             	mov    %ax,(%edx)

  if(pos < 0 || pos > 25*80)
8010068a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010068e:	78 09                	js     80100699 <cgaputc+0xcf>
80100690:	81 7d f4 d0 07 00 00 	cmpl   $0x7d0,-0xc(%ebp)
80100697:	7e 0c                	jle    801006a5 <cgaputc+0xdb>
    panic("pos under/overflow");
80100699:	c7 04 24 07 85 10 80 	movl   $0x80108507,(%esp)
801006a0:	e8 95 fe ff ff       	call   8010053a <panic>
  
  if((pos/80) >= 24){  // Scroll up.
801006a5:	81 7d f4 7f 07 00 00 	cmpl   $0x77f,-0xc(%ebp)
801006ac:	7e 53                	jle    80100701 <cgaputc+0x137>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801006ae:	a1 00 90 10 80       	mov    0x80109000,%eax
801006b3:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
801006b9:	a1 00 90 10 80       	mov    0x80109000,%eax
801006be:	c7 44 24 08 60 0e 00 	movl   $0xe60,0x8(%esp)
801006c5:	00 
801006c6:	89 54 24 04          	mov    %edx,0x4(%esp)
801006ca:	89 04 24             	mov    %eax,(%esp)
801006cd:	e8 e8 4b 00 00       	call   801052ba <memmove>
    pos -= 80;
801006d2:	83 6d f4 50          	subl   $0x50,-0xc(%ebp)
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
801006d6:	b8 80 07 00 00       	mov    $0x780,%eax
801006db:	2b 45 f4             	sub    -0xc(%ebp),%eax
801006de:	8d 14 00             	lea    (%eax,%eax,1),%edx
801006e1:	a1 00 90 10 80       	mov    0x80109000,%eax
801006e6:	8b 4d f4             	mov    -0xc(%ebp),%ecx
801006e9:	01 c9                	add    %ecx,%ecx
801006eb:	01 c8                	add    %ecx,%eax
801006ed:	89 54 24 08          	mov    %edx,0x8(%esp)
801006f1:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801006f8:	00 
801006f9:	89 04 24             	mov    %eax,(%esp)
801006fc:	e8 fa 4a 00 00       	call   801051fb <memset>
  }
  
  outb(CRTPORT, 14);
80100701:	c7 44 24 04 0e 00 00 	movl   $0xe,0x4(%esp)
80100708:	00 
80100709:	c7 04 24 d4 03 00 00 	movl   $0x3d4,(%esp)
80100710:	e8 b8 fb ff ff       	call   801002cd <outb>
  outb(CRTPORT+1, pos>>8);
80100715:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100718:	c1 f8 08             	sar    $0x8,%eax
8010071b:	0f b6 c0             	movzbl %al,%eax
8010071e:	89 44 24 04          	mov    %eax,0x4(%esp)
80100722:	c7 04 24 d5 03 00 00 	movl   $0x3d5,(%esp)
80100729:	e8 9f fb ff ff       	call   801002cd <outb>
  outb(CRTPORT, 15);
8010072e:	c7 44 24 04 0f 00 00 	movl   $0xf,0x4(%esp)
80100735:	00 
80100736:	c7 04 24 d4 03 00 00 	movl   $0x3d4,(%esp)
8010073d:	e8 8b fb ff ff       	call   801002cd <outb>
  outb(CRTPORT+1, pos);
80100742:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100745:	0f b6 c0             	movzbl %al,%eax
80100748:	89 44 24 04          	mov    %eax,0x4(%esp)
8010074c:	c7 04 24 d5 03 00 00 	movl   $0x3d5,(%esp)
80100753:	e8 75 fb ff ff       	call   801002cd <outb>
  crt[pos] = ' ' | 0x0700;
80100758:	a1 00 90 10 80       	mov    0x80109000,%eax
8010075d:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100760:	01 d2                	add    %edx,%edx
80100762:	01 d0                	add    %edx,%eax
80100764:	66 c7 00 20 07       	movw   $0x720,(%eax)
}
80100769:	c9                   	leave  
8010076a:	c3                   	ret    

8010076b <consputc>:

void
consputc(int c)
{
8010076b:	55                   	push   %ebp
8010076c:	89 e5                	mov    %esp,%ebp
8010076e:	83 ec 18             	sub    $0x18,%esp
  if(panicked){
80100771:	a1 a0 b5 10 80       	mov    0x8010b5a0,%eax
80100776:	85 c0                	test   %eax,%eax
80100778:	74 07                	je     80100781 <consputc+0x16>
    cli();
8010077a:	e8 6c fb ff ff       	call   801002eb <cli>
    for(;;)
      ;
8010077f:	eb fe                	jmp    8010077f <consputc+0x14>
  }

  if(c == BACKSPACE){
80100781:	81 7d 08 00 01 00 00 	cmpl   $0x100,0x8(%ebp)
80100788:	75 26                	jne    801007b0 <consputc+0x45>
    uartputc('\b'); uartputc(' '); uartputc('\b');
8010078a:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100791:	e8 af 63 00 00       	call   80106b45 <uartputc>
80100796:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
8010079d:	e8 a3 63 00 00       	call   80106b45 <uartputc>
801007a2:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801007a9:	e8 97 63 00 00       	call   80106b45 <uartputc>
801007ae:	eb 0b                	jmp    801007bb <consputc+0x50>
  } else
    uartputc(c);
801007b0:	8b 45 08             	mov    0x8(%ebp),%eax
801007b3:	89 04 24             	mov    %eax,(%esp)
801007b6:	e8 8a 63 00 00       	call   80106b45 <uartputc>
  cgaputc(c);
801007bb:	8b 45 08             	mov    0x8(%ebp),%eax
801007be:	89 04 24             	mov    %eax,(%esp)
801007c1:	e8 04 fe ff ff       	call   801005ca <cgaputc>
}
801007c6:	c9                   	leave  
801007c7:	c3                   	ret    

801007c8 <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
801007c8:	55                   	push   %ebp
801007c9:	89 e5                	mov    %esp,%ebp
801007cb:	83 ec 28             	sub    $0x28,%esp
  int c, doprocdump = 0;
801007ce:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  acquire(&cons.lock);
801007d5:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
801007dc:	e8 b7 47 00 00       	call   80104f98 <acquire>
  while((c = getc()) >= 0){
801007e1:	e9 39 01 00 00       	jmp    8010091f <consoleintr+0x157>
    switch(c){
801007e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801007e9:	83 f8 10             	cmp    $0x10,%eax
801007ec:	74 1e                	je     8010080c <consoleintr+0x44>
801007ee:	83 f8 10             	cmp    $0x10,%eax
801007f1:	7f 0a                	jg     801007fd <consoleintr+0x35>
801007f3:	83 f8 08             	cmp    $0x8,%eax
801007f6:	74 66                	je     8010085e <consoleintr+0x96>
801007f8:	e9 93 00 00 00       	jmp    80100890 <consoleintr+0xc8>
801007fd:	83 f8 15             	cmp    $0x15,%eax
80100800:	74 31                	je     80100833 <consoleintr+0x6b>
80100802:	83 f8 7f             	cmp    $0x7f,%eax
80100805:	74 57                	je     8010085e <consoleintr+0x96>
80100807:	e9 84 00 00 00       	jmp    80100890 <consoleintr+0xc8>
    case C('P'):  // Process listing.
      doprocdump = 1;   // procdump() locks cons.lock indirectly; invoke later
8010080c:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
      break;
80100813:	e9 07 01 00 00       	jmp    8010091f <consoleintr+0x157>
    case C('U'):  // Kill line.
      while(input.e != input.w &&
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
80100818:	a1 08 08 11 80       	mov    0x80110808,%eax
8010081d:	83 e8 01             	sub    $0x1,%eax
80100820:	a3 08 08 11 80       	mov    %eax,0x80110808
        consputc(BACKSPACE);
80100825:	c7 04 24 00 01 00 00 	movl   $0x100,(%esp)
8010082c:	e8 3a ff ff ff       	call   8010076b <consputc>
80100831:	eb 01                	jmp    80100834 <consoleintr+0x6c>
    switch(c){
    case C('P'):  // Process listing.
      doprocdump = 1;   // procdump() locks cons.lock indirectly; invoke later
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100833:	90                   	nop
80100834:	8b 15 08 08 11 80    	mov    0x80110808,%edx
8010083a:	a1 04 08 11 80       	mov    0x80110804,%eax
8010083f:	39 c2                	cmp    %eax,%edx
80100841:	74 16                	je     80100859 <consoleintr+0x91>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100843:	a1 08 08 11 80       	mov    0x80110808,%eax
80100848:	83 e8 01             	sub    $0x1,%eax
8010084b:	83 e0 7f             	and    $0x7f,%eax
8010084e:	0f b6 80 80 07 11 80 	movzbl -0x7feef880(%eax),%eax
    switch(c){
    case C('P'):  // Process listing.
      doprocdump = 1;   // procdump() locks cons.lock indirectly; invoke later
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100855:	3c 0a                	cmp    $0xa,%al
80100857:	75 bf                	jne    80100818 <consoleintr+0x50>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
        consputc(BACKSPACE);
      }
      break;
80100859:	e9 c1 00 00 00       	jmp    8010091f <consoleintr+0x157>
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
8010085e:	8b 15 08 08 11 80    	mov    0x80110808,%edx
80100864:	a1 04 08 11 80       	mov    0x80110804,%eax
80100869:	39 c2                	cmp    %eax,%edx
8010086b:	74 1e                	je     8010088b <consoleintr+0xc3>
        input.e--;
8010086d:	a1 08 08 11 80       	mov    0x80110808,%eax
80100872:	83 e8 01             	sub    $0x1,%eax
80100875:	a3 08 08 11 80       	mov    %eax,0x80110808
        consputc(BACKSPACE);
8010087a:	c7 04 24 00 01 00 00 	movl   $0x100,(%esp)
80100881:	e8 e5 fe ff ff       	call   8010076b <consputc>
      }
      break;
80100886:	e9 94 00 00 00       	jmp    8010091f <consoleintr+0x157>
8010088b:	e9 8f 00 00 00       	jmp    8010091f <consoleintr+0x157>
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100890:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80100894:	0f 84 84 00 00 00    	je     8010091e <consoleintr+0x156>
8010089a:	8b 15 08 08 11 80    	mov    0x80110808,%edx
801008a0:	a1 00 08 11 80       	mov    0x80110800,%eax
801008a5:	29 c2                	sub    %eax,%edx
801008a7:	89 d0                	mov    %edx,%eax
801008a9:	83 f8 7f             	cmp    $0x7f,%eax
801008ac:	77 70                	ja     8010091e <consoleintr+0x156>
        c = (c == '\r') ? '\n' : c;
801008ae:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
801008b2:	74 05                	je     801008b9 <consoleintr+0xf1>
801008b4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801008b7:	eb 05                	jmp    801008be <consoleintr+0xf6>
801008b9:	b8 0a 00 00 00       	mov    $0xa,%eax
801008be:	89 45 f0             	mov    %eax,-0x10(%ebp)
        input.buf[input.e++ % INPUT_BUF] = c;
801008c1:	a1 08 08 11 80       	mov    0x80110808,%eax
801008c6:	8d 50 01             	lea    0x1(%eax),%edx
801008c9:	89 15 08 08 11 80    	mov    %edx,0x80110808
801008cf:	83 e0 7f             	and    $0x7f,%eax
801008d2:	89 c2                	mov    %eax,%edx
801008d4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801008d7:	88 82 80 07 11 80    	mov    %al,-0x7feef880(%edx)
        consputc(c);
801008dd:	8b 45 f0             	mov    -0x10(%ebp),%eax
801008e0:	89 04 24             	mov    %eax,(%esp)
801008e3:	e8 83 fe ff ff       	call   8010076b <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008e8:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
801008ec:	74 18                	je     80100906 <consoleintr+0x13e>
801008ee:	83 7d f0 04          	cmpl   $0x4,-0x10(%ebp)
801008f2:	74 12                	je     80100906 <consoleintr+0x13e>
801008f4:	a1 08 08 11 80       	mov    0x80110808,%eax
801008f9:	8b 15 00 08 11 80    	mov    0x80110800,%edx
801008ff:	83 ea 80             	sub    $0xffffff80,%edx
80100902:	39 d0                	cmp    %edx,%eax
80100904:	75 18                	jne    8010091e <consoleintr+0x156>
          input.w = input.e;
80100906:	a1 08 08 11 80       	mov    0x80110808,%eax
8010090b:	a3 04 08 11 80       	mov    %eax,0x80110804
          wakeup(&input.r);
80100910:	c7 04 24 00 08 11 80 	movl   $0x80110800,(%esp)
80100917:	e8 6e 44 00 00       	call   80104d8a <wakeup>
        }
      }
      break;
8010091c:	eb 00                	jmp    8010091e <consoleintr+0x156>
8010091e:	90                   	nop
consoleintr(int (*getc)(void))
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
8010091f:	8b 45 08             	mov    0x8(%ebp),%eax
80100922:	ff d0                	call   *%eax
80100924:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100927:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010092b:	0f 89 b5 fe ff ff    	jns    801007e6 <consoleintr+0x1e>
        }
      }
      break;
    }
  }
  release(&cons.lock);
80100931:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
80100938:	e8 c2 46 00 00       	call   80104fff <release>
  if(doprocdump) {
8010093d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80100941:	74 05                	je     80100948 <consoleintr+0x180>
    procdump();  // now call procdump() wo. cons.lock held
80100943:	e8 fd 44 00 00       	call   80104e45 <procdump>
  }
}
80100948:	c9                   	leave  
80100949:	c3                   	ret    

8010094a <consoleread>:

int
consoleread(struct inode *ip, char *dst, int n)
{
8010094a:	55                   	push   %ebp
8010094b:	89 e5                	mov    %esp,%ebp
8010094d:	83 ec 28             	sub    $0x28,%esp
  uint target;
  int c;

  iunlock(ip);
80100950:	8b 45 08             	mov    0x8(%ebp),%eax
80100953:	89 04 24             	mov    %eax,(%esp)
80100956:	e8 06 11 00 00       	call   80101a61 <iunlock>
  target = n;
8010095b:	8b 45 10             	mov    0x10(%ebp),%eax
8010095e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  acquire(&cons.lock);
80100961:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
80100968:	e8 2b 46 00 00       	call   80104f98 <acquire>
  while(n > 0){
8010096d:	e9 aa 00 00 00       	jmp    80100a1c <consoleread+0xd2>
    while(input.r == input.w){
80100972:	eb 42                	jmp    801009b6 <consoleread+0x6c>
      if(proc->killed){
80100974:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010097a:	8b 40 24             	mov    0x24(%eax),%eax
8010097d:	85 c0                	test   %eax,%eax
8010097f:	74 21                	je     801009a2 <consoleread+0x58>
        release(&cons.lock);
80100981:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
80100988:	e8 72 46 00 00       	call   80104fff <release>
        ilock(ip);
8010098d:	8b 45 08             	mov    0x8(%ebp),%eax
80100990:	89 04 24             	mov    %eax,(%esp)
80100993:	e8 6b 0f 00 00       	call   80101903 <ilock>
        return -1;
80100998:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010099d:	e9 a5 00 00 00       	jmp    80100a47 <consoleread+0xfd>
      }
      sleep(&input.r, &cons.lock);
801009a2:	c7 44 24 04 c0 b5 10 	movl   $0x8010b5c0,0x4(%esp)
801009a9:	80 
801009aa:	c7 04 24 00 08 11 80 	movl   $0x80110800,(%esp)
801009b1:	e8 e9 42 00 00       	call   80104c9f <sleep>

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
    while(input.r == input.w){
801009b6:	8b 15 00 08 11 80    	mov    0x80110800,%edx
801009bc:	a1 04 08 11 80       	mov    0x80110804,%eax
801009c1:	39 c2                	cmp    %eax,%edx
801009c3:	74 af                	je     80100974 <consoleread+0x2a>
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
801009c5:	a1 00 08 11 80       	mov    0x80110800,%eax
801009ca:	8d 50 01             	lea    0x1(%eax),%edx
801009cd:	89 15 00 08 11 80    	mov    %edx,0x80110800
801009d3:	83 e0 7f             	and    $0x7f,%eax
801009d6:	0f b6 80 80 07 11 80 	movzbl -0x7feef880(%eax),%eax
801009dd:	0f be c0             	movsbl %al,%eax
801009e0:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(c == C('D')){  // EOF
801009e3:	83 7d f0 04          	cmpl   $0x4,-0x10(%ebp)
801009e7:	75 19                	jne    80100a02 <consoleread+0xb8>
      if(n < target){
801009e9:	8b 45 10             	mov    0x10(%ebp),%eax
801009ec:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801009ef:	73 0f                	jae    80100a00 <consoleread+0xb6>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
801009f1:	a1 00 08 11 80       	mov    0x80110800,%eax
801009f6:	83 e8 01             	sub    $0x1,%eax
801009f9:	a3 00 08 11 80       	mov    %eax,0x80110800
      }
      break;
801009fe:	eb 26                	jmp    80100a26 <consoleread+0xdc>
80100a00:	eb 24                	jmp    80100a26 <consoleread+0xdc>
    }
    *dst++ = c;
80100a02:	8b 45 0c             	mov    0xc(%ebp),%eax
80100a05:	8d 50 01             	lea    0x1(%eax),%edx
80100a08:	89 55 0c             	mov    %edx,0xc(%ebp)
80100a0b:	8b 55 f0             	mov    -0x10(%ebp),%edx
80100a0e:	88 10                	mov    %dl,(%eax)
    --n;
80100a10:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    if(c == '\n')
80100a14:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
80100a18:	75 02                	jne    80100a1c <consoleread+0xd2>
      break;
80100a1a:	eb 0a                	jmp    80100a26 <consoleread+0xdc>
  int c;

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
80100a1c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100a20:	0f 8f 4c ff ff ff    	jg     80100972 <consoleread+0x28>
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
  }
  release(&cons.lock);
80100a26:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
80100a2d:	e8 cd 45 00 00       	call   80104fff <release>
  ilock(ip);
80100a32:	8b 45 08             	mov    0x8(%ebp),%eax
80100a35:	89 04 24             	mov    %eax,(%esp)
80100a38:	e8 c6 0e 00 00       	call   80101903 <ilock>

  return target - n;
80100a3d:	8b 45 10             	mov    0x10(%ebp),%eax
80100a40:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100a43:	29 c2                	sub    %eax,%edx
80100a45:	89 d0                	mov    %edx,%eax
}
80100a47:	c9                   	leave  
80100a48:	c3                   	ret    

80100a49 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100a49:	55                   	push   %ebp
80100a4a:	89 e5                	mov    %esp,%ebp
80100a4c:	83 ec 28             	sub    $0x28,%esp
  int i;

  iunlock(ip);
80100a4f:	8b 45 08             	mov    0x8(%ebp),%eax
80100a52:	89 04 24             	mov    %eax,(%esp)
80100a55:	e8 07 10 00 00       	call   80101a61 <iunlock>
  acquire(&cons.lock);
80100a5a:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
80100a61:	e8 32 45 00 00       	call   80104f98 <acquire>
  for(i = 0; i < n; i++)
80100a66:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80100a6d:	eb 1d                	jmp    80100a8c <consolewrite+0x43>
    consputc(buf[i] & 0xff);
80100a6f:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100a72:	8b 45 0c             	mov    0xc(%ebp),%eax
80100a75:	01 d0                	add    %edx,%eax
80100a77:	0f b6 00             	movzbl (%eax),%eax
80100a7a:	0f be c0             	movsbl %al,%eax
80100a7d:	0f b6 c0             	movzbl %al,%eax
80100a80:	89 04 24             	mov    %eax,(%esp)
80100a83:	e8 e3 fc ff ff       	call   8010076b <consputc>
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
80100a88:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100a8c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100a8f:	3b 45 10             	cmp    0x10(%ebp),%eax
80100a92:	7c db                	jl     80100a6f <consolewrite+0x26>
    consputc(buf[i] & 0xff);
  release(&cons.lock);
80100a94:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
80100a9b:	e8 5f 45 00 00       	call   80104fff <release>
  ilock(ip);
80100aa0:	8b 45 08             	mov    0x8(%ebp),%eax
80100aa3:	89 04 24             	mov    %eax,(%esp)
80100aa6:	e8 58 0e 00 00       	call   80101903 <ilock>

  return n;
80100aab:	8b 45 10             	mov    0x10(%ebp),%eax
}
80100aae:	c9                   	leave  
80100aaf:	c3                   	ret    

80100ab0 <consoleinit>:

void
consoleinit(void)
{
80100ab0:	55                   	push   %ebp
80100ab1:	89 e5                	mov    %esp,%ebp
80100ab3:	83 ec 18             	sub    $0x18,%esp
  initlock(&cons.lock, "console");
80100ab6:	c7 44 24 04 1a 85 10 	movl   $0x8010851a,0x4(%esp)
80100abd:	80 
80100abe:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
80100ac5:	e8 ac 44 00 00       	call   80104f76 <initlock>

  devsw[CONSOLE].write = consolewrite;
80100aca:	c7 05 cc 11 11 80 49 	movl   $0x80100a49,0x801111cc
80100ad1:	0a 10 80 
  devsw[CONSOLE].read = consoleread;
80100ad4:	c7 05 c8 11 11 80 4a 	movl   $0x8010094a,0x801111c8
80100adb:	09 10 80 
  cons.locking = 1;
80100ade:	c7 05 f4 b5 10 80 01 	movl   $0x1,0x8010b5f4
80100ae5:	00 00 00 

  picenable(IRQ_KBD);
80100ae8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80100aef:	e8 d0 33 00 00       	call   80103ec4 <picenable>
  ioapicenable(IRQ_KBD, 0);
80100af4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80100afb:	00 
80100afc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80100b03:	e8 6b 1f 00 00       	call   80102a73 <ioapicenable>
}
80100b08:	c9                   	leave  
80100b09:	c3                   	ret    

80100b0a <exec>:
80100b0a:	55                   	push   %ebp
80100b0b:	89 e5                	mov    %esp,%ebp
80100b0d:	81 ec 18 01 00 00    	sub    $0x118,%esp
80100b13:	e8 ce 29 00 00       	call   801034e6 <begin_op>
80100b18:	83 ec 0c             	sub    $0xc,%esp
80100b1b:	ff 75 08             	pushl  0x8(%ebp)
80100b1e:	e8 9e 19 00 00       	call   801024c1 <namei>
80100b23:	83 c4 10             	add    $0x10,%esp
80100b26:	89 45 d8             	mov    %eax,-0x28(%ebp)
80100b29:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
80100b2d:	75 0f                	jne    80100b3e <exec+0x34>
80100b2f:	e8 3e 2a 00 00       	call   80103572 <end_op>
80100b34:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100b39:	e9 ce 03 00 00       	jmp    80100f0c <exec+0x402>
80100b3e:	83 ec 0c             	sub    $0xc,%esp
80100b41:	ff 75 d8             	pushl  -0x28(%ebp)
80100b44:	e8 ba 0d 00 00       	call   80101903 <ilock>
80100b49:	83 c4 10             	add    $0x10,%esp
80100b4c:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
80100b53:	6a 34                	push   $0x34
80100b55:	6a 00                	push   $0x0
80100b57:	8d 85 0c ff ff ff    	lea    -0xf4(%ebp),%eax
80100b5d:	50                   	push   %eax
80100b5e:	ff 75 d8             	pushl  -0x28(%ebp)
80100b61:	e8 0b 13 00 00       	call   80101e71 <readi>
80100b66:	83 c4 10             	add    $0x10,%esp
80100b69:	83 f8 33             	cmp    $0x33,%eax
80100b6c:	0f 86 49 03 00 00    	jbe    80100ebb <exec+0x3b1>
80100b72:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100b78:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
80100b7d:	0f 85 3b 03 00 00    	jne    80100ebe <exec+0x3b4>
80100b83:	e8 12 71 00 00       	call   80107c9a <setupkvm>
80100b88:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80100b8b:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
80100b8f:	0f 84 2c 03 00 00    	je     80100ec1 <exec+0x3b7>
80100b95:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
80100b9c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
80100ba3:	8b 85 28 ff ff ff    	mov    -0xd8(%ebp),%eax
80100ba9:	89 45 e8             	mov    %eax,-0x18(%ebp)
80100bac:	e9 ab 00 00 00       	jmp    80100c5c <exec+0x152>
80100bb1:	8b 45 e8             	mov    -0x18(%ebp),%eax
80100bb4:	6a 20                	push   $0x20
80100bb6:	50                   	push   %eax
80100bb7:	8d 85 ec fe ff ff    	lea    -0x114(%ebp),%eax
80100bbd:	50                   	push   %eax
80100bbe:	ff 75 d8             	pushl  -0x28(%ebp)
80100bc1:	e8 ab 12 00 00       	call   80101e71 <readi>
80100bc6:	83 c4 10             	add    $0x10,%esp
80100bc9:	83 f8 20             	cmp    $0x20,%eax
80100bcc:	0f 85 f2 02 00 00    	jne    80100ec4 <exec+0x3ba>
80100bd2:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80100bd8:	83 f8 01             	cmp    $0x1,%eax
80100bdb:	75 71                	jne    80100c4e <exec+0x144>
80100bdd:	8b 95 00 ff ff ff    	mov    -0x100(%ebp),%edx
80100be3:	8b 85 fc fe ff ff    	mov    -0x104(%ebp),%eax
80100be9:	39 c2                	cmp    %eax,%edx
80100beb:	0f 82 d6 02 00 00    	jb     80100ec7 <exec+0x3bd>
80100bf1:	8b 95 f4 fe ff ff    	mov    -0x10c(%ebp),%edx
80100bf7:	8b 85 00 ff ff ff    	mov    -0x100(%ebp),%eax
80100bfd:	01 d0                	add    %edx,%eax
80100bff:	83 ec 04             	sub    $0x4,%esp
80100c02:	50                   	push   %eax
80100c03:	ff 75 e0             	pushl  -0x20(%ebp)
80100c06:	ff 75 d4             	pushl  -0x2c(%ebp)
80100c09:	e8 33 74 00 00       	call   80108041 <allocuvm>
80100c0e:	83 c4 10             	add    $0x10,%esp
80100c11:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100c14:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80100c18:	0f 84 ac 02 00 00    	je     80100eca <exec+0x3c0>
80100c1e:	8b 95 fc fe ff ff    	mov    -0x104(%ebp),%edx
80100c24:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100c2a:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
80100c30:	83 ec 0c             	sub    $0xc,%esp
80100c33:	52                   	push   %edx
80100c34:	50                   	push   %eax
80100c35:	ff 75 d8             	pushl  -0x28(%ebp)
80100c38:	51                   	push   %ecx
80100c39:	ff 75 d4             	pushl  -0x2c(%ebp)
80100c3c:	e8 29 73 00 00       	call   80107f6a <loaduvm>
80100c41:	83 c4 20             	add    $0x20,%esp
80100c44:	85 c0                	test   %eax,%eax
80100c46:	0f 88 81 02 00 00    	js     80100ecd <exec+0x3c3>
80100c4c:	eb 01                	jmp    80100c4f <exec+0x145>
80100c4e:	90                   	nop
80100c4f:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
80100c53:	8b 45 e8             	mov    -0x18(%ebp),%eax
80100c56:	83 c0 20             	add    $0x20,%eax
80100c59:	89 45 e8             	mov    %eax,-0x18(%ebp)
80100c5c:	0f b7 85 38 ff ff ff 	movzwl -0xc8(%ebp),%eax
80100c63:	0f b7 c0             	movzwl %ax,%eax
80100c66:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80100c69:	0f 8f 42 ff ff ff    	jg     80100bb1 <exec+0xa7>
80100c6f:	83 ec 0c             	sub    $0xc,%esp
80100c72:	ff 75 d8             	pushl  -0x28(%ebp)
80100c75:	e8 49 0f 00 00       	call   80101bc3 <iunlockput>
80100c7a:	83 c4 10             	add    $0x10,%esp
80100c7d:	e8 f0 28 00 00       	call   80103572 <end_op>
80100c82:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
80100c89:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100c8c:	05 ff 0f 00 00       	add    $0xfff,%eax
80100c91:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80100c96:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100c99:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100c9c:	05 00 20 00 00       	add    $0x2000,%eax
80100ca1:	83 ec 04             	sub    $0x4,%esp
80100ca4:	50                   	push   %eax
80100ca5:	ff 75 e0             	pushl  -0x20(%ebp)
80100ca8:	ff 75 d4             	pushl  -0x2c(%ebp)
80100cab:	e8 91 73 00 00       	call   80108041 <allocuvm>
80100cb0:	83 c4 10             	add    $0x10,%esp
80100cb3:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100cb6:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80100cba:	0f 84 10 02 00 00    	je     80100ed0 <exec+0x3c6>
80100cc0:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100cc3:	2d 00 20 00 00       	sub    $0x2000,%eax
80100cc8:	83 ec 08             	sub    $0x8,%esp
80100ccb:	50                   	push   %eax
80100ccc:	ff 75 d4             	pushl  -0x2c(%ebp)
80100ccf:	e8 93 75 00 00       	call   80108267 <clearpteu>
80100cd4:	83 c4 10             	add    $0x10,%esp
80100cd7:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100cda:	89 45 dc             	mov    %eax,-0x24(%ebp)
80100cdd:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80100ce4:	e9 96 00 00 00       	jmp    80100d7f <exec+0x275>
80100ce9:	83 7d e4 1f          	cmpl   $0x1f,-0x1c(%ebp)
80100ced:	0f 87 e0 01 00 00    	ja     80100ed3 <exec+0x3c9>
80100cf3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100cf6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100cfd:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d00:	01 d0                	add    %edx,%eax
80100d02:	8b 00                	mov    (%eax),%eax
80100d04:	83 ec 0c             	sub    $0xc,%esp
80100d07:	50                   	push   %eax
80100d08:	e8 3b 47 00 00       	call   80105448 <strlen>
80100d0d:	83 c4 10             	add    $0x10,%esp
80100d10:	89 c2                	mov    %eax,%edx
80100d12:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100d15:	29 d0                	sub    %edx,%eax
80100d17:	83 e8 01             	sub    $0x1,%eax
80100d1a:	83 e0 fc             	and    $0xfffffffc,%eax
80100d1d:	89 45 dc             	mov    %eax,-0x24(%ebp)
80100d20:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100d23:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100d2a:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d2d:	01 d0                	add    %edx,%eax
80100d2f:	8b 00                	mov    (%eax),%eax
80100d31:	83 ec 0c             	sub    $0xc,%esp
80100d34:	50                   	push   %eax
80100d35:	e8 0e 47 00 00       	call   80105448 <strlen>
80100d3a:	83 c4 10             	add    $0x10,%esp
80100d3d:	83 c0 01             	add    $0x1,%eax
80100d40:	89 c1                	mov    %eax,%ecx
80100d42:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100d45:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100d4c:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d4f:	01 d0                	add    %edx,%eax
80100d51:	8b 00                	mov    (%eax),%eax
80100d53:	51                   	push   %ecx
80100d54:	50                   	push   %eax
80100d55:	ff 75 dc             	pushl  -0x24(%ebp)
80100d58:	ff 75 d4             	pushl  -0x2c(%ebp)
80100d5b:	e8 be 76 00 00       	call   8010841e <copyout>
80100d60:	83 c4 10             	add    $0x10,%esp
80100d63:	85 c0                	test   %eax,%eax
80100d65:	0f 88 6b 01 00 00    	js     80100ed6 <exec+0x3cc>
80100d6b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100d6e:	8d 50 03             	lea    0x3(%eax),%edx
80100d71:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100d74:	89 84 95 40 ff ff ff 	mov    %eax,-0xc0(%ebp,%edx,4)
80100d7b:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
80100d7f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100d82:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100d89:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d8c:	01 d0                	add    %edx,%eax
80100d8e:	8b 00                	mov    (%eax),%eax
80100d90:	85 c0                	test   %eax,%eax
80100d92:	0f 85 51 ff ff ff    	jne    80100ce9 <exec+0x1df>
80100d98:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100d9b:	83 c0 03             	add    $0x3,%eax
80100d9e:	c7 84 85 40 ff ff ff 	movl   $0x0,-0xc0(%ebp,%eax,4)
80100da5:	00 00 00 00 
80100da9:	c7 85 40 ff ff ff ff 	movl   $0xffffffff,-0xc0(%ebp)
80100db0:	ff ff ff 
80100db3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100db6:	89 85 44 ff ff ff    	mov    %eax,-0xbc(%ebp)
80100dbc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100dbf:	83 c0 01             	add    $0x1,%eax
80100dc2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100dc9:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100dcc:	29 d0                	sub    %edx,%eax
80100dce:	89 85 48 ff ff ff    	mov    %eax,-0xb8(%ebp)
80100dd4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100dd7:	83 c0 04             	add    $0x4,%eax
80100dda:	c1 e0 02             	shl    $0x2,%eax
80100ddd:	29 45 dc             	sub    %eax,-0x24(%ebp)
80100de0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100de3:	83 c0 04             	add    $0x4,%eax
80100de6:	c1 e0 02             	shl    $0x2,%eax
80100de9:	50                   	push   %eax
80100dea:	8d 85 40 ff ff ff    	lea    -0xc0(%ebp),%eax
80100df0:	50                   	push   %eax
80100df1:	ff 75 dc             	pushl  -0x24(%ebp)
80100df4:	ff 75 d4             	pushl  -0x2c(%ebp)
80100df7:	e8 22 76 00 00       	call   8010841e <copyout>
80100dfc:	83 c4 10             	add    $0x10,%esp
80100dff:	85 c0                	test   %eax,%eax
80100e01:	0f 88 d2 00 00 00    	js     80100ed9 <exec+0x3cf>
80100e07:	8b 45 08             	mov    0x8(%ebp),%eax
80100e0a:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100e0d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100e10:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100e13:	eb 17                	jmp    80100e2c <exec+0x322>
80100e15:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100e18:	0f b6 00             	movzbl (%eax),%eax
80100e1b:	3c 2f                	cmp    $0x2f,%al
80100e1d:	75 09                	jne    80100e28 <exec+0x31e>
80100e1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100e22:	83 c0 01             	add    $0x1,%eax
80100e25:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100e28:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100e2c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100e2f:	0f b6 00             	movzbl (%eax),%eax
80100e32:	84 c0                	test   %al,%al
80100e34:	75 df                	jne    80100e15 <exec+0x30b>
80100e36:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100e3c:	83 c0 6c             	add    $0x6c,%eax
80100e3f:	83 ec 04             	sub    $0x4,%esp
80100e42:	6a 10                	push   $0x10
80100e44:	ff 75 f0             	pushl  -0x10(%ebp)
80100e47:	50                   	push   %eax
80100e48:	e8 b1 45 00 00       	call   801053fe <safestrcpy>
80100e4d:	83 c4 10             	add    $0x10,%esp
80100e50:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100e56:	8b 40 04             	mov    0x4(%eax),%eax
80100e59:	89 45 d0             	mov    %eax,-0x30(%ebp)
80100e5c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100e62:	8b 55 d4             	mov    -0x2c(%ebp),%edx
80100e65:	89 50 04             	mov    %edx,0x4(%eax)
80100e68:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100e6e:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100e71:	89 10                	mov    %edx,(%eax)
80100e73:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100e79:	8b 40 18             	mov    0x18(%eax),%eax
80100e7c:	8b 95 24 ff ff ff    	mov    -0xdc(%ebp),%edx
80100e82:	89 50 38             	mov    %edx,0x38(%eax)
80100e85:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100e8b:	8b 40 18             	mov    0x18(%eax),%eax
80100e8e:	8b 55 dc             	mov    -0x24(%ebp),%edx
80100e91:	89 50 44             	mov    %edx,0x44(%eax)
80100e94:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100e9a:	83 ec 0c             	sub    $0xc,%esp
80100e9d:	50                   	push   %eax
80100e9e:	e8 de 6e 00 00       	call   80107d81 <switchuvm>
80100ea3:	83 c4 10             	add    $0x10,%esp
80100ea6:	83 ec 0c             	sub    $0xc,%esp
80100ea9:	ff 75 d0             	pushl  -0x30(%ebp)
80100eac:	e8 16 73 00 00       	call   801081c7 <freevm>
80100eb1:	83 c4 10             	add    $0x10,%esp
80100eb4:	b8 00 00 00 00       	mov    $0x0,%eax
80100eb9:	eb 51                	jmp    80100f0c <exec+0x402>
80100ebb:	90                   	nop
80100ebc:	eb 1c                	jmp    80100eda <exec+0x3d0>
80100ebe:	90                   	nop
80100ebf:	eb 19                	jmp    80100eda <exec+0x3d0>
80100ec1:	90                   	nop
80100ec2:	eb 16                	jmp    80100eda <exec+0x3d0>
80100ec4:	90                   	nop
80100ec5:	eb 13                	jmp    80100eda <exec+0x3d0>
80100ec7:	90                   	nop
80100ec8:	eb 10                	jmp    80100eda <exec+0x3d0>
80100eca:	90                   	nop
80100ecb:	eb 0d                	jmp    80100eda <exec+0x3d0>
80100ecd:	90                   	nop
80100ece:	eb 0a                	jmp    80100eda <exec+0x3d0>
80100ed0:	90                   	nop
80100ed1:	eb 07                	jmp    80100eda <exec+0x3d0>
80100ed3:	90                   	nop
80100ed4:	eb 04                	jmp    80100eda <exec+0x3d0>
80100ed6:	90                   	nop
80100ed7:	eb 01                	jmp    80100eda <exec+0x3d0>
80100ed9:	90                   	nop
80100eda:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
80100ede:	74 0e                	je     80100eee <exec+0x3e4>
80100ee0:	83 ec 0c             	sub    $0xc,%esp
80100ee3:	ff 75 d4             	pushl  -0x2c(%ebp)
80100ee6:	e8 dc 72 00 00       	call   801081c7 <freevm>
80100eeb:	83 c4 10             	add    $0x10,%esp
80100eee:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
80100ef2:	74 13                	je     80100f07 <exec+0x3fd>
80100ef4:	83 ec 0c             	sub    $0xc,%esp
80100ef7:	ff 75 d8             	pushl  -0x28(%ebp)
80100efa:	e8 c4 0c 00 00       	call   80101bc3 <iunlockput>
80100eff:	83 c4 10             	add    $0x10,%esp
80100f02:	e8 6b 26 00 00       	call   80103572 <end_op>
80100f07:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100f0c:	c9                   	leave  
80100f0d:	c3                   	ret    

80100f0e <fileinit>:
80100f0e:	55                   	push   %ebp
80100f0f:	89 e5                	mov    %esp,%ebp
80100f11:	83 ec 08             	sub    $0x8,%esp
80100f14:	83 ec 08             	sub    $0x8,%esp
80100f17:	68 22 85 10 80       	push   $0x80108522
80100f1c:	68 20 08 11 80       	push   $0x80110820
80100f21:	e8 50 40 00 00       	call   80104f76 <initlock>
80100f26:	83 c4 10             	add    $0x10,%esp
80100f29:	90                   	nop
80100f2a:	c9                   	leave  
80100f2b:	c3                   	ret    

80100f2c <filealloc>:
80100f2c:	55                   	push   %ebp
80100f2d:	89 e5                	mov    %esp,%ebp
80100f2f:	83 ec 18             	sub    $0x18,%esp
80100f32:	83 ec 0c             	sub    $0xc,%esp
80100f35:	68 20 08 11 80       	push   $0x80110820
80100f3a:	e8 59 40 00 00       	call   80104f98 <acquire>
80100f3f:	83 c4 10             	add    $0x10,%esp
80100f42:	c7 45 f4 54 08 11 80 	movl   $0x80110854,-0xc(%ebp)
80100f49:	eb 2d                	jmp    80100f78 <filealloc+0x4c>
80100f4b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100f4e:	8b 40 04             	mov    0x4(%eax),%eax
80100f51:	85 c0                	test   %eax,%eax
80100f53:	75 1f                	jne    80100f74 <filealloc+0x48>
80100f55:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100f58:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%eax)
80100f5f:	83 ec 0c             	sub    $0xc,%esp
80100f62:	68 20 08 11 80       	push   $0x80110820
80100f67:	e8 93 40 00 00       	call   80104fff <release>
80100f6c:	83 c4 10             	add    $0x10,%esp
80100f6f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100f72:	eb 23                	jmp    80100f97 <filealloc+0x6b>
80100f74:	83 45 f4 18          	addl   $0x18,-0xc(%ebp)
80100f78:	b8 b4 11 11 80       	mov    $0x801111b4,%eax
80100f7d:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80100f80:	72 c9                	jb     80100f4b <filealloc+0x1f>
80100f82:	83 ec 0c             	sub    $0xc,%esp
80100f85:	68 20 08 11 80       	push   $0x80110820
80100f8a:	e8 70 40 00 00       	call   80104fff <release>
80100f8f:	83 c4 10             	add    $0x10,%esp
80100f92:	b8 00 00 00 00       	mov    $0x0,%eax
80100f97:	c9                   	leave  
80100f98:	c3                   	ret    

80100f99 <filedup>:
80100f99:	55                   	push   %ebp
80100f9a:	89 e5                	mov    %esp,%ebp
80100f9c:	83 ec 08             	sub    $0x8,%esp
80100f9f:	83 ec 0c             	sub    $0xc,%esp
80100fa2:	68 20 08 11 80       	push   $0x80110820
80100fa7:	e8 ec 3f 00 00       	call   80104f98 <acquire>
80100fac:	83 c4 10             	add    $0x10,%esp
80100faf:	8b 45 08             	mov    0x8(%ebp),%eax
80100fb2:	8b 40 04             	mov    0x4(%eax),%eax
80100fb5:	85 c0                	test   %eax,%eax
80100fb7:	7f 0d                	jg     80100fc6 <filedup+0x2d>
80100fb9:	83 ec 0c             	sub    $0xc,%esp
80100fbc:	68 29 85 10 80       	push   $0x80108529
80100fc1:	e8 74 f5 ff ff       	call   8010053a <panic>
80100fc6:	8b 45 08             	mov    0x8(%ebp),%eax
80100fc9:	8b 40 04             	mov    0x4(%eax),%eax
80100fcc:	8d 50 01             	lea    0x1(%eax),%edx
80100fcf:	8b 45 08             	mov    0x8(%ebp),%eax
80100fd2:	89 50 04             	mov    %edx,0x4(%eax)
80100fd5:	83 ec 0c             	sub    $0xc,%esp
80100fd8:	68 20 08 11 80       	push   $0x80110820
80100fdd:	e8 1d 40 00 00       	call   80104fff <release>
80100fe2:	83 c4 10             	add    $0x10,%esp
80100fe5:	8b 45 08             	mov    0x8(%ebp),%eax
80100fe8:	c9                   	leave  
80100fe9:	c3                   	ret    

80100fea <fileclose>:
80100fea:	55                   	push   %ebp
80100feb:	89 e5                	mov    %esp,%ebp
80100fed:	83 ec 28             	sub    $0x28,%esp
80100ff0:	83 ec 0c             	sub    $0xc,%esp
80100ff3:	68 20 08 11 80       	push   $0x80110820
80100ff8:	e8 9b 3f 00 00       	call   80104f98 <acquire>
80100ffd:	83 c4 10             	add    $0x10,%esp
80101000:	8b 45 08             	mov    0x8(%ebp),%eax
80101003:	8b 40 04             	mov    0x4(%eax),%eax
80101006:	85 c0                	test   %eax,%eax
80101008:	7f 0d                	jg     80101017 <fileclose+0x2d>
8010100a:	83 ec 0c             	sub    $0xc,%esp
8010100d:	68 31 85 10 80       	push   $0x80108531
80101012:	e8 23 f5 ff ff       	call   8010053a <panic>
80101017:	8b 45 08             	mov    0x8(%ebp),%eax
8010101a:	8b 40 04             	mov    0x4(%eax),%eax
8010101d:	8d 50 ff             	lea    -0x1(%eax),%edx
80101020:	8b 45 08             	mov    0x8(%ebp),%eax
80101023:	89 50 04             	mov    %edx,0x4(%eax)
80101026:	8b 45 08             	mov    0x8(%ebp),%eax
80101029:	8b 40 04             	mov    0x4(%eax),%eax
8010102c:	85 c0                	test   %eax,%eax
8010102e:	7e 15                	jle    80101045 <fileclose+0x5b>
80101030:	83 ec 0c             	sub    $0xc,%esp
80101033:	68 20 08 11 80       	push   $0x80110820
80101038:	e8 c2 3f 00 00       	call   80104fff <release>
8010103d:	83 c4 10             	add    $0x10,%esp
80101040:	e9 8b 00 00 00       	jmp    801010d0 <fileclose+0xe6>
80101045:	8b 45 08             	mov    0x8(%ebp),%eax
80101048:	8b 10                	mov    (%eax),%edx
8010104a:	89 55 e0             	mov    %edx,-0x20(%ebp)
8010104d:	8b 50 04             	mov    0x4(%eax),%edx
80101050:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101053:	8b 50 08             	mov    0x8(%eax),%edx
80101056:	89 55 e8             	mov    %edx,-0x18(%ebp)
80101059:	8b 50 0c             	mov    0xc(%eax),%edx
8010105c:	89 55 ec             	mov    %edx,-0x14(%ebp)
8010105f:	8b 50 10             	mov    0x10(%eax),%edx
80101062:	89 55 f0             	mov    %edx,-0x10(%ebp)
80101065:	8b 40 14             	mov    0x14(%eax),%eax
80101068:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010106b:	8b 45 08             	mov    0x8(%ebp),%eax
8010106e:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
80101075:	8b 45 08             	mov    0x8(%ebp),%eax
80101078:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
8010107e:	83 ec 0c             	sub    $0xc,%esp
80101081:	68 20 08 11 80       	push   $0x80110820
80101086:	e8 74 3f 00 00       	call   80104fff <release>
8010108b:	83 c4 10             	add    $0x10,%esp
8010108e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101091:	83 f8 01             	cmp    $0x1,%eax
80101094:	75 19                	jne    801010af <fileclose+0xc5>
80101096:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
8010109a:	0f be d0             	movsbl %al,%edx
8010109d:	8b 45 ec             	mov    -0x14(%ebp),%eax
801010a0:	83 ec 08             	sub    $0x8,%esp
801010a3:	52                   	push   %edx
801010a4:	50                   	push   %eax
801010a5:	e8 83 30 00 00       	call   8010412d <pipeclose>
801010aa:	83 c4 10             	add    $0x10,%esp
801010ad:	eb 21                	jmp    801010d0 <fileclose+0xe6>
801010af:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010b2:	83 f8 02             	cmp    $0x2,%eax
801010b5:	75 19                	jne    801010d0 <fileclose+0xe6>
801010b7:	e8 2a 24 00 00       	call   801034e6 <begin_op>
801010bc:	8b 45 f0             	mov    -0x10(%ebp),%eax
801010bf:	83 ec 0c             	sub    $0xc,%esp
801010c2:	50                   	push   %eax
801010c3:	e8 0b 0a 00 00       	call   80101ad3 <iput>
801010c8:	83 c4 10             	add    $0x10,%esp
801010cb:	e8 a2 24 00 00       	call   80103572 <end_op>
801010d0:	c9                   	leave  
801010d1:	c3                   	ret    

801010d2 <filestat>:
801010d2:	55                   	push   %ebp
801010d3:	89 e5                	mov    %esp,%ebp
801010d5:	83 ec 08             	sub    $0x8,%esp
801010d8:	8b 45 08             	mov    0x8(%ebp),%eax
801010db:	8b 00                	mov    (%eax),%eax
801010dd:	83 f8 02             	cmp    $0x2,%eax
801010e0:	75 40                	jne    80101122 <filestat+0x50>
801010e2:	8b 45 08             	mov    0x8(%ebp),%eax
801010e5:	8b 40 10             	mov    0x10(%eax),%eax
801010e8:	83 ec 0c             	sub    $0xc,%esp
801010eb:	50                   	push   %eax
801010ec:	e8 12 08 00 00       	call   80101903 <ilock>
801010f1:	83 c4 10             	add    $0x10,%esp
801010f4:	8b 45 08             	mov    0x8(%ebp),%eax
801010f7:	8b 40 10             	mov    0x10(%eax),%eax
801010fa:	83 ec 08             	sub    $0x8,%esp
801010fd:	ff 75 0c             	pushl  0xc(%ebp)
80101100:	50                   	push   %eax
80101101:	e8 25 0d 00 00       	call   80101e2b <stati>
80101106:	83 c4 10             	add    $0x10,%esp
80101109:	8b 45 08             	mov    0x8(%ebp),%eax
8010110c:	8b 40 10             	mov    0x10(%eax),%eax
8010110f:	83 ec 0c             	sub    $0xc,%esp
80101112:	50                   	push   %eax
80101113:	e8 49 09 00 00       	call   80101a61 <iunlock>
80101118:	83 c4 10             	add    $0x10,%esp
8010111b:	b8 00 00 00 00       	mov    $0x0,%eax
80101120:	eb 05                	jmp    80101127 <filestat+0x55>
80101122:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101127:	c9                   	leave  
80101128:	c3                   	ret    

80101129 <fileread>:
80101129:	55                   	push   %ebp
8010112a:	89 e5                	mov    %esp,%ebp
8010112c:	83 ec 18             	sub    $0x18,%esp
8010112f:	8b 45 08             	mov    0x8(%ebp),%eax
80101132:	0f b6 40 08          	movzbl 0x8(%eax),%eax
80101136:	84 c0                	test   %al,%al
80101138:	75 0a                	jne    80101144 <fileread+0x1b>
8010113a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010113f:	e9 9b 00 00 00       	jmp    801011df <fileread+0xb6>
80101144:	8b 45 08             	mov    0x8(%ebp),%eax
80101147:	8b 00                	mov    (%eax),%eax
80101149:	83 f8 01             	cmp    $0x1,%eax
8010114c:	75 1a                	jne    80101168 <fileread+0x3f>
8010114e:	8b 45 08             	mov    0x8(%ebp),%eax
80101151:	8b 40 0c             	mov    0xc(%eax),%eax
80101154:	83 ec 04             	sub    $0x4,%esp
80101157:	ff 75 10             	pushl  0x10(%ebp)
8010115a:	ff 75 0c             	pushl  0xc(%ebp)
8010115d:	50                   	push   %eax
8010115e:	e8 72 31 00 00       	call   801042d5 <piperead>
80101163:	83 c4 10             	add    $0x10,%esp
80101166:	eb 77                	jmp    801011df <fileread+0xb6>
80101168:	8b 45 08             	mov    0x8(%ebp),%eax
8010116b:	8b 00                	mov    (%eax),%eax
8010116d:	83 f8 02             	cmp    $0x2,%eax
80101170:	75 60                	jne    801011d2 <fileread+0xa9>
80101172:	8b 45 08             	mov    0x8(%ebp),%eax
80101175:	8b 40 10             	mov    0x10(%eax),%eax
80101178:	83 ec 0c             	sub    $0xc,%esp
8010117b:	50                   	push   %eax
8010117c:	e8 82 07 00 00       	call   80101903 <ilock>
80101181:	83 c4 10             	add    $0x10,%esp
80101184:	8b 4d 10             	mov    0x10(%ebp),%ecx
80101187:	8b 45 08             	mov    0x8(%ebp),%eax
8010118a:	8b 50 14             	mov    0x14(%eax),%edx
8010118d:	8b 45 08             	mov    0x8(%ebp),%eax
80101190:	8b 40 10             	mov    0x10(%eax),%eax
80101193:	51                   	push   %ecx
80101194:	52                   	push   %edx
80101195:	ff 75 0c             	pushl  0xc(%ebp)
80101198:	50                   	push   %eax
80101199:	e8 d3 0c 00 00       	call   80101e71 <readi>
8010119e:	83 c4 10             	add    $0x10,%esp
801011a1:	89 45 f4             	mov    %eax,-0xc(%ebp)
801011a4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801011a8:	7e 11                	jle    801011bb <fileread+0x92>
801011aa:	8b 45 08             	mov    0x8(%ebp),%eax
801011ad:	8b 50 14             	mov    0x14(%eax),%edx
801011b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801011b3:	01 c2                	add    %eax,%edx
801011b5:	8b 45 08             	mov    0x8(%ebp),%eax
801011b8:	89 50 14             	mov    %edx,0x14(%eax)
801011bb:	8b 45 08             	mov    0x8(%ebp),%eax
801011be:	8b 40 10             	mov    0x10(%eax),%eax
801011c1:	83 ec 0c             	sub    $0xc,%esp
801011c4:	50                   	push   %eax
801011c5:	e8 97 08 00 00       	call   80101a61 <iunlock>
801011ca:	83 c4 10             	add    $0x10,%esp
801011cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801011d0:	eb 0d                	jmp    801011df <fileread+0xb6>
801011d2:	83 ec 0c             	sub    $0xc,%esp
801011d5:	68 3b 85 10 80       	push   $0x8010853b
801011da:	e8 5b f3 ff ff       	call   8010053a <panic>
801011df:	c9                   	leave  
801011e0:	c3                   	ret    

801011e1 <filewrite>:
801011e1:	55                   	push   %ebp
801011e2:	89 e5                	mov    %esp,%ebp
801011e4:	53                   	push   %ebx
801011e5:	83 ec 14             	sub    $0x14,%esp
801011e8:	8b 45 08             	mov    0x8(%ebp),%eax
801011eb:	0f b6 40 09          	movzbl 0x9(%eax),%eax
801011ef:	84 c0                	test   %al,%al
801011f1:	75 0a                	jne    801011fd <filewrite+0x1c>
801011f3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801011f8:	e9 1b 01 00 00       	jmp    80101318 <filewrite+0x137>
801011fd:	8b 45 08             	mov    0x8(%ebp),%eax
80101200:	8b 00                	mov    (%eax),%eax
80101202:	83 f8 01             	cmp    $0x1,%eax
80101205:	75 1d                	jne    80101224 <filewrite+0x43>
80101207:	8b 45 08             	mov    0x8(%ebp),%eax
8010120a:	8b 40 0c             	mov    0xc(%eax),%eax
8010120d:	83 ec 04             	sub    $0x4,%esp
80101210:	ff 75 10             	pushl  0x10(%ebp)
80101213:	ff 75 0c             	pushl  0xc(%ebp)
80101216:	50                   	push   %eax
80101217:	e8 bb 2f 00 00       	call   801041d7 <pipewrite>
8010121c:	83 c4 10             	add    $0x10,%esp
8010121f:	e9 f4 00 00 00       	jmp    80101318 <filewrite+0x137>
80101224:	8b 45 08             	mov    0x8(%ebp),%eax
80101227:	8b 00                	mov    (%eax),%eax
80101229:	83 f8 02             	cmp    $0x2,%eax
8010122c:	0f 85 d9 00 00 00    	jne    8010130b <filewrite+0x12a>
80101232:	c7 45 ec 00 1a 00 00 	movl   $0x1a00,-0x14(%ebp)
80101239:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80101240:	e9 a3 00 00 00       	jmp    801012e8 <filewrite+0x107>
80101245:	8b 45 10             	mov    0x10(%ebp),%eax
80101248:	2b 45 f4             	sub    -0xc(%ebp),%eax
8010124b:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010124e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101251:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80101254:	7e 06                	jle    8010125c <filewrite+0x7b>
80101256:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101259:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010125c:	e8 85 22 00 00       	call   801034e6 <begin_op>
80101261:	8b 45 08             	mov    0x8(%ebp),%eax
80101264:	8b 40 10             	mov    0x10(%eax),%eax
80101267:	83 ec 0c             	sub    $0xc,%esp
8010126a:	50                   	push   %eax
8010126b:	e8 93 06 00 00       	call   80101903 <ilock>
80101270:	83 c4 10             	add    $0x10,%esp
80101273:	8b 4d f0             	mov    -0x10(%ebp),%ecx
80101276:	8b 45 08             	mov    0x8(%ebp),%eax
80101279:	8b 50 14             	mov    0x14(%eax),%edx
8010127c:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010127f:	8b 45 0c             	mov    0xc(%ebp),%eax
80101282:	01 c3                	add    %eax,%ebx
80101284:	8b 45 08             	mov    0x8(%ebp),%eax
80101287:	8b 40 10             	mov    0x10(%eax),%eax
8010128a:	51                   	push   %ecx
8010128b:	52                   	push   %edx
8010128c:	53                   	push   %ebx
8010128d:	50                   	push   %eax
8010128e:	e8 35 0d 00 00       	call   80101fc8 <writei>
80101293:	83 c4 10             	add    $0x10,%esp
80101296:	89 45 e8             	mov    %eax,-0x18(%ebp)
80101299:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
8010129d:	7e 11                	jle    801012b0 <filewrite+0xcf>
8010129f:	8b 45 08             	mov    0x8(%ebp),%eax
801012a2:	8b 50 14             	mov    0x14(%eax),%edx
801012a5:	8b 45 e8             	mov    -0x18(%ebp),%eax
801012a8:	01 c2                	add    %eax,%edx
801012aa:	8b 45 08             	mov    0x8(%ebp),%eax
801012ad:	89 50 14             	mov    %edx,0x14(%eax)
801012b0:	8b 45 08             	mov    0x8(%ebp),%eax
801012b3:	8b 40 10             	mov    0x10(%eax),%eax
801012b6:	83 ec 0c             	sub    $0xc,%esp
801012b9:	50                   	push   %eax
801012ba:	e8 a2 07 00 00       	call   80101a61 <iunlock>
801012bf:	83 c4 10             	add    $0x10,%esp
801012c2:	e8 ab 22 00 00       	call   80103572 <end_op>
801012c7:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
801012cb:	78 29                	js     801012f6 <filewrite+0x115>
801012cd:	8b 45 e8             	mov    -0x18(%ebp),%eax
801012d0:	3b 45 f0             	cmp    -0x10(%ebp),%eax
801012d3:	74 0d                	je     801012e2 <filewrite+0x101>
801012d5:	83 ec 0c             	sub    $0xc,%esp
801012d8:	68 44 85 10 80       	push   $0x80108544
801012dd:	e8 58 f2 ff ff       	call   8010053a <panic>
801012e2:	8b 45 e8             	mov    -0x18(%ebp),%eax
801012e5:	01 45 f4             	add    %eax,-0xc(%ebp)
801012e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801012eb:	3b 45 10             	cmp    0x10(%ebp),%eax
801012ee:	0f 8c 51 ff ff ff    	jl     80101245 <filewrite+0x64>
801012f4:	eb 01                	jmp    801012f7 <filewrite+0x116>
801012f6:	90                   	nop
801012f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801012fa:	3b 45 10             	cmp    0x10(%ebp),%eax
801012fd:	75 05                	jne    80101304 <filewrite+0x123>
801012ff:	8b 45 10             	mov    0x10(%ebp),%eax
80101302:	eb 14                	jmp    80101318 <filewrite+0x137>
80101304:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101309:	eb 0d                	jmp    80101318 <filewrite+0x137>
8010130b:	83 ec 0c             	sub    $0xc,%esp
8010130e:	68 54 85 10 80       	push   $0x80108554
80101313:	e8 22 f2 ff ff       	call   8010053a <panic>
80101318:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010131b:	c9                   	leave  
8010131c:	c3                   	ret    

8010131d <readsb>:
8010131d:	55                   	push   %ebp
8010131e:	89 e5                	mov    %esp,%ebp
80101320:	83 ec 18             	sub    $0x18,%esp
80101323:	8b 45 08             	mov    0x8(%ebp),%eax
80101326:	83 ec 08             	sub    $0x8,%esp
80101329:	6a 01                	push   $0x1
8010132b:	50                   	push   %eax
8010132c:	e8 75 ee ff ff       	call   801001a6 <bread>
80101331:	83 c4 10             	add    $0x10,%esp
80101334:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101337:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010133a:	83 c0 18             	add    $0x18,%eax
8010133d:	83 ec 04             	sub    $0x4,%esp
80101340:	6a 1c                	push   $0x1c
80101342:	50                   	push   %eax
80101343:	ff 75 0c             	pushl  0xc(%ebp)
80101346:	e8 6f 3f 00 00       	call   801052ba <memmove>
8010134b:	83 c4 10             	add    $0x10,%esp
8010134e:	83 ec 0c             	sub    $0xc,%esp
80101351:	ff 75 f4             	pushl  -0xc(%ebp)
80101354:	e8 be ee ff ff       	call   80100217 <brelse>
80101359:	83 c4 10             	add    $0x10,%esp
8010135c:	90                   	nop
8010135d:	c9                   	leave  
8010135e:	c3                   	ret    

8010135f <bzero>:
8010135f:	55                   	push   %ebp
80101360:	89 e5                	mov    %esp,%ebp
80101362:	83 ec 18             	sub    $0x18,%esp
80101365:	8b 55 0c             	mov    0xc(%ebp),%edx
80101368:	8b 45 08             	mov    0x8(%ebp),%eax
8010136b:	83 ec 08             	sub    $0x8,%esp
8010136e:	52                   	push   %edx
8010136f:	50                   	push   %eax
80101370:	e8 31 ee ff ff       	call   801001a6 <bread>
80101375:	83 c4 10             	add    $0x10,%esp
80101378:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010137b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010137e:	83 c0 18             	add    $0x18,%eax
80101381:	83 ec 04             	sub    $0x4,%esp
80101384:	68 00 02 00 00       	push   $0x200
80101389:	6a 00                	push   $0x0
8010138b:	50                   	push   %eax
8010138c:	e8 6a 3e 00 00       	call   801051fb <memset>
80101391:	83 c4 10             	add    $0x10,%esp
80101394:	83 ec 0c             	sub    $0xc,%esp
80101397:	ff 75 f4             	pushl  -0xc(%ebp)
8010139a:	e8 7f 23 00 00       	call   8010371e <log_write>
8010139f:	83 c4 10             	add    $0x10,%esp
801013a2:	83 ec 0c             	sub    $0xc,%esp
801013a5:	ff 75 f4             	pushl  -0xc(%ebp)
801013a8:	e8 6a ee ff ff       	call   80100217 <brelse>
801013ad:	83 c4 10             	add    $0x10,%esp
801013b0:	90                   	nop
801013b1:	c9                   	leave  
801013b2:	c3                   	ret    

801013b3 <balloc>:
801013b3:	55                   	push   %ebp
801013b4:	89 e5                	mov    %esp,%ebp
801013b6:	83 ec 18             	sub    $0x18,%esp
801013b9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
801013c0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801013c7:	e9 13 01 00 00       	jmp    801014df <balloc+0x12c>
801013cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801013cf:	8d 90 ff 0f 00 00    	lea    0xfff(%eax),%edx
801013d5:	85 c0                	test   %eax,%eax
801013d7:	0f 48 c2             	cmovs  %edx,%eax
801013da:	c1 f8 0c             	sar    $0xc,%eax
801013dd:	89 c2                	mov    %eax,%edx
801013df:	a1 38 12 11 80       	mov    0x80111238,%eax
801013e4:	01 d0                	add    %edx,%eax
801013e6:	83 ec 08             	sub    $0x8,%esp
801013e9:	50                   	push   %eax
801013ea:	ff 75 08             	pushl  0x8(%ebp)
801013ed:	e8 b4 ed ff ff       	call   801001a6 <bread>
801013f2:	83 c4 10             	add    $0x10,%esp
801013f5:	89 45 ec             	mov    %eax,-0x14(%ebp)
801013f8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
801013ff:	e9 a6 00 00 00       	jmp    801014aa <balloc+0xf7>
80101404:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101407:	99                   	cltd   
80101408:	c1 ea 1d             	shr    $0x1d,%edx
8010140b:	01 d0                	add    %edx,%eax
8010140d:	83 e0 07             	and    $0x7,%eax
80101410:	29 d0                	sub    %edx,%eax
80101412:	ba 01 00 00 00       	mov    $0x1,%edx
80101417:	89 c1                	mov    %eax,%ecx
80101419:	d3 e2                	shl    %cl,%edx
8010141b:	89 d0                	mov    %edx,%eax
8010141d:	89 45 e8             	mov    %eax,-0x18(%ebp)
80101420:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101423:	8d 50 07             	lea    0x7(%eax),%edx
80101426:	85 c0                	test   %eax,%eax
80101428:	0f 48 c2             	cmovs  %edx,%eax
8010142b:	c1 f8 03             	sar    $0x3,%eax
8010142e:	89 c2                	mov    %eax,%edx
80101430:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101433:	0f b6 44 10 18       	movzbl 0x18(%eax,%edx,1),%eax
80101438:	0f b6 c0             	movzbl %al,%eax
8010143b:	23 45 e8             	and    -0x18(%ebp),%eax
8010143e:	85 c0                	test   %eax,%eax
80101440:	75 64                	jne    801014a6 <balloc+0xf3>
80101442:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101445:	8d 50 07             	lea    0x7(%eax),%edx
80101448:	85 c0                	test   %eax,%eax
8010144a:	0f 48 c2             	cmovs  %edx,%eax
8010144d:	c1 f8 03             	sar    $0x3,%eax
80101450:	8b 55 ec             	mov    -0x14(%ebp),%edx
80101453:	0f b6 54 02 18       	movzbl 0x18(%edx,%eax,1),%edx
80101458:	89 d1                	mov    %edx,%ecx
8010145a:	8b 55 e8             	mov    -0x18(%ebp),%edx
8010145d:	09 ca                	or     %ecx,%edx
8010145f:	89 d1                	mov    %edx,%ecx
80101461:	8b 55 ec             	mov    -0x14(%ebp),%edx
80101464:	88 4c 02 18          	mov    %cl,0x18(%edx,%eax,1)
80101468:	83 ec 0c             	sub    $0xc,%esp
8010146b:	ff 75 ec             	pushl  -0x14(%ebp)
8010146e:	e8 ab 22 00 00       	call   8010371e <log_write>
80101473:	83 c4 10             	add    $0x10,%esp
80101476:	83 ec 0c             	sub    $0xc,%esp
80101479:	ff 75 ec             	pushl  -0x14(%ebp)
8010147c:	e8 96 ed ff ff       	call   80100217 <brelse>
80101481:	83 c4 10             	add    $0x10,%esp
80101484:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101487:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010148a:	01 c2                	add    %eax,%edx
8010148c:	8b 45 08             	mov    0x8(%ebp),%eax
8010148f:	83 ec 08             	sub    $0x8,%esp
80101492:	52                   	push   %edx
80101493:	50                   	push   %eax
80101494:	e8 c6 fe ff ff       	call   8010135f <bzero>
80101499:	83 c4 10             	add    $0x10,%esp
8010149c:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010149f:	8b 45 f0             	mov    -0x10(%ebp),%eax
801014a2:	01 d0                	add    %edx,%eax
801014a4:	eb 57                	jmp    801014fd <balloc+0x14a>
801014a6:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
801014aa:	81 7d f0 ff 0f 00 00 	cmpl   $0xfff,-0x10(%ebp)
801014b1:	7f 17                	jg     801014ca <balloc+0x117>
801014b3:	8b 55 f4             	mov    -0xc(%ebp),%edx
801014b6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801014b9:	01 d0                	add    %edx,%eax
801014bb:	89 c2                	mov    %eax,%edx
801014bd:	a1 20 12 11 80       	mov    0x80111220,%eax
801014c2:	39 c2                	cmp    %eax,%edx
801014c4:	0f 82 3a ff ff ff    	jb     80101404 <balloc+0x51>
801014ca:	83 ec 0c             	sub    $0xc,%esp
801014cd:	ff 75 ec             	pushl  -0x14(%ebp)
801014d0:	e8 42 ed ff ff       	call   80100217 <brelse>
801014d5:	83 c4 10             	add    $0x10,%esp
801014d8:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
801014df:	8b 15 20 12 11 80    	mov    0x80111220,%edx
801014e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801014e8:	39 c2                	cmp    %eax,%edx
801014ea:	0f 87 dc fe ff ff    	ja     801013cc <balloc+0x19>
801014f0:	83 ec 0c             	sub    $0xc,%esp
801014f3:	68 60 85 10 80       	push   $0x80108560
801014f8:	e8 3d f0 ff ff       	call   8010053a <panic>
801014fd:	c9                   	leave  
801014fe:	c3                   	ret    

801014ff <bfree>:
801014ff:	55                   	push   %ebp
80101500:	89 e5                	mov    %esp,%ebp
80101502:	83 ec 18             	sub    $0x18,%esp
80101505:	83 ec 08             	sub    $0x8,%esp
80101508:	68 20 12 11 80       	push   $0x80111220
8010150d:	ff 75 08             	pushl  0x8(%ebp)
80101510:	e8 08 fe ff ff       	call   8010131d <readsb>
80101515:	83 c4 10             	add    $0x10,%esp
80101518:	8b 45 0c             	mov    0xc(%ebp),%eax
8010151b:	c1 e8 0c             	shr    $0xc,%eax
8010151e:	89 c2                	mov    %eax,%edx
80101520:	a1 38 12 11 80       	mov    0x80111238,%eax
80101525:	01 c2                	add    %eax,%edx
80101527:	8b 45 08             	mov    0x8(%ebp),%eax
8010152a:	83 ec 08             	sub    $0x8,%esp
8010152d:	52                   	push   %edx
8010152e:	50                   	push   %eax
8010152f:	e8 72 ec ff ff       	call   801001a6 <bread>
80101534:	83 c4 10             	add    $0x10,%esp
80101537:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010153a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010153d:	25 ff 0f 00 00       	and    $0xfff,%eax
80101542:	89 45 f0             	mov    %eax,-0x10(%ebp)
80101545:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101548:	99                   	cltd   
80101549:	c1 ea 1d             	shr    $0x1d,%edx
8010154c:	01 d0                	add    %edx,%eax
8010154e:	83 e0 07             	and    $0x7,%eax
80101551:	29 d0                	sub    %edx,%eax
80101553:	ba 01 00 00 00       	mov    $0x1,%edx
80101558:	89 c1                	mov    %eax,%ecx
8010155a:	d3 e2                	shl    %cl,%edx
8010155c:	89 d0                	mov    %edx,%eax
8010155e:	89 45 ec             	mov    %eax,-0x14(%ebp)
80101561:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101564:	8d 50 07             	lea    0x7(%eax),%edx
80101567:	85 c0                	test   %eax,%eax
80101569:	0f 48 c2             	cmovs  %edx,%eax
8010156c:	c1 f8 03             	sar    $0x3,%eax
8010156f:	89 c2                	mov    %eax,%edx
80101571:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101574:	0f b6 44 10 18       	movzbl 0x18(%eax,%edx,1),%eax
80101579:	0f b6 c0             	movzbl %al,%eax
8010157c:	23 45 ec             	and    -0x14(%ebp),%eax
8010157f:	85 c0                	test   %eax,%eax
80101581:	75 0d                	jne    80101590 <bfree+0x91>
80101583:	83 ec 0c             	sub    $0xc,%esp
80101586:	68 76 85 10 80       	push   $0x80108576
8010158b:	e8 aa ef ff ff       	call   8010053a <panic>
80101590:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101593:	8d 50 07             	lea    0x7(%eax),%edx
80101596:	85 c0                	test   %eax,%eax
80101598:	0f 48 c2             	cmovs  %edx,%eax
8010159b:	c1 f8 03             	sar    $0x3,%eax
8010159e:	8b 55 f4             	mov    -0xc(%ebp),%edx
801015a1:	0f b6 54 02 18       	movzbl 0x18(%edx,%eax,1),%edx
801015a6:	89 d1                	mov    %edx,%ecx
801015a8:	8b 55 ec             	mov    -0x14(%ebp),%edx
801015ab:	f7 d2                	not    %edx
801015ad:	21 ca                	and    %ecx,%edx
801015af:	89 d1                	mov    %edx,%ecx
801015b1:	8b 55 f4             	mov    -0xc(%ebp),%edx
801015b4:	88 4c 02 18          	mov    %cl,0x18(%edx,%eax,1)
801015b8:	83 ec 0c             	sub    $0xc,%esp
801015bb:	ff 75 f4             	pushl  -0xc(%ebp)
801015be:	e8 5b 21 00 00       	call   8010371e <log_write>
801015c3:	83 c4 10             	add    $0x10,%esp
801015c6:	83 ec 0c             	sub    $0xc,%esp
801015c9:	ff 75 f4             	pushl  -0xc(%ebp)
801015cc:	e8 46 ec ff ff       	call   80100217 <brelse>
801015d1:	83 c4 10             	add    $0x10,%esp
801015d4:	90                   	nop
801015d5:	c9                   	leave  
801015d6:	c3                   	ret    

801015d7 <iinit>:
801015d7:	55                   	push   %ebp
801015d8:	89 e5                	mov    %esp,%ebp
801015da:	57                   	push   %edi
801015db:	56                   	push   %esi
801015dc:	53                   	push   %ebx
801015dd:	83 ec 1c             	sub    $0x1c,%esp
801015e0:	83 ec 08             	sub    $0x8,%esp
801015e3:	68 89 85 10 80       	push   $0x80108589
801015e8:	68 40 12 11 80       	push   $0x80111240
801015ed:	e8 84 39 00 00       	call   80104f76 <initlock>
801015f2:	83 c4 10             	add    $0x10,%esp
801015f5:	83 ec 08             	sub    $0x8,%esp
801015f8:	68 20 12 11 80       	push   $0x80111220
801015fd:	ff 75 08             	pushl  0x8(%ebp)
80101600:	e8 18 fd ff ff       	call   8010131d <readsb>
80101605:	83 c4 10             	add    $0x10,%esp
80101608:	a1 38 12 11 80       	mov    0x80111238,%eax
8010160d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101610:	8b 3d 34 12 11 80    	mov    0x80111234,%edi
80101616:	8b 35 30 12 11 80    	mov    0x80111230,%esi
8010161c:	8b 1d 2c 12 11 80    	mov    0x8011122c,%ebx
80101622:	8b 0d 28 12 11 80    	mov    0x80111228,%ecx
80101628:	8b 15 24 12 11 80    	mov    0x80111224,%edx
8010162e:	a1 20 12 11 80       	mov    0x80111220,%eax
80101633:	ff 75 e4             	pushl  -0x1c(%ebp)
80101636:	57                   	push   %edi
80101637:	56                   	push   %esi
80101638:	53                   	push   %ebx
80101639:	51                   	push   %ecx
8010163a:	52                   	push   %edx
8010163b:	50                   	push   %eax
8010163c:	68 90 85 10 80       	push   $0x80108590
80101641:	e8 5a ed ff ff       	call   801003a0 <cprintf>
80101646:	83 c4 20             	add    $0x20,%esp
80101649:	90                   	nop
8010164a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010164d:	5b                   	pop    %ebx
8010164e:	5e                   	pop    %esi
8010164f:	5f                   	pop    %edi
80101650:	5d                   	pop    %ebp
80101651:	c3                   	ret    

80101652 <ialloc>:
80101652:	55                   	push   %ebp
80101653:	89 e5                	mov    %esp,%ebp
80101655:	83 ec 28             	sub    $0x28,%esp
80101658:	8b 45 0c             	mov    0xc(%ebp),%eax
8010165b:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
8010165f:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
80101666:	e9 9e 00 00 00       	jmp    80101709 <ialloc+0xb7>
8010166b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010166e:	c1 e8 03             	shr    $0x3,%eax
80101671:	89 c2                	mov    %eax,%edx
80101673:	a1 34 12 11 80       	mov    0x80111234,%eax
80101678:	01 d0                	add    %edx,%eax
8010167a:	83 ec 08             	sub    $0x8,%esp
8010167d:	50                   	push   %eax
8010167e:	ff 75 08             	pushl  0x8(%ebp)
80101681:	e8 20 eb ff ff       	call   801001a6 <bread>
80101686:	83 c4 10             	add    $0x10,%esp
80101689:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010168c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010168f:	8d 50 18             	lea    0x18(%eax),%edx
80101692:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101695:	83 e0 07             	and    $0x7,%eax
80101698:	c1 e0 06             	shl    $0x6,%eax
8010169b:	01 d0                	add    %edx,%eax
8010169d:	89 45 ec             	mov    %eax,-0x14(%ebp)
801016a0:	8b 45 ec             	mov    -0x14(%ebp),%eax
801016a3:	0f b7 00             	movzwl (%eax),%eax
801016a6:	66 85 c0             	test   %ax,%ax
801016a9:	75 4c                	jne    801016f7 <ialloc+0xa5>
801016ab:	83 ec 04             	sub    $0x4,%esp
801016ae:	6a 40                	push   $0x40
801016b0:	6a 00                	push   $0x0
801016b2:	ff 75 ec             	pushl  -0x14(%ebp)
801016b5:	e8 41 3b 00 00       	call   801051fb <memset>
801016ba:	83 c4 10             	add    $0x10,%esp
801016bd:	8b 45 ec             	mov    -0x14(%ebp),%eax
801016c0:	0f b7 55 e4          	movzwl -0x1c(%ebp),%edx
801016c4:	66 89 10             	mov    %dx,(%eax)
801016c7:	83 ec 0c             	sub    $0xc,%esp
801016ca:	ff 75 f0             	pushl  -0x10(%ebp)
801016cd:	e8 4c 20 00 00       	call   8010371e <log_write>
801016d2:	83 c4 10             	add    $0x10,%esp
801016d5:	83 ec 0c             	sub    $0xc,%esp
801016d8:	ff 75 f0             	pushl  -0x10(%ebp)
801016db:	e8 37 eb ff ff       	call   80100217 <brelse>
801016e0:	83 c4 10             	add    $0x10,%esp
801016e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801016e6:	83 ec 08             	sub    $0x8,%esp
801016e9:	50                   	push   %eax
801016ea:	ff 75 08             	pushl  0x8(%ebp)
801016ed:	e8 f8 00 00 00       	call   801017ea <iget>
801016f2:	83 c4 10             	add    $0x10,%esp
801016f5:	eb 30                	jmp    80101727 <ialloc+0xd5>
801016f7:	83 ec 0c             	sub    $0xc,%esp
801016fa:	ff 75 f0             	pushl  -0x10(%ebp)
801016fd:	e8 15 eb ff ff       	call   80100217 <brelse>
80101702:	83 c4 10             	add    $0x10,%esp
80101705:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80101709:	8b 15 28 12 11 80    	mov    0x80111228,%edx
8010170f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101712:	39 c2                	cmp    %eax,%edx
80101714:	0f 87 51 ff ff ff    	ja     8010166b <ialloc+0x19>
8010171a:	83 ec 0c             	sub    $0xc,%esp
8010171d:	68 e3 85 10 80       	push   $0x801085e3
80101722:	e8 13 ee ff ff       	call   8010053a <panic>
80101727:	c9                   	leave  
80101728:	c3                   	ret    

80101729 <iupdate>:
80101729:	55                   	push   %ebp
8010172a:	89 e5                	mov    %esp,%ebp
8010172c:	83 ec 18             	sub    $0x18,%esp
8010172f:	8b 45 08             	mov    0x8(%ebp),%eax
80101732:	8b 40 04             	mov    0x4(%eax),%eax
80101735:	c1 e8 03             	shr    $0x3,%eax
80101738:	89 c2                	mov    %eax,%edx
8010173a:	a1 34 12 11 80       	mov    0x80111234,%eax
8010173f:	01 c2                	add    %eax,%edx
80101741:	8b 45 08             	mov    0x8(%ebp),%eax
80101744:	8b 00                	mov    (%eax),%eax
80101746:	83 ec 08             	sub    $0x8,%esp
80101749:	52                   	push   %edx
8010174a:	50                   	push   %eax
8010174b:	e8 56 ea ff ff       	call   801001a6 <bread>
80101750:	83 c4 10             	add    $0x10,%esp
80101753:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101756:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101759:	8d 50 18             	lea    0x18(%eax),%edx
8010175c:	8b 45 08             	mov    0x8(%ebp),%eax
8010175f:	8b 40 04             	mov    0x4(%eax),%eax
80101762:	83 e0 07             	and    $0x7,%eax
80101765:	c1 e0 06             	shl    $0x6,%eax
80101768:	01 d0                	add    %edx,%eax
8010176a:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010176d:	8b 45 08             	mov    0x8(%ebp),%eax
80101770:	0f b7 50 10          	movzwl 0x10(%eax),%edx
80101774:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101777:	66 89 10             	mov    %dx,(%eax)
8010177a:	8b 45 08             	mov    0x8(%ebp),%eax
8010177d:	0f b7 50 12          	movzwl 0x12(%eax),%edx
80101781:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101784:	66 89 50 02          	mov    %dx,0x2(%eax)
80101788:	8b 45 08             	mov    0x8(%ebp),%eax
8010178b:	0f b7 50 14          	movzwl 0x14(%eax),%edx
8010178f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101792:	66 89 50 04          	mov    %dx,0x4(%eax)
80101796:	8b 45 08             	mov    0x8(%ebp),%eax
80101799:	0f b7 50 16          	movzwl 0x16(%eax),%edx
8010179d:	8b 45 f0             	mov    -0x10(%ebp),%eax
801017a0:	66 89 50 06          	mov    %dx,0x6(%eax)
801017a4:	8b 45 08             	mov    0x8(%ebp),%eax
801017a7:	8b 50 18             	mov    0x18(%eax),%edx
801017aa:	8b 45 f0             	mov    -0x10(%ebp),%eax
801017ad:	89 50 08             	mov    %edx,0x8(%eax)
801017b0:	8b 45 08             	mov    0x8(%ebp),%eax
801017b3:	8d 50 1c             	lea    0x1c(%eax),%edx
801017b6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801017b9:	83 c0 0c             	add    $0xc,%eax
801017bc:	83 ec 04             	sub    $0x4,%esp
801017bf:	6a 34                	push   $0x34
801017c1:	52                   	push   %edx
801017c2:	50                   	push   %eax
801017c3:	e8 f2 3a 00 00       	call   801052ba <memmove>
801017c8:	83 c4 10             	add    $0x10,%esp
801017cb:	83 ec 0c             	sub    $0xc,%esp
801017ce:	ff 75 f4             	pushl  -0xc(%ebp)
801017d1:	e8 48 1f 00 00       	call   8010371e <log_write>
801017d6:	83 c4 10             	add    $0x10,%esp
801017d9:	83 ec 0c             	sub    $0xc,%esp
801017dc:	ff 75 f4             	pushl  -0xc(%ebp)
801017df:	e8 33 ea ff ff       	call   80100217 <brelse>
801017e4:	83 c4 10             	add    $0x10,%esp
801017e7:	90                   	nop
801017e8:	c9                   	leave  
801017e9:	c3                   	ret    

801017ea <iget>:
801017ea:	55                   	push   %ebp
801017eb:	89 e5                	mov    %esp,%ebp
801017ed:	83 ec 18             	sub    $0x18,%esp
801017f0:	83 ec 0c             	sub    $0xc,%esp
801017f3:	68 40 12 11 80       	push   $0x80111240
801017f8:	e8 9b 37 00 00       	call   80104f98 <acquire>
801017fd:	83 c4 10             	add    $0x10,%esp
80101800:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80101807:	c7 45 f4 74 12 11 80 	movl   $0x80111274,-0xc(%ebp)
8010180e:	eb 5d                	jmp    8010186d <iget+0x83>
80101810:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101813:	8b 40 08             	mov    0x8(%eax),%eax
80101816:	85 c0                	test   %eax,%eax
80101818:	7e 39                	jle    80101853 <iget+0x69>
8010181a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010181d:	8b 00                	mov    (%eax),%eax
8010181f:	3b 45 08             	cmp    0x8(%ebp),%eax
80101822:	75 2f                	jne    80101853 <iget+0x69>
80101824:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101827:	8b 40 04             	mov    0x4(%eax),%eax
8010182a:	3b 45 0c             	cmp    0xc(%ebp),%eax
8010182d:	75 24                	jne    80101853 <iget+0x69>
8010182f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101832:	8b 40 08             	mov    0x8(%eax),%eax
80101835:	8d 50 01             	lea    0x1(%eax),%edx
80101838:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010183b:	89 50 08             	mov    %edx,0x8(%eax)
8010183e:	83 ec 0c             	sub    $0xc,%esp
80101841:	68 40 12 11 80       	push   $0x80111240
80101846:	e8 b4 37 00 00       	call   80104fff <release>
8010184b:	83 c4 10             	add    $0x10,%esp
8010184e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101851:	eb 74                	jmp    801018c7 <iget+0xdd>
80101853:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80101857:	75 10                	jne    80101869 <iget+0x7f>
80101859:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010185c:	8b 40 08             	mov    0x8(%eax),%eax
8010185f:	85 c0                	test   %eax,%eax
80101861:	75 06                	jne    80101869 <iget+0x7f>
80101863:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101866:	89 45 f0             	mov    %eax,-0x10(%ebp)
80101869:	83 45 f4 50          	addl   $0x50,-0xc(%ebp)
8010186d:	81 7d f4 14 22 11 80 	cmpl   $0x80112214,-0xc(%ebp)
80101874:	72 9a                	jb     80101810 <iget+0x26>
80101876:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010187a:	75 0d                	jne    80101889 <iget+0x9f>
8010187c:	83 ec 0c             	sub    $0xc,%esp
8010187f:	68 f5 85 10 80       	push   $0x801085f5
80101884:	e8 b1 ec ff ff       	call   8010053a <panic>
80101889:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010188c:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010188f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101892:	8b 55 08             	mov    0x8(%ebp),%edx
80101895:	89 10                	mov    %edx,(%eax)
80101897:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010189a:	8b 55 0c             	mov    0xc(%ebp),%edx
8010189d:	89 50 04             	mov    %edx,0x4(%eax)
801018a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018a3:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%eax)
801018aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018ad:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
801018b4:	83 ec 0c             	sub    $0xc,%esp
801018b7:	68 40 12 11 80       	push   $0x80111240
801018bc:	e8 3e 37 00 00       	call   80104fff <release>
801018c1:	83 c4 10             	add    $0x10,%esp
801018c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018c7:	c9                   	leave  
801018c8:	c3                   	ret    

801018c9 <idup>:
801018c9:	55                   	push   %ebp
801018ca:	89 e5                	mov    %esp,%ebp
801018cc:	83 ec 08             	sub    $0x8,%esp
801018cf:	83 ec 0c             	sub    $0xc,%esp
801018d2:	68 40 12 11 80       	push   $0x80111240
801018d7:	e8 bc 36 00 00       	call   80104f98 <acquire>
801018dc:	83 c4 10             	add    $0x10,%esp
801018df:	8b 45 08             	mov    0x8(%ebp),%eax
801018e2:	8b 40 08             	mov    0x8(%eax),%eax
801018e5:	8d 50 01             	lea    0x1(%eax),%edx
801018e8:	8b 45 08             	mov    0x8(%ebp),%eax
801018eb:	89 50 08             	mov    %edx,0x8(%eax)
801018ee:	83 ec 0c             	sub    $0xc,%esp
801018f1:	68 40 12 11 80       	push   $0x80111240
801018f6:	e8 04 37 00 00       	call   80104fff <release>
801018fb:	83 c4 10             	add    $0x10,%esp
801018fe:	8b 45 08             	mov    0x8(%ebp),%eax
80101901:	c9                   	leave  
80101902:	c3                   	ret    

80101903 <ilock>:
80101903:	55                   	push   %ebp
80101904:	89 e5                	mov    %esp,%ebp
80101906:	83 ec 18             	sub    $0x18,%esp
80101909:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
8010190d:	74 0a                	je     80101919 <ilock+0x16>
8010190f:	8b 45 08             	mov    0x8(%ebp),%eax
80101912:	8b 40 08             	mov    0x8(%eax),%eax
80101915:	85 c0                	test   %eax,%eax
80101917:	7f 0d                	jg     80101926 <ilock+0x23>
80101919:	83 ec 0c             	sub    $0xc,%esp
8010191c:	68 05 86 10 80       	push   $0x80108605
80101921:	e8 14 ec ff ff       	call   8010053a <panic>
80101926:	83 ec 0c             	sub    $0xc,%esp
80101929:	68 40 12 11 80       	push   $0x80111240
8010192e:	e8 65 36 00 00       	call   80104f98 <acquire>
80101933:	83 c4 10             	add    $0x10,%esp
80101936:	eb 13                	jmp    8010194b <ilock+0x48>
80101938:	83 ec 08             	sub    $0x8,%esp
8010193b:	68 40 12 11 80       	push   $0x80111240
80101940:	ff 75 08             	pushl  0x8(%ebp)
80101943:	e8 57 33 00 00       	call   80104c9f <sleep>
80101948:	83 c4 10             	add    $0x10,%esp
8010194b:	8b 45 08             	mov    0x8(%ebp),%eax
8010194e:	8b 40 0c             	mov    0xc(%eax),%eax
80101951:	83 e0 01             	and    $0x1,%eax
80101954:	85 c0                	test   %eax,%eax
80101956:	75 e0                	jne    80101938 <ilock+0x35>
80101958:	8b 45 08             	mov    0x8(%ebp),%eax
8010195b:	8b 40 0c             	mov    0xc(%eax),%eax
8010195e:	83 c8 01             	or     $0x1,%eax
80101961:	89 c2                	mov    %eax,%edx
80101963:	8b 45 08             	mov    0x8(%ebp),%eax
80101966:	89 50 0c             	mov    %edx,0xc(%eax)
80101969:	83 ec 0c             	sub    $0xc,%esp
8010196c:	68 40 12 11 80       	push   $0x80111240
80101971:	e8 89 36 00 00       	call   80104fff <release>
80101976:	83 c4 10             	add    $0x10,%esp
80101979:	8b 45 08             	mov    0x8(%ebp),%eax
8010197c:	8b 40 0c             	mov    0xc(%eax),%eax
8010197f:	83 e0 02             	and    $0x2,%eax
80101982:	85 c0                	test   %eax,%eax
80101984:	0f 85 d4 00 00 00    	jne    80101a5e <ilock+0x15b>
8010198a:	8b 45 08             	mov    0x8(%ebp),%eax
8010198d:	8b 40 04             	mov    0x4(%eax),%eax
80101990:	c1 e8 03             	shr    $0x3,%eax
80101993:	89 c2                	mov    %eax,%edx
80101995:	a1 34 12 11 80       	mov    0x80111234,%eax
8010199a:	01 c2                	add    %eax,%edx
8010199c:	8b 45 08             	mov    0x8(%ebp),%eax
8010199f:	8b 00                	mov    (%eax),%eax
801019a1:	83 ec 08             	sub    $0x8,%esp
801019a4:	52                   	push   %edx
801019a5:	50                   	push   %eax
801019a6:	e8 fb e7 ff ff       	call   801001a6 <bread>
801019ab:	83 c4 10             	add    $0x10,%esp
801019ae:	89 45 f4             	mov    %eax,-0xc(%ebp)
801019b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801019b4:	8d 50 18             	lea    0x18(%eax),%edx
801019b7:	8b 45 08             	mov    0x8(%ebp),%eax
801019ba:	8b 40 04             	mov    0x4(%eax),%eax
801019bd:	83 e0 07             	and    $0x7,%eax
801019c0:	c1 e0 06             	shl    $0x6,%eax
801019c3:	01 d0                	add    %edx,%eax
801019c5:	89 45 f0             	mov    %eax,-0x10(%ebp)
801019c8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801019cb:	0f b7 10             	movzwl (%eax),%edx
801019ce:	8b 45 08             	mov    0x8(%ebp),%eax
801019d1:	66 89 50 10          	mov    %dx,0x10(%eax)
801019d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801019d8:	0f b7 50 02          	movzwl 0x2(%eax),%edx
801019dc:	8b 45 08             	mov    0x8(%ebp),%eax
801019df:	66 89 50 12          	mov    %dx,0x12(%eax)
801019e3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801019e6:	0f b7 50 04          	movzwl 0x4(%eax),%edx
801019ea:	8b 45 08             	mov    0x8(%ebp),%eax
801019ed:	66 89 50 14          	mov    %dx,0x14(%eax)
801019f1:	8b 45 f0             	mov    -0x10(%ebp),%eax
801019f4:	0f b7 50 06          	movzwl 0x6(%eax),%edx
801019f8:	8b 45 08             	mov    0x8(%ebp),%eax
801019fb:	66 89 50 16          	mov    %dx,0x16(%eax)
801019ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a02:	8b 50 08             	mov    0x8(%eax),%edx
80101a05:	8b 45 08             	mov    0x8(%ebp),%eax
80101a08:	89 50 18             	mov    %edx,0x18(%eax)
80101a0b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a0e:	8d 50 0c             	lea    0xc(%eax),%edx
80101a11:	8b 45 08             	mov    0x8(%ebp),%eax
80101a14:	83 c0 1c             	add    $0x1c,%eax
80101a17:	83 ec 04             	sub    $0x4,%esp
80101a1a:	6a 34                	push   $0x34
80101a1c:	52                   	push   %edx
80101a1d:	50                   	push   %eax
80101a1e:	e8 97 38 00 00       	call   801052ba <memmove>
80101a23:	83 c4 10             	add    $0x10,%esp
80101a26:	83 ec 0c             	sub    $0xc,%esp
80101a29:	ff 75 f4             	pushl  -0xc(%ebp)
80101a2c:	e8 e6 e7 ff ff       	call   80100217 <brelse>
80101a31:	83 c4 10             	add    $0x10,%esp
80101a34:	8b 45 08             	mov    0x8(%ebp),%eax
80101a37:	8b 40 0c             	mov    0xc(%eax),%eax
80101a3a:	83 c8 02             	or     $0x2,%eax
80101a3d:	89 c2                	mov    %eax,%edx
80101a3f:	8b 45 08             	mov    0x8(%ebp),%eax
80101a42:	89 50 0c             	mov    %edx,0xc(%eax)
80101a45:	8b 45 08             	mov    0x8(%ebp),%eax
80101a48:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80101a4c:	66 85 c0             	test   %ax,%ax
80101a4f:	75 0d                	jne    80101a5e <ilock+0x15b>
80101a51:	83 ec 0c             	sub    $0xc,%esp
80101a54:	68 0b 86 10 80       	push   $0x8010860b
80101a59:	e8 dc ea ff ff       	call   8010053a <panic>
80101a5e:	90                   	nop
80101a5f:	c9                   	leave  
80101a60:	c3                   	ret    

80101a61 <iunlock>:
80101a61:	55                   	push   %ebp
80101a62:	89 e5                	mov    %esp,%ebp
80101a64:	83 ec 08             	sub    $0x8,%esp
80101a67:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80101a6b:	74 17                	je     80101a84 <iunlock+0x23>
80101a6d:	8b 45 08             	mov    0x8(%ebp),%eax
80101a70:	8b 40 0c             	mov    0xc(%eax),%eax
80101a73:	83 e0 01             	and    $0x1,%eax
80101a76:	85 c0                	test   %eax,%eax
80101a78:	74 0a                	je     80101a84 <iunlock+0x23>
80101a7a:	8b 45 08             	mov    0x8(%ebp),%eax
80101a7d:	8b 40 08             	mov    0x8(%eax),%eax
80101a80:	85 c0                	test   %eax,%eax
80101a82:	7f 0d                	jg     80101a91 <iunlock+0x30>
80101a84:	83 ec 0c             	sub    $0xc,%esp
80101a87:	68 1a 86 10 80       	push   $0x8010861a
80101a8c:	e8 a9 ea ff ff       	call   8010053a <panic>
80101a91:	83 ec 0c             	sub    $0xc,%esp
80101a94:	68 40 12 11 80       	push   $0x80111240
80101a99:	e8 fa 34 00 00       	call   80104f98 <acquire>
80101a9e:	83 c4 10             	add    $0x10,%esp
80101aa1:	8b 45 08             	mov    0x8(%ebp),%eax
80101aa4:	8b 40 0c             	mov    0xc(%eax),%eax
80101aa7:	83 e0 fe             	and    $0xfffffffe,%eax
80101aaa:	89 c2                	mov    %eax,%edx
80101aac:	8b 45 08             	mov    0x8(%ebp),%eax
80101aaf:	89 50 0c             	mov    %edx,0xc(%eax)
80101ab2:	83 ec 0c             	sub    $0xc,%esp
80101ab5:	ff 75 08             	pushl  0x8(%ebp)
80101ab8:	e8 cd 32 00 00       	call   80104d8a <wakeup>
80101abd:	83 c4 10             	add    $0x10,%esp
80101ac0:	83 ec 0c             	sub    $0xc,%esp
80101ac3:	68 40 12 11 80       	push   $0x80111240
80101ac8:	e8 32 35 00 00       	call   80104fff <release>
80101acd:	83 c4 10             	add    $0x10,%esp
80101ad0:	90                   	nop
80101ad1:	c9                   	leave  
80101ad2:	c3                   	ret    

80101ad3 <iput>:
80101ad3:	55                   	push   %ebp
80101ad4:	89 e5                	mov    %esp,%ebp
80101ad6:	83 ec 08             	sub    $0x8,%esp
80101ad9:	83 ec 0c             	sub    $0xc,%esp
80101adc:	68 40 12 11 80       	push   $0x80111240
80101ae1:	e8 b2 34 00 00       	call   80104f98 <acquire>
80101ae6:	83 c4 10             	add    $0x10,%esp
80101ae9:	8b 45 08             	mov    0x8(%ebp),%eax
80101aec:	8b 40 08             	mov    0x8(%eax),%eax
80101aef:	83 f8 01             	cmp    $0x1,%eax
80101af2:	0f 85 a9 00 00 00    	jne    80101ba1 <iput+0xce>
80101af8:	8b 45 08             	mov    0x8(%ebp),%eax
80101afb:	8b 40 0c             	mov    0xc(%eax),%eax
80101afe:	83 e0 02             	and    $0x2,%eax
80101b01:	85 c0                	test   %eax,%eax
80101b03:	0f 84 98 00 00 00    	je     80101ba1 <iput+0xce>
80101b09:	8b 45 08             	mov    0x8(%ebp),%eax
80101b0c:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80101b10:	66 85 c0             	test   %ax,%ax
80101b13:	0f 85 88 00 00 00    	jne    80101ba1 <iput+0xce>
80101b19:	8b 45 08             	mov    0x8(%ebp),%eax
80101b1c:	8b 40 0c             	mov    0xc(%eax),%eax
80101b1f:	83 e0 01             	and    $0x1,%eax
80101b22:	85 c0                	test   %eax,%eax
80101b24:	74 0d                	je     80101b33 <iput+0x60>
80101b26:	83 ec 0c             	sub    $0xc,%esp
80101b29:	68 22 86 10 80       	push   $0x80108622
80101b2e:	e8 07 ea ff ff       	call   8010053a <panic>
80101b33:	8b 45 08             	mov    0x8(%ebp),%eax
80101b36:	8b 40 0c             	mov    0xc(%eax),%eax
80101b39:	83 c8 01             	or     $0x1,%eax
80101b3c:	89 c2                	mov    %eax,%edx
80101b3e:	8b 45 08             	mov    0x8(%ebp),%eax
80101b41:	89 50 0c             	mov    %edx,0xc(%eax)
80101b44:	83 ec 0c             	sub    $0xc,%esp
80101b47:	68 40 12 11 80       	push   $0x80111240
80101b4c:	e8 ae 34 00 00       	call   80104fff <release>
80101b51:	83 c4 10             	add    $0x10,%esp
80101b54:	83 ec 0c             	sub    $0xc,%esp
80101b57:	ff 75 08             	pushl  0x8(%ebp)
80101b5a:	e8 a8 01 00 00       	call   80101d07 <itrunc>
80101b5f:	83 c4 10             	add    $0x10,%esp
80101b62:	8b 45 08             	mov    0x8(%ebp),%eax
80101b65:	66 c7 40 10 00 00    	movw   $0x0,0x10(%eax)
80101b6b:	83 ec 0c             	sub    $0xc,%esp
80101b6e:	ff 75 08             	pushl  0x8(%ebp)
80101b71:	e8 b3 fb ff ff       	call   80101729 <iupdate>
80101b76:	83 c4 10             	add    $0x10,%esp
80101b79:	83 ec 0c             	sub    $0xc,%esp
80101b7c:	68 40 12 11 80       	push   $0x80111240
80101b81:	e8 12 34 00 00       	call   80104f98 <acquire>
80101b86:	83 c4 10             	add    $0x10,%esp
80101b89:	8b 45 08             	mov    0x8(%ebp),%eax
80101b8c:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
80101b93:	83 ec 0c             	sub    $0xc,%esp
80101b96:	ff 75 08             	pushl  0x8(%ebp)
80101b99:	e8 ec 31 00 00       	call   80104d8a <wakeup>
80101b9e:	83 c4 10             	add    $0x10,%esp
80101ba1:	8b 45 08             	mov    0x8(%ebp),%eax
80101ba4:	8b 40 08             	mov    0x8(%eax),%eax
80101ba7:	8d 50 ff             	lea    -0x1(%eax),%edx
80101baa:	8b 45 08             	mov    0x8(%ebp),%eax
80101bad:	89 50 08             	mov    %edx,0x8(%eax)
80101bb0:	83 ec 0c             	sub    $0xc,%esp
80101bb3:	68 40 12 11 80       	push   $0x80111240
80101bb8:	e8 42 34 00 00       	call   80104fff <release>
80101bbd:	83 c4 10             	add    $0x10,%esp
80101bc0:	90                   	nop
80101bc1:	c9                   	leave  
80101bc2:	c3                   	ret    

80101bc3 <iunlockput>:
80101bc3:	55                   	push   %ebp
80101bc4:	89 e5                	mov    %esp,%ebp
80101bc6:	83 ec 08             	sub    $0x8,%esp
80101bc9:	83 ec 0c             	sub    $0xc,%esp
80101bcc:	ff 75 08             	pushl  0x8(%ebp)
80101bcf:	e8 8d fe ff ff       	call   80101a61 <iunlock>
80101bd4:	83 c4 10             	add    $0x10,%esp
80101bd7:	83 ec 0c             	sub    $0xc,%esp
80101bda:	ff 75 08             	pushl  0x8(%ebp)
80101bdd:	e8 f1 fe ff ff       	call   80101ad3 <iput>
80101be2:	83 c4 10             	add    $0x10,%esp
80101be5:	90                   	nop
80101be6:	c9                   	leave  
80101be7:	c3                   	ret    

80101be8 <bmap>:
80101be8:	55                   	push   %ebp
80101be9:	89 e5                	mov    %esp,%ebp
80101beb:	53                   	push   %ebx
80101bec:	83 ec 14             	sub    $0x14,%esp
80101bef:	83 7d 0c 0b          	cmpl   $0xb,0xc(%ebp)
80101bf3:	77 42                	ja     80101c37 <bmap+0x4f>
80101bf5:	8b 45 08             	mov    0x8(%ebp),%eax
80101bf8:	8b 55 0c             	mov    0xc(%ebp),%edx
80101bfb:	83 c2 04             	add    $0x4,%edx
80101bfe:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101c02:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101c05:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101c09:	75 24                	jne    80101c2f <bmap+0x47>
80101c0b:	8b 45 08             	mov    0x8(%ebp),%eax
80101c0e:	8b 00                	mov    (%eax),%eax
80101c10:	83 ec 0c             	sub    $0xc,%esp
80101c13:	50                   	push   %eax
80101c14:	e8 9a f7 ff ff       	call   801013b3 <balloc>
80101c19:	83 c4 10             	add    $0x10,%esp
80101c1c:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101c1f:	8b 45 08             	mov    0x8(%ebp),%eax
80101c22:	8b 55 0c             	mov    0xc(%ebp),%edx
80101c25:	8d 4a 04             	lea    0x4(%edx),%ecx
80101c28:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101c2b:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)
80101c2f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101c32:	e9 cb 00 00 00       	jmp    80101d02 <bmap+0x11a>
80101c37:	83 6d 0c 0c          	subl   $0xc,0xc(%ebp)
80101c3b:	83 7d 0c 7f          	cmpl   $0x7f,0xc(%ebp)
80101c3f:	0f 87 b0 00 00 00    	ja     80101cf5 <bmap+0x10d>
80101c45:	8b 45 08             	mov    0x8(%ebp),%eax
80101c48:	8b 40 4c             	mov    0x4c(%eax),%eax
80101c4b:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101c4e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101c52:	75 1d                	jne    80101c71 <bmap+0x89>
80101c54:	8b 45 08             	mov    0x8(%ebp),%eax
80101c57:	8b 00                	mov    (%eax),%eax
80101c59:	83 ec 0c             	sub    $0xc,%esp
80101c5c:	50                   	push   %eax
80101c5d:	e8 51 f7 ff ff       	call   801013b3 <balloc>
80101c62:	83 c4 10             	add    $0x10,%esp
80101c65:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101c68:	8b 45 08             	mov    0x8(%ebp),%eax
80101c6b:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101c6e:	89 50 4c             	mov    %edx,0x4c(%eax)
80101c71:	8b 45 08             	mov    0x8(%ebp),%eax
80101c74:	8b 00                	mov    (%eax),%eax
80101c76:	83 ec 08             	sub    $0x8,%esp
80101c79:	ff 75 f4             	pushl  -0xc(%ebp)
80101c7c:	50                   	push   %eax
80101c7d:	e8 24 e5 ff ff       	call   801001a6 <bread>
80101c82:	83 c4 10             	add    $0x10,%esp
80101c85:	89 45 f0             	mov    %eax,-0x10(%ebp)
80101c88:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101c8b:	83 c0 18             	add    $0x18,%eax
80101c8e:	89 45 ec             	mov    %eax,-0x14(%ebp)
80101c91:	8b 45 0c             	mov    0xc(%ebp),%eax
80101c94:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101c9b:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101c9e:	01 d0                	add    %edx,%eax
80101ca0:	8b 00                	mov    (%eax),%eax
80101ca2:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101ca5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101ca9:	75 37                	jne    80101ce2 <bmap+0xfa>
80101cab:	8b 45 0c             	mov    0xc(%ebp),%eax
80101cae:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101cb5:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101cb8:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
80101cbb:	8b 45 08             	mov    0x8(%ebp),%eax
80101cbe:	8b 00                	mov    (%eax),%eax
80101cc0:	83 ec 0c             	sub    $0xc,%esp
80101cc3:	50                   	push   %eax
80101cc4:	e8 ea f6 ff ff       	call   801013b3 <balloc>
80101cc9:	83 c4 10             	add    $0x10,%esp
80101ccc:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101ccf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101cd2:	89 03                	mov    %eax,(%ebx)
80101cd4:	83 ec 0c             	sub    $0xc,%esp
80101cd7:	ff 75 f0             	pushl  -0x10(%ebp)
80101cda:	e8 3f 1a 00 00       	call   8010371e <log_write>
80101cdf:	83 c4 10             	add    $0x10,%esp
80101ce2:	83 ec 0c             	sub    $0xc,%esp
80101ce5:	ff 75 f0             	pushl  -0x10(%ebp)
80101ce8:	e8 2a e5 ff ff       	call   80100217 <brelse>
80101ced:	83 c4 10             	add    $0x10,%esp
80101cf0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101cf3:	eb 0d                	jmp    80101d02 <bmap+0x11a>
80101cf5:	83 ec 0c             	sub    $0xc,%esp
80101cf8:	68 2c 86 10 80       	push   $0x8010862c
80101cfd:	e8 38 e8 ff ff       	call   8010053a <panic>
80101d02:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101d05:	c9                   	leave  
80101d06:	c3                   	ret    

80101d07 <itrunc>:
80101d07:	55                   	push   %ebp
80101d08:	89 e5                	mov    %esp,%ebp
80101d0a:	83 ec 18             	sub    $0x18,%esp
80101d0d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80101d14:	eb 45                	jmp    80101d5b <itrunc+0x54>
80101d16:	8b 45 08             	mov    0x8(%ebp),%eax
80101d19:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101d1c:	83 c2 04             	add    $0x4,%edx
80101d1f:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101d23:	85 c0                	test   %eax,%eax
80101d25:	74 30                	je     80101d57 <itrunc+0x50>
80101d27:	8b 45 08             	mov    0x8(%ebp),%eax
80101d2a:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101d2d:	83 c2 04             	add    $0x4,%edx
80101d30:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101d34:	8b 55 08             	mov    0x8(%ebp),%edx
80101d37:	8b 12                	mov    (%edx),%edx
80101d39:	83 ec 08             	sub    $0x8,%esp
80101d3c:	50                   	push   %eax
80101d3d:	52                   	push   %edx
80101d3e:	e8 bc f7 ff ff       	call   801014ff <bfree>
80101d43:	83 c4 10             	add    $0x10,%esp
80101d46:	8b 45 08             	mov    0x8(%ebp),%eax
80101d49:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101d4c:	83 c2 04             	add    $0x4,%edx
80101d4f:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%eax,%edx,4)
80101d56:	00 
80101d57:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80101d5b:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
80101d5f:	7e b5                	jle    80101d16 <itrunc+0xf>
80101d61:	8b 45 08             	mov    0x8(%ebp),%eax
80101d64:	8b 40 4c             	mov    0x4c(%eax),%eax
80101d67:	85 c0                	test   %eax,%eax
80101d69:	0f 84 a1 00 00 00    	je     80101e10 <itrunc+0x109>
80101d6f:	8b 45 08             	mov    0x8(%ebp),%eax
80101d72:	8b 50 4c             	mov    0x4c(%eax),%edx
80101d75:	8b 45 08             	mov    0x8(%ebp),%eax
80101d78:	8b 00                	mov    (%eax),%eax
80101d7a:	83 ec 08             	sub    $0x8,%esp
80101d7d:	52                   	push   %edx
80101d7e:	50                   	push   %eax
80101d7f:	e8 22 e4 ff ff       	call   801001a6 <bread>
80101d84:	83 c4 10             	add    $0x10,%esp
80101d87:	89 45 ec             	mov    %eax,-0x14(%ebp)
80101d8a:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101d8d:	83 c0 18             	add    $0x18,%eax
80101d90:	89 45 e8             	mov    %eax,-0x18(%ebp)
80101d93:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80101d9a:	eb 3c                	jmp    80101dd8 <itrunc+0xd1>
80101d9c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101d9f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101da6:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101da9:	01 d0                	add    %edx,%eax
80101dab:	8b 00                	mov    (%eax),%eax
80101dad:	85 c0                	test   %eax,%eax
80101daf:	74 23                	je     80101dd4 <itrunc+0xcd>
80101db1:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101db4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101dbb:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101dbe:	01 d0                	add    %edx,%eax
80101dc0:	8b 00                	mov    (%eax),%eax
80101dc2:	8b 55 08             	mov    0x8(%ebp),%edx
80101dc5:	8b 12                	mov    (%edx),%edx
80101dc7:	83 ec 08             	sub    $0x8,%esp
80101dca:	50                   	push   %eax
80101dcb:	52                   	push   %edx
80101dcc:	e8 2e f7 ff ff       	call   801014ff <bfree>
80101dd1:	83 c4 10             	add    $0x10,%esp
80101dd4:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80101dd8:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101ddb:	83 f8 7f             	cmp    $0x7f,%eax
80101dde:	76 bc                	jbe    80101d9c <itrunc+0x95>
80101de0:	83 ec 0c             	sub    $0xc,%esp
80101de3:	ff 75 ec             	pushl  -0x14(%ebp)
80101de6:	e8 2c e4 ff ff       	call   80100217 <brelse>
80101deb:	83 c4 10             	add    $0x10,%esp
80101dee:	8b 45 08             	mov    0x8(%ebp),%eax
80101df1:	8b 40 4c             	mov    0x4c(%eax),%eax
80101df4:	8b 55 08             	mov    0x8(%ebp),%edx
80101df7:	8b 12                	mov    (%edx),%edx
80101df9:	83 ec 08             	sub    $0x8,%esp
80101dfc:	50                   	push   %eax
80101dfd:	52                   	push   %edx
80101dfe:	e8 fc f6 ff ff       	call   801014ff <bfree>
80101e03:	83 c4 10             	add    $0x10,%esp
80101e06:	8b 45 08             	mov    0x8(%ebp),%eax
80101e09:	c7 40 4c 00 00 00 00 	movl   $0x0,0x4c(%eax)
80101e10:	8b 45 08             	mov    0x8(%ebp),%eax
80101e13:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
80101e1a:	83 ec 0c             	sub    $0xc,%esp
80101e1d:	ff 75 08             	pushl  0x8(%ebp)
80101e20:	e8 04 f9 ff ff       	call   80101729 <iupdate>
80101e25:	83 c4 10             	add    $0x10,%esp
80101e28:	90                   	nop
80101e29:	c9                   	leave  
80101e2a:	c3                   	ret    

80101e2b <stati>:
80101e2b:	55                   	push   %ebp
80101e2c:	89 e5                	mov    %esp,%ebp
80101e2e:	8b 45 08             	mov    0x8(%ebp),%eax
80101e31:	8b 00                	mov    (%eax),%eax
80101e33:	89 c2                	mov    %eax,%edx
80101e35:	8b 45 0c             	mov    0xc(%ebp),%eax
80101e38:	89 50 04             	mov    %edx,0x4(%eax)
80101e3b:	8b 45 08             	mov    0x8(%ebp),%eax
80101e3e:	8b 50 04             	mov    0x4(%eax),%edx
80101e41:	8b 45 0c             	mov    0xc(%ebp),%eax
80101e44:	89 50 08             	mov    %edx,0x8(%eax)
80101e47:	8b 45 08             	mov    0x8(%ebp),%eax
80101e4a:	0f b7 50 10          	movzwl 0x10(%eax),%edx
80101e4e:	8b 45 0c             	mov    0xc(%ebp),%eax
80101e51:	66 89 10             	mov    %dx,(%eax)
80101e54:	8b 45 08             	mov    0x8(%ebp),%eax
80101e57:	0f b7 50 16          	movzwl 0x16(%eax),%edx
80101e5b:	8b 45 0c             	mov    0xc(%ebp),%eax
80101e5e:	66 89 50 0c          	mov    %dx,0xc(%eax)
80101e62:	8b 45 08             	mov    0x8(%ebp),%eax
80101e65:	8b 50 18             	mov    0x18(%eax),%edx
80101e68:	8b 45 0c             	mov    0xc(%ebp),%eax
80101e6b:	89 50 10             	mov    %edx,0x10(%eax)
80101e6e:	90                   	nop
80101e6f:	5d                   	pop    %ebp
80101e70:	c3                   	ret    

80101e71 <readi>:
80101e71:	55                   	push   %ebp
80101e72:	89 e5                	mov    %esp,%ebp
80101e74:	83 ec 18             	sub    $0x18,%esp
80101e77:	8b 45 08             	mov    0x8(%ebp),%eax
80101e7a:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80101e7e:	66 83 f8 03          	cmp    $0x3,%ax
80101e82:	75 5c                	jne    80101ee0 <readi+0x6f>
80101e84:	8b 45 08             	mov    0x8(%ebp),%eax
80101e87:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101e8b:	66 85 c0             	test   %ax,%ax
80101e8e:	78 20                	js     80101eb0 <readi+0x3f>
80101e90:	8b 45 08             	mov    0x8(%ebp),%eax
80101e93:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101e97:	66 83 f8 09          	cmp    $0x9,%ax
80101e9b:	7f 13                	jg     80101eb0 <readi+0x3f>
80101e9d:	8b 45 08             	mov    0x8(%ebp),%eax
80101ea0:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101ea4:	98                   	cwtl   
80101ea5:	8b 04 c5 c0 11 11 80 	mov    -0x7feeee40(,%eax,8),%eax
80101eac:	85 c0                	test   %eax,%eax
80101eae:	75 0a                	jne    80101eba <readi+0x49>
80101eb0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101eb5:	e9 0c 01 00 00       	jmp    80101fc6 <readi+0x155>
80101eba:	8b 45 08             	mov    0x8(%ebp),%eax
80101ebd:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101ec1:	98                   	cwtl   
80101ec2:	8b 04 c5 c0 11 11 80 	mov    -0x7feeee40(,%eax,8),%eax
80101ec9:	8b 55 14             	mov    0x14(%ebp),%edx
80101ecc:	83 ec 04             	sub    $0x4,%esp
80101ecf:	52                   	push   %edx
80101ed0:	ff 75 0c             	pushl  0xc(%ebp)
80101ed3:	ff 75 08             	pushl  0x8(%ebp)
80101ed6:	ff d0                	call   *%eax
80101ed8:	83 c4 10             	add    $0x10,%esp
80101edb:	e9 e6 00 00 00       	jmp    80101fc6 <readi+0x155>
80101ee0:	8b 45 08             	mov    0x8(%ebp),%eax
80101ee3:	8b 40 18             	mov    0x18(%eax),%eax
80101ee6:	3b 45 10             	cmp    0x10(%ebp),%eax
80101ee9:	72 0d                	jb     80101ef8 <readi+0x87>
80101eeb:	8b 55 10             	mov    0x10(%ebp),%edx
80101eee:	8b 45 14             	mov    0x14(%ebp),%eax
80101ef1:	01 d0                	add    %edx,%eax
80101ef3:	3b 45 10             	cmp    0x10(%ebp),%eax
80101ef6:	73 0a                	jae    80101f02 <readi+0x91>
80101ef8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101efd:	e9 c4 00 00 00       	jmp    80101fc6 <readi+0x155>
80101f02:	8b 55 10             	mov    0x10(%ebp),%edx
80101f05:	8b 45 14             	mov    0x14(%ebp),%eax
80101f08:	01 c2                	add    %eax,%edx
80101f0a:	8b 45 08             	mov    0x8(%ebp),%eax
80101f0d:	8b 40 18             	mov    0x18(%eax),%eax
80101f10:	39 c2                	cmp    %eax,%edx
80101f12:	76 0c                	jbe    80101f20 <readi+0xaf>
80101f14:	8b 45 08             	mov    0x8(%ebp),%eax
80101f17:	8b 40 18             	mov    0x18(%eax),%eax
80101f1a:	2b 45 10             	sub    0x10(%ebp),%eax
80101f1d:	89 45 14             	mov    %eax,0x14(%ebp)
80101f20:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80101f27:	e9 8b 00 00 00       	jmp    80101fb7 <readi+0x146>
80101f2c:	8b 45 10             	mov    0x10(%ebp),%eax
80101f2f:	c1 e8 09             	shr    $0x9,%eax
80101f32:	83 ec 08             	sub    $0x8,%esp
80101f35:	50                   	push   %eax
80101f36:	ff 75 08             	pushl  0x8(%ebp)
80101f39:	e8 aa fc ff ff       	call   80101be8 <bmap>
80101f3e:	83 c4 10             	add    $0x10,%esp
80101f41:	89 c2                	mov    %eax,%edx
80101f43:	8b 45 08             	mov    0x8(%ebp),%eax
80101f46:	8b 00                	mov    (%eax),%eax
80101f48:	83 ec 08             	sub    $0x8,%esp
80101f4b:	52                   	push   %edx
80101f4c:	50                   	push   %eax
80101f4d:	e8 54 e2 ff ff       	call   801001a6 <bread>
80101f52:	83 c4 10             	add    $0x10,%esp
80101f55:	89 45 f0             	mov    %eax,-0x10(%ebp)
80101f58:	8b 45 10             	mov    0x10(%ebp),%eax
80101f5b:	25 ff 01 00 00       	and    $0x1ff,%eax
80101f60:	ba 00 02 00 00       	mov    $0x200,%edx
80101f65:	29 c2                	sub    %eax,%edx
80101f67:	8b 45 14             	mov    0x14(%ebp),%eax
80101f6a:	2b 45 f4             	sub    -0xc(%ebp),%eax
80101f6d:	39 c2                	cmp    %eax,%edx
80101f6f:	0f 46 c2             	cmovbe %edx,%eax
80101f72:	89 45 ec             	mov    %eax,-0x14(%ebp)
80101f75:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101f78:	8d 50 18             	lea    0x18(%eax),%edx
80101f7b:	8b 45 10             	mov    0x10(%ebp),%eax
80101f7e:	25 ff 01 00 00       	and    $0x1ff,%eax
80101f83:	01 d0                	add    %edx,%eax
80101f85:	83 ec 04             	sub    $0x4,%esp
80101f88:	ff 75 ec             	pushl  -0x14(%ebp)
80101f8b:	50                   	push   %eax
80101f8c:	ff 75 0c             	pushl  0xc(%ebp)
80101f8f:	e8 26 33 00 00       	call   801052ba <memmove>
80101f94:	83 c4 10             	add    $0x10,%esp
80101f97:	83 ec 0c             	sub    $0xc,%esp
80101f9a:	ff 75 f0             	pushl  -0x10(%ebp)
80101f9d:	e8 75 e2 ff ff       	call   80100217 <brelse>
80101fa2:	83 c4 10             	add    $0x10,%esp
80101fa5:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101fa8:	01 45 f4             	add    %eax,-0xc(%ebp)
80101fab:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101fae:	01 45 10             	add    %eax,0x10(%ebp)
80101fb1:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101fb4:	01 45 0c             	add    %eax,0xc(%ebp)
80101fb7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101fba:	3b 45 14             	cmp    0x14(%ebp),%eax
80101fbd:	0f 82 69 ff ff ff    	jb     80101f2c <readi+0xbb>
80101fc3:	8b 45 14             	mov    0x14(%ebp),%eax
80101fc6:	c9                   	leave  
80101fc7:	c3                   	ret    

80101fc8 <writei>:
80101fc8:	55                   	push   %ebp
80101fc9:	89 e5                	mov    %esp,%ebp
80101fcb:	83 ec 18             	sub    $0x18,%esp
80101fce:	8b 45 08             	mov    0x8(%ebp),%eax
80101fd1:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80101fd5:	66 83 f8 03          	cmp    $0x3,%ax
80101fd9:	75 5c                	jne    80102037 <writei+0x6f>
80101fdb:	8b 45 08             	mov    0x8(%ebp),%eax
80101fde:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101fe2:	66 85 c0             	test   %ax,%ax
80101fe5:	78 20                	js     80102007 <writei+0x3f>
80101fe7:	8b 45 08             	mov    0x8(%ebp),%eax
80101fea:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101fee:	66 83 f8 09          	cmp    $0x9,%ax
80101ff2:	7f 13                	jg     80102007 <writei+0x3f>
80101ff4:	8b 45 08             	mov    0x8(%ebp),%eax
80101ff7:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101ffb:	98                   	cwtl   
80101ffc:	8b 04 c5 c4 11 11 80 	mov    -0x7feeee3c(,%eax,8),%eax
80102003:	85 c0                	test   %eax,%eax
80102005:	75 0a                	jne    80102011 <writei+0x49>
80102007:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010200c:	e9 3d 01 00 00       	jmp    8010214e <writei+0x186>
80102011:	8b 45 08             	mov    0x8(%ebp),%eax
80102014:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80102018:	98                   	cwtl   
80102019:	8b 04 c5 c4 11 11 80 	mov    -0x7feeee3c(,%eax,8),%eax
80102020:	8b 55 14             	mov    0x14(%ebp),%edx
80102023:	83 ec 04             	sub    $0x4,%esp
80102026:	52                   	push   %edx
80102027:	ff 75 0c             	pushl  0xc(%ebp)
8010202a:	ff 75 08             	pushl  0x8(%ebp)
8010202d:	ff d0                	call   *%eax
8010202f:	83 c4 10             	add    $0x10,%esp
80102032:	e9 17 01 00 00       	jmp    8010214e <writei+0x186>
80102037:	8b 45 08             	mov    0x8(%ebp),%eax
8010203a:	8b 40 18             	mov    0x18(%eax),%eax
8010203d:	3b 45 10             	cmp    0x10(%ebp),%eax
80102040:	72 0d                	jb     8010204f <writei+0x87>
80102042:	8b 55 10             	mov    0x10(%ebp),%edx
80102045:	8b 45 14             	mov    0x14(%ebp),%eax
80102048:	01 d0                	add    %edx,%eax
8010204a:	3b 45 10             	cmp    0x10(%ebp),%eax
8010204d:	73 0a                	jae    80102059 <writei+0x91>
8010204f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102054:	e9 f5 00 00 00       	jmp    8010214e <writei+0x186>
80102059:	8b 55 10             	mov    0x10(%ebp),%edx
8010205c:	8b 45 14             	mov    0x14(%ebp),%eax
8010205f:	01 d0                	add    %edx,%eax
80102061:	3d 00 18 01 00       	cmp    $0x11800,%eax
80102066:	76 0a                	jbe    80102072 <writei+0xaa>
80102068:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010206d:	e9 dc 00 00 00       	jmp    8010214e <writei+0x186>
80102072:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102079:	e9 99 00 00 00       	jmp    80102117 <writei+0x14f>
8010207e:	8b 45 10             	mov    0x10(%ebp),%eax
80102081:	c1 e8 09             	shr    $0x9,%eax
80102084:	83 ec 08             	sub    $0x8,%esp
80102087:	50                   	push   %eax
80102088:	ff 75 08             	pushl  0x8(%ebp)
8010208b:	e8 58 fb ff ff       	call   80101be8 <bmap>
80102090:	83 c4 10             	add    $0x10,%esp
80102093:	89 c2                	mov    %eax,%edx
80102095:	8b 45 08             	mov    0x8(%ebp),%eax
80102098:	8b 00                	mov    (%eax),%eax
8010209a:	83 ec 08             	sub    $0x8,%esp
8010209d:	52                   	push   %edx
8010209e:	50                   	push   %eax
8010209f:	e8 02 e1 ff ff       	call   801001a6 <bread>
801020a4:	83 c4 10             	add    $0x10,%esp
801020a7:	89 45 f0             	mov    %eax,-0x10(%ebp)
801020aa:	8b 45 10             	mov    0x10(%ebp),%eax
801020ad:	25 ff 01 00 00       	and    $0x1ff,%eax
801020b2:	ba 00 02 00 00       	mov    $0x200,%edx
801020b7:	29 c2                	sub    %eax,%edx
801020b9:	8b 45 14             	mov    0x14(%ebp),%eax
801020bc:	2b 45 f4             	sub    -0xc(%ebp),%eax
801020bf:	39 c2                	cmp    %eax,%edx
801020c1:	0f 46 c2             	cmovbe %edx,%eax
801020c4:	89 45 ec             	mov    %eax,-0x14(%ebp)
801020c7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801020ca:	8d 50 18             	lea    0x18(%eax),%edx
801020cd:	8b 45 10             	mov    0x10(%ebp),%eax
801020d0:	25 ff 01 00 00       	and    $0x1ff,%eax
801020d5:	01 d0                	add    %edx,%eax
801020d7:	83 ec 04             	sub    $0x4,%esp
801020da:	ff 75 ec             	pushl  -0x14(%ebp)
801020dd:	ff 75 0c             	pushl  0xc(%ebp)
801020e0:	50                   	push   %eax
801020e1:	e8 d4 31 00 00       	call   801052ba <memmove>
801020e6:	83 c4 10             	add    $0x10,%esp
801020e9:	83 ec 0c             	sub    $0xc,%esp
801020ec:	ff 75 f0             	pushl  -0x10(%ebp)
801020ef:	e8 2a 16 00 00       	call   8010371e <log_write>
801020f4:	83 c4 10             	add    $0x10,%esp
801020f7:	83 ec 0c             	sub    $0xc,%esp
801020fa:	ff 75 f0             	pushl  -0x10(%ebp)
801020fd:	e8 15 e1 ff ff       	call   80100217 <brelse>
80102102:	83 c4 10             	add    $0x10,%esp
80102105:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102108:	01 45 f4             	add    %eax,-0xc(%ebp)
8010210b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010210e:	01 45 10             	add    %eax,0x10(%ebp)
80102111:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102114:	01 45 0c             	add    %eax,0xc(%ebp)
80102117:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010211a:	3b 45 14             	cmp    0x14(%ebp),%eax
8010211d:	0f 82 5b ff ff ff    	jb     8010207e <writei+0xb6>
80102123:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
80102127:	74 22                	je     8010214b <writei+0x183>
80102129:	8b 45 08             	mov    0x8(%ebp),%eax
8010212c:	8b 40 18             	mov    0x18(%eax),%eax
8010212f:	3b 45 10             	cmp    0x10(%ebp),%eax
80102132:	73 17                	jae    8010214b <writei+0x183>
80102134:	8b 45 08             	mov    0x8(%ebp),%eax
80102137:	8b 55 10             	mov    0x10(%ebp),%edx
8010213a:	89 50 18             	mov    %edx,0x18(%eax)
8010213d:	83 ec 0c             	sub    $0xc,%esp
80102140:	ff 75 08             	pushl  0x8(%ebp)
80102143:	e8 e1 f5 ff ff       	call   80101729 <iupdate>
80102148:	83 c4 10             	add    $0x10,%esp
8010214b:	8b 45 14             	mov    0x14(%ebp),%eax
8010214e:	c9                   	leave  
8010214f:	c3                   	ret    

80102150 <namecmp>:
80102150:	55                   	push   %ebp
80102151:	89 e5                	mov    %esp,%ebp
80102153:	83 ec 08             	sub    $0x8,%esp
80102156:	83 ec 04             	sub    $0x4,%esp
80102159:	6a 0e                	push   $0xe
8010215b:	ff 75 0c             	pushl  0xc(%ebp)
8010215e:	ff 75 08             	pushl  0x8(%ebp)
80102161:	e8 ea 31 00 00       	call   80105350 <strncmp>
80102166:	83 c4 10             	add    $0x10,%esp
80102169:	c9                   	leave  
8010216a:	c3                   	ret    

8010216b <dirlookup>:
8010216b:	55                   	push   %ebp
8010216c:	89 e5                	mov    %esp,%ebp
8010216e:	83 ec 28             	sub    $0x28,%esp
80102171:	8b 45 08             	mov    0x8(%ebp),%eax
80102174:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80102178:	66 83 f8 01          	cmp    $0x1,%ax
8010217c:	74 0d                	je     8010218b <dirlookup+0x20>
8010217e:	83 ec 0c             	sub    $0xc,%esp
80102181:	68 3f 86 10 80       	push   $0x8010863f
80102186:	e8 af e3 ff ff       	call   8010053a <panic>
8010218b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102192:	eb 7b                	jmp    8010220f <dirlookup+0xa4>
80102194:	6a 10                	push   $0x10
80102196:	ff 75 f4             	pushl  -0xc(%ebp)
80102199:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010219c:	50                   	push   %eax
8010219d:	ff 75 08             	pushl  0x8(%ebp)
801021a0:	e8 cc fc ff ff       	call   80101e71 <readi>
801021a5:	83 c4 10             	add    $0x10,%esp
801021a8:	83 f8 10             	cmp    $0x10,%eax
801021ab:	74 0d                	je     801021ba <dirlookup+0x4f>
801021ad:	83 ec 0c             	sub    $0xc,%esp
801021b0:	68 51 86 10 80       	push   $0x80108651
801021b5:	e8 80 e3 ff ff       	call   8010053a <panic>
801021ba:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
801021be:	66 85 c0             	test   %ax,%ax
801021c1:	74 47                	je     8010220a <dirlookup+0x9f>
801021c3:	83 ec 08             	sub    $0x8,%esp
801021c6:	8d 45 e0             	lea    -0x20(%ebp),%eax
801021c9:	83 c0 02             	add    $0x2,%eax
801021cc:	50                   	push   %eax
801021cd:	ff 75 0c             	pushl  0xc(%ebp)
801021d0:	e8 7b ff ff ff       	call   80102150 <namecmp>
801021d5:	83 c4 10             	add    $0x10,%esp
801021d8:	85 c0                	test   %eax,%eax
801021da:	75 2f                	jne    8010220b <dirlookup+0xa0>
801021dc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801021e0:	74 08                	je     801021ea <dirlookup+0x7f>
801021e2:	8b 45 10             	mov    0x10(%ebp),%eax
801021e5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801021e8:	89 10                	mov    %edx,(%eax)
801021ea:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
801021ee:	0f b7 c0             	movzwl %ax,%eax
801021f1:	89 45 f0             	mov    %eax,-0x10(%ebp)
801021f4:	8b 45 08             	mov    0x8(%ebp),%eax
801021f7:	8b 00                	mov    (%eax),%eax
801021f9:	83 ec 08             	sub    $0x8,%esp
801021fc:	ff 75 f0             	pushl  -0x10(%ebp)
801021ff:	50                   	push   %eax
80102200:	e8 e5 f5 ff ff       	call   801017ea <iget>
80102205:	83 c4 10             	add    $0x10,%esp
80102208:	eb 19                	jmp    80102223 <dirlookup+0xb8>
8010220a:	90                   	nop
8010220b:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
8010220f:	8b 45 08             	mov    0x8(%ebp),%eax
80102212:	8b 40 18             	mov    0x18(%eax),%eax
80102215:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80102218:	0f 87 76 ff ff ff    	ja     80102194 <dirlookup+0x29>
8010221e:	b8 00 00 00 00       	mov    $0x0,%eax
80102223:	c9                   	leave  
80102224:	c3                   	ret    

80102225 <dirlink>:
80102225:	55                   	push   %ebp
80102226:	89 e5                	mov    %esp,%ebp
80102228:	83 ec 28             	sub    $0x28,%esp
8010222b:	83 ec 04             	sub    $0x4,%esp
8010222e:	6a 00                	push   $0x0
80102230:	ff 75 0c             	pushl  0xc(%ebp)
80102233:	ff 75 08             	pushl  0x8(%ebp)
80102236:	e8 30 ff ff ff       	call   8010216b <dirlookup>
8010223b:	83 c4 10             	add    $0x10,%esp
8010223e:	89 45 f0             	mov    %eax,-0x10(%ebp)
80102241:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80102245:	74 18                	je     8010225f <dirlink+0x3a>
80102247:	83 ec 0c             	sub    $0xc,%esp
8010224a:	ff 75 f0             	pushl  -0x10(%ebp)
8010224d:	e8 81 f8 ff ff       	call   80101ad3 <iput>
80102252:	83 c4 10             	add    $0x10,%esp
80102255:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010225a:	e9 9c 00 00 00       	jmp    801022fb <dirlink+0xd6>
8010225f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102266:	eb 39                	jmp    801022a1 <dirlink+0x7c>
80102268:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010226b:	6a 10                	push   $0x10
8010226d:	50                   	push   %eax
8010226e:	8d 45 e0             	lea    -0x20(%ebp),%eax
80102271:	50                   	push   %eax
80102272:	ff 75 08             	pushl  0x8(%ebp)
80102275:	e8 f7 fb ff ff       	call   80101e71 <readi>
8010227a:	83 c4 10             	add    $0x10,%esp
8010227d:	83 f8 10             	cmp    $0x10,%eax
80102280:	74 0d                	je     8010228f <dirlink+0x6a>
80102282:	83 ec 0c             	sub    $0xc,%esp
80102285:	68 51 86 10 80       	push   $0x80108651
8010228a:	e8 ab e2 ff ff       	call   8010053a <panic>
8010228f:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
80102293:	66 85 c0             	test   %ax,%ax
80102296:	74 18                	je     801022b0 <dirlink+0x8b>
80102298:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010229b:	83 c0 10             	add    $0x10,%eax
8010229e:	89 45 f4             	mov    %eax,-0xc(%ebp)
801022a1:	8b 45 08             	mov    0x8(%ebp),%eax
801022a4:	8b 50 18             	mov    0x18(%eax),%edx
801022a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801022aa:	39 c2                	cmp    %eax,%edx
801022ac:	77 ba                	ja     80102268 <dirlink+0x43>
801022ae:	eb 01                	jmp    801022b1 <dirlink+0x8c>
801022b0:	90                   	nop
801022b1:	83 ec 04             	sub    $0x4,%esp
801022b4:	6a 0e                	push   $0xe
801022b6:	ff 75 0c             	pushl  0xc(%ebp)
801022b9:	8d 45 e0             	lea    -0x20(%ebp),%eax
801022bc:	83 c0 02             	add    $0x2,%eax
801022bf:	50                   	push   %eax
801022c0:	e8 e1 30 00 00       	call   801053a6 <strncpy>
801022c5:	83 c4 10             	add    $0x10,%esp
801022c8:	8b 45 10             	mov    0x10(%ebp),%eax
801022cb:	66 89 45 e0          	mov    %ax,-0x20(%ebp)
801022cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
801022d2:	6a 10                	push   $0x10
801022d4:	50                   	push   %eax
801022d5:	8d 45 e0             	lea    -0x20(%ebp),%eax
801022d8:	50                   	push   %eax
801022d9:	ff 75 08             	pushl  0x8(%ebp)
801022dc:	e8 e7 fc ff ff       	call   80101fc8 <writei>
801022e1:	83 c4 10             	add    $0x10,%esp
801022e4:	83 f8 10             	cmp    $0x10,%eax
801022e7:	74 0d                	je     801022f6 <dirlink+0xd1>
801022e9:	83 ec 0c             	sub    $0xc,%esp
801022ec:	68 5e 86 10 80       	push   $0x8010865e
801022f1:	e8 44 e2 ff ff       	call   8010053a <panic>
801022f6:	b8 00 00 00 00       	mov    $0x0,%eax
801022fb:	c9                   	leave  
801022fc:	c3                   	ret    

801022fd <skipelem>:
801022fd:	55                   	push   %ebp
801022fe:	89 e5                	mov    %esp,%ebp
80102300:	83 ec 18             	sub    $0x18,%esp
80102303:	eb 04                	jmp    80102309 <skipelem+0xc>
80102305:	83 45 08 01          	addl   $0x1,0x8(%ebp)
80102309:	8b 45 08             	mov    0x8(%ebp),%eax
8010230c:	0f b6 00             	movzbl (%eax),%eax
8010230f:	3c 2f                	cmp    $0x2f,%al
80102311:	74 f2                	je     80102305 <skipelem+0x8>
80102313:	8b 45 08             	mov    0x8(%ebp),%eax
80102316:	0f b6 00             	movzbl (%eax),%eax
80102319:	84 c0                	test   %al,%al
8010231b:	75 07                	jne    80102324 <skipelem+0x27>
8010231d:	b8 00 00 00 00       	mov    $0x0,%eax
80102322:	eb 7b                	jmp    8010239f <skipelem+0xa2>
80102324:	8b 45 08             	mov    0x8(%ebp),%eax
80102327:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010232a:	eb 04                	jmp    80102330 <skipelem+0x33>
8010232c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
80102330:	8b 45 08             	mov    0x8(%ebp),%eax
80102333:	0f b6 00             	movzbl (%eax),%eax
80102336:	3c 2f                	cmp    $0x2f,%al
80102338:	74 0a                	je     80102344 <skipelem+0x47>
8010233a:	8b 45 08             	mov    0x8(%ebp),%eax
8010233d:	0f b6 00             	movzbl (%eax),%eax
80102340:	84 c0                	test   %al,%al
80102342:	75 e8                	jne    8010232c <skipelem+0x2f>
80102344:	8b 55 08             	mov    0x8(%ebp),%edx
80102347:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010234a:	29 c2                	sub    %eax,%edx
8010234c:	89 d0                	mov    %edx,%eax
8010234e:	89 45 f0             	mov    %eax,-0x10(%ebp)
80102351:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
80102355:	7e 15                	jle    8010236c <skipelem+0x6f>
80102357:	83 ec 04             	sub    $0x4,%esp
8010235a:	6a 0e                	push   $0xe
8010235c:	ff 75 f4             	pushl  -0xc(%ebp)
8010235f:	ff 75 0c             	pushl  0xc(%ebp)
80102362:	e8 53 2f 00 00       	call   801052ba <memmove>
80102367:	83 c4 10             	add    $0x10,%esp
8010236a:	eb 26                	jmp    80102392 <skipelem+0x95>
8010236c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010236f:	83 ec 04             	sub    $0x4,%esp
80102372:	50                   	push   %eax
80102373:	ff 75 f4             	pushl  -0xc(%ebp)
80102376:	ff 75 0c             	pushl  0xc(%ebp)
80102379:	e8 3c 2f 00 00       	call   801052ba <memmove>
8010237e:	83 c4 10             	add    $0x10,%esp
80102381:	8b 55 f0             	mov    -0x10(%ebp),%edx
80102384:	8b 45 0c             	mov    0xc(%ebp),%eax
80102387:	01 d0                	add    %edx,%eax
80102389:	c6 00 00             	movb   $0x0,(%eax)
8010238c:	eb 04                	jmp    80102392 <skipelem+0x95>
8010238e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
80102392:	8b 45 08             	mov    0x8(%ebp),%eax
80102395:	0f b6 00             	movzbl (%eax),%eax
80102398:	3c 2f                	cmp    $0x2f,%al
8010239a:	74 f2                	je     8010238e <skipelem+0x91>
8010239c:	8b 45 08             	mov    0x8(%ebp),%eax
8010239f:	c9                   	leave  
801023a0:	c3                   	ret    

801023a1 <namex>:
801023a1:	55                   	push   %ebp
801023a2:	89 e5                	mov    %esp,%ebp
801023a4:	83 ec 18             	sub    $0x18,%esp
801023a7:	8b 45 08             	mov    0x8(%ebp),%eax
801023aa:	0f b6 00             	movzbl (%eax),%eax
801023ad:	3c 2f                	cmp    $0x2f,%al
801023af:	75 17                	jne    801023c8 <namex+0x27>
801023b1:	83 ec 08             	sub    $0x8,%esp
801023b4:	6a 01                	push   $0x1
801023b6:	6a 01                	push   $0x1
801023b8:	e8 2d f4 ff ff       	call   801017ea <iget>
801023bd:	83 c4 10             	add    $0x10,%esp
801023c0:	89 45 f4             	mov    %eax,-0xc(%ebp)
801023c3:	e9 bb 00 00 00       	jmp    80102483 <namex+0xe2>
801023c8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801023ce:	8b 40 68             	mov    0x68(%eax),%eax
801023d1:	83 ec 0c             	sub    $0xc,%esp
801023d4:	50                   	push   %eax
801023d5:	e8 ef f4 ff ff       	call   801018c9 <idup>
801023da:	83 c4 10             	add    $0x10,%esp
801023dd:	89 45 f4             	mov    %eax,-0xc(%ebp)
801023e0:	e9 9e 00 00 00       	jmp    80102483 <namex+0xe2>
801023e5:	83 ec 0c             	sub    $0xc,%esp
801023e8:	ff 75 f4             	pushl  -0xc(%ebp)
801023eb:	e8 13 f5 ff ff       	call   80101903 <ilock>
801023f0:	83 c4 10             	add    $0x10,%esp
801023f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801023f6:	0f b7 40 10          	movzwl 0x10(%eax),%eax
801023fa:	66 83 f8 01          	cmp    $0x1,%ax
801023fe:	74 18                	je     80102418 <namex+0x77>
80102400:	83 ec 0c             	sub    $0xc,%esp
80102403:	ff 75 f4             	pushl  -0xc(%ebp)
80102406:	e8 b8 f7 ff ff       	call   80101bc3 <iunlockput>
8010240b:	83 c4 10             	add    $0x10,%esp
8010240e:	b8 00 00 00 00       	mov    $0x0,%eax
80102413:	e9 a7 00 00 00       	jmp    801024bf <namex+0x11e>
80102418:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
8010241c:	74 20                	je     8010243e <namex+0x9d>
8010241e:	8b 45 08             	mov    0x8(%ebp),%eax
80102421:	0f b6 00             	movzbl (%eax),%eax
80102424:	84 c0                	test   %al,%al
80102426:	75 16                	jne    8010243e <namex+0x9d>
80102428:	83 ec 0c             	sub    $0xc,%esp
8010242b:	ff 75 f4             	pushl  -0xc(%ebp)
8010242e:	e8 2e f6 ff ff       	call   80101a61 <iunlock>
80102433:	83 c4 10             	add    $0x10,%esp
80102436:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102439:	e9 81 00 00 00       	jmp    801024bf <namex+0x11e>
8010243e:	83 ec 04             	sub    $0x4,%esp
80102441:	6a 00                	push   $0x0
80102443:	ff 75 10             	pushl  0x10(%ebp)
80102446:	ff 75 f4             	pushl  -0xc(%ebp)
80102449:	e8 1d fd ff ff       	call   8010216b <dirlookup>
8010244e:	83 c4 10             	add    $0x10,%esp
80102451:	89 45 f0             	mov    %eax,-0x10(%ebp)
80102454:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80102458:	75 15                	jne    8010246f <namex+0xce>
8010245a:	83 ec 0c             	sub    $0xc,%esp
8010245d:	ff 75 f4             	pushl  -0xc(%ebp)
80102460:	e8 5e f7 ff ff       	call   80101bc3 <iunlockput>
80102465:	83 c4 10             	add    $0x10,%esp
80102468:	b8 00 00 00 00       	mov    $0x0,%eax
8010246d:	eb 50                	jmp    801024bf <namex+0x11e>
8010246f:	83 ec 0c             	sub    $0xc,%esp
80102472:	ff 75 f4             	pushl  -0xc(%ebp)
80102475:	e8 49 f7 ff ff       	call   80101bc3 <iunlockput>
8010247a:	83 c4 10             	add    $0x10,%esp
8010247d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102480:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102483:	83 ec 08             	sub    $0x8,%esp
80102486:	ff 75 10             	pushl  0x10(%ebp)
80102489:	ff 75 08             	pushl  0x8(%ebp)
8010248c:	e8 6c fe ff ff       	call   801022fd <skipelem>
80102491:	83 c4 10             	add    $0x10,%esp
80102494:	89 45 08             	mov    %eax,0x8(%ebp)
80102497:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
8010249b:	0f 85 44 ff ff ff    	jne    801023e5 <namex+0x44>
801024a1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
801024a5:	74 15                	je     801024bc <namex+0x11b>
801024a7:	83 ec 0c             	sub    $0xc,%esp
801024aa:	ff 75 f4             	pushl  -0xc(%ebp)
801024ad:	e8 21 f6 ff ff       	call   80101ad3 <iput>
801024b2:	83 c4 10             	add    $0x10,%esp
801024b5:	b8 00 00 00 00       	mov    $0x0,%eax
801024ba:	eb 03                	jmp    801024bf <namex+0x11e>
801024bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801024bf:	c9                   	leave  
801024c0:	c3                   	ret    

801024c1 <namei>:
801024c1:	55                   	push   %ebp
801024c2:	89 e5                	mov    %esp,%ebp
801024c4:	83 ec 18             	sub    $0x18,%esp
801024c7:	83 ec 04             	sub    $0x4,%esp
801024ca:	8d 45 ea             	lea    -0x16(%ebp),%eax
801024cd:	50                   	push   %eax
801024ce:	6a 00                	push   $0x0
801024d0:	ff 75 08             	pushl  0x8(%ebp)
801024d3:	e8 c9 fe ff ff       	call   801023a1 <namex>
801024d8:	83 c4 10             	add    $0x10,%esp
801024db:	c9                   	leave  
801024dc:	c3                   	ret    

801024dd <nameiparent>:
801024dd:	55                   	push   %ebp
801024de:	89 e5                	mov    %esp,%ebp
801024e0:	83 ec 08             	sub    $0x8,%esp
801024e3:	83 ec 04             	sub    $0x4,%esp
801024e6:	ff 75 0c             	pushl  0xc(%ebp)
801024e9:	6a 01                	push   $0x1
801024eb:	ff 75 08             	pushl  0x8(%ebp)
801024ee:	e8 ae fe ff ff       	call   801023a1 <namex>
801024f3:	83 c4 10             	add    $0x10,%esp
801024f6:	c9                   	leave  
801024f7:	c3                   	ret    

801024f8 <inb>:
801024f8:	55                   	push   %ebp
801024f9:	89 e5                	mov    %esp,%ebp
801024fb:	83 ec 14             	sub    $0x14,%esp
801024fe:	8b 45 08             	mov    0x8(%ebp),%eax
80102501:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
80102505:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80102509:	89 c2                	mov    %eax,%edx
8010250b:	ec                   	in     (%dx),%al
8010250c:	88 45 ff             	mov    %al,-0x1(%ebp)
8010250f:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
80102513:	c9                   	leave  
80102514:	c3                   	ret    

80102515 <insl>:
80102515:	55                   	push   %ebp
80102516:	89 e5                	mov    %esp,%ebp
80102518:	57                   	push   %edi
80102519:	53                   	push   %ebx
8010251a:	8b 55 08             	mov    0x8(%ebp),%edx
8010251d:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102520:	8b 45 10             	mov    0x10(%ebp),%eax
80102523:	89 cb                	mov    %ecx,%ebx
80102525:	89 df                	mov    %ebx,%edi
80102527:	89 c1                	mov    %eax,%ecx
80102529:	fc                   	cld    
8010252a:	f3 6d                	rep insl (%dx),%es:(%edi)
8010252c:	89 c8                	mov    %ecx,%eax
8010252e:	89 fb                	mov    %edi,%ebx
80102530:	89 5d 0c             	mov    %ebx,0xc(%ebp)
80102533:	89 45 10             	mov    %eax,0x10(%ebp)
80102536:	90                   	nop
80102537:	5b                   	pop    %ebx
80102538:	5f                   	pop    %edi
80102539:	5d                   	pop    %ebp
8010253a:	c3                   	ret    

8010253b <outb>:
8010253b:	55                   	push   %ebp
8010253c:	89 e5                	mov    %esp,%ebp
8010253e:	83 ec 08             	sub    $0x8,%esp
80102541:	8b 55 08             	mov    0x8(%ebp),%edx
80102544:	8b 45 0c             	mov    0xc(%ebp),%eax
80102547:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
8010254b:	88 45 f8             	mov    %al,-0x8(%ebp)
8010254e:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80102552:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80102556:	ee                   	out    %al,(%dx)
80102557:	90                   	nop
80102558:	c9                   	leave  
80102559:	c3                   	ret    

8010255a <outsl>:
8010255a:	55                   	push   %ebp
8010255b:	89 e5                	mov    %esp,%ebp
8010255d:	56                   	push   %esi
8010255e:	53                   	push   %ebx
8010255f:	8b 55 08             	mov    0x8(%ebp),%edx
80102562:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102565:	8b 45 10             	mov    0x10(%ebp),%eax
80102568:	89 cb                	mov    %ecx,%ebx
8010256a:	89 de                	mov    %ebx,%esi
8010256c:	89 c1                	mov    %eax,%ecx
8010256e:	fc                   	cld    
8010256f:	f3 6f                	rep outsl %ds:(%esi),(%dx)
80102571:	89 c8                	mov    %ecx,%eax
80102573:	89 f3                	mov    %esi,%ebx
80102575:	89 5d 0c             	mov    %ebx,0xc(%ebp)
80102578:	89 45 10             	mov    %eax,0x10(%ebp)
8010257b:	90                   	nop
8010257c:	5b                   	pop    %ebx
8010257d:	5e                   	pop    %esi
8010257e:	5d                   	pop    %ebp
8010257f:	c3                   	ret    

80102580 <idewait>:
80102580:	55                   	push   %ebp
80102581:	89 e5                	mov    %esp,%ebp
80102583:	83 ec 10             	sub    $0x10,%esp
80102586:	90                   	nop
80102587:	68 f7 01 00 00       	push   $0x1f7
8010258c:	e8 67 ff ff ff       	call   801024f8 <inb>
80102591:	83 c4 04             	add    $0x4,%esp
80102594:	0f b6 c0             	movzbl %al,%eax
80102597:	89 45 fc             	mov    %eax,-0x4(%ebp)
8010259a:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010259d:	25 c0 00 00 00       	and    $0xc0,%eax
801025a2:	83 f8 40             	cmp    $0x40,%eax
801025a5:	75 e0                	jne    80102587 <idewait+0x7>
801025a7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801025ab:	74 11                	je     801025be <idewait+0x3e>
801025ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
801025b0:	83 e0 21             	and    $0x21,%eax
801025b3:	85 c0                	test   %eax,%eax
801025b5:	74 07                	je     801025be <idewait+0x3e>
801025b7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801025bc:	eb 05                	jmp    801025c3 <idewait+0x43>
801025be:	b8 00 00 00 00       	mov    $0x0,%eax
801025c3:	c9                   	leave  
801025c4:	c3                   	ret    

801025c5 <ideinit>:
801025c5:	55                   	push   %ebp
801025c6:	89 e5                	mov    %esp,%ebp
801025c8:	83 ec 18             	sub    $0x18,%esp
801025cb:	83 ec 08             	sub    $0x8,%esp
801025ce:	68 66 86 10 80       	push   $0x80108666
801025d3:	68 00 b6 10 80       	push   $0x8010b600
801025d8:	e8 99 29 00 00       	call   80104f76 <initlock>
801025dd:	83 c4 10             	add    $0x10,%esp
801025e0:	83 ec 0c             	sub    $0xc,%esp
801025e3:	6a 0e                	push   $0xe
801025e5:	e8 da 18 00 00       	call   80103ec4 <picenable>
801025ea:	83 c4 10             	add    $0x10,%esp
801025ed:	a1 40 29 11 80       	mov    0x80112940,%eax
801025f2:	83 e8 01             	sub    $0x1,%eax
801025f5:	83 ec 08             	sub    $0x8,%esp
801025f8:	50                   	push   %eax
801025f9:	6a 0e                	push   $0xe
801025fb:	e8 73 04 00 00       	call   80102a73 <ioapicenable>
80102600:	83 c4 10             	add    $0x10,%esp
80102603:	83 ec 0c             	sub    $0xc,%esp
80102606:	6a 00                	push   $0x0
80102608:	e8 73 ff ff ff       	call   80102580 <idewait>
8010260d:	83 c4 10             	add    $0x10,%esp
80102610:	83 ec 08             	sub    $0x8,%esp
80102613:	68 f0 00 00 00       	push   $0xf0
80102618:	68 f6 01 00 00       	push   $0x1f6
8010261d:	e8 19 ff ff ff       	call   8010253b <outb>
80102622:	83 c4 10             	add    $0x10,%esp
80102625:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010262c:	eb 24                	jmp    80102652 <ideinit+0x8d>
8010262e:	83 ec 0c             	sub    $0xc,%esp
80102631:	68 f7 01 00 00       	push   $0x1f7
80102636:	e8 bd fe ff ff       	call   801024f8 <inb>
8010263b:	83 c4 10             	add    $0x10,%esp
8010263e:	84 c0                	test   %al,%al
80102640:	74 0c                	je     8010264e <ideinit+0x89>
80102642:	c7 05 38 b6 10 80 01 	movl   $0x1,0x8010b638
80102649:	00 00 00 
8010264c:	eb 0d                	jmp    8010265b <ideinit+0x96>
8010264e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80102652:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
80102659:	7e d3                	jle    8010262e <ideinit+0x69>
8010265b:	83 ec 08             	sub    $0x8,%esp
8010265e:	68 e0 00 00 00       	push   $0xe0
80102663:	68 f6 01 00 00       	push   $0x1f6
80102668:	e8 ce fe ff ff       	call   8010253b <outb>
8010266d:	83 c4 10             	add    $0x10,%esp
80102670:	90                   	nop
80102671:	c9                   	leave  
80102672:	c3                   	ret    

80102673 <idestart>:
80102673:	55                   	push   %ebp
80102674:	89 e5                	mov    %esp,%ebp
80102676:	83 ec 18             	sub    $0x18,%esp
80102679:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
8010267d:	75 0d                	jne    8010268c <idestart+0x19>
8010267f:	83 ec 0c             	sub    $0xc,%esp
80102682:	68 6a 86 10 80       	push   $0x8010866a
80102687:	e8 ae de ff ff       	call   8010053a <panic>
8010268c:	8b 45 08             	mov    0x8(%ebp),%eax
8010268f:	8b 40 08             	mov    0x8(%eax),%eax
80102692:	3d e7 03 00 00       	cmp    $0x3e7,%eax
80102697:	76 0d                	jbe    801026a6 <idestart+0x33>
80102699:	83 ec 0c             	sub    $0xc,%esp
8010269c:	68 73 86 10 80       	push   $0x80108673
801026a1:	e8 94 de ff ff       	call   8010053a <panic>
801026a6:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
801026ad:	8b 45 08             	mov    0x8(%ebp),%eax
801026b0:	8b 50 08             	mov    0x8(%eax),%edx
801026b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801026b6:	0f af c2             	imul   %edx,%eax
801026b9:	89 45 f0             	mov    %eax,-0x10(%ebp)
801026bc:	83 7d f4 07          	cmpl   $0x7,-0xc(%ebp)
801026c0:	7e 0d                	jle    801026cf <idestart+0x5c>
801026c2:	83 ec 0c             	sub    $0xc,%esp
801026c5:	68 6a 86 10 80       	push   $0x8010866a
801026ca:	e8 6b de ff ff       	call   8010053a <panic>
801026cf:	83 ec 0c             	sub    $0xc,%esp
801026d2:	6a 00                	push   $0x0
801026d4:	e8 a7 fe ff ff       	call   80102580 <idewait>
801026d9:	83 c4 10             	add    $0x10,%esp
801026dc:	83 ec 08             	sub    $0x8,%esp
801026df:	6a 00                	push   $0x0
801026e1:	68 f6 03 00 00       	push   $0x3f6
801026e6:	e8 50 fe ff ff       	call   8010253b <outb>
801026eb:	83 c4 10             	add    $0x10,%esp
801026ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
801026f1:	0f b6 c0             	movzbl %al,%eax
801026f4:	83 ec 08             	sub    $0x8,%esp
801026f7:	50                   	push   %eax
801026f8:	68 f2 01 00 00       	push   $0x1f2
801026fd:	e8 39 fe ff ff       	call   8010253b <outb>
80102702:	83 c4 10             	add    $0x10,%esp
80102705:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102708:	0f b6 c0             	movzbl %al,%eax
8010270b:	83 ec 08             	sub    $0x8,%esp
8010270e:	50                   	push   %eax
8010270f:	68 f3 01 00 00       	push   $0x1f3
80102714:	e8 22 fe ff ff       	call   8010253b <outb>
80102719:	83 c4 10             	add    $0x10,%esp
8010271c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010271f:	c1 f8 08             	sar    $0x8,%eax
80102722:	0f b6 c0             	movzbl %al,%eax
80102725:	83 ec 08             	sub    $0x8,%esp
80102728:	50                   	push   %eax
80102729:	68 f4 01 00 00       	push   $0x1f4
8010272e:	e8 08 fe ff ff       	call   8010253b <outb>
80102733:	83 c4 10             	add    $0x10,%esp
80102736:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102739:	c1 f8 10             	sar    $0x10,%eax
8010273c:	0f b6 c0             	movzbl %al,%eax
8010273f:	83 ec 08             	sub    $0x8,%esp
80102742:	50                   	push   %eax
80102743:	68 f5 01 00 00       	push   $0x1f5
80102748:	e8 ee fd ff ff       	call   8010253b <outb>
8010274d:	83 c4 10             	add    $0x10,%esp
80102750:	8b 45 08             	mov    0x8(%ebp),%eax
80102753:	8b 40 04             	mov    0x4(%eax),%eax
80102756:	83 e0 01             	and    $0x1,%eax
80102759:	c1 e0 04             	shl    $0x4,%eax
8010275c:	89 c2                	mov    %eax,%edx
8010275e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102761:	c1 f8 18             	sar    $0x18,%eax
80102764:	83 e0 0f             	and    $0xf,%eax
80102767:	09 d0                	or     %edx,%eax
80102769:	83 c8 e0             	or     $0xffffffe0,%eax
8010276c:	0f b6 c0             	movzbl %al,%eax
8010276f:	83 ec 08             	sub    $0x8,%esp
80102772:	50                   	push   %eax
80102773:	68 f6 01 00 00       	push   $0x1f6
80102778:	e8 be fd ff ff       	call   8010253b <outb>
8010277d:	83 c4 10             	add    $0x10,%esp
80102780:	8b 45 08             	mov    0x8(%ebp),%eax
80102783:	8b 00                	mov    (%eax),%eax
80102785:	83 e0 04             	and    $0x4,%eax
80102788:	85 c0                	test   %eax,%eax
8010278a:	74 30                	je     801027bc <idestart+0x149>
8010278c:	83 ec 08             	sub    $0x8,%esp
8010278f:	6a 30                	push   $0x30
80102791:	68 f7 01 00 00       	push   $0x1f7
80102796:	e8 a0 fd ff ff       	call   8010253b <outb>
8010279b:	83 c4 10             	add    $0x10,%esp
8010279e:	8b 45 08             	mov    0x8(%ebp),%eax
801027a1:	83 c0 18             	add    $0x18,%eax
801027a4:	83 ec 04             	sub    $0x4,%esp
801027a7:	68 80 00 00 00       	push   $0x80
801027ac:	50                   	push   %eax
801027ad:	68 f0 01 00 00       	push   $0x1f0
801027b2:	e8 a3 fd ff ff       	call   8010255a <outsl>
801027b7:	83 c4 10             	add    $0x10,%esp
801027ba:	eb 12                	jmp    801027ce <idestart+0x15b>
801027bc:	83 ec 08             	sub    $0x8,%esp
801027bf:	6a 20                	push   $0x20
801027c1:	68 f7 01 00 00       	push   $0x1f7
801027c6:	e8 70 fd ff ff       	call   8010253b <outb>
801027cb:	83 c4 10             	add    $0x10,%esp
801027ce:	90                   	nop
801027cf:	c9                   	leave  
801027d0:	c3                   	ret    

801027d1 <ideintr>:
801027d1:	55                   	push   %ebp
801027d2:	89 e5                	mov    %esp,%ebp
801027d4:	83 ec 18             	sub    $0x18,%esp
801027d7:	83 ec 0c             	sub    $0xc,%esp
801027da:	68 00 b6 10 80       	push   $0x8010b600
801027df:	e8 b4 27 00 00       	call   80104f98 <acquire>
801027e4:	83 c4 10             	add    $0x10,%esp
801027e7:	a1 34 b6 10 80       	mov    0x8010b634,%eax
801027ec:	89 45 f4             	mov    %eax,-0xc(%ebp)
801027ef:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801027f3:	75 15                	jne    8010280a <ideintr+0x39>
801027f5:	83 ec 0c             	sub    $0xc,%esp
801027f8:	68 00 b6 10 80       	push   $0x8010b600
801027fd:	e8 fd 27 00 00       	call   80104fff <release>
80102802:	83 c4 10             	add    $0x10,%esp
80102805:	e9 9a 00 00 00       	jmp    801028a4 <ideintr+0xd3>
8010280a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010280d:	8b 40 14             	mov    0x14(%eax),%eax
80102810:	a3 34 b6 10 80       	mov    %eax,0x8010b634
80102815:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102818:	8b 00                	mov    (%eax),%eax
8010281a:	83 e0 04             	and    $0x4,%eax
8010281d:	85 c0                	test   %eax,%eax
8010281f:	75 2d                	jne    8010284e <ideintr+0x7d>
80102821:	83 ec 0c             	sub    $0xc,%esp
80102824:	6a 01                	push   $0x1
80102826:	e8 55 fd ff ff       	call   80102580 <idewait>
8010282b:	83 c4 10             	add    $0x10,%esp
8010282e:	85 c0                	test   %eax,%eax
80102830:	78 1c                	js     8010284e <ideintr+0x7d>
80102832:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102835:	83 c0 18             	add    $0x18,%eax
80102838:	83 ec 04             	sub    $0x4,%esp
8010283b:	68 80 00 00 00       	push   $0x80
80102840:	50                   	push   %eax
80102841:	68 f0 01 00 00       	push   $0x1f0
80102846:	e8 ca fc ff ff       	call   80102515 <insl>
8010284b:	83 c4 10             	add    $0x10,%esp
8010284e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102851:	8b 00                	mov    (%eax),%eax
80102853:	83 c8 02             	or     $0x2,%eax
80102856:	89 c2                	mov    %eax,%edx
80102858:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010285b:	89 10                	mov    %edx,(%eax)
8010285d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102860:	8b 00                	mov    (%eax),%eax
80102862:	83 e0 fb             	and    $0xfffffffb,%eax
80102865:	89 c2                	mov    %eax,%edx
80102867:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010286a:	89 10                	mov    %edx,(%eax)
8010286c:	83 ec 0c             	sub    $0xc,%esp
8010286f:	ff 75 f4             	pushl  -0xc(%ebp)
80102872:	e8 13 25 00 00       	call   80104d8a <wakeup>
80102877:	83 c4 10             	add    $0x10,%esp
8010287a:	a1 34 b6 10 80       	mov    0x8010b634,%eax
8010287f:	85 c0                	test   %eax,%eax
80102881:	74 11                	je     80102894 <ideintr+0xc3>
80102883:	a1 34 b6 10 80       	mov    0x8010b634,%eax
80102888:	83 ec 0c             	sub    $0xc,%esp
8010288b:	50                   	push   %eax
8010288c:	e8 e2 fd ff ff       	call   80102673 <idestart>
80102891:	83 c4 10             	add    $0x10,%esp
80102894:	83 ec 0c             	sub    $0xc,%esp
80102897:	68 00 b6 10 80       	push   $0x8010b600
8010289c:	e8 5e 27 00 00       	call   80104fff <release>
801028a1:	83 c4 10             	add    $0x10,%esp
801028a4:	c9                   	leave  
801028a5:	c3                   	ret    

801028a6 <iderw>:
801028a6:	55                   	push   %ebp
801028a7:	89 e5                	mov    %esp,%ebp
801028a9:	83 ec 18             	sub    $0x18,%esp
801028ac:	8b 45 08             	mov    0x8(%ebp),%eax
801028af:	8b 00                	mov    (%eax),%eax
801028b1:	83 e0 01             	and    $0x1,%eax
801028b4:	85 c0                	test   %eax,%eax
801028b6:	75 0d                	jne    801028c5 <iderw+0x1f>
801028b8:	83 ec 0c             	sub    $0xc,%esp
801028bb:	68 85 86 10 80       	push   $0x80108685
801028c0:	e8 75 dc ff ff       	call   8010053a <panic>
801028c5:	8b 45 08             	mov    0x8(%ebp),%eax
801028c8:	8b 00                	mov    (%eax),%eax
801028ca:	83 e0 06             	and    $0x6,%eax
801028cd:	83 f8 02             	cmp    $0x2,%eax
801028d0:	75 0d                	jne    801028df <iderw+0x39>
801028d2:	83 ec 0c             	sub    $0xc,%esp
801028d5:	68 99 86 10 80       	push   $0x80108699
801028da:	e8 5b dc ff ff       	call   8010053a <panic>
801028df:	8b 45 08             	mov    0x8(%ebp),%eax
801028e2:	8b 40 04             	mov    0x4(%eax),%eax
801028e5:	85 c0                	test   %eax,%eax
801028e7:	74 16                	je     801028ff <iderw+0x59>
801028e9:	a1 38 b6 10 80       	mov    0x8010b638,%eax
801028ee:	85 c0                	test   %eax,%eax
801028f0:	75 0d                	jne    801028ff <iderw+0x59>
801028f2:	83 ec 0c             	sub    $0xc,%esp
801028f5:	68 ae 86 10 80       	push   $0x801086ae
801028fa:	e8 3b dc ff ff       	call   8010053a <panic>
801028ff:	83 ec 0c             	sub    $0xc,%esp
80102902:	68 00 b6 10 80       	push   $0x8010b600
80102907:	e8 8c 26 00 00       	call   80104f98 <acquire>
8010290c:	83 c4 10             	add    $0x10,%esp
8010290f:	8b 45 08             	mov    0x8(%ebp),%eax
80102912:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
80102919:	c7 45 f4 34 b6 10 80 	movl   $0x8010b634,-0xc(%ebp)
80102920:	eb 0b                	jmp    8010292d <iderw+0x87>
80102922:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102925:	8b 00                	mov    (%eax),%eax
80102927:	83 c0 14             	add    $0x14,%eax
8010292a:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010292d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102930:	8b 00                	mov    (%eax),%eax
80102932:	85 c0                	test   %eax,%eax
80102934:	75 ec                	jne    80102922 <iderw+0x7c>
80102936:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102939:	8b 55 08             	mov    0x8(%ebp),%edx
8010293c:	89 10                	mov    %edx,(%eax)
8010293e:	a1 34 b6 10 80       	mov    0x8010b634,%eax
80102943:	3b 45 08             	cmp    0x8(%ebp),%eax
80102946:	75 23                	jne    8010296b <iderw+0xc5>
80102948:	83 ec 0c             	sub    $0xc,%esp
8010294b:	ff 75 08             	pushl  0x8(%ebp)
8010294e:	e8 20 fd ff ff       	call   80102673 <idestart>
80102953:	83 c4 10             	add    $0x10,%esp
80102956:	eb 13                	jmp    8010296b <iderw+0xc5>
80102958:	83 ec 08             	sub    $0x8,%esp
8010295b:	68 00 b6 10 80       	push   $0x8010b600
80102960:	ff 75 08             	pushl  0x8(%ebp)
80102963:	e8 37 23 00 00       	call   80104c9f <sleep>
80102968:	83 c4 10             	add    $0x10,%esp
8010296b:	8b 45 08             	mov    0x8(%ebp),%eax
8010296e:	8b 00                	mov    (%eax),%eax
80102970:	83 e0 06             	and    $0x6,%eax
80102973:	83 f8 02             	cmp    $0x2,%eax
80102976:	75 e0                	jne    80102958 <iderw+0xb2>
80102978:	83 ec 0c             	sub    $0xc,%esp
8010297b:	68 00 b6 10 80       	push   $0x8010b600
80102980:	e8 7a 26 00 00       	call   80104fff <release>
80102985:	83 c4 10             	add    $0x10,%esp
80102988:	90                   	nop
80102989:	c9                   	leave  
8010298a:	c3                   	ret    

8010298b <ioapicread>:
8010298b:	55                   	push   %ebp
8010298c:	89 e5                	mov    %esp,%ebp
8010298e:	a1 14 22 11 80       	mov    0x80112214,%eax
80102993:	8b 55 08             	mov    0x8(%ebp),%edx
80102996:	89 10                	mov    %edx,(%eax)
80102998:	a1 14 22 11 80       	mov    0x80112214,%eax
8010299d:	8b 40 10             	mov    0x10(%eax),%eax
801029a0:	5d                   	pop    %ebp
801029a1:	c3                   	ret    

801029a2 <ioapicwrite>:
801029a2:	55                   	push   %ebp
801029a3:	89 e5                	mov    %esp,%ebp
801029a5:	a1 14 22 11 80       	mov    0x80112214,%eax
801029aa:	8b 55 08             	mov    0x8(%ebp),%edx
801029ad:	89 10                	mov    %edx,(%eax)
801029af:	a1 14 22 11 80       	mov    0x80112214,%eax
801029b4:	8b 55 0c             	mov    0xc(%ebp),%edx
801029b7:	89 50 10             	mov    %edx,0x10(%eax)
801029ba:	90                   	nop
801029bb:	5d                   	pop    %ebp
801029bc:	c3                   	ret    

801029bd <ioapicinit>:
801029bd:	55                   	push   %ebp
801029be:	89 e5                	mov    %esp,%ebp
801029c0:	83 ec 18             	sub    $0x18,%esp
801029c3:	a1 44 23 11 80       	mov    0x80112344,%eax
801029c8:	85 c0                	test   %eax,%eax
801029ca:	0f 84 a0 00 00 00    	je     80102a70 <ioapicinit+0xb3>
801029d0:	c7 05 14 22 11 80 00 	movl   $0xfec00000,0x80112214
801029d7:	00 c0 fe 
801029da:	6a 01                	push   $0x1
801029dc:	e8 aa ff ff ff       	call   8010298b <ioapicread>
801029e1:	83 c4 04             	add    $0x4,%esp
801029e4:	c1 e8 10             	shr    $0x10,%eax
801029e7:	25 ff 00 00 00       	and    $0xff,%eax
801029ec:	89 45 f0             	mov    %eax,-0x10(%ebp)
801029ef:	6a 00                	push   $0x0
801029f1:	e8 95 ff ff ff       	call   8010298b <ioapicread>
801029f6:	83 c4 04             	add    $0x4,%esp
801029f9:	c1 e8 18             	shr    $0x18,%eax
801029fc:	89 45 ec             	mov    %eax,-0x14(%ebp)
801029ff:	0f b6 05 40 23 11 80 	movzbl 0x80112340,%eax
80102a06:	0f b6 c0             	movzbl %al,%eax
80102a09:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80102a0c:	74 10                	je     80102a1e <ioapicinit+0x61>
80102a0e:	83 ec 0c             	sub    $0xc,%esp
80102a11:	68 cc 86 10 80       	push   $0x801086cc
80102a16:	e8 85 d9 ff ff       	call   801003a0 <cprintf>
80102a1b:	83 c4 10             	add    $0x10,%esp
80102a1e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102a25:	eb 3f                	jmp    80102a66 <ioapicinit+0xa9>
80102a27:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102a2a:	83 c0 20             	add    $0x20,%eax
80102a2d:	0d 00 00 01 00       	or     $0x10000,%eax
80102a32:	89 c2                	mov    %eax,%edx
80102a34:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102a37:	83 c0 08             	add    $0x8,%eax
80102a3a:	01 c0                	add    %eax,%eax
80102a3c:	83 ec 08             	sub    $0x8,%esp
80102a3f:	52                   	push   %edx
80102a40:	50                   	push   %eax
80102a41:	e8 5c ff ff ff       	call   801029a2 <ioapicwrite>
80102a46:	83 c4 10             	add    $0x10,%esp
80102a49:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102a4c:	83 c0 08             	add    $0x8,%eax
80102a4f:	01 c0                	add    %eax,%eax
80102a51:	83 c0 01             	add    $0x1,%eax
80102a54:	83 ec 08             	sub    $0x8,%esp
80102a57:	6a 00                	push   $0x0
80102a59:	50                   	push   %eax
80102a5a:	e8 43 ff ff ff       	call   801029a2 <ioapicwrite>
80102a5f:	83 c4 10             	add    $0x10,%esp
80102a62:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80102a66:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102a69:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80102a6c:	7e b9                	jle    80102a27 <ioapicinit+0x6a>
80102a6e:	eb 01                	jmp    80102a71 <ioapicinit+0xb4>
80102a70:	90                   	nop
80102a71:	c9                   	leave  
80102a72:	c3                   	ret    

80102a73 <ioapicenable>:
80102a73:	55                   	push   %ebp
80102a74:	89 e5                	mov    %esp,%ebp
80102a76:	a1 44 23 11 80       	mov    0x80112344,%eax
80102a7b:	85 c0                	test   %eax,%eax
80102a7d:	74 39                	je     80102ab8 <ioapicenable+0x45>
80102a7f:	8b 45 08             	mov    0x8(%ebp),%eax
80102a82:	83 c0 20             	add    $0x20,%eax
80102a85:	89 c2                	mov    %eax,%edx
80102a87:	8b 45 08             	mov    0x8(%ebp),%eax
80102a8a:	83 c0 08             	add    $0x8,%eax
80102a8d:	01 c0                	add    %eax,%eax
80102a8f:	52                   	push   %edx
80102a90:	50                   	push   %eax
80102a91:	e8 0c ff ff ff       	call   801029a2 <ioapicwrite>
80102a96:	83 c4 08             	add    $0x8,%esp
80102a99:	8b 45 0c             	mov    0xc(%ebp),%eax
80102a9c:	c1 e0 18             	shl    $0x18,%eax
80102a9f:	89 c2                	mov    %eax,%edx
80102aa1:	8b 45 08             	mov    0x8(%ebp),%eax
80102aa4:	83 c0 08             	add    $0x8,%eax
80102aa7:	01 c0                	add    %eax,%eax
80102aa9:	83 c0 01             	add    $0x1,%eax
80102aac:	52                   	push   %edx
80102aad:	50                   	push   %eax
80102aae:	e8 ef fe ff ff       	call   801029a2 <ioapicwrite>
80102ab3:	83 c4 08             	add    $0x8,%esp
80102ab6:	eb 01                	jmp    80102ab9 <ioapicenable+0x46>
80102ab8:	90                   	nop
80102ab9:	c9                   	leave  
80102aba:	c3                   	ret    

80102abb <v2p>:
80102abb:	55                   	push   %ebp
80102abc:	89 e5                	mov    %esp,%ebp
80102abe:	8b 45 08             	mov    0x8(%ebp),%eax
80102ac1:	05 00 00 00 80       	add    $0x80000000,%eax
80102ac6:	5d                   	pop    %ebp
80102ac7:	c3                   	ret    

80102ac8 <kinit1>:
80102ac8:	55                   	push   %ebp
80102ac9:	89 e5                	mov    %esp,%ebp
80102acb:	83 ec 08             	sub    $0x8,%esp
80102ace:	83 ec 08             	sub    $0x8,%esp
80102ad1:	68 fe 86 10 80       	push   $0x801086fe
80102ad6:	68 20 22 11 80       	push   $0x80112220
80102adb:	e8 96 24 00 00       	call   80104f76 <initlock>
80102ae0:	83 c4 10             	add    $0x10,%esp
80102ae3:	c7 05 54 22 11 80 00 	movl   $0x0,0x80112254
80102aea:	00 00 00 
80102aed:	83 ec 08             	sub    $0x8,%esp
80102af0:	ff 75 0c             	pushl  0xc(%ebp)
80102af3:	ff 75 08             	pushl  0x8(%ebp)
80102af6:	e8 2a 00 00 00       	call   80102b25 <freerange>
80102afb:	83 c4 10             	add    $0x10,%esp
80102afe:	90                   	nop
80102aff:	c9                   	leave  
80102b00:	c3                   	ret    

80102b01 <kinit2>:
80102b01:	55                   	push   %ebp
80102b02:	89 e5                	mov    %esp,%ebp
80102b04:	83 ec 08             	sub    $0x8,%esp
80102b07:	83 ec 08             	sub    $0x8,%esp
80102b0a:	ff 75 0c             	pushl  0xc(%ebp)
80102b0d:	ff 75 08             	pushl  0x8(%ebp)
80102b10:	e8 10 00 00 00       	call   80102b25 <freerange>
80102b15:	83 c4 10             	add    $0x10,%esp
80102b18:	c7 05 54 22 11 80 01 	movl   $0x1,0x80112254
80102b1f:	00 00 00 
80102b22:	90                   	nop
80102b23:	c9                   	leave  
80102b24:	c3                   	ret    

80102b25 <freerange>:
80102b25:	55                   	push   %ebp
80102b26:	89 e5                	mov    %esp,%ebp
80102b28:	83 ec 18             	sub    $0x18,%esp
80102b2b:	8b 45 08             	mov    0x8(%ebp),%eax
80102b2e:	05 ff 0f 00 00       	add    $0xfff,%eax
80102b33:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80102b38:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102b3b:	eb 15                	jmp    80102b52 <freerange+0x2d>
80102b3d:	83 ec 0c             	sub    $0xc,%esp
80102b40:	ff 75 f4             	pushl  -0xc(%ebp)
80102b43:	e8 1a 00 00 00       	call   80102b62 <kfree>
80102b48:	83 c4 10             	add    $0x10,%esp
80102b4b:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80102b52:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102b55:	05 00 10 00 00       	add    $0x1000,%eax
80102b5a:	3b 45 0c             	cmp    0xc(%ebp),%eax
80102b5d:	76 de                	jbe    80102b3d <freerange+0x18>
80102b5f:	90                   	nop
80102b60:	c9                   	leave  
80102b61:	c3                   	ret    

80102b62 <kfree>:
80102b62:	55                   	push   %ebp
80102b63:	89 e5                	mov    %esp,%ebp
80102b65:	83 ec 18             	sub    $0x18,%esp
80102b68:	8b 45 08             	mov    0x8(%ebp),%eax
80102b6b:	25 ff 0f 00 00       	and    $0xfff,%eax
80102b70:	85 c0                	test   %eax,%eax
80102b72:	75 1b                	jne    80102b8f <kfree+0x2d>
80102b74:	81 7d 08 3c 51 11 80 	cmpl   $0x8011513c,0x8(%ebp)
80102b7b:	72 12                	jb     80102b8f <kfree+0x2d>
80102b7d:	ff 75 08             	pushl  0x8(%ebp)
80102b80:	e8 36 ff ff ff       	call   80102abb <v2p>
80102b85:	83 c4 04             	add    $0x4,%esp
80102b88:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102b8d:	76 0d                	jbe    80102b9c <kfree+0x3a>
80102b8f:	83 ec 0c             	sub    $0xc,%esp
80102b92:	68 03 87 10 80       	push   $0x80108703
80102b97:	e8 9e d9 ff ff       	call   8010053a <panic>
80102b9c:	83 ec 04             	sub    $0x4,%esp
80102b9f:	68 00 10 00 00       	push   $0x1000
80102ba4:	6a 01                	push   $0x1
80102ba6:	ff 75 08             	pushl  0x8(%ebp)
80102ba9:	e8 4d 26 00 00       	call   801051fb <memset>
80102bae:	83 c4 10             	add    $0x10,%esp
80102bb1:	a1 54 22 11 80       	mov    0x80112254,%eax
80102bb6:	85 c0                	test   %eax,%eax
80102bb8:	74 10                	je     80102bca <kfree+0x68>
80102bba:	83 ec 0c             	sub    $0xc,%esp
80102bbd:	68 20 22 11 80       	push   $0x80112220
80102bc2:	e8 d1 23 00 00       	call   80104f98 <acquire>
80102bc7:	83 c4 10             	add    $0x10,%esp
80102bca:	8b 45 08             	mov    0x8(%ebp),%eax
80102bcd:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102bd0:	8b 15 58 22 11 80    	mov    0x80112258,%edx
80102bd6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102bd9:	89 10                	mov    %edx,(%eax)
80102bdb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102bde:	a3 58 22 11 80       	mov    %eax,0x80112258
80102be3:	a1 54 22 11 80       	mov    0x80112254,%eax
80102be8:	85 c0                	test   %eax,%eax
80102bea:	74 10                	je     80102bfc <kfree+0x9a>
80102bec:	83 ec 0c             	sub    $0xc,%esp
80102bef:	68 20 22 11 80       	push   $0x80112220
80102bf4:	e8 06 24 00 00       	call   80104fff <release>
80102bf9:	83 c4 10             	add    $0x10,%esp
80102bfc:	90                   	nop
80102bfd:	c9                   	leave  
80102bfe:	c3                   	ret    

80102bff <kalloc>:
80102bff:	55                   	push   %ebp
80102c00:	89 e5                	mov    %esp,%ebp
80102c02:	83 ec 18             	sub    $0x18,%esp
80102c05:	a1 54 22 11 80       	mov    0x80112254,%eax
80102c0a:	85 c0                	test   %eax,%eax
80102c0c:	74 10                	je     80102c1e <kalloc+0x1f>
80102c0e:	83 ec 0c             	sub    $0xc,%esp
80102c11:	68 20 22 11 80       	push   $0x80112220
80102c16:	e8 7d 23 00 00       	call   80104f98 <acquire>
80102c1b:	83 c4 10             	add    $0x10,%esp
80102c1e:	a1 58 22 11 80       	mov    0x80112258,%eax
80102c23:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102c26:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80102c2a:	74 0a                	je     80102c36 <kalloc+0x37>
80102c2c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102c2f:	8b 00                	mov    (%eax),%eax
80102c31:	a3 58 22 11 80       	mov    %eax,0x80112258
80102c36:	a1 54 22 11 80       	mov    0x80112254,%eax
80102c3b:	85 c0                	test   %eax,%eax
80102c3d:	74 10                	je     80102c4f <kalloc+0x50>
80102c3f:	83 ec 0c             	sub    $0xc,%esp
80102c42:	68 20 22 11 80       	push   $0x80112220
80102c47:	e8 b3 23 00 00       	call   80104fff <release>
80102c4c:	83 c4 10             	add    $0x10,%esp
80102c4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102c52:	c9                   	leave  
80102c53:	c3                   	ret    

80102c54 <inb>:
80102c54:	55                   	push   %ebp
80102c55:	89 e5                	mov    %esp,%ebp
80102c57:	83 ec 14             	sub    $0x14,%esp
80102c5a:	8b 45 08             	mov    0x8(%ebp),%eax
80102c5d:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
80102c61:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80102c65:	89 c2                	mov    %eax,%edx
80102c67:	ec                   	in     (%dx),%al
80102c68:	88 45 ff             	mov    %al,-0x1(%ebp)
80102c6b:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
80102c6f:	c9                   	leave  
80102c70:	c3                   	ret    

80102c71 <kbdgetc>:
80102c71:	55                   	push   %ebp
80102c72:	89 e5                	mov    %esp,%ebp
80102c74:	83 ec 10             	sub    $0x10,%esp
80102c77:	6a 64                	push   $0x64
80102c79:	e8 d6 ff ff ff       	call   80102c54 <inb>
80102c7e:	83 c4 04             	add    $0x4,%esp
80102c81:	0f b6 c0             	movzbl %al,%eax
80102c84:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102c87:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102c8a:	83 e0 01             	and    $0x1,%eax
80102c8d:	85 c0                	test   %eax,%eax
80102c8f:	75 0a                	jne    80102c9b <kbdgetc+0x2a>
80102c91:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102c96:	e9 23 01 00 00       	jmp    80102dbe <kbdgetc+0x14d>
80102c9b:	6a 60                	push   $0x60
80102c9d:	e8 b2 ff ff ff       	call   80102c54 <inb>
80102ca2:	83 c4 04             	add    $0x4,%esp
80102ca5:	0f b6 c0             	movzbl %al,%eax
80102ca8:	89 45 fc             	mov    %eax,-0x4(%ebp)
80102cab:	81 7d fc e0 00 00 00 	cmpl   $0xe0,-0x4(%ebp)
80102cb2:	75 17                	jne    80102ccb <kbdgetc+0x5a>
80102cb4:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102cb9:	83 c8 40             	or     $0x40,%eax
80102cbc:	a3 3c b6 10 80       	mov    %eax,0x8010b63c
80102cc1:	b8 00 00 00 00       	mov    $0x0,%eax
80102cc6:	e9 f3 00 00 00       	jmp    80102dbe <kbdgetc+0x14d>
80102ccb:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102cce:	25 80 00 00 00       	and    $0x80,%eax
80102cd3:	85 c0                	test   %eax,%eax
80102cd5:	74 45                	je     80102d1c <kbdgetc+0xab>
80102cd7:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102cdc:	83 e0 40             	and    $0x40,%eax
80102cdf:	85 c0                	test   %eax,%eax
80102ce1:	75 08                	jne    80102ceb <kbdgetc+0x7a>
80102ce3:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102ce6:	83 e0 7f             	and    $0x7f,%eax
80102ce9:	eb 03                	jmp    80102cee <kbdgetc+0x7d>
80102ceb:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102cee:	89 45 fc             	mov    %eax,-0x4(%ebp)
80102cf1:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102cf4:	05 20 90 10 80       	add    $0x80109020,%eax
80102cf9:	0f b6 00             	movzbl (%eax),%eax
80102cfc:	83 c8 40             	or     $0x40,%eax
80102cff:	0f b6 c0             	movzbl %al,%eax
80102d02:	f7 d0                	not    %eax
80102d04:	89 c2                	mov    %eax,%edx
80102d06:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102d0b:	21 d0                	and    %edx,%eax
80102d0d:	a3 3c b6 10 80       	mov    %eax,0x8010b63c
80102d12:	b8 00 00 00 00       	mov    $0x0,%eax
80102d17:	e9 a2 00 00 00       	jmp    80102dbe <kbdgetc+0x14d>
80102d1c:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102d21:	83 e0 40             	and    $0x40,%eax
80102d24:	85 c0                	test   %eax,%eax
80102d26:	74 14                	je     80102d3c <kbdgetc+0xcb>
80102d28:	81 4d fc 80 00 00 00 	orl    $0x80,-0x4(%ebp)
80102d2f:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102d34:	83 e0 bf             	and    $0xffffffbf,%eax
80102d37:	a3 3c b6 10 80       	mov    %eax,0x8010b63c
80102d3c:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102d3f:	05 20 90 10 80       	add    $0x80109020,%eax
80102d44:	0f b6 00             	movzbl (%eax),%eax
80102d47:	0f b6 d0             	movzbl %al,%edx
80102d4a:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102d4f:	09 d0                	or     %edx,%eax
80102d51:	a3 3c b6 10 80       	mov    %eax,0x8010b63c
80102d56:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102d59:	05 20 91 10 80       	add    $0x80109120,%eax
80102d5e:	0f b6 00             	movzbl (%eax),%eax
80102d61:	0f b6 d0             	movzbl %al,%edx
80102d64:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102d69:	31 d0                	xor    %edx,%eax
80102d6b:	a3 3c b6 10 80       	mov    %eax,0x8010b63c
80102d70:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102d75:	83 e0 03             	and    $0x3,%eax
80102d78:	8b 14 85 20 95 10 80 	mov    -0x7fef6ae0(,%eax,4),%edx
80102d7f:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102d82:	01 d0                	add    %edx,%eax
80102d84:	0f b6 00             	movzbl (%eax),%eax
80102d87:	0f b6 c0             	movzbl %al,%eax
80102d8a:	89 45 f8             	mov    %eax,-0x8(%ebp)
80102d8d:	a1 3c b6 10 80       	mov    0x8010b63c,%eax
80102d92:	83 e0 08             	and    $0x8,%eax
80102d95:	85 c0                	test   %eax,%eax
80102d97:	74 22                	je     80102dbb <kbdgetc+0x14a>
80102d99:	83 7d f8 60          	cmpl   $0x60,-0x8(%ebp)
80102d9d:	76 0c                	jbe    80102dab <kbdgetc+0x13a>
80102d9f:	83 7d f8 7a          	cmpl   $0x7a,-0x8(%ebp)
80102da3:	77 06                	ja     80102dab <kbdgetc+0x13a>
80102da5:	83 6d f8 20          	subl   $0x20,-0x8(%ebp)
80102da9:	eb 10                	jmp    80102dbb <kbdgetc+0x14a>
80102dab:	83 7d f8 40          	cmpl   $0x40,-0x8(%ebp)
80102daf:	76 0a                	jbe    80102dbb <kbdgetc+0x14a>
80102db1:	83 7d f8 5a          	cmpl   $0x5a,-0x8(%ebp)
80102db5:	77 04                	ja     80102dbb <kbdgetc+0x14a>
80102db7:	83 45 f8 20          	addl   $0x20,-0x8(%ebp)
80102dbb:	8b 45 f8             	mov    -0x8(%ebp),%eax
80102dbe:	c9                   	leave  
80102dbf:	c3                   	ret    

80102dc0 <kbdintr>:
80102dc0:	55                   	push   %ebp
80102dc1:	89 e5                	mov    %esp,%ebp
80102dc3:	83 ec 08             	sub    $0x8,%esp
80102dc6:	83 ec 0c             	sub    $0xc,%esp
80102dc9:	68 71 2c 10 80       	push   $0x80102c71
80102dce:	e8 f5 d9 ff ff       	call   801007c8 <consoleintr>
80102dd3:	83 c4 10             	add    $0x10,%esp
80102dd6:	90                   	nop
80102dd7:	c9                   	leave  
80102dd8:	c3                   	ret    

80102dd9 <inb>:
80102dd9:	55                   	push   %ebp
80102dda:	89 e5                	mov    %esp,%ebp
80102ddc:	83 ec 14             	sub    $0x14,%esp
80102ddf:	8b 45 08             	mov    0x8(%ebp),%eax
80102de2:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
80102de6:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80102dea:	89 c2                	mov    %eax,%edx
80102dec:	ec                   	in     (%dx),%al
80102ded:	88 45 ff             	mov    %al,-0x1(%ebp)
80102df0:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
80102df4:	c9                   	leave  
80102df5:	c3                   	ret    

80102df6 <outb>:
80102df6:	55                   	push   %ebp
80102df7:	89 e5                	mov    %esp,%ebp
80102df9:	83 ec 08             	sub    $0x8,%esp
80102dfc:	8b 55 08             	mov    0x8(%ebp),%edx
80102dff:	8b 45 0c             	mov    0xc(%ebp),%eax
80102e02:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80102e06:	88 45 f8             	mov    %al,-0x8(%ebp)
80102e09:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80102e0d:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80102e11:	ee                   	out    %al,(%dx)
80102e12:	90                   	nop
80102e13:	c9                   	leave  
80102e14:	c3                   	ret    

80102e15 <readeflags>:
80102e15:	55                   	push   %ebp
80102e16:	89 e5                	mov    %esp,%ebp
80102e18:	83 ec 10             	sub    $0x10,%esp
80102e1b:	9c                   	pushf  
80102e1c:	58                   	pop    %eax
80102e1d:	89 45 fc             	mov    %eax,-0x4(%ebp)
80102e20:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102e23:	c9                   	leave  
80102e24:	c3                   	ret    

80102e25 <lapicw>:
80102e25:	55                   	push   %ebp
80102e26:	89 e5                	mov    %esp,%ebp
80102e28:	a1 5c 22 11 80       	mov    0x8011225c,%eax
80102e2d:	8b 55 08             	mov    0x8(%ebp),%edx
80102e30:	c1 e2 02             	shl    $0x2,%edx
80102e33:	01 c2                	add    %eax,%edx
80102e35:	8b 45 0c             	mov    0xc(%ebp),%eax
80102e38:	89 02                	mov    %eax,(%edx)
80102e3a:	a1 5c 22 11 80       	mov    0x8011225c,%eax
80102e3f:	83 c0 20             	add    $0x20,%eax
80102e42:	8b 00                	mov    (%eax),%eax
80102e44:	90                   	nop
80102e45:	5d                   	pop    %ebp
80102e46:	c3                   	ret    

80102e47 <lapicinit>:
80102e47:	55                   	push   %ebp
80102e48:	89 e5                	mov    %esp,%ebp
80102e4a:	a1 5c 22 11 80       	mov    0x8011225c,%eax
80102e4f:	85 c0                	test   %eax,%eax
80102e51:	0f 84 0b 01 00 00    	je     80102f62 <lapicinit+0x11b>
80102e57:	68 3f 01 00 00       	push   $0x13f
80102e5c:	6a 3c                	push   $0x3c
80102e5e:	e8 c2 ff ff ff       	call   80102e25 <lapicw>
80102e63:	83 c4 08             	add    $0x8,%esp
80102e66:	6a 0b                	push   $0xb
80102e68:	68 f8 00 00 00       	push   $0xf8
80102e6d:	e8 b3 ff ff ff       	call   80102e25 <lapicw>
80102e72:	83 c4 08             	add    $0x8,%esp
80102e75:	68 20 00 02 00       	push   $0x20020
80102e7a:	68 c8 00 00 00       	push   $0xc8
80102e7f:	e8 a1 ff ff ff       	call   80102e25 <lapicw>
80102e84:	83 c4 08             	add    $0x8,%esp
80102e87:	68 80 96 98 00       	push   $0x989680
80102e8c:	68 e0 00 00 00       	push   $0xe0
80102e91:	e8 8f ff ff ff       	call   80102e25 <lapicw>
80102e96:	83 c4 08             	add    $0x8,%esp
80102e99:	68 00 00 01 00       	push   $0x10000
80102e9e:	68 d4 00 00 00       	push   $0xd4
80102ea3:	e8 7d ff ff ff       	call   80102e25 <lapicw>
80102ea8:	83 c4 08             	add    $0x8,%esp
80102eab:	68 00 00 01 00       	push   $0x10000
80102eb0:	68 d8 00 00 00       	push   $0xd8
80102eb5:	e8 6b ff ff ff       	call   80102e25 <lapicw>
80102eba:	83 c4 08             	add    $0x8,%esp
80102ebd:	a1 5c 22 11 80       	mov    0x8011225c,%eax
80102ec2:	83 c0 30             	add    $0x30,%eax
80102ec5:	8b 00                	mov    (%eax),%eax
80102ec7:	c1 e8 10             	shr    $0x10,%eax
80102eca:	0f b6 c0             	movzbl %al,%eax
80102ecd:	83 f8 03             	cmp    $0x3,%eax
80102ed0:	76 12                	jbe    80102ee4 <lapicinit+0x9d>
80102ed2:	68 00 00 01 00       	push   $0x10000
80102ed7:	68 d0 00 00 00       	push   $0xd0
80102edc:	e8 44 ff ff ff       	call   80102e25 <lapicw>
80102ee1:	83 c4 08             	add    $0x8,%esp
80102ee4:	6a 33                	push   $0x33
80102ee6:	68 dc 00 00 00       	push   $0xdc
80102eeb:	e8 35 ff ff ff       	call   80102e25 <lapicw>
80102ef0:	83 c4 08             	add    $0x8,%esp
80102ef3:	6a 00                	push   $0x0
80102ef5:	68 a0 00 00 00       	push   $0xa0
80102efa:	e8 26 ff ff ff       	call   80102e25 <lapicw>
80102eff:	83 c4 08             	add    $0x8,%esp
80102f02:	6a 00                	push   $0x0
80102f04:	68 a0 00 00 00       	push   $0xa0
80102f09:	e8 17 ff ff ff       	call   80102e25 <lapicw>
80102f0e:	83 c4 08             	add    $0x8,%esp
80102f11:	6a 00                	push   $0x0
80102f13:	6a 2c                	push   $0x2c
80102f15:	e8 0b ff ff ff       	call   80102e25 <lapicw>
80102f1a:	83 c4 08             	add    $0x8,%esp
80102f1d:	6a 00                	push   $0x0
80102f1f:	68 c4 00 00 00       	push   $0xc4
80102f24:	e8 fc fe ff ff       	call   80102e25 <lapicw>
80102f29:	83 c4 08             	add    $0x8,%esp
80102f2c:	68 00 85 08 00       	push   $0x88500
80102f31:	68 c0 00 00 00       	push   $0xc0
80102f36:	e8 ea fe ff ff       	call   80102e25 <lapicw>
80102f3b:	83 c4 08             	add    $0x8,%esp
80102f3e:	90                   	nop
80102f3f:	a1 5c 22 11 80       	mov    0x8011225c,%eax
80102f44:	05 00 03 00 00       	add    $0x300,%eax
80102f49:	8b 00                	mov    (%eax),%eax
80102f4b:	25 00 10 00 00       	and    $0x1000,%eax
80102f50:	85 c0                	test   %eax,%eax
80102f52:	75 eb                	jne    80102f3f <lapicinit+0xf8>
80102f54:	6a 00                	push   $0x0
80102f56:	6a 20                	push   $0x20
80102f58:	e8 c8 fe ff ff       	call   80102e25 <lapicw>
80102f5d:	83 c4 08             	add    $0x8,%esp
80102f60:	eb 01                	jmp    80102f63 <lapicinit+0x11c>
80102f62:	90                   	nop
80102f63:	c9                   	leave  
80102f64:	c3                   	ret    

80102f65 <cpunum>:
80102f65:	55                   	push   %ebp
80102f66:	89 e5                	mov    %esp,%ebp
80102f68:	83 ec 08             	sub    $0x8,%esp
80102f6b:	e8 a5 fe ff ff       	call   80102e15 <readeflags>
80102f70:	25 00 02 00 00       	and    $0x200,%eax
80102f75:	85 c0                	test   %eax,%eax
80102f77:	74 26                	je     80102f9f <cpunum+0x3a>
80102f79:	a1 40 b6 10 80       	mov    0x8010b640,%eax
80102f7e:	8d 50 01             	lea    0x1(%eax),%edx
80102f81:	89 15 40 b6 10 80    	mov    %edx,0x8010b640
80102f87:	85 c0                	test   %eax,%eax
80102f89:	75 14                	jne    80102f9f <cpunum+0x3a>
80102f8b:	8b 45 04             	mov    0x4(%ebp),%eax
80102f8e:	83 ec 08             	sub    $0x8,%esp
80102f91:	50                   	push   %eax
80102f92:	68 0c 87 10 80       	push   $0x8010870c
80102f97:	e8 04 d4 ff ff       	call   801003a0 <cprintf>
80102f9c:	83 c4 10             	add    $0x10,%esp
80102f9f:	a1 5c 22 11 80       	mov    0x8011225c,%eax
80102fa4:	85 c0                	test   %eax,%eax
80102fa6:	74 0f                	je     80102fb7 <cpunum+0x52>
80102fa8:	a1 5c 22 11 80       	mov    0x8011225c,%eax
80102fad:	83 c0 20             	add    $0x20,%eax
80102fb0:	8b 00                	mov    (%eax),%eax
80102fb2:	c1 e8 18             	shr    $0x18,%eax
80102fb5:	eb 05                	jmp    80102fbc <cpunum+0x57>
80102fb7:	b8 00 00 00 00       	mov    $0x0,%eax
80102fbc:	c9                   	leave  
80102fbd:	c3                   	ret    

80102fbe <lapiceoi>:
80102fbe:	55                   	push   %ebp
80102fbf:	89 e5                	mov    %esp,%ebp
80102fc1:	a1 5c 22 11 80       	mov    0x8011225c,%eax
80102fc6:	85 c0                	test   %eax,%eax
80102fc8:	74 0c                	je     80102fd6 <lapiceoi+0x18>
80102fca:	6a 00                	push   $0x0
80102fcc:	6a 2c                	push   $0x2c
80102fce:	e8 52 fe ff ff       	call   80102e25 <lapicw>
80102fd3:	83 c4 08             	add    $0x8,%esp
80102fd6:	90                   	nop
80102fd7:	c9                   	leave  
80102fd8:	c3                   	ret    

80102fd9 <microdelay>:
80102fd9:	55                   	push   %ebp
80102fda:	89 e5                	mov    %esp,%ebp
80102fdc:	90                   	nop
80102fdd:	5d                   	pop    %ebp
80102fde:	c3                   	ret    

80102fdf <lapicstartap>:
80102fdf:	55                   	push   %ebp
80102fe0:	89 e5                	mov    %esp,%ebp
80102fe2:	83 ec 14             	sub    $0x14,%esp
80102fe5:	8b 45 08             	mov    0x8(%ebp),%eax
80102fe8:	88 45 ec             	mov    %al,-0x14(%ebp)
80102feb:	6a 0f                	push   $0xf
80102fed:	6a 70                	push   $0x70
80102fef:	e8 02 fe ff ff       	call   80102df6 <outb>
80102ff4:	83 c4 08             	add    $0x8,%esp
80102ff7:	6a 0a                	push   $0xa
80102ff9:	6a 71                	push   $0x71
80102ffb:	e8 f6 fd ff ff       	call   80102df6 <outb>
80103000:	83 c4 08             	add    $0x8,%esp
80103003:	c7 45 f8 67 04 00 80 	movl   $0x80000467,-0x8(%ebp)
8010300a:	8b 45 f8             	mov    -0x8(%ebp),%eax
8010300d:	66 c7 00 00 00       	movw   $0x0,(%eax)
80103012:	8b 45 f8             	mov    -0x8(%ebp),%eax
80103015:	83 c0 02             	add    $0x2,%eax
80103018:	8b 55 0c             	mov    0xc(%ebp),%edx
8010301b:	c1 ea 04             	shr    $0x4,%edx
8010301e:	66 89 10             	mov    %dx,(%eax)
80103021:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
80103025:	c1 e0 18             	shl    $0x18,%eax
80103028:	50                   	push   %eax
80103029:	68 c4 00 00 00       	push   $0xc4
8010302e:	e8 f2 fd ff ff       	call   80102e25 <lapicw>
80103033:	83 c4 08             	add    $0x8,%esp
80103036:	68 00 c5 00 00       	push   $0xc500
8010303b:	68 c0 00 00 00       	push   $0xc0
80103040:	e8 e0 fd ff ff       	call   80102e25 <lapicw>
80103045:	83 c4 08             	add    $0x8,%esp
80103048:	68 c8 00 00 00       	push   $0xc8
8010304d:	e8 87 ff ff ff       	call   80102fd9 <microdelay>
80103052:	83 c4 04             	add    $0x4,%esp
80103055:	68 00 85 00 00       	push   $0x8500
8010305a:	68 c0 00 00 00       	push   $0xc0
8010305f:	e8 c1 fd ff ff       	call   80102e25 <lapicw>
80103064:	83 c4 08             	add    $0x8,%esp
80103067:	6a 64                	push   $0x64
80103069:	e8 6b ff ff ff       	call   80102fd9 <microdelay>
8010306e:	83 c4 04             	add    $0x4,%esp
80103071:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80103078:	eb 3d                	jmp    801030b7 <lapicstartap+0xd8>
8010307a:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
8010307e:	c1 e0 18             	shl    $0x18,%eax
80103081:	50                   	push   %eax
80103082:	68 c4 00 00 00       	push   $0xc4
80103087:	e8 99 fd ff ff       	call   80102e25 <lapicw>
8010308c:	83 c4 08             	add    $0x8,%esp
8010308f:	8b 45 0c             	mov    0xc(%ebp),%eax
80103092:	c1 e8 0c             	shr    $0xc,%eax
80103095:	80 cc 06             	or     $0x6,%ah
80103098:	50                   	push   %eax
80103099:	68 c0 00 00 00       	push   $0xc0
8010309e:	e8 82 fd ff ff       	call   80102e25 <lapicw>
801030a3:	83 c4 08             	add    $0x8,%esp
801030a6:	68 c8 00 00 00       	push   $0xc8
801030ab:	e8 29 ff ff ff       	call   80102fd9 <microdelay>
801030b0:	83 c4 04             	add    $0x4,%esp
801030b3:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
801030b7:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
801030bb:	7e bd                	jle    8010307a <lapicstartap+0x9b>
801030bd:	90                   	nop
801030be:	c9                   	leave  
801030bf:	c3                   	ret    

801030c0 <cmos_read>:
801030c0:	55                   	push   %ebp
801030c1:	89 e5                	mov    %esp,%ebp
801030c3:	8b 45 08             	mov    0x8(%ebp),%eax
801030c6:	0f b6 c0             	movzbl %al,%eax
801030c9:	50                   	push   %eax
801030ca:	6a 70                	push   $0x70
801030cc:	e8 25 fd ff ff       	call   80102df6 <outb>
801030d1:	83 c4 08             	add    $0x8,%esp
801030d4:	68 c8 00 00 00       	push   $0xc8
801030d9:	e8 fb fe ff ff       	call   80102fd9 <microdelay>
801030de:	83 c4 04             	add    $0x4,%esp
801030e1:	6a 71                	push   $0x71
801030e3:	e8 f1 fc ff ff       	call   80102dd9 <inb>
801030e8:	83 c4 04             	add    $0x4,%esp
801030eb:	0f b6 c0             	movzbl %al,%eax
801030ee:	c9                   	leave  
801030ef:	c3                   	ret    

801030f0 <fill_rtcdate>:
801030f0:	55                   	push   %ebp
801030f1:	89 e5                	mov    %esp,%ebp
801030f3:	6a 00                	push   $0x0
801030f5:	e8 c6 ff ff ff       	call   801030c0 <cmos_read>
801030fa:	83 c4 04             	add    $0x4,%esp
801030fd:	89 c2                	mov    %eax,%edx
801030ff:	8b 45 08             	mov    0x8(%ebp),%eax
80103102:	89 10                	mov    %edx,(%eax)
80103104:	6a 02                	push   $0x2
80103106:	e8 b5 ff ff ff       	call   801030c0 <cmos_read>
8010310b:	83 c4 04             	add    $0x4,%esp
8010310e:	89 c2                	mov    %eax,%edx
80103110:	8b 45 08             	mov    0x8(%ebp),%eax
80103113:	89 50 04             	mov    %edx,0x4(%eax)
80103116:	6a 04                	push   $0x4
80103118:	e8 a3 ff ff ff       	call   801030c0 <cmos_read>
8010311d:	83 c4 04             	add    $0x4,%esp
80103120:	89 c2                	mov    %eax,%edx
80103122:	8b 45 08             	mov    0x8(%ebp),%eax
80103125:	89 50 08             	mov    %edx,0x8(%eax)
80103128:	6a 07                	push   $0x7
8010312a:	e8 91 ff ff ff       	call   801030c0 <cmos_read>
8010312f:	83 c4 04             	add    $0x4,%esp
80103132:	89 c2                	mov    %eax,%edx
80103134:	8b 45 08             	mov    0x8(%ebp),%eax
80103137:	89 50 0c             	mov    %edx,0xc(%eax)
8010313a:	6a 08                	push   $0x8
8010313c:	e8 7f ff ff ff       	call   801030c0 <cmos_read>
80103141:	83 c4 04             	add    $0x4,%esp
80103144:	89 c2                	mov    %eax,%edx
80103146:	8b 45 08             	mov    0x8(%ebp),%eax
80103149:	89 50 10             	mov    %edx,0x10(%eax)
8010314c:	6a 09                	push   $0x9
8010314e:	e8 6d ff ff ff       	call   801030c0 <cmos_read>
80103153:	83 c4 04             	add    $0x4,%esp
80103156:	89 c2                	mov    %eax,%edx
80103158:	8b 45 08             	mov    0x8(%ebp),%eax
8010315b:	89 50 14             	mov    %edx,0x14(%eax)
8010315e:	90                   	nop
8010315f:	c9                   	leave  
80103160:	c3                   	ret    

80103161 <cmostime>:
80103161:	55                   	push   %ebp
80103162:	89 e5                	mov    %esp,%ebp
80103164:	83 ec 48             	sub    $0x48,%esp
80103167:	6a 0b                	push   $0xb
80103169:	e8 52 ff ff ff       	call   801030c0 <cmos_read>
8010316e:	83 c4 04             	add    $0x4,%esp
80103171:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103174:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103177:	83 e0 04             	and    $0x4,%eax
8010317a:	85 c0                	test   %eax,%eax
8010317c:	0f 94 c0             	sete   %al
8010317f:	0f b6 c0             	movzbl %al,%eax
80103182:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103185:	8d 45 d8             	lea    -0x28(%ebp),%eax
80103188:	50                   	push   %eax
80103189:	e8 62 ff ff ff       	call   801030f0 <fill_rtcdate>
8010318e:	83 c4 04             	add    $0x4,%esp
80103191:	6a 0a                	push   $0xa
80103193:	e8 28 ff ff ff       	call   801030c0 <cmos_read>
80103198:	83 c4 04             	add    $0x4,%esp
8010319b:	25 80 00 00 00       	and    $0x80,%eax
801031a0:	85 c0                	test   %eax,%eax
801031a2:	75 27                	jne    801031cb <cmostime+0x6a>
801031a4:	8d 45 c0             	lea    -0x40(%ebp),%eax
801031a7:	50                   	push   %eax
801031a8:	e8 43 ff ff ff       	call   801030f0 <fill_rtcdate>
801031ad:	83 c4 04             	add    $0x4,%esp
801031b0:	83 ec 04             	sub    $0x4,%esp
801031b3:	6a 18                	push   $0x18
801031b5:	8d 45 c0             	lea    -0x40(%ebp),%eax
801031b8:	50                   	push   %eax
801031b9:	8d 45 d8             	lea    -0x28(%ebp),%eax
801031bc:	50                   	push   %eax
801031bd:	e8 a0 20 00 00       	call   80105262 <memcmp>
801031c2:	83 c4 10             	add    $0x10,%esp
801031c5:	85 c0                	test   %eax,%eax
801031c7:	74 05                	je     801031ce <cmostime+0x6d>
801031c9:	eb ba                	jmp    80103185 <cmostime+0x24>
801031cb:	90                   	nop
801031cc:	eb b7                	jmp    80103185 <cmostime+0x24>
801031ce:	90                   	nop
801031cf:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801031d3:	0f 84 b4 00 00 00    	je     8010328d <cmostime+0x12c>
801031d9:	8b 45 d8             	mov    -0x28(%ebp),%eax
801031dc:	c1 e8 04             	shr    $0x4,%eax
801031df:	89 c2                	mov    %eax,%edx
801031e1:	89 d0                	mov    %edx,%eax
801031e3:	c1 e0 02             	shl    $0x2,%eax
801031e6:	01 d0                	add    %edx,%eax
801031e8:	01 c0                	add    %eax,%eax
801031ea:	89 c2                	mov    %eax,%edx
801031ec:	8b 45 d8             	mov    -0x28(%ebp),%eax
801031ef:	83 e0 0f             	and    $0xf,%eax
801031f2:	01 d0                	add    %edx,%eax
801031f4:	89 45 d8             	mov    %eax,-0x28(%ebp)
801031f7:	8b 45 dc             	mov    -0x24(%ebp),%eax
801031fa:	c1 e8 04             	shr    $0x4,%eax
801031fd:	89 c2                	mov    %eax,%edx
801031ff:	89 d0                	mov    %edx,%eax
80103201:	c1 e0 02             	shl    $0x2,%eax
80103204:	01 d0                	add    %edx,%eax
80103206:	01 c0                	add    %eax,%eax
80103208:	89 c2                	mov    %eax,%edx
8010320a:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010320d:	83 e0 0f             	and    $0xf,%eax
80103210:	01 d0                	add    %edx,%eax
80103212:	89 45 dc             	mov    %eax,-0x24(%ebp)
80103215:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103218:	c1 e8 04             	shr    $0x4,%eax
8010321b:	89 c2                	mov    %eax,%edx
8010321d:	89 d0                	mov    %edx,%eax
8010321f:	c1 e0 02             	shl    $0x2,%eax
80103222:	01 d0                	add    %edx,%eax
80103224:	01 c0                	add    %eax,%eax
80103226:	89 c2                	mov    %eax,%edx
80103228:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010322b:	83 e0 0f             	and    $0xf,%eax
8010322e:	01 d0                	add    %edx,%eax
80103230:	89 45 e0             	mov    %eax,-0x20(%ebp)
80103233:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103236:	c1 e8 04             	shr    $0x4,%eax
80103239:	89 c2                	mov    %eax,%edx
8010323b:	89 d0                	mov    %edx,%eax
8010323d:	c1 e0 02             	shl    $0x2,%eax
80103240:	01 d0                	add    %edx,%eax
80103242:	01 c0                	add    %eax,%eax
80103244:	89 c2                	mov    %eax,%edx
80103246:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103249:	83 e0 0f             	and    $0xf,%eax
8010324c:	01 d0                	add    %edx,%eax
8010324e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103251:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103254:	c1 e8 04             	shr    $0x4,%eax
80103257:	89 c2                	mov    %eax,%edx
80103259:	89 d0                	mov    %edx,%eax
8010325b:	c1 e0 02             	shl    $0x2,%eax
8010325e:	01 d0                	add    %edx,%eax
80103260:	01 c0                	add    %eax,%eax
80103262:	89 c2                	mov    %eax,%edx
80103264:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103267:	83 e0 0f             	and    $0xf,%eax
8010326a:	01 d0                	add    %edx,%eax
8010326c:	89 45 e8             	mov    %eax,-0x18(%ebp)
8010326f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103272:	c1 e8 04             	shr    $0x4,%eax
80103275:	89 c2                	mov    %eax,%edx
80103277:	89 d0                	mov    %edx,%eax
80103279:	c1 e0 02             	shl    $0x2,%eax
8010327c:	01 d0                	add    %edx,%eax
8010327e:	01 c0                	add    %eax,%eax
80103280:	89 c2                	mov    %eax,%edx
80103282:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103285:	83 e0 0f             	and    $0xf,%eax
80103288:	01 d0                	add    %edx,%eax
8010328a:	89 45 ec             	mov    %eax,-0x14(%ebp)
8010328d:	8b 45 08             	mov    0x8(%ebp),%eax
80103290:	8b 55 d8             	mov    -0x28(%ebp),%edx
80103293:	89 10                	mov    %edx,(%eax)
80103295:	8b 55 dc             	mov    -0x24(%ebp),%edx
80103298:	89 50 04             	mov    %edx,0x4(%eax)
8010329b:	8b 55 e0             	mov    -0x20(%ebp),%edx
8010329e:	89 50 08             	mov    %edx,0x8(%eax)
801032a1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801032a4:	89 50 0c             	mov    %edx,0xc(%eax)
801032a7:	8b 55 e8             	mov    -0x18(%ebp),%edx
801032aa:	89 50 10             	mov    %edx,0x10(%eax)
801032ad:	8b 55 ec             	mov    -0x14(%ebp),%edx
801032b0:	89 50 14             	mov    %edx,0x14(%eax)
801032b3:	8b 45 08             	mov    0x8(%ebp),%eax
801032b6:	8b 40 14             	mov    0x14(%eax),%eax
801032b9:	8d 90 d0 07 00 00    	lea    0x7d0(%eax),%edx
801032bf:	8b 45 08             	mov    0x8(%ebp),%eax
801032c2:	89 50 14             	mov    %edx,0x14(%eax)
801032c5:	90                   	nop
801032c6:	c9                   	leave  
801032c7:	c3                   	ret    

801032c8 <initlog>:
801032c8:	55                   	push   %ebp
801032c9:	89 e5                	mov    %esp,%ebp
801032cb:	83 ec 28             	sub    $0x28,%esp
801032ce:	83 ec 08             	sub    $0x8,%esp
801032d1:	68 38 87 10 80       	push   $0x80108738
801032d6:	68 60 22 11 80       	push   $0x80112260
801032db:	e8 96 1c 00 00       	call   80104f76 <initlock>
801032e0:	83 c4 10             	add    $0x10,%esp
801032e3:	83 ec 08             	sub    $0x8,%esp
801032e6:	8d 45 dc             	lea    -0x24(%ebp),%eax
801032e9:	50                   	push   %eax
801032ea:	ff 75 08             	pushl  0x8(%ebp)
801032ed:	e8 2b e0 ff ff       	call   8010131d <readsb>
801032f2:	83 c4 10             	add    $0x10,%esp
801032f5:	8b 45 ec             	mov    -0x14(%ebp),%eax
801032f8:	a3 94 22 11 80       	mov    %eax,0x80112294
801032fd:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103300:	a3 98 22 11 80       	mov    %eax,0x80112298
80103305:	8b 45 08             	mov    0x8(%ebp),%eax
80103308:	a3 a4 22 11 80       	mov    %eax,0x801122a4
8010330d:	e8 b2 01 00 00       	call   801034c4 <recover_from_log>
80103312:	90                   	nop
80103313:	c9                   	leave  
80103314:	c3                   	ret    

80103315 <install_trans>:
80103315:	55                   	push   %ebp
80103316:	89 e5                	mov    %esp,%ebp
80103318:	83 ec 18             	sub    $0x18,%esp
8010331b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103322:	e9 95 00 00 00       	jmp    801033bc <install_trans+0xa7>
80103327:	8b 15 94 22 11 80    	mov    0x80112294,%edx
8010332d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103330:	01 d0                	add    %edx,%eax
80103332:	83 c0 01             	add    $0x1,%eax
80103335:	89 c2                	mov    %eax,%edx
80103337:	a1 a4 22 11 80       	mov    0x801122a4,%eax
8010333c:	83 ec 08             	sub    $0x8,%esp
8010333f:	52                   	push   %edx
80103340:	50                   	push   %eax
80103341:	e8 60 ce ff ff       	call   801001a6 <bread>
80103346:	83 c4 10             	add    $0x10,%esp
80103349:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010334c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010334f:	83 c0 10             	add    $0x10,%eax
80103352:	8b 04 85 6c 22 11 80 	mov    -0x7feedd94(,%eax,4),%eax
80103359:	89 c2                	mov    %eax,%edx
8010335b:	a1 a4 22 11 80       	mov    0x801122a4,%eax
80103360:	83 ec 08             	sub    $0x8,%esp
80103363:	52                   	push   %edx
80103364:	50                   	push   %eax
80103365:	e8 3c ce ff ff       	call   801001a6 <bread>
8010336a:	83 c4 10             	add    $0x10,%esp
8010336d:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103370:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103373:	8d 50 18             	lea    0x18(%eax),%edx
80103376:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103379:	83 c0 18             	add    $0x18,%eax
8010337c:	83 ec 04             	sub    $0x4,%esp
8010337f:	68 00 02 00 00       	push   $0x200
80103384:	52                   	push   %edx
80103385:	50                   	push   %eax
80103386:	e8 2f 1f 00 00       	call   801052ba <memmove>
8010338b:	83 c4 10             	add    $0x10,%esp
8010338e:	83 ec 0c             	sub    $0xc,%esp
80103391:	ff 75 ec             	pushl  -0x14(%ebp)
80103394:	e8 44 ce ff ff       	call   801001dd <bwrite>
80103399:	83 c4 10             	add    $0x10,%esp
8010339c:	83 ec 0c             	sub    $0xc,%esp
8010339f:	ff 75 f0             	pushl  -0x10(%ebp)
801033a2:	e8 70 ce ff ff       	call   80100217 <brelse>
801033a7:	83 c4 10             	add    $0x10,%esp
801033aa:	83 ec 0c             	sub    $0xc,%esp
801033ad:	ff 75 ec             	pushl  -0x14(%ebp)
801033b0:	e8 62 ce ff ff       	call   80100217 <brelse>
801033b5:	83 c4 10             	add    $0x10,%esp
801033b8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801033bc:	a1 a8 22 11 80       	mov    0x801122a8,%eax
801033c1:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801033c4:	0f 8f 5d ff ff ff    	jg     80103327 <install_trans+0x12>
801033ca:	90                   	nop
801033cb:	c9                   	leave  
801033cc:	c3                   	ret    

801033cd <read_head>:
801033cd:	55                   	push   %ebp
801033ce:	89 e5                	mov    %esp,%ebp
801033d0:	83 ec 18             	sub    $0x18,%esp
801033d3:	a1 94 22 11 80       	mov    0x80112294,%eax
801033d8:	89 c2                	mov    %eax,%edx
801033da:	a1 a4 22 11 80       	mov    0x801122a4,%eax
801033df:	83 ec 08             	sub    $0x8,%esp
801033e2:	52                   	push   %edx
801033e3:	50                   	push   %eax
801033e4:	e8 bd cd ff ff       	call   801001a6 <bread>
801033e9:	83 c4 10             	add    $0x10,%esp
801033ec:	89 45 f0             	mov    %eax,-0x10(%ebp)
801033ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
801033f2:	83 c0 18             	add    $0x18,%eax
801033f5:	89 45 ec             	mov    %eax,-0x14(%ebp)
801033f8:	8b 45 ec             	mov    -0x14(%ebp),%eax
801033fb:	8b 00                	mov    (%eax),%eax
801033fd:	a3 a8 22 11 80       	mov    %eax,0x801122a8
80103402:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103409:	eb 1b                	jmp    80103426 <read_head+0x59>
8010340b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010340e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103411:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
80103415:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103418:	83 c2 10             	add    $0x10,%edx
8010341b:	89 04 95 6c 22 11 80 	mov    %eax,-0x7feedd94(,%edx,4)
80103422:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103426:	a1 a8 22 11 80       	mov    0x801122a8,%eax
8010342b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010342e:	7f db                	jg     8010340b <read_head+0x3e>
80103430:	83 ec 0c             	sub    $0xc,%esp
80103433:	ff 75 f0             	pushl  -0x10(%ebp)
80103436:	e8 dc cd ff ff       	call   80100217 <brelse>
8010343b:	83 c4 10             	add    $0x10,%esp
8010343e:	90                   	nop
8010343f:	c9                   	leave  
80103440:	c3                   	ret    

80103441 <write_head>:
80103441:	55                   	push   %ebp
80103442:	89 e5                	mov    %esp,%ebp
80103444:	83 ec 18             	sub    $0x18,%esp
80103447:	a1 94 22 11 80       	mov    0x80112294,%eax
8010344c:	89 c2                	mov    %eax,%edx
8010344e:	a1 a4 22 11 80       	mov    0x801122a4,%eax
80103453:	83 ec 08             	sub    $0x8,%esp
80103456:	52                   	push   %edx
80103457:	50                   	push   %eax
80103458:	e8 49 cd ff ff       	call   801001a6 <bread>
8010345d:	83 c4 10             	add    $0x10,%esp
80103460:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103463:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103466:	83 c0 18             	add    $0x18,%eax
80103469:	89 45 ec             	mov    %eax,-0x14(%ebp)
8010346c:	8b 15 a8 22 11 80    	mov    0x801122a8,%edx
80103472:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103475:	89 10                	mov    %edx,(%eax)
80103477:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010347e:	eb 1b                	jmp    8010349b <write_head+0x5a>
80103480:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103483:	83 c0 10             	add    $0x10,%eax
80103486:	8b 0c 85 6c 22 11 80 	mov    -0x7feedd94(,%eax,4),%ecx
8010348d:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103490:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103493:	89 4c 90 04          	mov    %ecx,0x4(%eax,%edx,4)
80103497:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010349b:	a1 a8 22 11 80       	mov    0x801122a8,%eax
801034a0:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801034a3:	7f db                	jg     80103480 <write_head+0x3f>
801034a5:	83 ec 0c             	sub    $0xc,%esp
801034a8:	ff 75 f0             	pushl  -0x10(%ebp)
801034ab:	e8 2d cd ff ff       	call   801001dd <bwrite>
801034b0:	83 c4 10             	add    $0x10,%esp
801034b3:	83 ec 0c             	sub    $0xc,%esp
801034b6:	ff 75 f0             	pushl  -0x10(%ebp)
801034b9:	e8 59 cd ff ff       	call   80100217 <brelse>
801034be:	83 c4 10             	add    $0x10,%esp
801034c1:	90                   	nop
801034c2:	c9                   	leave  
801034c3:	c3                   	ret    

801034c4 <recover_from_log>:
801034c4:	55                   	push   %ebp
801034c5:	89 e5                	mov    %esp,%ebp
801034c7:	83 ec 08             	sub    $0x8,%esp
801034ca:	e8 fe fe ff ff       	call   801033cd <read_head>
801034cf:	e8 41 fe ff ff       	call   80103315 <install_trans>
801034d4:	c7 05 a8 22 11 80 00 	movl   $0x0,0x801122a8
801034db:	00 00 00 
801034de:	e8 5e ff ff ff       	call   80103441 <write_head>
801034e3:	90                   	nop
801034e4:	c9                   	leave  
801034e5:	c3                   	ret    

801034e6 <begin_op>:
801034e6:	55                   	push   %ebp
801034e7:	89 e5                	mov    %esp,%ebp
801034e9:	83 ec 08             	sub    $0x8,%esp
801034ec:	83 ec 0c             	sub    $0xc,%esp
801034ef:	68 60 22 11 80       	push   $0x80112260
801034f4:	e8 9f 1a 00 00       	call   80104f98 <acquire>
801034f9:	83 c4 10             	add    $0x10,%esp
801034fc:	a1 a0 22 11 80       	mov    0x801122a0,%eax
80103501:	85 c0                	test   %eax,%eax
80103503:	74 17                	je     8010351c <begin_op+0x36>
80103505:	83 ec 08             	sub    $0x8,%esp
80103508:	68 60 22 11 80       	push   $0x80112260
8010350d:	68 60 22 11 80       	push   $0x80112260
80103512:	e8 88 17 00 00       	call   80104c9f <sleep>
80103517:	83 c4 10             	add    $0x10,%esp
8010351a:	eb e0                	jmp    801034fc <begin_op+0x16>
8010351c:	8b 0d a8 22 11 80    	mov    0x801122a8,%ecx
80103522:	a1 9c 22 11 80       	mov    0x8011229c,%eax
80103527:	8d 50 01             	lea    0x1(%eax),%edx
8010352a:	89 d0                	mov    %edx,%eax
8010352c:	c1 e0 02             	shl    $0x2,%eax
8010352f:	01 d0                	add    %edx,%eax
80103531:	01 c0                	add    %eax,%eax
80103533:	01 c8                	add    %ecx,%eax
80103535:	83 f8 1e             	cmp    $0x1e,%eax
80103538:	7e 17                	jle    80103551 <begin_op+0x6b>
8010353a:	83 ec 08             	sub    $0x8,%esp
8010353d:	68 60 22 11 80       	push   $0x80112260
80103542:	68 60 22 11 80       	push   $0x80112260
80103547:	e8 53 17 00 00       	call   80104c9f <sleep>
8010354c:	83 c4 10             	add    $0x10,%esp
8010354f:	eb ab                	jmp    801034fc <begin_op+0x16>
80103551:	a1 9c 22 11 80       	mov    0x8011229c,%eax
80103556:	83 c0 01             	add    $0x1,%eax
80103559:	a3 9c 22 11 80       	mov    %eax,0x8011229c
8010355e:	83 ec 0c             	sub    $0xc,%esp
80103561:	68 60 22 11 80       	push   $0x80112260
80103566:	e8 94 1a 00 00       	call   80104fff <release>
8010356b:	83 c4 10             	add    $0x10,%esp
8010356e:	90                   	nop
8010356f:	90                   	nop
80103570:	c9                   	leave  
80103571:	c3                   	ret    

80103572 <end_op>:
80103572:	55                   	push   %ebp
80103573:	89 e5                	mov    %esp,%ebp
80103575:	83 ec 18             	sub    $0x18,%esp
80103578:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010357f:	83 ec 0c             	sub    $0xc,%esp
80103582:	68 60 22 11 80       	push   $0x80112260
80103587:	e8 0c 1a 00 00       	call   80104f98 <acquire>
8010358c:	83 c4 10             	add    $0x10,%esp
8010358f:	a1 9c 22 11 80       	mov    0x8011229c,%eax
80103594:	83 e8 01             	sub    $0x1,%eax
80103597:	a3 9c 22 11 80       	mov    %eax,0x8011229c
8010359c:	a1 a0 22 11 80       	mov    0x801122a0,%eax
801035a1:	85 c0                	test   %eax,%eax
801035a3:	74 0d                	je     801035b2 <end_op+0x40>
801035a5:	83 ec 0c             	sub    $0xc,%esp
801035a8:	68 3c 87 10 80       	push   $0x8010873c
801035ad:	e8 88 cf ff ff       	call   8010053a <panic>
801035b2:	a1 9c 22 11 80       	mov    0x8011229c,%eax
801035b7:	85 c0                	test   %eax,%eax
801035b9:	75 13                	jne    801035ce <end_op+0x5c>
801035bb:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
801035c2:	c7 05 a0 22 11 80 01 	movl   $0x1,0x801122a0
801035c9:	00 00 00 
801035cc:	eb 10                	jmp    801035de <end_op+0x6c>
801035ce:	83 ec 0c             	sub    $0xc,%esp
801035d1:	68 60 22 11 80       	push   $0x80112260
801035d6:	e8 af 17 00 00       	call   80104d8a <wakeup>
801035db:	83 c4 10             	add    $0x10,%esp
801035de:	83 ec 0c             	sub    $0xc,%esp
801035e1:	68 60 22 11 80       	push   $0x80112260
801035e6:	e8 14 1a 00 00       	call   80104fff <release>
801035eb:	83 c4 10             	add    $0x10,%esp
801035ee:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801035f2:	74 3f                	je     80103633 <end_op+0xc1>
801035f4:	e8 f5 00 00 00       	call   801036ee <commit>
801035f9:	83 ec 0c             	sub    $0xc,%esp
801035fc:	68 60 22 11 80       	push   $0x80112260
80103601:	e8 92 19 00 00       	call   80104f98 <acquire>
80103606:	83 c4 10             	add    $0x10,%esp
80103609:	c7 05 a0 22 11 80 00 	movl   $0x0,0x801122a0
80103610:	00 00 00 
80103613:	83 ec 0c             	sub    $0xc,%esp
80103616:	68 60 22 11 80       	push   $0x80112260
8010361b:	e8 6a 17 00 00       	call   80104d8a <wakeup>
80103620:	83 c4 10             	add    $0x10,%esp
80103623:	83 ec 0c             	sub    $0xc,%esp
80103626:	68 60 22 11 80       	push   $0x80112260
8010362b:	e8 cf 19 00 00       	call   80104fff <release>
80103630:	83 c4 10             	add    $0x10,%esp
80103633:	90                   	nop
80103634:	c9                   	leave  
80103635:	c3                   	ret    

80103636 <write_log>:
80103636:	55                   	push   %ebp
80103637:	89 e5                	mov    %esp,%ebp
80103639:	83 ec 18             	sub    $0x18,%esp
8010363c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103643:	e9 95 00 00 00       	jmp    801036dd <write_log+0xa7>
80103648:	8b 15 94 22 11 80    	mov    0x80112294,%edx
8010364e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103651:	01 d0                	add    %edx,%eax
80103653:	83 c0 01             	add    $0x1,%eax
80103656:	89 c2                	mov    %eax,%edx
80103658:	a1 a4 22 11 80       	mov    0x801122a4,%eax
8010365d:	83 ec 08             	sub    $0x8,%esp
80103660:	52                   	push   %edx
80103661:	50                   	push   %eax
80103662:	e8 3f cb ff ff       	call   801001a6 <bread>
80103667:	83 c4 10             	add    $0x10,%esp
8010366a:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010366d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103670:	83 c0 10             	add    $0x10,%eax
80103673:	8b 04 85 6c 22 11 80 	mov    -0x7feedd94(,%eax,4),%eax
8010367a:	89 c2                	mov    %eax,%edx
8010367c:	a1 a4 22 11 80       	mov    0x801122a4,%eax
80103681:	83 ec 08             	sub    $0x8,%esp
80103684:	52                   	push   %edx
80103685:	50                   	push   %eax
80103686:	e8 1b cb ff ff       	call   801001a6 <bread>
8010368b:	83 c4 10             	add    $0x10,%esp
8010368e:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103691:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103694:	8d 50 18             	lea    0x18(%eax),%edx
80103697:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010369a:	83 c0 18             	add    $0x18,%eax
8010369d:	83 ec 04             	sub    $0x4,%esp
801036a0:	68 00 02 00 00       	push   $0x200
801036a5:	52                   	push   %edx
801036a6:	50                   	push   %eax
801036a7:	e8 0e 1c 00 00       	call   801052ba <memmove>
801036ac:	83 c4 10             	add    $0x10,%esp
801036af:	83 ec 0c             	sub    $0xc,%esp
801036b2:	ff 75 f0             	pushl  -0x10(%ebp)
801036b5:	e8 23 cb ff ff       	call   801001dd <bwrite>
801036ba:	83 c4 10             	add    $0x10,%esp
801036bd:	83 ec 0c             	sub    $0xc,%esp
801036c0:	ff 75 ec             	pushl  -0x14(%ebp)
801036c3:	e8 4f cb ff ff       	call   80100217 <brelse>
801036c8:	83 c4 10             	add    $0x10,%esp
801036cb:	83 ec 0c             	sub    $0xc,%esp
801036ce:	ff 75 f0             	pushl  -0x10(%ebp)
801036d1:	e8 41 cb ff ff       	call   80100217 <brelse>
801036d6:	83 c4 10             	add    $0x10,%esp
801036d9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801036dd:	a1 a8 22 11 80       	mov    0x801122a8,%eax
801036e2:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801036e5:	0f 8f 5d ff ff ff    	jg     80103648 <write_log+0x12>
801036eb:	90                   	nop
801036ec:	c9                   	leave  
801036ed:	c3                   	ret    

801036ee <commit>:
801036ee:	55                   	push   %ebp
801036ef:	89 e5                	mov    %esp,%ebp
801036f1:	83 ec 08             	sub    $0x8,%esp
801036f4:	a1 a8 22 11 80       	mov    0x801122a8,%eax
801036f9:	85 c0                	test   %eax,%eax
801036fb:	7e 1e                	jle    8010371b <commit+0x2d>
801036fd:	e8 34 ff ff ff       	call   80103636 <write_log>
80103702:	e8 3a fd ff ff       	call   80103441 <write_head>
80103707:	e8 09 fc ff ff       	call   80103315 <install_trans>
8010370c:	c7 05 a8 22 11 80 00 	movl   $0x0,0x801122a8
80103713:	00 00 00 
80103716:	e8 26 fd ff ff       	call   80103441 <write_head>
8010371b:	90                   	nop
8010371c:	c9                   	leave  
8010371d:	c3                   	ret    

8010371e <log_write>:
8010371e:	55                   	push   %ebp
8010371f:	89 e5                	mov    %esp,%ebp
80103721:	83 ec 18             	sub    $0x18,%esp
80103724:	a1 a8 22 11 80       	mov    0x801122a8,%eax
80103729:	83 f8 1d             	cmp    $0x1d,%eax
8010372c:	7f 12                	jg     80103740 <log_write+0x22>
8010372e:	a1 a8 22 11 80       	mov    0x801122a8,%eax
80103733:	8b 15 98 22 11 80    	mov    0x80112298,%edx
80103739:	83 ea 01             	sub    $0x1,%edx
8010373c:	39 d0                	cmp    %edx,%eax
8010373e:	7c 0d                	jl     8010374d <log_write+0x2f>
80103740:	83 ec 0c             	sub    $0xc,%esp
80103743:	68 4b 87 10 80       	push   $0x8010874b
80103748:	e8 ed cd ff ff       	call   8010053a <panic>
8010374d:	a1 9c 22 11 80       	mov    0x8011229c,%eax
80103752:	85 c0                	test   %eax,%eax
80103754:	7f 0d                	jg     80103763 <log_write+0x45>
80103756:	83 ec 0c             	sub    $0xc,%esp
80103759:	68 61 87 10 80       	push   $0x80108761
8010375e:	e8 d7 cd ff ff       	call   8010053a <panic>
80103763:	83 ec 0c             	sub    $0xc,%esp
80103766:	68 60 22 11 80       	push   $0x80112260
8010376b:	e8 28 18 00 00       	call   80104f98 <acquire>
80103770:	83 c4 10             	add    $0x10,%esp
80103773:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010377a:	eb 1d                	jmp    80103799 <log_write+0x7b>
8010377c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010377f:	83 c0 10             	add    $0x10,%eax
80103782:	8b 04 85 6c 22 11 80 	mov    -0x7feedd94(,%eax,4),%eax
80103789:	89 c2                	mov    %eax,%edx
8010378b:	8b 45 08             	mov    0x8(%ebp),%eax
8010378e:	8b 40 08             	mov    0x8(%eax),%eax
80103791:	39 c2                	cmp    %eax,%edx
80103793:	74 10                	je     801037a5 <log_write+0x87>
80103795:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103799:	a1 a8 22 11 80       	mov    0x801122a8,%eax
8010379e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801037a1:	7f d9                	jg     8010377c <log_write+0x5e>
801037a3:	eb 01                	jmp    801037a6 <log_write+0x88>
801037a5:	90                   	nop
801037a6:	8b 45 08             	mov    0x8(%ebp),%eax
801037a9:	8b 40 08             	mov    0x8(%eax),%eax
801037ac:	89 c2                	mov    %eax,%edx
801037ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
801037b1:	83 c0 10             	add    $0x10,%eax
801037b4:	89 14 85 6c 22 11 80 	mov    %edx,-0x7feedd94(,%eax,4)
801037bb:	a1 a8 22 11 80       	mov    0x801122a8,%eax
801037c0:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801037c3:	75 0d                	jne    801037d2 <log_write+0xb4>
801037c5:	a1 a8 22 11 80       	mov    0x801122a8,%eax
801037ca:	83 c0 01             	add    $0x1,%eax
801037cd:	a3 a8 22 11 80       	mov    %eax,0x801122a8
801037d2:	8b 45 08             	mov    0x8(%ebp),%eax
801037d5:	8b 00                	mov    (%eax),%eax
801037d7:	83 c8 04             	or     $0x4,%eax
801037da:	89 c2                	mov    %eax,%edx
801037dc:	8b 45 08             	mov    0x8(%ebp),%eax
801037df:	89 10                	mov    %edx,(%eax)
801037e1:	83 ec 0c             	sub    $0xc,%esp
801037e4:	68 60 22 11 80       	push   $0x80112260
801037e9:	e8 11 18 00 00       	call   80104fff <release>
801037ee:	83 c4 10             	add    $0x10,%esp
801037f1:	90                   	nop
801037f2:	c9                   	leave  
801037f3:	c3                   	ret    

801037f4 <v2p>:
801037f4:	55                   	push   %ebp
801037f5:	89 e5                	mov    %esp,%ebp
801037f7:	8b 45 08             	mov    0x8(%ebp),%eax
801037fa:	05 00 00 00 80       	add    $0x80000000,%eax
801037ff:	5d                   	pop    %ebp
80103800:	c3                   	ret    

80103801 <p2v>:
80103801:	55                   	push   %ebp
80103802:	89 e5                	mov    %esp,%ebp
80103804:	8b 45 08             	mov    0x8(%ebp),%eax
80103807:	05 00 00 00 80       	add    $0x80000000,%eax
8010380c:	5d                   	pop    %ebp
8010380d:	c3                   	ret    

8010380e <xchg>:
8010380e:	55                   	push   %ebp
8010380f:	89 e5                	mov    %esp,%ebp
80103811:	83 ec 10             	sub    $0x10,%esp
80103814:	8b 55 08             	mov    0x8(%ebp),%edx
80103817:	8b 45 0c             	mov    0xc(%ebp),%eax
8010381a:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010381d:	f0 87 02             	lock xchg %eax,(%edx)
80103820:	89 45 fc             	mov    %eax,-0x4(%ebp)
80103823:	8b 45 fc             	mov    -0x4(%ebp),%eax
80103826:	c9                   	leave  
80103827:	c3                   	ret    

80103828 <main>:
80103828:	8d 4c 24 04          	lea    0x4(%esp),%ecx
8010382c:	83 e4 f0             	and    $0xfffffff0,%esp
8010382f:	ff 71 fc             	pushl  -0x4(%ecx)
80103832:	55                   	push   %ebp
80103833:	89 e5                	mov    %esp,%ebp
80103835:	51                   	push   %ecx
80103836:	83 ec 04             	sub    $0x4,%esp
80103839:	83 ec 08             	sub    $0x8,%esp
8010383c:	68 00 00 40 80       	push   $0x80400000
80103841:	68 3c 51 11 80       	push   $0x8011513c
80103846:	e8 7d f2 ff ff       	call   80102ac8 <kinit1>
8010384b:	83 c4 10             	add    $0x10,%esp
8010384e:	e8 f9 44 00 00       	call   80107d4c <kvmalloc>
80103853:	e8 43 04 00 00       	call   80103c9b <mpinit>
80103858:	e8 ea f5 ff ff       	call   80102e47 <lapicinit>
8010385d:	e8 93 3e 00 00       	call   801076f5 <seginit>
80103862:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80103868:	0f b6 00             	movzbl (%eax),%eax
8010386b:	0f b6 c0             	movzbl %al,%eax
8010386e:	83 ec 08             	sub    $0x8,%esp
80103871:	50                   	push   %eax
80103872:	68 7c 87 10 80       	push   $0x8010877c
80103877:	e8 24 cb ff ff       	call   801003a0 <cprintf>
8010387c:	83 c4 10             	add    $0x10,%esp
8010387f:	e8 6d 06 00 00       	call   80103ef1 <picinit>
80103884:	e8 34 f1 ff ff       	call   801029bd <ioapicinit>
80103889:	e8 22 d2 ff ff       	call   80100ab0 <consoleinit>
8010388e:	e8 be 31 00 00       	call   80106a51 <uartinit>
80103893:	e8 56 0b 00 00       	call   801043ee <pinit>
80103898:	e8 7e 2d 00 00       	call   8010661b <tvinit>
8010389d:	e8 92 c7 ff ff       	call   80100034 <binit>
801038a2:	e8 67 d6 ff ff       	call   80100f0e <fileinit>
801038a7:	e8 19 ed ff ff       	call   801025c5 <ideinit>
801038ac:	a1 44 23 11 80       	mov    0x80112344,%eax
801038b1:	85 c0                	test   %eax,%eax
801038b3:	75 05                	jne    801038ba <main+0x92>
801038b5:	e8 be 2c 00 00       	call   80106578 <timerinit>
801038ba:	e8 7f 00 00 00       	call   8010393e <startothers>
801038bf:	83 ec 08             	sub    $0x8,%esp
801038c2:	68 00 00 00 8e       	push   $0x8e000000
801038c7:	68 00 00 40 80       	push   $0x80400000
801038cc:	e8 30 f2 ff ff       	call   80102b01 <kinit2>
801038d1:	83 c4 10             	add    $0x10,%esp
801038d4:	e8 39 0c 00 00       	call   80104512 <userinit>
801038d9:	e8 1a 00 00 00       	call   801038f8 <mpmain>

801038de <mpenter>:
801038de:	55                   	push   %ebp
801038df:	89 e5                	mov    %esp,%ebp
801038e1:	83 ec 08             	sub    $0x8,%esp
801038e4:	e8 7b 44 00 00       	call   80107d64 <switchkvm>
801038e9:	e8 07 3e 00 00       	call   801076f5 <seginit>
801038ee:	e8 54 f5 ff ff       	call   80102e47 <lapicinit>
801038f3:	e8 00 00 00 00       	call   801038f8 <mpmain>

801038f8 <mpmain>:
801038f8:	55                   	push   %ebp
801038f9:	89 e5                	mov    %esp,%ebp
801038fb:	83 ec 08             	sub    $0x8,%esp
801038fe:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80103904:	0f b6 00             	movzbl (%eax),%eax
80103907:	0f b6 c0             	movzbl %al,%eax
8010390a:	83 ec 08             	sub    $0x8,%esp
8010390d:	50                   	push   %eax
8010390e:	68 93 87 10 80       	push   $0x80108793
80103913:	e8 88 ca ff ff       	call   801003a0 <cprintf>
80103918:	83 c4 10             	add    $0x10,%esp
8010391b:	e8 71 2e 00 00       	call   80106791 <idtinit>
80103920:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80103926:	05 a8 00 00 00       	add    $0xa8,%eax
8010392b:	83 ec 08             	sub    $0x8,%esp
8010392e:	6a 01                	push   $0x1
80103930:	50                   	push   %eax
80103931:	e8 d8 fe ff ff       	call   8010380e <xchg>
80103936:	83 c4 10             	add    $0x10,%esp
80103939:	e8 7f 11 00 00       	call   80104abd <scheduler>

8010393e <startothers>:
8010393e:	55                   	push   %ebp
8010393f:	89 e5                	mov    %esp,%ebp
80103941:	53                   	push   %ebx
80103942:	83 ec 14             	sub    $0x14,%esp
80103945:	68 00 70 00 00       	push   $0x7000
8010394a:	e8 b2 fe ff ff       	call   80103801 <p2v>
8010394f:	83 c4 04             	add    $0x4,%esp
80103952:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103955:	b8 8a 00 00 00       	mov    $0x8a,%eax
8010395a:	83 ec 04             	sub    $0x4,%esp
8010395d:	50                   	push   %eax
8010395e:	68 0c b5 10 80       	push   $0x8010b50c
80103963:	ff 75 f0             	pushl  -0x10(%ebp)
80103966:	e8 4f 19 00 00       	call   801052ba <memmove>
8010396b:	83 c4 10             	add    $0x10,%esp
8010396e:	c7 45 f4 60 23 11 80 	movl   $0x80112360,-0xc(%ebp)
80103975:	e9 90 00 00 00       	jmp    80103a0a <startothers+0xcc>
8010397a:	e8 e6 f5 ff ff       	call   80102f65 <cpunum>
8010397f:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103985:	05 60 23 11 80       	add    $0x80112360,%eax
8010398a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010398d:	74 73                	je     80103a02 <startothers+0xc4>
8010398f:	e8 6b f2 ff ff       	call   80102bff <kalloc>
80103994:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103997:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010399a:	83 e8 04             	sub    $0x4,%eax
8010399d:	8b 55 ec             	mov    -0x14(%ebp),%edx
801039a0:	81 c2 00 10 00 00    	add    $0x1000,%edx
801039a6:	89 10                	mov    %edx,(%eax)
801039a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801039ab:	83 e8 08             	sub    $0x8,%eax
801039ae:	c7 00 de 38 10 80    	movl   $0x801038de,(%eax)
801039b4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801039b7:	8d 58 f4             	lea    -0xc(%eax),%ebx
801039ba:	83 ec 0c             	sub    $0xc,%esp
801039bd:	68 00 a0 10 80       	push   $0x8010a000
801039c2:	e8 2d fe ff ff       	call   801037f4 <v2p>
801039c7:	83 c4 10             	add    $0x10,%esp
801039ca:	89 03                	mov    %eax,(%ebx)
801039cc:	83 ec 0c             	sub    $0xc,%esp
801039cf:	ff 75 f0             	pushl  -0x10(%ebp)
801039d2:	e8 1d fe ff ff       	call   801037f4 <v2p>
801039d7:	83 c4 10             	add    $0x10,%esp
801039da:	89 c2                	mov    %eax,%edx
801039dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801039df:	0f b6 00             	movzbl (%eax),%eax
801039e2:	0f b6 c0             	movzbl %al,%eax
801039e5:	83 ec 08             	sub    $0x8,%esp
801039e8:	52                   	push   %edx
801039e9:	50                   	push   %eax
801039ea:	e8 f0 f5 ff ff       	call   80102fdf <lapicstartap>
801039ef:	83 c4 10             	add    $0x10,%esp
801039f2:	90                   	nop
801039f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801039f6:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
801039fc:	85 c0                	test   %eax,%eax
801039fe:	74 f3                	je     801039f3 <startothers+0xb5>
80103a00:	eb 01                	jmp    80103a03 <startothers+0xc5>
80103a02:	90                   	nop
80103a03:	81 45 f4 bc 00 00 00 	addl   $0xbc,-0xc(%ebp)
80103a0a:	a1 40 29 11 80       	mov    0x80112940,%eax
80103a0f:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103a15:	05 60 23 11 80       	add    $0x80112360,%eax
80103a1a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103a1d:	0f 87 57 ff ff ff    	ja     8010397a <startothers+0x3c>
80103a23:	90                   	nop
80103a24:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103a27:	c9                   	leave  
80103a28:	c3                   	ret    

80103a29 <p2v>:
80103a29:	55                   	push   %ebp
80103a2a:	89 e5                	mov    %esp,%ebp
80103a2c:	8b 45 08             	mov    0x8(%ebp),%eax
80103a2f:	05 00 00 00 80       	add    $0x80000000,%eax
80103a34:	5d                   	pop    %ebp
80103a35:	c3                   	ret    

80103a36 <inb>:
80103a36:	55                   	push   %ebp
80103a37:	89 e5                	mov    %esp,%ebp
80103a39:	83 ec 14             	sub    $0x14,%esp
80103a3c:	8b 45 08             	mov    0x8(%ebp),%eax
80103a3f:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
80103a43:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80103a47:	89 c2                	mov    %eax,%edx
80103a49:	ec                   	in     (%dx),%al
80103a4a:	88 45 ff             	mov    %al,-0x1(%ebp)
80103a4d:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
80103a51:	c9                   	leave  
80103a52:	c3                   	ret    

80103a53 <outb>:
80103a53:	55                   	push   %ebp
80103a54:	89 e5                	mov    %esp,%ebp
80103a56:	83 ec 08             	sub    $0x8,%esp
80103a59:	8b 55 08             	mov    0x8(%ebp),%edx
80103a5c:	8b 45 0c             	mov    0xc(%ebp),%eax
80103a5f:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80103a63:	88 45 f8             	mov    %al,-0x8(%ebp)
80103a66:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80103a6a:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80103a6e:	ee                   	out    %al,(%dx)
80103a6f:	90                   	nop
80103a70:	c9                   	leave  
80103a71:	c3                   	ret    

80103a72 <mpbcpu>:
80103a72:	55                   	push   %ebp
80103a73:	89 e5                	mov    %esp,%ebp
80103a75:	a1 44 b6 10 80       	mov    0x8010b644,%eax
80103a7a:	89 c2                	mov    %eax,%edx
80103a7c:	b8 60 23 11 80       	mov    $0x80112360,%eax
80103a81:	29 c2                	sub    %eax,%edx
80103a83:	89 d0                	mov    %edx,%eax
80103a85:	c1 f8 02             	sar    $0x2,%eax
80103a88:	69 c0 cf 46 7d 67    	imul   $0x677d46cf,%eax,%eax
80103a8e:	5d                   	pop    %ebp
80103a8f:	c3                   	ret    

80103a90 <sum>:
80103a90:	55                   	push   %ebp
80103a91:	89 e5                	mov    %esp,%ebp
80103a93:	83 ec 10             	sub    $0x10,%esp
80103a96:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
80103a9d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80103aa4:	eb 15                	jmp    80103abb <sum+0x2b>
80103aa6:	8b 55 fc             	mov    -0x4(%ebp),%edx
80103aa9:	8b 45 08             	mov    0x8(%ebp),%eax
80103aac:	01 d0                	add    %edx,%eax
80103aae:	0f b6 00             	movzbl (%eax),%eax
80103ab1:	0f b6 c0             	movzbl %al,%eax
80103ab4:	01 45 f8             	add    %eax,-0x8(%ebp)
80103ab7:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80103abb:	8b 45 fc             	mov    -0x4(%ebp),%eax
80103abe:	3b 45 0c             	cmp    0xc(%ebp),%eax
80103ac1:	7c e3                	jl     80103aa6 <sum+0x16>
80103ac3:	8b 45 f8             	mov    -0x8(%ebp),%eax
80103ac6:	c9                   	leave  
80103ac7:	c3                   	ret    

80103ac8 <mpsearch1>:
80103ac8:	55                   	push   %ebp
80103ac9:	89 e5                	mov    %esp,%ebp
80103acb:	83 ec 18             	sub    $0x18,%esp
80103ace:	ff 75 08             	pushl  0x8(%ebp)
80103ad1:	e8 53 ff ff ff       	call   80103a29 <p2v>
80103ad6:	83 c4 04             	add    $0x4,%esp
80103ad9:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103adc:	8b 55 0c             	mov    0xc(%ebp),%edx
80103adf:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103ae2:	01 d0                	add    %edx,%eax
80103ae4:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103ae7:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103aea:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103aed:	eb 36                	jmp    80103b25 <mpsearch1+0x5d>
80103aef:	83 ec 04             	sub    $0x4,%esp
80103af2:	6a 04                	push   $0x4
80103af4:	68 a4 87 10 80       	push   $0x801087a4
80103af9:	ff 75 f4             	pushl  -0xc(%ebp)
80103afc:	e8 61 17 00 00       	call   80105262 <memcmp>
80103b01:	83 c4 10             	add    $0x10,%esp
80103b04:	85 c0                	test   %eax,%eax
80103b06:	75 19                	jne    80103b21 <mpsearch1+0x59>
80103b08:	83 ec 08             	sub    $0x8,%esp
80103b0b:	6a 10                	push   $0x10
80103b0d:	ff 75 f4             	pushl  -0xc(%ebp)
80103b10:	e8 7b ff ff ff       	call   80103a90 <sum>
80103b15:	83 c4 10             	add    $0x10,%esp
80103b18:	84 c0                	test   %al,%al
80103b1a:	75 05                	jne    80103b21 <mpsearch1+0x59>
80103b1c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103b1f:	eb 11                	jmp    80103b32 <mpsearch1+0x6a>
80103b21:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80103b25:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103b28:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80103b2b:	72 c2                	jb     80103aef <mpsearch1+0x27>
80103b2d:	b8 00 00 00 00       	mov    $0x0,%eax
80103b32:	c9                   	leave  
80103b33:	c3                   	ret    

80103b34 <mpsearch>:
80103b34:	55                   	push   %ebp
80103b35:	89 e5                	mov    %esp,%ebp
80103b37:	83 ec 18             	sub    $0x18,%esp
80103b3a:	c7 45 f4 00 04 00 80 	movl   $0x80000400,-0xc(%ebp)
80103b41:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103b44:	83 c0 0f             	add    $0xf,%eax
80103b47:	0f b6 00             	movzbl (%eax),%eax
80103b4a:	0f b6 c0             	movzbl %al,%eax
80103b4d:	c1 e0 08             	shl    $0x8,%eax
80103b50:	89 c2                	mov    %eax,%edx
80103b52:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103b55:	83 c0 0e             	add    $0xe,%eax
80103b58:	0f b6 00             	movzbl (%eax),%eax
80103b5b:	0f b6 c0             	movzbl %al,%eax
80103b5e:	09 d0                	or     %edx,%eax
80103b60:	c1 e0 04             	shl    $0x4,%eax
80103b63:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103b66:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80103b6a:	74 21                	je     80103b8d <mpsearch+0x59>
80103b6c:	83 ec 08             	sub    $0x8,%esp
80103b6f:	68 00 04 00 00       	push   $0x400
80103b74:	ff 75 f0             	pushl  -0x10(%ebp)
80103b77:	e8 4c ff ff ff       	call   80103ac8 <mpsearch1>
80103b7c:	83 c4 10             	add    $0x10,%esp
80103b7f:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103b82:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80103b86:	74 51                	je     80103bd9 <mpsearch+0xa5>
80103b88:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103b8b:	eb 61                	jmp    80103bee <mpsearch+0xba>
80103b8d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103b90:	83 c0 14             	add    $0x14,%eax
80103b93:	0f b6 00             	movzbl (%eax),%eax
80103b96:	0f b6 c0             	movzbl %al,%eax
80103b99:	c1 e0 08             	shl    $0x8,%eax
80103b9c:	89 c2                	mov    %eax,%edx
80103b9e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103ba1:	83 c0 13             	add    $0x13,%eax
80103ba4:	0f b6 00             	movzbl (%eax),%eax
80103ba7:	0f b6 c0             	movzbl %al,%eax
80103baa:	09 d0                	or     %edx,%eax
80103bac:	c1 e0 0a             	shl    $0xa,%eax
80103baf:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103bb2:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103bb5:	2d 00 04 00 00       	sub    $0x400,%eax
80103bba:	83 ec 08             	sub    $0x8,%esp
80103bbd:	68 00 04 00 00       	push   $0x400
80103bc2:	50                   	push   %eax
80103bc3:	e8 00 ff ff ff       	call   80103ac8 <mpsearch1>
80103bc8:	83 c4 10             	add    $0x10,%esp
80103bcb:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103bce:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80103bd2:	74 05                	je     80103bd9 <mpsearch+0xa5>
80103bd4:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103bd7:	eb 15                	jmp    80103bee <mpsearch+0xba>
80103bd9:	83 ec 08             	sub    $0x8,%esp
80103bdc:	68 00 00 01 00       	push   $0x10000
80103be1:	68 00 00 0f 00       	push   $0xf0000
80103be6:	e8 dd fe ff ff       	call   80103ac8 <mpsearch1>
80103beb:	83 c4 10             	add    $0x10,%esp
80103bee:	c9                   	leave  
80103bef:	c3                   	ret    

80103bf0 <mpconfig>:
80103bf0:	55                   	push   %ebp
80103bf1:	89 e5                	mov    %esp,%ebp
80103bf3:	83 ec 18             	sub    $0x18,%esp
80103bf6:	e8 39 ff ff ff       	call   80103b34 <mpsearch>
80103bfb:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103bfe:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103c02:	74 0a                	je     80103c0e <mpconfig+0x1e>
80103c04:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c07:	8b 40 04             	mov    0x4(%eax),%eax
80103c0a:	85 c0                	test   %eax,%eax
80103c0c:	75 0a                	jne    80103c18 <mpconfig+0x28>
80103c0e:	b8 00 00 00 00       	mov    $0x0,%eax
80103c13:	e9 81 00 00 00       	jmp    80103c99 <mpconfig+0xa9>
80103c18:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c1b:	8b 40 04             	mov    0x4(%eax),%eax
80103c1e:	83 ec 0c             	sub    $0xc,%esp
80103c21:	50                   	push   %eax
80103c22:	e8 02 fe ff ff       	call   80103a29 <p2v>
80103c27:	83 c4 10             	add    $0x10,%esp
80103c2a:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103c2d:	83 ec 04             	sub    $0x4,%esp
80103c30:	6a 04                	push   $0x4
80103c32:	68 a9 87 10 80       	push   $0x801087a9
80103c37:	ff 75 f0             	pushl  -0x10(%ebp)
80103c3a:	e8 23 16 00 00       	call   80105262 <memcmp>
80103c3f:	83 c4 10             	add    $0x10,%esp
80103c42:	85 c0                	test   %eax,%eax
80103c44:	74 07                	je     80103c4d <mpconfig+0x5d>
80103c46:	b8 00 00 00 00       	mov    $0x0,%eax
80103c4b:	eb 4c                	jmp    80103c99 <mpconfig+0xa9>
80103c4d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103c50:	0f b6 40 06          	movzbl 0x6(%eax),%eax
80103c54:	3c 01                	cmp    $0x1,%al
80103c56:	74 12                	je     80103c6a <mpconfig+0x7a>
80103c58:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103c5b:	0f b6 40 06          	movzbl 0x6(%eax),%eax
80103c5f:	3c 04                	cmp    $0x4,%al
80103c61:	74 07                	je     80103c6a <mpconfig+0x7a>
80103c63:	b8 00 00 00 00       	mov    $0x0,%eax
80103c68:	eb 2f                	jmp    80103c99 <mpconfig+0xa9>
80103c6a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103c6d:	0f b7 40 04          	movzwl 0x4(%eax),%eax
80103c71:	0f b7 c0             	movzwl %ax,%eax
80103c74:	83 ec 08             	sub    $0x8,%esp
80103c77:	50                   	push   %eax
80103c78:	ff 75 f0             	pushl  -0x10(%ebp)
80103c7b:	e8 10 fe ff ff       	call   80103a90 <sum>
80103c80:	83 c4 10             	add    $0x10,%esp
80103c83:	84 c0                	test   %al,%al
80103c85:	74 07                	je     80103c8e <mpconfig+0x9e>
80103c87:	b8 00 00 00 00       	mov    $0x0,%eax
80103c8c:	eb 0b                	jmp    80103c99 <mpconfig+0xa9>
80103c8e:	8b 45 08             	mov    0x8(%ebp),%eax
80103c91:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103c94:	89 10                	mov    %edx,(%eax)
80103c96:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103c99:	c9                   	leave  
80103c9a:	c3                   	ret    

80103c9b <mpinit>:
80103c9b:	55                   	push   %ebp
80103c9c:	89 e5                	mov    %esp,%ebp
80103c9e:	83 ec 28             	sub    $0x28,%esp
80103ca1:	c7 05 44 b6 10 80 60 	movl   $0x80112360,0x8010b644
80103ca8:	23 11 80 
80103cab:	83 ec 0c             	sub    $0xc,%esp
80103cae:	8d 45 e0             	lea    -0x20(%ebp),%eax
80103cb1:	50                   	push   %eax
80103cb2:	e8 39 ff ff ff       	call   80103bf0 <mpconfig>
80103cb7:	83 c4 10             	add    $0x10,%esp
80103cba:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103cbd:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80103cc1:	0f 84 96 01 00 00    	je     80103e5d <mpinit+0x1c2>
80103cc7:	c7 05 44 23 11 80 01 	movl   $0x1,0x80112344
80103cce:	00 00 00 
80103cd1:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103cd4:	8b 40 24             	mov    0x24(%eax),%eax
80103cd7:	a3 5c 22 11 80       	mov    %eax,0x8011225c
80103cdc:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103cdf:	83 c0 2c             	add    $0x2c,%eax
80103ce2:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103ce5:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103ce8:	0f b7 40 04          	movzwl 0x4(%eax),%eax
80103cec:	0f b7 d0             	movzwl %ax,%edx
80103cef:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103cf2:	01 d0                	add    %edx,%eax
80103cf4:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103cf7:	e9 f2 00 00 00       	jmp    80103dee <mpinit+0x153>
80103cfc:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103cff:	0f b6 00             	movzbl (%eax),%eax
80103d02:	0f b6 c0             	movzbl %al,%eax
80103d05:	83 f8 04             	cmp    $0x4,%eax
80103d08:	0f 87 bc 00 00 00    	ja     80103dca <mpinit+0x12f>
80103d0e:	8b 04 85 ec 87 10 80 	mov    -0x7fef7814(,%eax,4),%eax
80103d15:	ff e0                	jmp    *%eax
80103d17:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103d1a:	89 45 e8             	mov    %eax,-0x18(%ebp)
80103d1d:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103d20:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103d24:	0f b6 d0             	movzbl %al,%edx
80103d27:	a1 40 29 11 80       	mov    0x80112940,%eax
80103d2c:	39 c2                	cmp    %eax,%edx
80103d2e:	74 2b                	je     80103d5b <mpinit+0xc0>
80103d30:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103d33:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103d37:	0f b6 d0             	movzbl %al,%edx
80103d3a:	a1 40 29 11 80       	mov    0x80112940,%eax
80103d3f:	83 ec 04             	sub    $0x4,%esp
80103d42:	52                   	push   %edx
80103d43:	50                   	push   %eax
80103d44:	68 ae 87 10 80       	push   $0x801087ae
80103d49:	e8 52 c6 ff ff       	call   801003a0 <cprintf>
80103d4e:	83 c4 10             	add    $0x10,%esp
80103d51:	c7 05 44 23 11 80 00 	movl   $0x0,0x80112344
80103d58:	00 00 00 
80103d5b:	8b 45 e8             	mov    -0x18(%ebp),%eax
80103d5e:	0f b6 40 03          	movzbl 0x3(%eax),%eax
80103d62:	0f b6 c0             	movzbl %al,%eax
80103d65:	83 e0 02             	and    $0x2,%eax
80103d68:	85 c0                	test   %eax,%eax
80103d6a:	74 15                	je     80103d81 <mpinit+0xe6>
80103d6c:	a1 40 29 11 80       	mov    0x80112940,%eax
80103d71:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103d77:	05 60 23 11 80       	add    $0x80112360,%eax
80103d7c:	a3 44 b6 10 80       	mov    %eax,0x8010b644
80103d81:	a1 40 29 11 80       	mov    0x80112940,%eax
80103d86:	8b 15 40 29 11 80    	mov    0x80112940,%edx
80103d8c:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103d92:	05 60 23 11 80       	add    $0x80112360,%eax
80103d97:	88 10                	mov    %dl,(%eax)
80103d99:	a1 40 29 11 80       	mov    0x80112940,%eax
80103d9e:	83 c0 01             	add    $0x1,%eax
80103da1:	a3 40 29 11 80       	mov    %eax,0x80112940
80103da6:	83 45 f4 14          	addl   $0x14,-0xc(%ebp)
80103daa:	eb 42                	jmp    80103dee <mpinit+0x153>
80103dac:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103daf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103db2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103db5:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103db9:	a2 40 23 11 80       	mov    %al,0x80112340
80103dbe:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
80103dc2:	eb 2a                	jmp    80103dee <mpinit+0x153>
80103dc4:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
80103dc8:	eb 24                	jmp    80103dee <mpinit+0x153>
80103dca:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103dcd:	0f b6 00             	movzbl (%eax),%eax
80103dd0:	0f b6 c0             	movzbl %al,%eax
80103dd3:	83 ec 08             	sub    $0x8,%esp
80103dd6:	50                   	push   %eax
80103dd7:	68 cc 87 10 80       	push   $0x801087cc
80103ddc:	e8 bf c5 ff ff       	call   801003a0 <cprintf>
80103de1:	83 c4 10             	add    $0x10,%esp
80103de4:	c7 05 44 23 11 80 00 	movl   $0x0,0x80112344
80103deb:	00 00 00 
80103dee:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103df1:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80103df4:	0f 82 02 ff ff ff    	jb     80103cfc <mpinit+0x61>
80103dfa:	a1 44 23 11 80       	mov    0x80112344,%eax
80103dff:	85 c0                	test   %eax,%eax
80103e01:	75 1d                	jne    80103e20 <mpinit+0x185>
80103e03:	c7 05 40 29 11 80 01 	movl   $0x1,0x80112940
80103e0a:	00 00 00 
80103e0d:	c7 05 5c 22 11 80 00 	movl   $0x0,0x8011225c
80103e14:	00 00 00 
80103e17:	c6 05 40 23 11 80 00 	movb   $0x0,0x80112340
80103e1e:	eb 3e                	jmp    80103e5e <mpinit+0x1c3>
80103e20:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103e23:	0f b6 40 0c          	movzbl 0xc(%eax),%eax
80103e27:	84 c0                	test   %al,%al
80103e29:	74 33                	je     80103e5e <mpinit+0x1c3>
80103e2b:	83 ec 08             	sub    $0x8,%esp
80103e2e:	6a 70                	push   $0x70
80103e30:	6a 22                	push   $0x22
80103e32:	e8 1c fc ff ff       	call   80103a53 <outb>
80103e37:	83 c4 10             	add    $0x10,%esp
80103e3a:	83 ec 0c             	sub    $0xc,%esp
80103e3d:	6a 23                	push   $0x23
80103e3f:	e8 f2 fb ff ff       	call   80103a36 <inb>
80103e44:	83 c4 10             	add    $0x10,%esp
80103e47:	83 c8 01             	or     $0x1,%eax
80103e4a:	0f b6 c0             	movzbl %al,%eax
80103e4d:	83 ec 08             	sub    $0x8,%esp
80103e50:	50                   	push   %eax
80103e51:	6a 23                	push   $0x23
80103e53:	e8 fb fb ff ff       	call   80103a53 <outb>
80103e58:	83 c4 10             	add    $0x10,%esp
80103e5b:	eb 01                	jmp    80103e5e <mpinit+0x1c3>
80103e5d:	90                   	nop
80103e5e:	c9                   	leave  
80103e5f:	c3                   	ret    

80103e60 <outb>:
80103e60:	55                   	push   %ebp
80103e61:	89 e5                	mov    %esp,%ebp
80103e63:	83 ec 08             	sub    $0x8,%esp
80103e66:	8b 55 08             	mov    0x8(%ebp),%edx
80103e69:	8b 45 0c             	mov    0xc(%ebp),%eax
80103e6c:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80103e70:	88 45 f8             	mov    %al,-0x8(%ebp)
80103e73:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80103e77:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80103e7b:	ee                   	out    %al,(%dx)
80103e7c:	90                   	nop
80103e7d:	c9                   	leave  
80103e7e:	c3                   	ret    

80103e7f <picsetmask>:
80103e7f:	55                   	push   %ebp
80103e80:	89 e5                	mov    %esp,%ebp
80103e82:	83 ec 04             	sub    $0x4,%esp
80103e85:	8b 45 08             	mov    0x8(%ebp),%eax
80103e88:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
80103e8c:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103e90:	66 a3 00 b0 10 80    	mov    %ax,0x8010b000
80103e96:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103e9a:	0f b6 c0             	movzbl %al,%eax
80103e9d:	50                   	push   %eax
80103e9e:	6a 21                	push   $0x21
80103ea0:	e8 bb ff ff ff       	call   80103e60 <outb>
80103ea5:	83 c4 08             	add    $0x8,%esp
80103ea8:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103eac:	66 c1 e8 08          	shr    $0x8,%ax
80103eb0:	0f b6 c0             	movzbl %al,%eax
80103eb3:	50                   	push   %eax
80103eb4:	68 a1 00 00 00       	push   $0xa1
80103eb9:	e8 a2 ff ff ff       	call   80103e60 <outb>
80103ebe:	83 c4 08             	add    $0x8,%esp
80103ec1:	90                   	nop
80103ec2:	c9                   	leave  
80103ec3:	c3                   	ret    

80103ec4 <picenable>:
80103ec4:	55                   	push   %ebp
80103ec5:	89 e5                	mov    %esp,%ebp
80103ec7:	8b 45 08             	mov    0x8(%ebp),%eax
80103eca:	ba 01 00 00 00       	mov    $0x1,%edx
80103ecf:	89 c1                	mov    %eax,%ecx
80103ed1:	d3 e2                	shl    %cl,%edx
80103ed3:	89 d0                	mov    %edx,%eax
80103ed5:	f7 d0                	not    %eax
80103ed7:	89 c2                	mov    %eax,%edx
80103ed9:	0f b7 05 00 b0 10 80 	movzwl 0x8010b000,%eax
80103ee0:	21 d0                	and    %edx,%eax
80103ee2:	0f b7 c0             	movzwl %ax,%eax
80103ee5:	50                   	push   %eax
80103ee6:	e8 94 ff ff ff       	call   80103e7f <picsetmask>
80103eeb:	83 c4 04             	add    $0x4,%esp
80103eee:	90                   	nop
80103eef:	c9                   	leave  
80103ef0:	c3                   	ret    

80103ef1 <picinit>:
80103ef1:	55                   	push   %ebp
80103ef2:	89 e5                	mov    %esp,%ebp
80103ef4:	68 ff 00 00 00       	push   $0xff
80103ef9:	6a 21                	push   $0x21
80103efb:	e8 60 ff ff ff       	call   80103e60 <outb>
80103f00:	83 c4 08             	add    $0x8,%esp
80103f03:	68 ff 00 00 00       	push   $0xff
80103f08:	68 a1 00 00 00       	push   $0xa1
80103f0d:	e8 4e ff ff ff       	call   80103e60 <outb>
80103f12:	83 c4 08             	add    $0x8,%esp
80103f15:	6a 11                	push   $0x11
80103f17:	6a 20                	push   $0x20
80103f19:	e8 42 ff ff ff       	call   80103e60 <outb>
80103f1e:	83 c4 08             	add    $0x8,%esp
80103f21:	6a 20                	push   $0x20
80103f23:	6a 21                	push   $0x21
80103f25:	e8 36 ff ff ff       	call   80103e60 <outb>
80103f2a:	83 c4 08             	add    $0x8,%esp
80103f2d:	6a 04                	push   $0x4
80103f2f:	6a 21                	push   $0x21
80103f31:	e8 2a ff ff ff       	call   80103e60 <outb>
80103f36:	83 c4 08             	add    $0x8,%esp
80103f39:	6a 03                	push   $0x3
80103f3b:	6a 21                	push   $0x21
80103f3d:	e8 1e ff ff ff       	call   80103e60 <outb>
80103f42:	83 c4 08             	add    $0x8,%esp
80103f45:	6a 11                	push   $0x11
80103f47:	68 a0 00 00 00       	push   $0xa0
80103f4c:	e8 0f ff ff ff       	call   80103e60 <outb>
80103f51:	83 c4 08             	add    $0x8,%esp
80103f54:	6a 28                	push   $0x28
80103f56:	68 a1 00 00 00       	push   $0xa1
80103f5b:	e8 00 ff ff ff       	call   80103e60 <outb>
80103f60:	83 c4 08             	add    $0x8,%esp
80103f63:	6a 02                	push   $0x2
80103f65:	68 a1 00 00 00       	push   $0xa1
80103f6a:	e8 f1 fe ff ff       	call   80103e60 <outb>
80103f6f:	83 c4 08             	add    $0x8,%esp
80103f72:	6a 03                	push   $0x3
80103f74:	68 a1 00 00 00       	push   $0xa1
80103f79:	e8 e2 fe ff ff       	call   80103e60 <outb>
80103f7e:	83 c4 08             	add    $0x8,%esp
80103f81:	6a 68                	push   $0x68
80103f83:	6a 20                	push   $0x20
80103f85:	e8 d6 fe ff ff       	call   80103e60 <outb>
80103f8a:	83 c4 08             	add    $0x8,%esp
80103f8d:	6a 0a                	push   $0xa
80103f8f:	6a 20                	push   $0x20
80103f91:	e8 ca fe ff ff       	call   80103e60 <outb>
80103f96:	83 c4 08             	add    $0x8,%esp
80103f99:	6a 68                	push   $0x68
80103f9b:	68 a0 00 00 00       	push   $0xa0
80103fa0:	e8 bb fe ff ff       	call   80103e60 <outb>
80103fa5:	83 c4 08             	add    $0x8,%esp
80103fa8:	6a 0a                	push   $0xa
80103faa:	68 a0 00 00 00       	push   $0xa0
80103faf:	e8 ac fe ff ff       	call   80103e60 <outb>
80103fb4:	83 c4 08             	add    $0x8,%esp
80103fb7:	0f b7 05 00 b0 10 80 	movzwl 0x8010b000,%eax
80103fbe:	66 83 f8 ff          	cmp    $0xffff,%ax
80103fc2:	74 13                	je     80103fd7 <picinit+0xe6>
80103fc4:	0f b7 05 00 b0 10 80 	movzwl 0x8010b000,%eax
80103fcb:	0f b7 c0             	movzwl %ax,%eax
80103fce:	50                   	push   %eax
80103fcf:	e8 ab fe ff ff       	call   80103e7f <picsetmask>
80103fd4:	83 c4 04             	add    $0x4,%esp
80103fd7:	90                   	nop
80103fd8:	c9                   	leave  
80103fd9:	c3                   	ret    

80103fda <pipealloc>:
80103fda:	55                   	push   %ebp
80103fdb:	89 e5                	mov    %esp,%ebp
80103fdd:	83 ec 18             	sub    $0x18,%esp
80103fe0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103fe7:	8b 45 0c             	mov    0xc(%ebp),%eax
80103fea:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80103ff0:	8b 45 0c             	mov    0xc(%ebp),%eax
80103ff3:	8b 10                	mov    (%eax),%edx
80103ff5:	8b 45 08             	mov    0x8(%ebp),%eax
80103ff8:	89 10                	mov    %edx,(%eax)
80103ffa:	e8 2d cf ff ff       	call   80100f2c <filealloc>
80103fff:	89 c2                	mov    %eax,%edx
80104001:	8b 45 08             	mov    0x8(%ebp),%eax
80104004:	89 10                	mov    %edx,(%eax)
80104006:	8b 45 08             	mov    0x8(%ebp),%eax
80104009:	8b 00                	mov    (%eax),%eax
8010400b:	85 c0                	test   %eax,%eax
8010400d:	0f 84 cb 00 00 00    	je     801040de <pipealloc+0x104>
80104013:	e8 14 cf ff ff       	call   80100f2c <filealloc>
80104018:	89 c2                	mov    %eax,%edx
8010401a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010401d:	89 10                	mov    %edx,(%eax)
8010401f:	8b 45 0c             	mov    0xc(%ebp),%eax
80104022:	8b 00                	mov    (%eax),%eax
80104024:	85 c0                	test   %eax,%eax
80104026:	0f 84 b2 00 00 00    	je     801040de <pipealloc+0x104>
8010402c:	e8 ce eb ff ff       	call   80102bff <kalloc>
80104031:	89 45 f4             	mov    %eax,-0xc(%ebp)
80104034:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80104038:	0f 84 9f 00 00 00    	je     801040dd <pipealloc+0x103>
8010403e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104041:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80104048:	00 00 00 
8010404b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010404e:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80104055:	00 00 00 
80104058:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010405b:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80104062:	00 00 00 
80104065:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104068:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
8010406f:	00 00 00 
80104072:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104075:	83 ec 08             	sub    $0x8,%esp
80104078:	68 00 88 10 80       	push   $0x80108800
8010407d:	50                   	push   %eax
8010407e:	e8 f3 0e 00 00       	call   80104f76 <initlock>
80104083:	83 c4 10             	add    $0x10,%esp
80104086:	8b 45 08             	mov    0x8(%ebp),%eax
80104089:	8b 00                	mov    (%eax),%eax
8010408b:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
80104091:	8b 45 08             	mov    0x8(%ebp),%eax
80104094:	8b 00                	mov    (%eax),%eax
80104096:	c6 40 08 01          	movb   $0x1,0x8(%eax)
8010409a:	8b 45 08             	mov    0x8(%ebp),%eax
8010409d:	8b 00                	mov    (%eax),%eax
8010409f:	c6 40 09 00          	movb   $0x0,0x9(%eax)
801040a3:	8b 45 08             	mov    0x8(%ebp),%eax
801040a6:	8b 00                	mov    (%eax),%eax
801040a8:	8b 55 f4             	mov    -0xc(%ebp),%edx
801040ab:	89 50 0c             	mov    %edx,0xc(%eax)
801040ae:	8b 45 0c             	mov    0xc(%ebp),%eax
801040b1:	8b 00                	mov    (%eax),%eax
801040b3:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
801040b9:	8b 45 0c             	mov    0xc(%ebp),%eax
801040bc:	8b 00                	mov    (%eax),%eax
801040be:	c6 40 08 00          	movb   $0x0,0x8(%eax)
801040c2:	8b 45 0c             	mov    0xc(%ebp),%eax
801040c5:	8b 00                	mov    (%eax),%eax
801040c7:	c6 40 09 01          	movb   $0x1,0x9(%eax)
801040cb:	8b 45 0c             	mov    0xc(%ebp),%eax
801040ce:	8b 00                	mov    (%eax),%eax
801040d0:	8b 55 f4             	mov    -0xc(%ebp),%edx
801040d3:	89 50 0c             	mov    %edx,0xc(%eax)
801040d6:	b8 00 00 00 00       	mov    $0x0,%eax
801040db:	eb 4e                	jmp    8010412b <pipealloc+0x151>
801040dd:	90                   	nop
801040de:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801040e2:	74 0e                	je     801040f2 <pipealloc+0x118>
801040e4:	83 ec 0c             	sub    $0xc,%esp
801040e7:	ff 75 f4             	pushl  -0xc(%ebp)
801040ea:	e8 73 ea ff ff       	call   80102b62 <kfree>
801040ef:	83 c4 10             	add    $0x10,%esp
801040f2:	8b 45 08             	mov    0x8(%ebp),%eax
801040f5:	8b 00                	mov    (%eax),%eax
801040f7:	85 c0                	test   %eax,%eax
801040f9:	74 11                	je     8010410c <pipealloc+0x132>
801040fb:	8b 45 08             	mov    0x8(%ebp),%eax
801040fe:	8b 00                	mov    (%eax),%eax
80104100:	83 ec 0c             	sub    $0xc,%esp
80104103:	50                   	push   %eax
80104104:	e8 e1 ce ff ff       	call   80100fea <fileclose>
80104109:	83 c4 10             	add    $0x10,%esp
8010410c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010410f:	8b 00                	mov    (%eax),%eax
80104111:	85 c0                	test   %eax,%eax
80104113:	74 11                	je     80104126 <pipealloc+0x14c>
80104115:	8b 45 0c             	mov    0xc(%ebp),%eax
80104118:	8b 00                	mov    (%eax),%eax
8010411a:	83 ec 0c             	sub    $0xc,%esp
8010411d:	50                   	push   %eax
8010411e:	e8 c7 ce ff ff       	call   80100fea <fileclose>
80104123:	83 c4 10             	add    $0x10,%esp
80104126:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010412b:	c9                   	leave  
8010412c:	c3                   	ret    

8010412d <pipeclose>:
8010412d:	55                   	push   %ebp
8010412e:	89 e5                	mov    %esp,%ebp
80104130:	83 ec 08             	sub    $0x8,%esp
80104133:	8b 45 08             	mov    0x8(%ebp),%eax
80104136:	83 ec 0c             	sub    $0xc,%esp
80104139:	50                   	push   %eax
8010413a:	e8 59 0e 00 00       	call   80104f98 <acquire>
8010413f:	83 c4 10             	add    $0x10,%esp
80104142:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80104146:	74 23                	je     8010416b <pipeclose+0x3e>
80104148:	8b 45 08             	mov    0x8(%ebp),%eax
8010414b:	c7 80 40 02 00 00 00 	movl   $0x0,0x240(%eax)
80104152:	00 00 00 
80104155:	8b 45 08             	mov    0x8(%ebp),%eax
80104158:	05 34 02 00 00       	add    $0x234,%eax
8010415d:	83 ec 0c             	sub    $0xc,%esp
80104160:	50                   	push   %eax
80104161:	e8 24 0c 00 00       	call   80104d8a <wakeup>
80104166:	83 c4 10             	add    $0x10,%esp
80104169:	eb 21                	jmp    8010418c <pipeclose+0x5f>
8010416b:	8b 45 08             	mov    0x8(%ebp),%eax
8010416e:	c7 80 3c 02 00 00 00 	movl   $0x0,0x23c(%eax)
80104175:	00 00 00 
80104178:	8b 45 08             	mov    0x8(%ebp),%eax
8010417b:	05 38 02 00 00       	add    $0x238,%eax
80104180:	83 ec 0c             	sub    $0xc,%esp
80104183:	50                   	push   %eax
80104184:	e8 01 0c 00 00       	call   80104d8a <wakeup>
80104189:	83 c4 10             	add    $0x10,%esp
8010418c:	8b 45 08             	mov    0x8(%ebp),%eax
8010418f:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
80104195:	85 c0                	test   %eax,%eax
80104197:	75 2c                	jne    801041c5 <pipeclose+0x98>
80104199:	8b 45 08             	mov    0x8(%ebp),%eax
8010419c:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
801041a2:	85 c0                	test   %eax,%eax
801041a4:	75 1f                	jne    801041c5 <pipeclose+0x98>
801041a6:	8b 45 08             	mov    0x8(%ebp),%eax
801041a9:	83 ec 0c             	sub    $0xc,%esp
801041ac:	50                   	push   %eax
801041ad:	e8 4d 0e 00 00       	call   80104fff <release>
801041b2:	83 c4 10             	add    $0x10,%esp
801041b5:	83 ec 0c             	sub    $0xc,%esp
801041b8:	ff 75 08             	pushl  0x8(%ebp)
801041bb:	e8 a2 e9 ff ff       	call   80102b62 <kfree>
801041c0:	83 c4 10             	add    $0x10,%esp
801041c3:	eb 0f                	jmp    801041d4 <pipeclose+0xa7>
801041c5:	8b 45 08             	mov    0x8(%ebp),%eax
801041c8:	83 ec 0c             	sub    $0xc,%esp
801041cb:	50                   	push   %eax
801041cc:	e8 2e 0e 00 00       	call   80104fff <release>
801041d1:	83 c4 10             	add    $0x10,%esp
801041d4:	90                   	nop
801041d5:	c9                   	leave  
801041d6:	c3                   	ret    

801041d7 <pipewrite>:
801041d7:	55                   	push   %ebp
801041d8:	89 e5                	mov    %esp,%ebp
801041da:	83 ec 18             	sub    $0x18,%esp
801041dd:	8b 45 08             	mov    0x8(%ebp),%eax
801041e0:	83 ec 0c             	sub    $0xc,%esp
801041e3:	50                   	push   %eax
801041e4:	e8 af 0d 00 00       	call   80104f98 <acquire>
801041e9:	83 c4 10             	add    $0x10,%esp
801041ec:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801041f3:	e9 ad 00 00 00       	jmp    801042a5 <pipewrite+0xce>
801041f8:	8b 45 08             	mov    0x8(%ebp),%eax
801041fb:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
80104201:	85 c0                	test   %eax,%eax
80104203:	74 0d                	je     80104212 <pipewrite+0x3b>
80104205:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010420b:	8b 40 24             	mov    0x24(%eax),%eax
8010420e:	85 c0                	test   %eax,%eax
80104210:	74 19                	je     8010422b <pipewrite+0x54>
80104212:	8b 45 08             	mov    0x8(%ebp),%eax
80104215:	83 ec 0c             	sub    $0xc,%esp
80104218:	50                   	push   %eax
80104219:	e8 e1 0d 00 00       	call   80104fff <release>
8010421e:	83 c4 10             	add    $0x10,%esp
80104221:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104226:	e9 a8 00 00 00       	jmp    801042d3 <pipewrite+0xfc>
8010422b:	8b 45 08             	mov    0x8(%ebp),%eax
8010422e:	05 34 02 00 00       	add    $0x234,%eax
80104233:	83 ec 0c             	sub    $0xc,%esp
80104236:	50                   	push   %eax
80104237:	e8 4e 0b 00 00       	call   80104d8a <wakeup>
8010423c:	83 c4 10             	add    $0x10,%esp
8010423f:	8b 45 08             	mov    0x8(%ebp),%eax
80104242:	8b 55 08             	mov    0x8(%ebp),%edx
80104245:	81 c2 38 02 00 00    	add    $0x238,%edx
8010424b:	83 ec 08             	sub    $0x8,%esp
8010424e:	50                   	push   %eax
8010424f:	52                   	push   %edx
80104250:	e8 4a 0a 00 00       	call   80104c9f <sleep>
80104255:	83 c4 10             	add    $0x10,%esp
80104258:	8b 45 08             	mov    0x8(%ebp),%eax
8010425b:	8b 90 38 02 00 00    	mov    0x238(%eax),%edx
80104261:	8b 45 08             	mov    0x8(%ebp),%eax
80104264:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
8010426a:	05 00 02 00 00       	add    $0x200,%eax
8010426f:	39 c2                	cmp    %eax,%edx
80104271:	74 85                	je     801041f8 <pipewrite+0x21>
80104273:	8b 45 08             	mov    0x8(%ebp),%eax
80104276:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
8010427c:	8d 48 01             	lea    0x1(%eax),%ecx
8010427f:	8b 55 08             	mov    0x8(%ebp),%edx
80104282:	89 8a 38 02 00 00    	mov    %ecx,0x238(%edx)
80104288:	25 ff 01 00 00       	and    $0x1ff,%eax
8010428d:	89 c1                	mov    %eax,%ecx
8010428f:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104292:	8b 45 0c             	mov    0xc(%ebp),%eax
80104295:	01 d0                	add    %edx,%eax
80104297:	0f b6 10             	movzbl (%eax),%edx
8010429a:	8b 45 08             	mov    0x8(%ebp),%eax
8010429d:	88 54 08 34          	mov    %dl,0x34(%eax,%ecx,1)
801042a1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801042a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801042a8:	3b 45 10             	cmp    0x10(%ebp),%eax
801042ab:	7c ab                	jl     80104258 <pipewrite+0x81>
801042ad:	8b 45 08             	mov    0x8(%ebp),%eax
801042b0:	05 34 02 00 00       	add    $0x234,%eax
801042b5:	83 ec 0c             	sub    $0xc,%esp
801042b8:	50                   	push   %eax
801042b9:	e8 cc 0a 00 00       	call   80104d8a <wakeup>
801042be:	83 c4 10             	add    $0x10,%esp
801042c1:	8b 45 08             	mov    0x8(%ebp),%eax
801042c4:	83 ec 0c             	sub    $0xc,%esp
801042c7:	50                   	push   %eax
801042c8:	e8 32 0d 00 00       	call   80104fff <release>
801042cd:	83 c4 10             	add    $0x10,%esp
801042d0:	8b 45 10             	mov    0x10(%ebp),%eax
801042d3:	c9                   	leave  
801042d4:	c3                   	ret    

801042d5 <piperead>:
801042d5:	55                   	push   %ebp
801042d6:	89 e5                	mov    %esp,%ebp
801042d8:	53                   	push   %ebx
801042d9:	83 ec 14             	sub    $0x14,%esp
801042dc:	8b 45 08             	mov    0x8(%ebp),%eax
801042df:	83 ec 0c             	sub    $0xc,%esp
801042e2:	50                   	push   %eax
801042e3:	e8 b0 0c 00 00       	call   80104f98 <acquire>
801042e8:	83 c4 10             	add    $0x10,%esp
801042eb:	eb 3f                	jmp    8010432c <piperead+0x57>
801042ed:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801042f3:	8b 40 24             	mov    0x24(%eax),%eax
801042f6:	85 c0                	test   %eax,%eax
801042f8:	74 19                	je     80104313 <piperead+0x3e>
801042fa:	8b 45 08             	mov    0x8(%ebp),%eax
801042fd:	83 ec 0c             	sub    $0xc,%esp
80104300:	50                   	push   %eax
80104301:	e8 f9 0c 00 00       	call   80104fff <release>
80104306:	83 c4 10             	add    $0x10,%esp
80104309:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010430e:	e9 bf 00 00 00       	jmp    801043d2 <piperead+0xfd>
80104313:	8b 45 08             	mov    0x8(%ebp),%eax
80104316:	8b 55 08             	mov    0x8(%ebp),%edx
80104319:	81 c2 34 02 00 00    	add    $0x234,%edx
8010431f:	83 ec 08             	sub    $0x8,%esp
80104322:	50                   	push   %eax
80104323:	52                   	push   %edx
80104324:	e8 76 09 00 00       	call   80104c9f <sleep>
80104329:	83 c4 10             	add    $0x10,%esp
8010432c:	8b 45 08             	mov    0x8(%ebp),%eax
8010432f:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
80104335:	8b 45 08             	mov    0x8(%ebp),%eax
80104338:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
8010433e:	39 c2                	cmp    %eax,%edx
80104340:	75 0d                	jne    8010434f <piperead+0x7a>
80104342:	8b 45 08             	mov    0x8(%ebp),%eax
80104345:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
8010434b:	85 c0                	test   %eax,%eax
8010434d:	75 9e                	jne    801042ed <piperead+0x18>
8010434f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80104356:	eb 49                	jmp    801043a1 <piperead+0xcc>
80104358:	8b 45 08             	mov    0x8(%ebp),%eax
8010435b:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
80104361:	8b 45 08             	mov    0x8(%ebp),%eax
80104364:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
8010436a:	39 c2                	cmp    %eax,%edx
8010436c:	74 3d                	je     801043ab <piperead+0xd6>
8010436e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104371:	8b 45 0c             	mov    0xc(%ebp),%eax
80104374:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
80104377:	8b 45 08             	mov    0x8(%ebp),%eax
8010437a:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
80104380:	8d 48 01             	lea    0x1(%eax),%ecx
80104383:	8b 55 08             	mov    0x8(%ebp),%edx
80104386:	89 8a 34 02 00 00    	mov    %ecx,0x234(%edx)
8010438c:	25 ff 01 00 00       	and    $0x1ff,%eax
80104391:	89 c2                	mov    %eax,%edx
80104393:	8b 45 08             	mov    0x8(%ebp),%eax
80104396:	0f b6 44 10 34       	movzbl 0x34(%eax,%edx,1),%eax
8010439b:	88 03                	mov    %al,(%ebx)
8010439d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801043a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801043a4:	3b 45 10             	cmp    0x10(%ebp),%eax
801043a7:	7c af                	jl     80104358 <piperead+0x83>
801043a9:	eb 01                	jmp    801043ac <piperead+0xd7>
801043ab:	90                   	nop
801043ac:	8b 45 08             	mov    0x8(%ebp),%eax
801043af:	05 38 02 00 00       	add    $0x238,%eax
801043b4:	83 ec 0c             	sub    $0xc,%esp
801043b7:	50                   	push   %eax
801043b8:	e8 cd 09 00 00       	call   80104d8a <wakeup>
801043bd:	83 c4 10             	add    $0x10,%esp
801043c0:	8b 45 08             	mov    0x8(%ebp),%eax
801043c3:	83 ec 0c             	sub    $0xc,%esp
801043c6:	50                   	push   %eax
801043c7:	e8 33 0c 00 00       	call   80104fff <release>
801043cc:	83 c4 10             	add    $0x10,%esp
801043cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
801043d2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801043d5:	c9                   	leave  
801043d6:	c3                   	ret    

801043d7 <readeflags>:
801043d7:	55                   	push   %ebp
801043d8:	89 e5                	mov    %esp,%ebp
801043da:	83 ec 10             	sub    $0x10,%esp
801043dd:	9c                   	pushf  
801043de:	58                   	pop    %eax
801043df:	89 45 fc             	mov    %eax,-0x4(%ebp)
801043e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
801043e5:	c9                   	leave  
801043e6:	c3                   	ret    

801043e7 <sti>:
801043e7:	55                   	push   %ebp
801043e8:	89 e5                	mov    %esp,%ebp
801043ea:	fb                   	sti    
801043eb:	90                   	nop
801043ec:	5d                   	pop    %ebp
801043ed:	c3                   	ret    

801043ee <pinit>:
801043ee:	55                   	push   %ebp
801043ef:	89 e5                	mov    %esp,%ebp
801043f1:	83 ec 08             	sub    $0x8,%esp
801043f4:	83 ec 08             	sub    $0x8,%esp
801043f7:	68 05 88 10 80       	push   $0x80108805
801043fc:	68 60 29 11 80       	push   $0x80112960
80104401:	e8 70 0b 00 00       	call   80104f76 <initlock>
80104406:	83 c4 10             	add    $0x10,%esp
80104409:	90                   	nop
8010440a:	c9                   	leave  
8010440b:	c3                   	ret    

8010440c <allocproc>:
8010440c:	55                   	push   %ebp
8010440d:	89 e5                	mov    %esp,%ebp
8010440f:	83 ec 18             	sub    $0x18,%esp
80104412:	83 ec 0c             	sub    $0xc,%esp
80104415:	68 60 29 11 80       	push   $0x80112960
8010441a:	e8 79 0b 00 00       	call   80104f98 <acquire>
8010441f:	83 c4 10             	add    $0x10,%esp
80104422:	c7 45 f4 94 29 11 80 	movl   $0x80112994,-0xc(%ebp)
80104429:	eb 0e                	jmp    80104439 <allocproc+0x2d>
8010442b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010442e:	8b 40 0c             	mov    0xc(%eax),%eax
80104431:	85 c0                	test   %eax,%eax
80104433:	74 27                	je     8010445c <allocproc+0x50>
80104435:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
80104439:	81 7d f4 94 48 11 80 	cmpl   $0x80114894,-0xc(%ebp)
80104440:	72 e9                	jb     8010442b <allocproc+0x1f>
80104442:	83 ec 0c             	sub    $0xc,%esp
80104445:	68 60 29 11 80       	push   $0x80112960
8010444a:	e8 b0 0b 00 00       	call   80104fff <release>
8010444f:	83 c4 10             	add    $0x10,%esp
80104452:	b8 00 00 00 00       	mov    $0x0,%eax
80104457:	e9 b4 00 00 00       	jmp    80104510 <allocproc+0x104>
8010445c:	90                   	nop
8010445d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104460:	c7 40 0c 01 00 00 00 	movl   $0x1,0xc(%eax)
80104467:	a1 04 b0 10 80       	mov    0x8010b004,%eax
8010446c:	8d 50 01             	lea    0x1(%eax),%edx
8010446f:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
80104475:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104478:	89 42 10             	mov    %eax,0x10(%edx)
8010447b:	83 ec 0c             	sub    $0xc,%esp
8010447e:	68 60 29 11 80       	push   $0x80112960
80104483:	e8 77 0b 00 00       	call   80104fff <release>
80104488:	83 c4 10             	add    $0x10,%esp
8010448b:	e8 6f e7 ff ff       	call   80102bff <kalloc>
80104490:	89 c2                	mov    %eax,%edx
80104492:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104495:	89 50 08             	mov    %edx,0x8(%eax)
80104498:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010449b:	8b 40 08             	mov    0x8(%eax),%eax
8010449e:	85 c0                	test   %eax,%eax
801044a0:	75 11                	jne    801044b3 <allocproc+0xa7>
801044a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044a5:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
801044ac:	b8 00 00 00 00       	mov    $0x0,%eax
801044b1:	eb 5d                	jmp    80104510 <allocproc+0x104>
801044b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044b6:	8b 40 08             	mov    0x8(%eax),%eax
801044b9:	05 00 10 00 00       	add    $0x1000,%eax
801044be:	89 45 f0             	mov    %eax,-0x10(%ebp)
801044c1:	83 6d f0 4c          	subl   $0x4c,-0x10(%ebp)
801044c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044c8:	8b 55 f0             	mov    -0x10(%ebp),%edx
801044cb:	89 50 18             	mov    %edx,0x18(%eax)
801044ce:	83 6d f0 04          	subl   $0x4,-0x10(%ebp)
801044d2:	ba d5 65 10 80       	mov    $0x801065d5,%edx
801044d7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801044da:	89 10                	mov    %edx,(%eax)
801044dc:	83 6d f0 14          	subl   $0x14,-0x10(%ebp)
801044e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044e3:	8b 55 f0             	mov    -0x10(%ebp),%edx
801044e6:	89 50 1c             	mov    %edx,0x1c(%eax)
801044e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044ec:	8b 40 1c             	mov    0x1c(%eax),%eax
801044ef:	83 ec 04             	sub    $0x4,%esp
801044f2:	6a 14                	push   $0x14
801044f4:	6a 00                	push   $0x0
801044f6:	50                   	push   %eax
801044f7:	e8 ff 0c 00 00       	call   801051fb <memset>
801044fc:	83 c4 10             	add    $0x10,%esp
801044ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104502:	8b 40 1c             	mov    0x1c(%eax),%eax
80104505:	ba 59 4c 10 80       	mov    $0x80104c59,%edx
8010450a:	89 50 10             	mov    %edx,0x10(%eax)
8010450d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104510:	c9                   	leave  
80104511:	c3                   	ret    

80104512 <userinit>:
80104512:	55                   	push   %ebp
80104513:	89 e5                	mov    %esp,%ebp
80104515:	83 ec 18             	sub    $0x18,%esp
80104518:	e8 ef fe ff ff       	call   8010440c <allocproc>
8010451d:	89 45 f4             	mov    %eax,-0xc(%ebp)
80104520:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104523:	a3 48 b6 10 80       	mov    %eax,0x8010b648
80104528:	e8 6d 37 00 00       	call   80107c9a <setupkvm>
8010452d:	89 c2                	mov    %eax,%edx
8010452f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104532:	89 50 04             	mov    %edx,0x4(%eax)
80104535:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104538:	8b 40 04             	mov    0x4(%eax),%eax
8010453b:	85 c0                	test   %eax,%eax
8010453d:	75 0d                	jne    8010454c <userinit+0x3a>
8010453f:	83 ec 0c             	sub    $0xc,%esp
80104542:	68 0c 88 10 80       	push   $0x8010880c
80104547:	e8 ee bf ff ff       	call   8010053a <panic>
8010454c:	ba 2c 00 00 00       	mov    $0x2c,%edx
80104551:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104554:	8b 40 04             	mov    0x4(%eax),%eax
80104557:	83 ec 04             	sub    $0x4,%esp
8010455a:	52                   	push   %edx
8010455b:	68 e0 b4 10 80       	push   $0x8010b4e0
80104560:	50                   	push   %eax
80104561:	e8 8e 39 00 00       	call   80107ef4 <inituvm>
80104566:	83 c4 10             	add    $0x10,%esp
80104569:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010456c:	c7 00 00 10 00 00    	movl   $0x1000,(%eax)
80104572:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104575:	8b 40 18             	mov    0x18(%eax),%eax
80104578:	83 ec 04             	sub    $0x4,%esp
8010457b:	6a 4c                	push   $0x4c
8010457d:	6a 00                	push   $0x0
8010457f:	50                   	push   %eax
80104580:	e8 76 0c 00 00       	call   801051fb <memset>
80104585:	83 c4 10             	add    $0x10,%esp
80104588:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010458b:	8b 40 18             	mov    0x18(%eax),%eax
8010458e:	66 c7 40 3c 23 00    	movw   $0x23,0x3c(%eax)
80104594:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104597:	8b 40 18             	mov    0x18(%eax),%eax
8010459a:	66 c7 40 2c 2b 00    	movw   $0x2b,0x2c(%eax)
801045a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045a3:	8b 40 18             	mov    0x18(%eax),%eax
801045a6:	8b 55 f4             	mov    -0xc(%ebp),%edx
801045a9:	8b 52 18             	mov    0x18(%edx),%edx
801045ac:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
801045b0:	66 89 50 28          	mov    %dx,0x28(%eax)
801045b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045b7:	8b 40 18             	mov    0x18(%eax),%eax
801045ba:	8b 55 f4             	mov    -0xc(%ebp),%edx
801045bd:	8b 52 18             	mov    0x18(%edx),%edx
801045c0:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
801045c4:	66 89 50 48          	mov    %dx,0x48(%eax)
801045c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045cb:	8b 40 18             	mov    0x18(%eax),%eax
801045ce:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
801045d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045d8:	8b 40 18             	mov    0x18(%eax),%eax
801045db:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
801045e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045e5:	8b 40 18             	mov    0x18(%eax),%eax
801045e8:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
801045ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045f2:	83 c0 6c             	add    $0x6c,%eax
801045f5:	83 ec 04             	sub    $0x4,%esp
801045f8:	6a 10                	push   $0x10
801045fa:	68 25 88 10 80       	push   $0x80108825
801045ff:	50                   	push   %eax
80104600:	e8 f9 0d 00 00       	call   801053fe <safestrcpy>
80104605:	83 c4 10             	add    $0x10,%esp
80104608:	83 ec 0c             	sub    $0xc,%esp
8010460b:	68 2e 88 10 80       	push   $0x8010882e
80104610:	e8 ac de ff ff       	call   801024c1 <namei>
80104615:	83 c4 10             	add    $0x10,%esp
80104618:	89 c2                	mov    %eax,%edx
8010461a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010461d:	89 50 68             	mov    %edx,0x68(%eax)
80104620:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104623:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
8010462a:	90                   	nop
8010462b:	c9                   	leave  
8010462c:	c3                   	ret    

8010462d <growproc>:
8010462d:	55                   	push   %ebp
8010462e:	89 e5                	mov    %esp,%ebp
80104630:	83 ec 18             	sub    $0x18,%esp
80104633:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104639:	8b 00                	mov    (%eax),%eax
8010463b:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010463e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80104642:	7e 31                	jle    80104675 <growproc+0x48>
80104644:	8b 55 08             	mov    0x8(%ebp),%edx
80104647:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010464a:	01 c2                	add    %eax,%edx
8010464c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104652:	8b 40 04             	mov    0x4(%eax),%eax
80104655:	83 ec 04             	sub    $0x4,%esp
80104658:	52                   	push   %edx
80104659:	ff 75 f4             	pushl  -0xc(%ebp)
8010465c:	50                   	push   %eax
8010465d:	e8 df 39 00 00       	call   80108041 <allocuvm>
80104662:	83 c4 10             	add    $0x10,%esp
80104665:	89 45 f4             	mov    %eax,-0xc(%ebp)
80104668:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010466c:	75 3e                	jne    801046ac <growproc+0x7f>
8010466e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104673:	eb 59                	jmp    801046ce <growproc+0xa1>
80104675:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80104679:	79 31                	jns    801046ac <growproc+0x7f>
8010467b:	8b 55 08             	mov    0x8(%ebp),%edx
8010467e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104681:	01 c2                	add    %eax,%edx
80104683:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104689:	8b 40 04             	mov    0x4(%eax),%eax
8010468c:	83 ec 04             	sub    $0x4,%esp
8010468f:	52                   	push   %edx
80104690:	ff 75 f4             	pushl  -0xc(%ebp)
80104693:	50                   	push   %eax
80104694:	e8 71 3a 00 00       	call   8010810a <deallocuvm>
80104699:	83 c4 10             	add    $0x10,%esp
8010469c:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010469f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801046a3:	75 07                	jne    801046ac <growproc+0x7f>
801046a5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801046aa:	eb 22                	jmp    801046ce <growproc+0xa1>
801046ac:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801046b2:	8b 55 f4             	mov    -0xc(%ebp),%edx
801046b5:	89 10                	mov    %edx,(%eax)
801046b7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801046bd:	83 ec 0c             	sub    $0xc,%esp
801046c0:	50                   	push   %eax
801046c1:	e8 bb 36 00 00       	call   80107d81 <switchuvm>
801046c6:	83 c4 10             	add    $0x10,%esp
801046c9:	b8 00 00 00 00       	mov    $0x0,%eax
801046ce:	c9                   	leave  
801046cf:	c3                   	ret    

801046d0 <fork>:
801046d0:	55                   	push   %ebp
801046d1:	89 e5                	mov    %esp,%ebp
801046d3:	57                   	push   %edi
801046d4:	56                   	push   %esi
801046d5:	53                   	push   %ebx
801046d6:	83 ec 1c             	sub    $0x1c,%esp
801046d9:	e8 2e fd ff ff       	call   8010440c <allocproc>
801046de:	89 45 e0             	mov    %eax,-0x20(%ebp)
801046e1:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
801046e5:	75 0a                	jne    801046f1 <fork+0x21>
801046e7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801046ec:	e9 68 01 00 00       	jmp    80104859 <fork+0x189>
801046f1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801046f7:	8b 10                	mov    (%eax),%edx
801046f9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801046ff:	8b 40 04             	mov    0x4(%eax),%eax
80104702:	83 ec 08             	sub    $0x8,%esp
80104705:	52                   	push   %edx
80104706:	50                   	push   %eax
80104707:	e8 9c 3b 00 00       	call   801082a8 <copyuvm>
8010470c:	83 c4 10             	add    $0x10,%esp
8010470f:	89 c2                	mov    %eax,%edx
80104711:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104714:	89 50 04             	mov    %edx,0x4(%eax)
80104717:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010471a:	8b 40 04             	mov    0x4(%eax),%eax
8010471d:	85 c0                	test   %eax,%eax
8010471f:	75 30                	jne    80104751 <fork+0x81>
80104721:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104724:	8b 40 08             	mov    0x8(%eax),%eax
80104727:	83 ec 0c             	sub    $0xc,%esp
8010472a:	50                   	push   %eax
8010472b:	e8 32 e4 ff ff       	call   80102b62 <kfree>
80104730:	83 c4 10             	add    $0x10,%esp
80104733:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104736:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
8010473d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104740:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
80104747:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010474c:	e9 08 01 00 00       	jmp    80104859 <fork+0x189>
80104751:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104757:	8b 10                	mov    (%eax),%edx
80104759:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010475c:	89 10                	mov    %edx,(%eax)
8010475e:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104765:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104768:	89 50 14             	mov    %edx,0x14(%eax)
8010476b:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010476e:	8b 50 18             	mov    0x18(%eax),%edx
80104771:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104777:	8b 40 18             	mov    0x18(%eax),%eax
8010477a:	89 c3                	mov    %eax,%ebx
8010477c:	b8 13 00 00 00       	mov    $0x13,%eax
80104781:	89 d7                	mov    %edx,%edi
80104783:	89 de                	mov    %ebx,%esi
80104785:	89 c1                	mov    %eax,%ecx
80104787:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
80104789:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010478c:	8b 40 18             	mov    0x18(%eax),%eax
8010478f:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
80104796:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
8010479d:	eb 43                	jmp    801047e2 <fork+0x112>
8010479f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801047a5:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801047a8:	83 c2 08             	add    $0x8,%edx
801047ab:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801047af:	85 c0                	test   %eax,%eax
801047b1:	74 2b                	je     801047de <fork+0x10e>
801047b3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801047b9:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801047bc:	83 c2 08             	add    $0x8,%edx
801047bf:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801047c3:	83 ec 0c             	sub    $0xc,%esp
801047c6:	50                   	push   %eax
801047c7:	e8 cd c7 ff ff       	call   80100f99 <filedup>
801047cc:	83 c4 10             	add    $0x10,%esp
801047cf:	89 c1                	mov    %eax,%ecx
801047d1:	8b 45 e0             	mov    -0x20(%ebp),%eax
801047d4:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801047d7:	83 c2 08             	add    $0x8,%edx
801047da:	89 4c 90 08          	mov    %ecx,0x8(%eax,%edx,4)
801047de:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
801047e2:	83 7d e4 0f          	cmpl   $0xf,-0x1c(%ebp)
801047e6:	7e b7                	jle    8010479f <fork+0xcf>
801047e8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801047ee:	8b 40 68             	mov    0x68(%eax),%eax
801047f1:	83 ec 0c             	sub    $0xc,%esp
801047f4:	50                   	push   %eax
801047f5:	e8 cf d0 ff ff       	call   801018c9 <idup>
801047fa:	83 c4 10             	add    $0x10,%esp
801047fd:	89 c2                	mov    %eax,%edx
801047ff:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104802:	89 50 68             	mov    %edx,0x68(%eax)
80104805:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010480b:	8d 50 6c             	lea    0x6c(%eax),%edx
8010480e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104811:	83 c0 6c             	add    $0x6c,%eax
80104814:	83 ec 04             	sub    $0x4,%esp
80104817:	6a 10                	push   $0x10
80104819:	52                   	push   %edx
8010481a:	50                   	push   %eax
8010481b:	e8 de 0b 00 00       	call   801053fe <safestrcpy>
80104820:	83 c4 10             	add    $0x10,%esp
80104823:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104826:	8b 40 10             	mov    0x10(%eax),%eax
80104829:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010482c:	83 ec 0c             	sub    $0xc,%esp
8010482f:	68 60 29 11 80       	push   $0x80112960
80104834:	e8 5f 07 00 00       	call   80104f98 <acquire>
80104839:	83 c4 10             	add    $0x10,%esp
8010483c:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010483f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80104846:	83 ec 0c             	sub    $0xc,%esp
80104849:	68 60 29 11 80       	push   $0x80112960
8010484e:	e8 ac 07 00 00       	call   80104fff <release>
80104853:	83 c4 10             	add    $0x10,%esp
80104856:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104859:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010485c:	5b                   	pop    %ebx
8010485d:	5e                   	pop    %esi
8010485e:	5f                   	pop    %edi
8010485f:	5d                   	pop    %ebp
80104860:	c3                   	ret    

80104861 <exit>:
80104861:	55                   	push   %ebp
80104862:	89 e5                	mov    %esp,%ebp
80104864:	83 ec 18             	sub    $0x18,%esp
80104867:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
8010486e:	a1 48 b6 10 80       	mov    0x8010b648,%eax
80104873:	39 c2                	cmp    %eax,%edx
80104875:	75 0d                	jne    80104884 <exit+0x23>
80104877:	83 ec 0c             	sub    $0xc,%esp
8010487a:	68 30 88 10 80       	push   $0x80108830
8010487f:	e8 b6 bc ff ff       	call   8010053a <panic>
80104884:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
8010488b:	eb 48                	jmp    801048d5 <exit+0x74>
8010488d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104893:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104896:	83 c2 08             	add    $0x8,%edx
80104899:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
8010489d:	85 c0                	test   %eax,%eax
8010489f:	74 30                	je     801048d1 <exit+0x70>
801048a1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801048a7:	8b 55 f0             	mov    -0x10(%ebp),%edx
801048aa:	83 c2 08             	add    $0x8,%edx
801048ad:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801048b1:	83 ec 0c             	sub    $0xc,%esp
801048b4:	50                   	push   %eax
801048b5:	e8 30 c7 ff ff       	call   80100fea <fileclose>
801048ba:	83 c4 10             	add    $0x10,%esp
801048bd:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801048c3:	8b 55 f0             	mov    -0x10(%ebp),%edx
801048c6:	83 c2 08             	add    $0x8,%edx
801048c9:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
801048d0:	00 
801048d1:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
801048d5:	83 7d f0 0f          	cmpl   $0xf,-0x10(%ebp)
801048d9:	7e b2                	jle    8010488d <exit+0x2c>
801048db:	e8 06 ec ff ff       	call   801034e6 <begin_op>
801048e0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801048e6:	8b 40 68             	mov    0x68(%eax),%eax
801048e9:	83 ec 0c             	sub    $0xc,%esp
801048ec:	50                   	push   %eax
801048ed:	e8 e1 d1 ff ff       	call   80101ad3 <iput>
801048f2:	83 c4 10             	add    $0x10,%esp
801048f5:	e8 78 ec ff ff       	call   80103572 <end_op>
801048fa:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104900:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)
80104907:	83 ec 0c             	sub    $0xc,%esp
8010490a:	68 60 29 11 80       	push   $0x80112960
8010490f:	e8 84 06 00 00       	call   80104f98 <acquire>
80104914:	83 c4 10             	add    $0x10,%esp
80104917:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010491d:	8b 40 14             	mov    0x14(%eax),%eax
80104920:	83 ec 0c             	sub    $0xc,%esp
80104923:	50                   	push   %eax
80104924:	e8 22 04 00 00       	call   80104d4b <wakeup1>
80104929:	83 c4 10             	add    $0x10,%esp
8010492c:	c7 45 f4 94 29 11 80 	movl   $0x80112994,-0xc(%ebp)
80104933:	eb 3c                	jmp    80104971 <exit+0x110>
80104935:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104938:	8b 50 14             	mov    0x14(%eax),%edx
8010493b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104941:	39 c2                	cmp    %eax,%edx
80104943:	75 28                	jne    8010496d <exit+0x10c>
80104945:	8b 15 48 b6 10 80    	mov    0x8010b648,%edx
8010494b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010494e:	89 50 14             	mov    %edx,0x14(%eax)
80104951:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104954:	8b 40 0c             	mov    0xc(%eax),%eax
80104957:	83 f8 05             	cmp    $0x5,%eax
8010495a:	75 11                	jne    8010496d <exit+0x10c>
8010495c:	a1 48 b6 10 80       	mov    0x8010b648,%eax
80104961:	83 ec 0c             	sub    $0xc,%esp
80104964:	50                   	push   %eax
80104965:	e8 e1 03 00 00       	call   80104d4b <wakeup1>
8010496a:	83 c4 10             	add    $0x10,%esp
8010496d:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
80104971:	81 7d f4 94 48 11 80 	cmpl   $0x80114894,-0xc(%ebp)
80104978:	72 bb                	jb     80104935 <exit+0xd4>
8010497a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104980:	c7 40 0c 05 00 00 00 	movl   $0x5,0xc(%eax)
80104987:	e8 d6 01 00 00       	call   80104b62 <sched>
8010498c:	83 ec 0c             	sub    $0xc,%esp
8010498f:	68 3d 88 10 80       	push   $0x8010883d
80104994:	e8 a1 bb ff ff       	call   8010053a <panic>

80104999 <wait>:
80104999:	55                   	push   %ebp
8010499a:	89 e5                	mov    %esp,%ebp
8010499c:	83 ec 18             	sub    $0x18,%esp
8010499f:	83 ec 0c             	sub    $0xc,%esp
801049a2:	68 60 29 11 80       	push   $0x80112960
801049a7:	e8 ec 05 00 00       	call   80104f98 <acquire>
801049ac:	83 c4 10             	add    $0x10,%esp
801049af:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
801049b6:	c7 45 f4 94 29 11 80 	movl   $0x80112994,-0xc(%ebp)
801049bd:	e9 a6 00 00 00       	jmp    80104a68 <wait+0xcf>
801049c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049c5:	8b 50 14             	mov    0x14(%eax),%edx
801049c8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801049ce:	39 c2                	cmp    %eax,%edx
801049d0:	0f 85 8d 00 00 00    	jne    80104a63 <wait+0xca>
801049d6:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
801049dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049e0:	8b 40 0c             	mov    0xc(%eax),%eax
801049e3:	83 f8 05             	cmp    $0x5,%eax
801049e6:	75 7c                	jne    80104a64 <wait+0xcb>
801049e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049eb:	8b 40 10             	mov    0x10(%eax),%eax
801049ee:	89 45 ec             	mov    %eax,-0x14(%ebp)
801049f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049f4:	8b 40 08             	mov    0x8(%eax),%eax
801049f7:	83 ec 0c             	sub    $0xc,%esp
801049fa:	50                   	push   %eax
801049fb:	e8 62 e1 ff ff       	call   80102b62 <kfree>
80104a00:	83 c4 10             	add    $0x10,%esp
80104a03:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a06:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
80104a0d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a10:	8b 40 04             	mov    0x4(%eax),%eax
80104a13:	83 ec 0c             	sub    $0xc,%esp
80104a16:	50                   	push   %eax
80104a17:	e8 ab 37 00 00       	call   801081c7 <freevm>
80104a1c:	83 c4 10             	add    $0x10,%esp
80104a1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a22:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
80104a29:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a2c:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
80104a33:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a36:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
80104a3d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a40:	c6 40 6c 00          	movb   $0x0,0x6c(%eax)
80104a44:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a47:	c7 40 24 00 00 00 00 	movl   $0x0,0x24(%eax)
80104a4e:	83 ec 0c             	sub    $0xc,%esp
80104a51:	68 60 29 11 80       	push   $0x80112960
80104a56:	e8 a4 05 00 00       	call   80104fff <release>
80104a5b:	83 c4 10             	add    $0x10,%esp
80104a5e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104a61:	eb 58                	jmp    80104abb <wait+0x122>
80104a63:	90                   	nop
80104a64:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
80104a68:	81 7d f4 94 48 11 80 	cmpl   $0x80114894,-0xc(%ebp)
80104a6f:	0f 82 4d ff ff ff    	jb     801049c2 <wait+0x29>
80104a75:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80104a79:	74 0d                	je     80104a88 <wait+0xef>
80104a7b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104a81:	8b 40 24             	mov    0x24(%eax),%eax
80104a84:	85 c0                	test   %eax,%eax
80104a86:	74 17                	je     80104a9f <wait+0x106>
80104a88:	83 ec 0c             	sub    $0xc,%esp
80104a8b:	68 60 29 11 80       	push   $0x80112960
80104a90:	e8 6a 05 00 00       	call   80104fff <release>
80104a95:	83 c4 10             	add    $0x10,%esp
80104a98:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104a9d:	eb 1c                	jmp    80104abb <wait+0x122>
80104a9f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104aa5:	83 ec 08             	sub    $0x8,%esp
80104aa8:	68 60 29 11 80       	push   $0x80112960
80104aad:	50                   	push   %eax
80104aae:	e8 ec 01 00 00       	call   80104c9f <sleep>
80104ab3:	83 c4 10             	add    $0x10,%esp
80104ab6:	e9 f4 fe ff ff       	jmp    801049af <wait+0x16>
80104abb:	c9                   	leave  
80104abc:	c3                   	ret    

80104abd <scheduler>:
80104abd:	55                   	push   %ebp
80104abe:	89 e5                	mov    %esp,%ebp
80104ac0:	83 ec 18             	sub    $0x18,%esp
80104ac3:	e8 1f f9 ff ff       	call   801043e7 <sti>
80104ac8:	83 ec 0c             	sub    $0xc,%esp
80104acb:	68 60 29 11 80       	push   $0x80112960
80104ad0:	e8 c3 04 00 00       	call   80104f98 <acquire>
80104ad5:	83 c4 10             	add    $0x10,%esp
80104ad8:	c7 45 f4 94 29 11 80 	movl   $0x80112994,-0xc(%ebp)
80104adf:	eb 63                	jmp    80104b44 <scheduler+0x87>
80104ae1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104ae4:	8b 40 0c             	mov    0xc(%eax),%eax
80104ae7:	83 f8 03             	cmp    $0x3,%eax
80104aea:	75 53                	jne    80104b3f <scheduler+0x82>
80104aec:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104aef:	65 a3 04 00 00 00    	mov    %eax,%gs:0x4
80104af5:	83 ec 0c             	sub    $0xc,%esp
80104af8:	ff 75 f4             	pushl  -0xc(%ebp)
80104afb:	e8 81 32 00 00       	call   80107d81 <switchuvm>
80104b00:	83 c4 10             	add    $0x10,%esp
80104b03:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b06:	c7 40 0c 04 00 00 00 	movl   $0x4,0xc(%eax)
80104b0d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104b13:	8b 40 1c             	mov    0x1c(%eax),%eax
80104b16:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104b1d:	83 c2 04             	add    $0x4,%edx
80104b20:	83 ec 08             	sub    $0x8,%esp
80104b23:	50                   	push   %eax
80104b24:	52                   	push   %edx
80104b25:	e8 45 09 00 00       	call   8010546f <swtch>
80104b2a:	83 c4 10             	add    $0x10,%esp
80104b2d:	e8 32 32 00 00       	call   80107d64 <switchkvm>
80104b32:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80104b39:	00 00 00 00 
80104b3d:	eb 01                	jmp    80104b40 <scheduler+0x83>
80104b3f:	90                   	nop
80104b40:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
80104b44:	81 7d f4 94 48 11 80 	cmpl   $0x80114894,-0xc(%ebp)
80104b4b:	72 94                	jb     80104ae1 <scheduler+0x24>
80104b4d:	83 ec 0c             	sub    $0xc,%esp
80104b50:	68 60 29 11 80       	push   $0x80112960
80104b55:	e8 a5 04 00 00       	call   80104fff <release>
80104b5a:	83 c4 10             	add    $0x10,%esp
80104b5d:	e9 61 ff ff ff       	jmp    80104ac3 <scheduler+0x6>

80104b62 <sched>:
80104b62:	55                   	push   %ebp
80104b63:	89 e5                	mov    %esp,%ebp
80104b65:	83 ec 18             	sub    $0x18,%esp
80104b68:	83 ec 0c             	sub    $0xc,%esp
80104b6b:	68 60 29 11 80       	push   $0x80112960
80104b70:	e8 56 05 00 00       	call   801050cb <holding>
80104b75:	83 c4 10             	add    $0x10,%esp
80104b78:	85 c0                	test   %eax,%eax
80104b7a:	75 0d                	jne    80104b89 <sched+0x27>
80104b7c:	83 ec 0c             	sub    $0xc,%esp
80104b7f:	68 49 88 10 80       	push   $0x80108849
80104b84:	e8 b1 b9 ff ff       	call   8010053a <panic>
80104b89:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104b8f:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80104b95:	83 f8 01             	cmp    $0x1,%eax
80104b98:	74 0d                	je     80104ba7 <sched+0x45>
80104b9a:	83 ec 0c             	sub    $0xc,%esp
80104b9d:	68 5b 88 10 80       	push   $0x8010885b
80104ba2:	e8 93 b9 ff ff       	call   8010053a <panic>
80104ba7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104bad:	8b 40 0c             	mov    0xc(%eax),%eax
80104bb0:	83 f8 04             	cmp    $0x4,%eax
80104bb3:	75 0d                	jne    80104bc2 <sched+0x60>
80104bb5:	83 ec 0c             	sub    $0xc,%esp
80104bb8:	68 67 88 10 80       	push   $0x80108867
80104bbd:	e8 78 b9 ff ff       	call   8010053a <panic>
80104bc2:	e8 10 f8 ff ff       	call   801043d7 <readeflags>
80104bc7:	25 00 02 00 00       	and    $0x200,%eax
80104bcc:	85 c0                	test   %eax,%eax
80104bce:	74 0d                	je     80104bdd <sched+0x7b>
80104bd0:	83 ec 0c             	sub    $0xc,%esp
80104bd3:	68 75 88 10 80       	push   $0x80108875
80104bd8:	e8 5d b9 ff ff       	call   8010053a <panic>
80104bdd:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104be3:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
80104be9:	89 45 f4             	mov    %eax,-0xc(%ebp)
80104bec:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104bf2:	8b 40 04             	mov    0x4(%eax),%eax
80104bf5:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104bfc:	83 c2 1c             	add    $0x1c,%edx
80104bff:	83 ec 08             	sub    $0x8,%esp
80104c02:	50                   	push   %eax
80104c03:	52                   	push   %edx
80104c04:	e8 66 08 00 00       	call   8010546f <swtch>
80104c09:	83 c4 10             	add    $0x10,%esp
80104c0c:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104c12:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104c15:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
80104c1b:	90                   	nop
80104c1c:	c9                   	leave  
80104c1d:	c3                   	ret    

80104c1e <yield>:
80104c1e:	55                   	push   %ebp
80104c1f:	89 e5                	mov    %esp,%ebp
80104c21:	83 ec 08             	sub    $0x8,%esp
80104c24:	83 ec 0c             	sub    $0xc,%esp
80104c27:	68 60 29 11 80       	push   $0x80112960
80104c2c:	e8 67 03 00 00       	call   80104f98 <acquire>
80104c31:	83 c4 10             	add    $0x10,%esp
80104c34:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104c3a:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80104c41:	e8 1c ff ff ff       	call   80104b62 <sched>
80104c46:	83 ec 0c             	sub    $0xc,%esp
80104c49:	68 60 29 11 80       	push   $0x80112960
80104c4e:	e8 ac 03 00 00       	call   80104fff <release>
80104c53:	83 c4 10             	add    $0x10,%esp
80104c56:	90                   	nop
80104c57:	c9                   	leave  
80104c58:	c3                   	ret    

80104c59 <forkret>:
80104c59:	55                   	push   %ebp
80104c5a:	89 e5                	mov    %esp,%ebp
80104c5c:	83 ec 08             	sub    $0x8,%esp
80104c5f:	83 ec 0c             	sub    $0xc,%esp
80104c62:	68 60 29 11 80       	push   $0x80112960
80104c67:	e8 93 03 00 00       	call   80104fff <release>
80104c6c:	83 c4 10             	add    $0x10,%esp
80104c6f:	a1 08 b0 10 80       	mov    0x8010b008,%eax
80104c74:	85 c0                	test   %eax,%eax
80104c76:	74 24                	je     80104c9c <forkret+0x43>
80104c78:	c7 05 08 b0 10 80 00 	movl   $0x0,0x8010b008
80104c7f:	00 00 00 
80104c82:	83 ec 0c             	sub    $0xc,%esp
80104c85:	6a 01                	push   $0x1
80104c87:	e8 4b c9 ff ff       	call   801015d7 <iinit>
80104c8c:	83 c4 10             	add    $0x10,%esp
80104c8f:	83 ec 0c             	sub    $0xc,%esp
80104c92:	6a 01                	push   $0x1
80104c94:	e8 2f e6 ff ff       	call   801032c8 <initlog>
80104c99:	83 c4 10             	add    $0x10,%esp
80104c9c:	90                   	nop
80104c9d:	c9                   	leave  
80104c9e:	c3                   	ret    

80104c9f <sleep>:
80104c9f:	55                   	push   %ebp
80104ca0:	89 e5                	mov    %esp,%ebp
80104ca2:	83 ec 08             	sub    $0x8,%esp
80104ca5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104cab:	85 c0                	test   %eax,%eax
80104cad:	75 0d                	jne    80104cbc <sleep+0x1d>
80104caf:	83 ec 0c             	sub    $0xc,%esp
80104cb2:	68 89 88 10 80       	push   $0x80108889
80104cb7:	e8 7e b8 ff ff       	call   8010053a <panic>
80104cbc:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80104cc0:	75 0d                	jne    80104ccf <sleep+0x30>
80104cc2:	83 ec 0c             	sub    $0xc,%esp
80104cc5:	68 8f 88 10 80       	push   $0x8010888f
80104cca:	e8 6b b8 ff ff       	call   8010053a <panic>
80104ccf:	81 7d 0c 60 29 11 80 	cmpl   $0x80112960,0xc(%ebp)
80104cd6:	74 1e                	je     80104cf6 <sleep+0x57>
80104cd8:	83 ec 0c             	sub    $0xc,%esp
80104cdb:	68 60 29 11 80       	push   $0x80112960
80104ce0:	e8 b3 02 00 00       	call   80104f98 <acquire>
80104ce5:	83 c4 10             	add    $0x10,%esp
80104ce8:	83 ec 0c             	sub    $0xc,%esp
80104ceb:	ff 75 0c             	pushl  0xc(%ebp)
80104cee:	e8 0c 03 00 00       	call   80104fff <release>
80104cf3:	83 c4 10             	add    $0x10,%esp
80104cf6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104cfc:	8b 55 08             	mov    0x8(%ebp),%edx
80104cff:	89 50 20             	mov    %edx,0x20(%eax)
80104d02:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104d08:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
80104d0f:	e8 4e fe ff ff       	call   80104b62 <sched>
80104d14:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104d1a:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)
80104d21:	81 7d 0c 60 29 11 80 	cmpl   $0x80112960,0xc(%ebp)
80104d28:	74 1e                	je     80104d48 <sleep+0xa9>
80104d2a:	83 ec 0c             	sub    $0xc,%esp
80104d2d:	68 60 29 11 80       	push   $0x80112960
80104d32:	e8 c8 02 00 00       	call   80104fff <release>
80104d37:	83 c4 10             	add    $0x10,%esp
80104d3a:	83 ec 0c             	sub    $0xc,%esp
80104d3d:	ff 75 0c             	pushl  0xc(%ebp)
80104d40:	e8 53 02 00 00       	call   80104f98 <acquire>
80104d45:	83 c4 10             	add    $0x10,%esp
80104d48:	90                   	nop
80104d49:	c9                   	leave  
80104d4a:	c3                   	ret    

80104d4b <wakeup1>:
80104d4b:	55                   	push   %ebp
80104d4c:	89 e5                	mov    %esp,%ebp
80104d4e:	83 ec 10             	sub    $0x10,%esp
80104d51:	c7 45 fc 94 29 11 80 	movl   $0x80112994,-0x4(%ebp)
80104d58:	eb 24                	jmp    80104d7e <wakeup1+0x33>
80104d5a:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104d5d:	8b 40 0c             	mov    0xc(%eax),%eax
80104d60:	83 f8 02             	cmp    $0x2,%eax
80104d63:	75 15                	jne    80104d7a <wakeup1+0x2f>
80104d65:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104d68:	8b 40 20             	mov    0x20(%eax),%eax
80104d6b:	3b 45 08             	cmp    0x8(%ebp),%eax
80104d6e:	75 0a                	jne    80104d7a <wakeup1+0x2f>
80104d70:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104d73:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80104d7a:	83 45 fc 7c          	addl   $0x7c,-0x4(%ebp)
80104d7e:	81 7d fc 94 48 11 80 	cmpl   $0x80114894,-0x4(%ebp)
80104d85:	72 d3                	jb     80104d5a <wakeup1+0xf>
80104d87:	90                   	nop
80104d88:	c9                   	leave  
80104d89:	c3                   	ret    

80104d8a <wakeup>:
80104d8a:	55                   	push   %ebp
80104d8b:	89 e5                	mov    %esp,%ebp
80104d8d:	83 ec 08             	sub    $0x8,%esp
80104d90:	83 ec 0c             	sub    $0xc,%esp
80104d93:	68 60 29 11 80       	push   $0x80112960
80104d98:	e8 fb 01 00 00       	call   80104f98 <acquire>
80104d9d:	83 c4 10             	add    $0x10,%esp
80104da0:	83 ec 0c             	sub    $0xc,%esp
80104da3:	ff 75 08             	pushl  0x8(%ebp)
80104da6:	e8 a0 ff ff ff       	call   80104d4b <wakeup1>
80104dab:	83 c4 10             	add    $0x10,%esp
80104dae:	83 ec 0c             	sub    $0xc,%esp
80104db1:	68 60 29 11 80       	push   $0x80112960
80104db6:	e8 44 02 00 00       	call   80104fff <release>
80104dbb:	83 c4 10             	add    $0x10,%esp
80104dbe:	90                   	nop
80104dbf:	c9                   	leave  
80104dc0:	c3                   	ret    

80104dc1 <kill>:
80104dc1:	55                   	push   %ebp
80104dc2:	89 e5                	mov    %esp,%ebp
80104dc4:	83 ec 18             	sub    $0x18,%esp
80104dc7:	83 ec 0c             	sub    $0xc,%esp
80104dca:	68 60 29 11 80       	push   $0x80112960
80104dcf:	e8 c4 01 00 00       	call   80104f98 <acquire>
80104dd4:	83 c4 10             	add    $0x10,%esp
80104dd7:	c7 45 f4 94 29 11 80 	movl   $0x80112994,-0xc(%ebp)
80104dde:	eb 45                	jmp    80104e25 <kill+0x64>
80104de0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104de3:	8b 40 10             	mov    0x10(%eax),%eax
80104de6:	3b 45 08             	cmp    0x8(%ebp),%eax
80104de9:	75 36                	jne    80104e21 <kill+0x60>
80104deb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104dee:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80104df5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104df8:	8b 40 0c             	mov    0xc(%eax),%eax
80104dfb:	83 f8 02             	cmp    $0x2,%eax
80104dfe:	75 0a                	jne    80104e0a <kill+0x49>
80104e00:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104e03:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80104e0a:	83 ec 0c             	sub    $0xc,%esp
80104e0d:	68 60 29 11 80       	push   $0x80112960
80104e12:	e8 e8 01 00 00       	call   80104fff <release>
80104e17:	83 c4 10             	add    $0x10,%esp
80104e1a:	b8 00 00 00 00       	mov    $0x0,%eax
80104e1f:	eb 22                	jmp    80104e43 <kill+0x82>
80104e21:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
80104e25:	81 7d f4 94 48 11 80 	cmpl   $0x80114894,-0xc(%ebp)
80104e2c:	72 b2                	jb     80104de0 <kill+0x1f>
80104e2e:	83 ec 0c             	sub    $0xc,%esp
80104e31:	68 60 29 11 80       	push   $0x80112960
80104e36:	e8 c4 01 00 00       	call   80104fff <release>
80104e3b:	83 c4 10             	add    $0x10,%esp
80104e3e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104e43:	c9                   	leave  
80104e44:	c3                   	ret    

80104e45 <procdump>:
80104e45:	55                   	push   %ebp
80104e46:	89 e5                	mov    %esp,%ebp
80104e48:	83 ec 48             	sub    $0x48,%esp
80104e4b:	c7 45 f0 94 29 11 80 	movl   $0x80112994,-0x10(%ebp)
80104e52:	e9 d7 00 00 00       	jmp    80104f2e <procdump+0xe9>
80104e57:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104e5a:	8b 40 0c             	mov    0xc(%eax),%eax
80104e5d:	85 c0                	test   %eax,%eax
80104e5f:	0f 84 c4 00 00 00    	je     80104f29 <procdump+0xe4>
80104e65:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104e68:	8b 40 0c             	mov    0xc(%eax),%eax
80104e6b:	83 f8 05             	cmp    $0x5,%eax
80104e6e:	77 23                	ja     80104e93 <procdump+0x4e>
80104e70:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104e73:	8b 40 0c             	mov    0xc(%eax),%eax
80104e76:	8b 04 85 0c b0 10 80 	mov    -0x7fef4ff4(,%eax,4),%eax
80104e7d:	85 c0                	test   %eax,%eax
80104e7f:	74 12                	je     80104e93 <procdump+0x4e>
80104e81:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104e84:	8b 40 0c             	mov    0xc(%eax),%eax
80104e87:	8b 04 85 0c b0 10 80 	mov    -0x7fef4ff4(,%eax,4),%eax
80104e8e:	89 45 ec             	mov    %eax,-0x14(%ebp)
80104e91:	eb 07                	jmp    80104e9a <procdump+0x55>
80104e93:	c7 45 ec a0 88 10 80 	movl   $0x801088a0,-0x14(%ebp)
80104e9a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104e9d:	8d 50 6c             	lea    0x6c(%eax),%edx
80104ea0:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104ea3:	8b 40 10             	mov    0x10(%eax),%eax
80104ea6:	52                   	push   %edx
80104ea7:	ff 75 ec             	pushl  -0x14(%ebp)
80104eaa:	50                   	push   %eax
80104eab:	68 a4 88 10 80       	push   $0x801088a4
80104eb0:	e8 eb b4 ff ff       	call   801003a0 <cprintf>
80104eb5:	83 c4 10             	add    $0x10,%esp
80104eb8:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104ebb:	8b 40 0c             	mov    0xc(%eax),%eax
80104ebe:	83 f8 02             	cmp    $0x2,%eax
80104ec1:	75 54                	jne    80104f17 <procdump+0xd2>
80104ec3:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104ec6:	8b 40 1c             	mov    0x1c(%eax),%eax
80104ec9:	8b 40 0c             	mov    0xc(%eax),%eax
80104ecc:	83 c0 08             	add    $0x8,%eax
80104ecf:	89 c2                	mov    %eax,%edx
80104ed1:	83 ec 08             	sub    $0x8,%esp
80104ed4:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80104ed7:	50                   	push   %eax
80104ed8:	52                   	push   %edx
80104ed9:	e8 73 01 00 00       	call   80105051 <getcallerpcs>
80104ede:	83 c4 10             	add    $0x10,%esp
80104ee1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80104ee8:	eb 1c                	jmp    80104f06 <procdump+0xc1>
80104eea:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104eed:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
80104ef1:	83 ec 08             	sub    $0x8,%esp
80104ef4:	50                   	push   %eax
80104ef5:	68 ad 88 10 80       	push   $0x801088ad
80104efa:	e8 a1 b4 ff ff       	call   801003a0 <cprintf>
80104eff:	83 c4 10             	add    $0x10,%esp
80104f02:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80104f06:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
80104f0a:	7f 0b                	jg     80104f17 <procdump+0xd2>
80104f0c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104f0f:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
80104f13:	85 c0                	test   %eax,%eax
80104f15:	75 d3                	jne    80104eea <procdump+0xa5>
80104f17:	83 ec 0c             	sub    $0xc,%esp
80104f1a:	68 b1 88 10 80       	push   $0x801088b1
80104f1f:	e8 7c b4 ff ff       	call   801003a0 <cprintf>
80104f24:	83 c4 10             	add    $0x10,%esp
80104f27:	eb 01                	jmp    80104f2a <procdump+0xe5>
80104f29:	90                   	nop
80104f2a:	83 45 f0 7c          	addl   $0x7c,-0x10(%ebp)
80104f2e:	81 7d f0 94 48 11 80 	cmpl   $0x80114894,-0x10(%ebp)
80104f35:	0f 82 1c ff ff ff    	jb     80104e57 <procdump+0x12>
80104f3b:	90                   	nop
80104f3c:	c9                   	leave  
80104f3d:	c3                   	ret    

80104f3e <readeflags>:
80104f3e:	55                   	push   %ebp
80104f3f:	89 e5                	mov    %esp,%ebp
80104f41:	83 ec 10             	sub    $0x10,%esp
80104f44:	9c                   	pushf  
80104f45:	58                   	pop    %eax
80104f46:	89 45 fc             	mov    %eax,-0x4(%ebp)
80104f49:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104f4c:	c9                   	leave  
80104f4d:	c3                   	ret    

80104f4e <cli>:
80104f4e:	55                   	push   %ebp
80104f4f:	89 e5                	mov    %esp,%ebp
80104f51:	fa                   	cli    
80104f52:	90                   	nop
80104f53:	5d                   	pop    %ebp
80104f54:	c3                   	ret    

80104f55 <sti>:
80104f55:	55                   	push   %ebp
80104f56:	89 e5                	mov    %esp,%ebp
80104f58:	fb                   	sti    
80104f59:	90                   	nop
80104f5a:	5d                   	pop    %ebp
80104f5b:	c3                   	ret    

80104f5c <xchg>:
80104f5c:	55                   	push   %ebp
80104f5d:	89 e5                	mov    %esp,%ebp
80104f5f:	83 ec 10             	sub    $0x10,%esp
80104f62:	8b 55 08             	mov    0x8(%ebp),%edx
80104f65:	8b 45 0c             	mov    0xc(%ebp),%eax
80104f68:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104f6b:	f0 87 02             	lock xchg %eax,(%edx)
80104f6e:	89 45 fc             	mov    %eax,-0x4(%ebp)
80104f71:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104f74:	c9                   	leave  
80104f75:	c3                   	ret    

80104f76 <initlock>:
80104f76:	55                   	push   %ebp
80104f77:	89 e5                	mov    %esp,%ebp
80104f79:	8b 45 08             	mov    0x8(%ebp),%eax
80104f7c:	8b 55 0c             	mov    0xc(%ebp),%edx
80104f7f:	89 50 04             	mov    %edx,0x4(%eax)
80104f82:	8b 45 08             	mov    0x8(%ebp),%eax
80104f85:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104f8b:	8b 45 08             	mov    0x8(%ebp),%eax
80104f8e:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
80104f95:	90                   	nop
80104f96:	5d                   	pop    %ebp
80104f97:	c3                   	ret    

80104f98 <acquire>:
80104f98:	55                   	push   %ebp
80104f99:	89 e5                	mov    %esp,%ebp
80104f9b:	83 ec 08             	sub    $0x8,%esp
80104f9e:	e8 52 01 00 00       	call   801050f5 <pushcli>
80104fa3:	8b 45 08             	mov    0x8(%ebp),%eax
80104fa6:	83 ec 0c             	sub    $0xc,%esp
80104fa9:	50                   	push   %eax
80104faa:	e8 1c 01 00 00       	call   801050cb <holding>
80104faf:	83 c4 10             	add    $0x10,%esp
80104fb2:	85 c0                	test   %eax,%eax
80104fb4:	74 0d                	je     80104fc3 <acquire+0x2b>
80104fb6:	83 ec 0c             	sub    $0xc,%esp
80104fb9:	68 dd 88 10 80       	push   $0x801088dd
80104fbe:	e8 77 b5 ff ff       	call   8010053a <panic>
80104fc3:	90                   	nop
80104fc4:	8b 45 08             	mov    0x8(%ebp),%eax
80104fc7:	83 ec 08             	sub    $0x8,%esp
80104fca:	6a 01                	push   $0x1
80104fcc:	50                   	push   %eax
80104fcd:	e8 8a ff ff ff       	call   80104f5c <xchg>
80104fd2:	83 c4 10             	add    $0x10,%esp
80104fd5:	85 c0                	test   %eax,%eax
80104fd7:	75 eb                	jne    80104fc4 <acquire+0x2c>
80104fd9:	8b 45 08             	mov    0x8(%ebp),%eax
80104fdc:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104fe3:	89 50 08             	mov    %edx,0x8(%eax)
80104fe6:	8b 45 08             	mov    0x8(%ebp),%eax
80104fe9:	83 c0 0c             	add    $0xc,%eax
80104fec:	83 ec 08             	sub    $0x8,%esp
80104fef:	50                   	push   %eax
80104ff0:	8d 45 08             	lea    0x8(%ebp),%eax
80104ff3:	50                   	push   %eax
80104ff4:	e8 58 00 00 00       	call   80105051 <getcallerpcs>
80104ff9:	83 c4 10             	add    $0x10,%esp
80104ffc:	90                   	nop
80104ffd:	c9                   	leave  
80104ffe:	c3                   	ret    

80104fff <release>:
80104fff:	55                   	push   %ebp
80105000:	89 e5                	mov    %esp,%ebp
80105002:	83 ec 08             	sub    $0x8,%esp
80105005:	83 ec 0c             	sub    $0xc,%esp
80105008:	ff 75 08             	pushl  0x8(%ebp)
8010500b:	e8 bb 00 00 00       	call   801050cb <holding>
80105010:	83 c4 10             	add    $0x10,%esp
80105013:	85 c0                	test   %eax,%eax
80105015:	75 0d                	jne    80105024 <release+0x25>
80105017:	83 ec 0c             	sub    $0xc,%esp
8010501a:	68 e5 88 10 80       	push   $0x801088e5
8010501f:	e8 16 b5 ff ff       	call   8010053a <panic>
80105024:	8b 45 08             	mov    0x8(%ebp),%eax
80105027:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
8010502e:	8b 45 08             	mov    0x8(%ebp),%eax
80105031:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
80105038:	8b 45 08             	mov    0x8(%ebp),%eax
8010503b:	83 ec 08             	sub    $0x8,%esp
8010503e:	6a 00                	push   $0x0
80105040:	50                   	push   %eax
80105041:	e8 16 ff ff ff       	call   80104f5c <xchg>
80105046:	83 c4 10             	add    $0x10,%esp
80105049:	e8 ec 00 00 00       	call   8010513a <popcli>
8010504e:	90                   	nop
8010504f:	c9                   	leave  
80105050:	c3                   	ret    

80105051 <getcallerpcs>:
80105051:	55                   	push   %ebp
80105052:	89 e5                	mov    %esp,%ebp
80105054:	83 ec 10             	sub    $0x10,%esp
80105057:	8b 45 08             	mov    0x8(%ebp),%eax
8010505a:	83 e8 08             	sub    $0x8,%eax
8010505d:	89 45 fc             	mov    %eax,-0x4(%ebp)
80105060:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
80105067:	eb 38                	jmp    801050a1 <getcallerpcs+0x50>
80105069:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
8010506d:	74 53                	je     801050c2 <getcallerpcs+0x71>
8010506f:	81 7d fc ff ff ff 7f 	cmpl   $0x7fffffff,-0x4(%ebp)
80105076:	76 4a                	jbe    801050c2 <getcallerpcs+0x71>
80105078:	83 7d fc ff          	cmpl   $0xffffffff,-0x4(%ebp)
8010507c:	74 44                	je     801050c2 <getcallerpcs+0x71>
8010507e:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105081:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80105088:	8b 45 0c             	mov    0xc(%ebp),%eax
8010508b:	01 c2                	add    %eax,%edx
8010508d:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105090:	8b 40 04             	mov    0x4(%eax),%eax
80105093:	89 02                	mov    %eax,(%edx)
80105095:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105098:	8b 00                	mov    (%eax),%eax
8010509a:	89 45 fc             	mov    %eax,-0x4(%ebp)
8010509d:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
801050a1:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
801050a5:	7e c2                	jle    80105069 <getcallerpcs+0x18>
801050a7:	eb 19                	jmp    801050c2 <getcallerpcs+0x71>
801050a9:	8b 45 f8             	mov    -0x8(%ebp),%eax
801050ac:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
801050b3:	8b 45 0c             	mov    0xc(%ebp),%eax
801050b6:	01 d0                	add    %edx,%eax
801050b8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
801050be:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
801050c2:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
801050c6:	7e e1                	jle    801050a9 <getcallerpcs+0x58>
801050c8:	90                   	nop
801050c9:	c9                   	leave  
801050ca:	c3                   	ret    

801050cb <holding>:
801050cb:	55                   	push   %ebp
801050cc:	89 e5                	mov    %esp,%ebp
801050ce:	8b 45 08             	mov    0x8(%ebp),%eax
801050d1:	8b 00                	mov    (%eax),%eax
801050d3:	85 c0                	test   %eax,%eax
801050d5:	74 17                	je     801050ee <holding+0x23>
801050d7:	8b 45 08             	mov    0x8(%ebp),%eax
801050da:	8b 50 08             	mov    0x8(%eax),%edx
801050dd:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801050e3:	39 c2                	cmp    %eax,%edx
801050e5:	75 07                	jne    801050ee <holding+0x23>
801050e7:	b8 01 00 00 00       	mov    $0x1,%eax
801050ec:	eb 05                	jmp    801050f3 <holding+0x28>
801050ee:	b8 00 00 00 00       	mov    $0x0,%eax
801050f3:	5d                   	pop    %ebp
801050f4:	c3                   	ret    

801050f5 <pushcli>:
801050f5:	55                   	push   %ebp
801050f6:	89 e5                	mov    %esp,%ebp
801050f8:	83 ec 10             	sub    $0x10,%esp
801050fb:	e8 3e fe ff ff       	call   80104f3e <readeflags>
80105100:	89 45 fc             	mov    %eax,-0x4(%ebp)
80105103:	e8 46 fe ff ff       	call   80104f4e <cli>
80105108:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
8010510f:	8b 82 ac 00 00 00    	mov    0xac(%edx),%eax
80105115:	8d 48 01             	lea    0x1(%eax),%ecx
80105118:	89 8a ac 00 00 00    	mov    %ecx,0xac(%edx)
8010511e:	85 c0                	test   %eax,%eax
80105120:	75 15                	jne    80105137 <pushcli+0x42>
80105122:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105128:	8b 55 fc             	mov    -0x4(%ebp),%edx
8010512b:	81 e2 00 02 00 00    	and    $0x200,%edx
80105131:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
80105137:	90                   	nop
80105138:	c9                   	leave  
80105139:	c3                   	ret    

8010513a <popcli>:
8010513a:	55                   	push   %ebp
8010513b:	89 e5                	mov    %esp,%ebp
8010513d:	83 ec 08             	sub    $0x8,%esp
80105140:	e8 f9 fd ff ff       	call   80104f3e <readeflags>
80105145:	25 00 02 00 00       	and    $0x200,%eax
8010514a:	85 c0                	test   %eax,%eax
8010514c:	74 0d                	je     8010515b <popcli+0x21>
8010514e:	83 ec 0c             	sub    $0xc,%esp
80105151:	68 ed 88 10 80       	push   $0x801088ed
80105156:	e8 df b3 ff ff       	call   8010053a <panic>
8010515b:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105161:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
80105167:	83 ea 01             	sub    $0x1,%edx
8010516a:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
80105170:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80105176:	85 c0                	test   %eax,%eax
80105178:	79 0d                	jns    80105187 <popcli+0x4d>
8010517a:	83 ec 0c             	sub    $0xc,%esp
8010517d:	68 04 89 10 80       	push   $0x80108904
80105182:	e8 b3 b3 ff ff       	call   8010053a <panic>
80105187:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010518d:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80105193:	85 c0                	test   %eax,%eax
80105195:	75 15                	jne    801051ac <popcli+0x72>
80105197:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010519d:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
801051a3:	85 c0                	test   %eax,%eax
801051a5:	74 05                	je     801051ac <popcli+0x72>
801051a7:	e8 a9 fd ff ff       	call   80104f55 <sti>
801051ac:	90                   	nop
801051ad:	c9                   	leave  
801051ae:	c3                   	ret    

801051af <stosb>:
801051af:	55                   	push   %ebp
801051b0:	89 e5                	mov    %esp,%ebp
801051b2:	57                   	push   %edi
801051b3:	53                   	push   %ebx
801051b4:	8b 4d 08             	mov    0x8(%ebp),%ecx
801051b7:	8b 55 10             	mov    0x10(%ebp),%edx
801051ba:	8b 45 0c             	mov    0xc(%ebp),%eax
801051bd:	89 cb                	mov    %ecx,%ebx
801051bf:	89 df                	mov    %ebx,%edi
801051c1:	89 d1                	mov    %edx,%ecx
801051c3:	fc                   	cld    
801051c4:	f3 aa                	rep stos %al,%es:(%edi)
801051c6:	89 ca                	mov    %ecx,%edx
801051c8:	89 fb                	mov    %edi,%ebx
801051ca:	89 5d 08             	mov    %ebx,0x8(%ebp)
801051cd:	89 55 10             	mov    %edx,0x10(%ebp)
801051d0:	90                   	nop
801051d1:	5b                   	pop    %ebx
801051d2:	5f                   	pop    %edi
801051d3:	5d                   	pop    %ebp
801051d4:	c3                   	ret    

801051d5 <stosl>:
801051d5:	55                   	push   %ebp
801051d6:	89 e5                	mov    %esp,%ebp
801051d8:	57                   	push   %edi
801051d9:	53                   	push   %ebx
801051da:	8b 4d 08             	mov    0x8(%ebp),%ecx
801051dd:	8b 55 10             	mov    0x10(%ebp),%edx
801051e0:	8b 45 0c             	mov    0xc(%ebp),%eax
801051e3:	89 cb                	mov    %ecx,%ebx
801051e5:	89 df                	mov    %ebx,%edi
801051e7:	89 d1                	mov    %edx,%ecx
801051e9:	fc                   	cld    
801051ea:	f3 ab                	rep stos %eax,%es:(%edi)
801051ec:	89 ca                	mov    %ecx,%edx
801051ee:	89 fb                	mov    %edi,%ebx
801051f0:	89 5d 08             	mov    %ebx,0x8(%ebp)
801051f3:	89 55 10             	mov    %edx,0x10(%ebp)
801051f6:	90                   	nop
801051f7:	5b                   	pop    %ebx
801051f8:	5f                   	pop    %edi
801051f9:	5d                   	pop    %ebp
801051fa:	c3                   	ret    

801051fb <memset>:
801051fb:	55                   	push   %ebp
801051fc:	89 e5                	mov    %esp,%ebp
801051fe:	8b 45 08             	mov    0x8(%ebp),%eax
80105201:	83 e0 03             	and    $0x3,%eax
80105204:	85 c0                	test   %eax,%eax
80105206:	75 43                	jne    8010524b <memset+0x50>
80105208:	8b 45 10             	mov    0x10(%ebp),%eax
8010520b:	83 e0 03             	and    $0x3,%eax
8010520e:	85 c0                	test   %eax,%eax
80105210:	75 39                	jne    8010524b <memset+0x50>
80105212:	81 65 0c ff 00 00 00 	andl   $0xff,0xc(%ebp)
80105219:	8b 45 10             	mov    0x10(%ebp),%eax
8010521c:	c1 e8 02             	shr    $0x2,%eax
8010521f:	89 c1                	mov    %eax,%ecx
80105221:	8b 45 0c             	mov    0xc(%ebp),%eax
80105224:	c1 e0 18             	shl    $0x18,%eax
80105227:	89 c2                	mov    %eax,%edx
80105229:	8b 45 0c             	mov    0xc(%ebp),%eax
8010522c:	c1 e0 10             	shl    $0x10,%eax
8010522f:	09 c2                	or     %eax,%edx
80105231:	8b 45 0c             	mov    0xc(%ebp),%eax
80105234:	c1 e0 08             	shl    $0x8,%eax
80105237:	09 d0                	or     %edx,%eax
80105239:	0b 45 0c             	or     0xc(%ebp),%eax
8010523c:	51                   	push   %ecx
8010523d:	50                   	push   %eax
8010523e:	ff 75 08             	pushl  0x8(%ebp)
80105241:	e8 8f ff ff ff       	call   801051d5 <stosl>
80105246:	83 c4 0c             	add    $0xc,%esp
80105249:	eb 12                	jmp    8010525d <memset+0x62>
8010524b:	8b 45 10             	mov    0x10(%ebp),%eax
8010524e:	50                   	push   %eax
8010524f:	ff 75 0c             	pushl  0xc(%ebp)
80105252:	ff 75 08             	pushl  0x8(%ebp)
80105255:	e8 55 ff ff ff       	call   801051af <stosb>
8010525a:	83 c4 0c             	add    $0xc,%esp
8010525d:	8b 45 08             	mov    0x8(%ebp),%eax
80105260:	c9                   	leave  
80105261:	c3                   	ret    

80105262 <memcmp>:
80105262:	55                   	push   %ebp
80105263:	89 e5                	mov    %esp,%ebp
80105265:	83 ec 10             	sub    $0x10,%esp
80105268:	8b 45 08             	mov    0x8(%ebp),%eax
8010526b:	89 45 fc             	mov    %eax,-0x4(%ebp)
8010526e:	8b 45 0c             	mov    0xc(%ebp),%eax
80105271:	89 45 f8             	mov    %eax,-0x8(%ebp)
80105274:	eb 30                	jmp    801052a6 <memcmp+0x44>
80105276:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105279:	0f b6 10             	movzbl (%eax),%edx
8010527c:	8b 45 f8             	mov    -0x8(%ebp),%eax
8010527f:	0f b6 00             	movzbl (%eax),%eax
80105282:	38 c2                	cmp    %al,%dl
80105284:	74 18                	je     8010529e <memcmp+0x3c>
80105286:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105289:	0f b6 00             	movzbl (%eax),%eax
8010528c:	0f b6 d0             	movzbl %al,%edx
8010528f:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105292:	0f b6 00             	movzbl (%eax),%eax
80105295:	0f b6 c0             	movzbl %al,%eax
80105298:	29 c2                	sub    %eax,%edx
8010529a:	89 d0                	mov    %edx,%eax
8010529c:	eb 1a                	jmp    801052b8 <memcmp+0x56>
8010529e:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
801052a2:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
801052a6:	8b 45 10             	mov    0x10(%ebp),%eax
801052a9:	8d 50 ff             	lea    -0x1(%eax),%edx
801052ac:	89 55 10             	mov    %edx,0x10(%ebp)
801052af:	85 c0                	test   %eax,%eax
801052b1:	75 c3                	jne    80105276 <memcmp+0x14>
801052b3:	b8 00 00 00 00       	mov    $0x0,%eax
801052b8:	c9                   	leave  
801052b9:	c3                   	ret    

801052ba <memmove>:
801052ba:	55                   	push   %ebp
801052bb:	89 e5                	mov    %esp,%ebp
801052bd:	83 ec 10             	sub    $0x10,%esp
801052c0:	8b 45 0c             	mov    0xc(%ebp),%eax
801052c3:	89 45 fc             	mov    %eax,-0x4(%ebp)
801052c6:	8b 45 08             	mov    0x8(%ebp),%eax
801052c9:	89 45 f8             	mov    %eax,-0x8(%ebp)
801052cc:	8b 45 fc             	mov    -0x4(%ebp),%eax
801052cf:	3b 45 f8             	cmp    -0x8(%ebp),%eax
801052d2:	73 54                	jae    80105328 <memmove+0x6e>
801052d4:	8b 55 fc             	mov    -0x4(%ebp),%edx
801052d7:	8b 45 10             	mov    0x10(%ebp),%eax
801052da:	01 d0                	add    %edx,%eax
801052dc:	3b 45 f8             	cmp    -0x8(%ebp),%eax
801052df:	76 47                	jbe    80105328 <memmove+0x6e>
801052e1:	8b 45 10             	mov    0x10(%ebp),%eax
801052e4:	01 45 fc             	add    %eax,-0x4(%ebp)
801052e7:	8b 45 10             	mov    0x10(%ebp),%eax
801052ea:	01 45 f8             	add    %eax,-0x8(%ebp)
801052ed:	eb 13                	jmp    80105302 <memmove+0x48>
801052ef:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
801052f3:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
801052f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
801052fa:	0f b6 10             	movzbl (%eax),%edx
801052fd:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105300:	88 10                	mov    %dl,(%eax)
80105302:	8b 45 10             	mov    0x10(%ebp),%eax
80105305:	8d 50 ff             	lea    -0x1(%eax),%edx
80105308:	89 55 10             	mov    %edx,0x10(%ebp)
8010530b:	85 c0                	test   %eax,%eax
8010530d:	75 e0                	jne    801052ef <memmove+0x35>
8010530f:	eb 24                	jmp    80105335 <memmove+0x7b>
80105311:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105314:	8d 50 01             	lea    0x1(%eax),%edx
80105317:	89 55 f8             	mov    %edx,-0x8(%ebp)
8010531a:	8b 55 fc             	mov    -0x4(%ebp),%edx
8010531d:	8d 4a 01             	lea    0x1(%edx),%ecx
80105320:	89 4d fc             	mov    %ecx,-0x4(%ebp)
80105323:	0f b6 12             	movzbl (%edx),%edx
80105326:	88 10                	mov    %dl,(%eax)
80105328:	8b 45 10             	mov    0x10(%ebp),%eax
8010532b:	8d 50 ff             	lea    -0x1(%eax),%edx
8010532e:	89 55 10             	mov    %edx,0x10(%ebp)
80105331:	85 c0                	test   %eax,%eax
80105333:	75 dc                	jne    80105311 <memmove+0x57>
80105335:	8b 45 08             	mov    0x8(%ebp),%eax
80105338:	c9                   	leave  
80105339:	c3                   	ret    

8010533a <memcpy>:
8010533a:	55                   	push   %ebp
8010533b:	89 e5                	mov    %esp,%ebp
8010533d:	ff 75 10             	pushl  0x10(%ebp)
80105340:	ff 75 0c             	pushl  0xc(%ebp)
80105343:	ff 75 08             	pushl  0x8(%ebp)
80105346:	e8 6f ff ff ff       	call   801052ba <memmove>
8010534b:	83 c4 0c             	add    $0xc,%esp
8010534e:	c9                   	leave  
8010534f:	c3                   	ret    

80105350 <strncmp>:
80105350:	55                   	push   %ebp
80105351:	89 e5                	mov    %esp,%ebp
80105353:	eb 0c                	jmp    80105361 <strncmp+0x11>
80105355:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
80105359:	83 45 08 01          	addl   $0x1,0x8(%ebp)
8010535d:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
80105361:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105365:	74 1a                	je     80105381 <strncmp+0x31>
80105367:	8b 45 08             	mov    0x8(%ebp),%eax
8010536a:	0f b6 00             	movzbl (%eax),%eax
8010536d:	84 c0                	test   %al,%al
8010536f:	74 10                	je     80105381 <strncmp+0x31>
80105371:	8b 45 08             	mov    0x8(%ebp),%eax
80105374:	0f b6 10             	movzbl (%eax),%edx
80105377:	8b 45 0c             	mov    0xc(%ebp),%eax
8010537a:	0f b6 00             	movzbl (%eax),%eax
8010537d:	38 c2                	cmp    %al,%dl
8010537f:	74 d4                	je     80105355 <strncmp+0x5>
80105381:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105385:	75 07                	jne    8010538e <strncmp+0x3e>
80105387:	b8 00 00 00 00       	mov    $0x0,%eax
8010538c:	eb 16                	jmp    801053a4 <strncmp+0x54>
8010538e:	8b 45 08             	mov    0x8(%ebp),%eax
80105391:	0f b6 00             	movzbl (%eax),%eax
80105394:	0f b6 d0             	movzbl %al,%edx
80105397:	8b 45 0c             	mov    0xc(%ebp),%eax
8010539a:	0f b6 00             	movzbl (%eax),%eax
8010539d:	0f b6 c0             	movzbl %al,%eax
801053a0:	29 c2                	sub    %eax,%edx
801053a2:	89 d0                	mov    %edx,%eax
801053a4:	5d                   	pop    %ebp
801053a5:	c3                   	ret    

801053a6 <strncpy>:
801053a6:	55                   	push   %ebp
801053a7:	89 e5                	mov    %esp,%ebp
801053a9:	83 ec 10             	sub    $0x10,%esp
801053ac:	8b 45 08             	mov    0x8(%ebp),%eax
801053af:	89 45 fc             	mov    %eax,-0x4(%ebp)
801053b2:	90                   	nop
801053b3:	8b 45 10             	mov    0x10(%ebp),%eax
801053b6:	8d 50 ff             	lea    -0x1(%eax),%edx
801053b9:	89 55 10             	mov    %edx,0x10(%ebp)
801053bc:	85 c0                	test   %eax,%eax
801053be:	7e 2c                	jle    801053ec <strncpy+0x46>
801053c0:	8b 45 08             	mov    0x8(%ebp),%eax
801053c3:	8d 50 01             	lea    0x1(%eax),%edx
801053c6:	89 55 08             	mov    %edx,0x8(%ebp)
801053c9:	8b 55 0c             	mov    0xc(%ebp),%edx
801053cc:	8d 4a 01             	lea    0x1(%edx),%ecx
801053cf:	89 4d 0c             	mov    %ecx,0xc(%ebp)
801053d2:	0f b6 12             	movzbl (%edx),%edx
801053d5:	88 10                	mov    %dl,(%eax)
801053d7:	0f b6 00             	movzbl (%eax),%eax
801053da:	84 c0                	test   %al,%al
801053dc:	75 d5                	jne    801053b3 <strncpy+0xd>
801053de:	eb 0c                	jmp    801053ec <strncpy+0x46>
801053e0:	8b 45 08             	mov    0x8(%ebp),%eax
801053e3:	8d 50 01             	lea    0x1(%eax),%edx
801053e6:	89 55 08             	mov    %edx,0x8(%ebp)
801053e9:	c6 00 00             	movb   $0x0,(%eax)
801053ec:	8b 45 10             	mov    0x10(%ebp),%eax
801053ef:	8d 50 ff             	lea    -0x1(%eax),%edx
801053f2:	89 55 10             	mov    %edx,0x10(%ebp)
801053f5:	85 c0                	test   %eax,%eax
801053f7:	7f e7                	jg     801053e0 <strncpy+0x3a>
801053f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
801053fc:	c9                   	leave  
801053fd:	c3                   	ret    

801053fe <safestrcpy>:
801053fe:	55                   	push   %ebp
801053ff:	89 e5                	mov    %esp,%ebp
80105401:	83 ec 10             	sub    $0x10,%esp
80105404:	8b 45 08             	mov    0x8(%ebp),%eax
80105407:	89 45 fc             	mov    %eax,-0x4(%ebp)
8010540a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010540e:	7f 05                	jg     80105415 <safestrcpy+0x17>
80105410:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105413:	eb 31                	jmp    80105446 <safestrcpy+0x48>
80105415:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
80105419:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010541d:	7e 1e                	jle    8010543d <safestrcpy+0x3f>
8010541f:	8b 45 08             	mov    0x8(%ebp),%eax
80105422:	8d 50 01             	lea    0x1(%eax),%edx
80105425:	89 55 08             	mov    %edx,0x8(%ebp)
80105428:	8b 55 0c             	mov    0xc(%ebp),%edx
8010542b:	8d 4a 01             	lea    0x1(%edx),%ecx
8010542e:	89 4d 0c             	mov    %ecx,0xc(%ebp)
80105431:	0f b6 12             	movzbl (%edx),%edx
80105434:	88 10                	mov    %dl,(%eax)
80105436:	0f b6 00             	movzbl (%eax),%eax
80105439:	84 c0                	test   %al,%al
8010543b:	75 d8                	jne    80105415 <safestrcpy+0x17>
8010543d:	8b 45 08             	mov    0x8(%ebp),%eax
80105440:	c6 00 00             	movb   $0x0,(%eax)
80105443:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105446:	c9                   	leave  
80105447:	c3                   	ret    

80105448 <strlen>:
80105448:	55                   	push   %ebp
80105449:	89 e5                	mov    %esp,%ebp
8010544b:	83 ec 10             	sub    $0x10,%esp
8010544e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80105455:	eb 04                	jmp    8010545b <strlen+0x13>
80105457:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
8010545b:	8b 55 fc             	mov    -0x4(%ebp),%edx
8010545e:	8b 45 08             	mov    0x8(%ebp),%eax
80105461:	01 d0                	add    %edx,%eax
80105463:	0f b6 00             	movzbl (%eax),%eax
80105466:	84 c0                	test   %al,%al
80105468:	75 ed                	jne    80105457 <strlen+0xf>
8010546a:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010546d:	c9                   	leave  
8010546e:	c3                   	ret    

8010546f <swtch>:
8010546f:	8b 44 24 04          	mov    0x4(%esp),%eax
80105473:	8b 54 24 08          	mov    0x8(%esp),%edx
80105477:	55                   	push   %ebp
80105478:	53                   	push   %ebx
80105479:	56                   	push   %esi
8010547a:	57                   	push   %edi
8010547b:	89 20                	mov    %esp,(%eax)
8010547d:	89 d4                	mov    %edx,%esp
8010547f:	5f                   	pop    %edi
80105480:	5e                   	pop    %esi
80105481:	5b                   	pop    %ebx
80105482:	5d                   	pop    %ebp
80105483:	c3                   	ret    

80105484 <fetchint>:
80105484:	55                   	push   %ebp
80105485:	89 e5                	mov    %esp,%ebp
80105487:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010548d:	8b 00                	mov    (%eax),%eax
8010548f:	3b 45 08             	cmp    0x8(%ebp),%eax
80105492:	76 12                	jbe    801054a6 <fetchint+0x22>
80105494:	8b 45 08             	mov    0x8(%ebp),%eax
80105497:	8d 50 04             	lea    0x4(%eax),%edx
8010549a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801054a0:	8b 00                	mov    (%eax),%eax
801054a2:	39 c2                	cmp    %eax,%edx
801054a4:	76 07                	jbe    801054ad <fetchint+0x29>
801054a6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054ab:	eb 0f                	jmp    801054bc <fetchint+0x38>
801054ad:	8b 45 08             	mov    0x8(%ebp),%eax
801054b0:	8b 10                	mov    (%eax),%edx
801054b2:	8b 45 0c             	mov    0xc(%ebp),%eax
801054b5:	89 10                	mov    %edx,(%eax)
801054b7:	b8 00 00 00 00       	mov    $0x0,%eax
801054bc:	5d                   	pop    %ebp
801054bd:	c3                   	ret    

801054be <fetchstr>:
801054be:	55                   	push   %ebp
801054bf:	89 e5                	mov    %esp,%ebp
801054c1:	83 ec 10             	sub    $0x10,%esp
801054c4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801054ca:	8b 00                	mov    (%eax),%eax
801054cc:	3b 45 08             	cmp    0x8(%ebp),%eax
801054cf:	77 07                	ja     801054d8 <fetchstr+0x1a>
801054d1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054d6:	eb 46                	jmp    8010551e <fetchstr+0x60>
801054d8:	8b 55 08             	mov    0x8(%ebp),%edx
801054db:	8b 45 0c             	mov    0xc(%ebp),%eax
801054de:	89 10                	mov    %edx,(%eax)
801054e0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801054e6:	8b 00                	mov    (%eax),%eax
801054e8:	89 45 f8             	mov    %eax,-0x8(%ebp)
801054eb:	8b 45 0c             	mov    0xc(%ebp),%eax
801054ee:	8b 00                	mov    (%eax),%eax
801054f0:	89 45 fc             	mov    %eax,-0x4(%ebp)
801054f3:	eb 1c                	jmp    80105511 <fetchstr+0x53>
801054f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
801054f8:	0f b6 00             	movzbl (%eax),%eax
801054fb:	84 c0                	test   %al,%al
801054fd:	75 0e                	jne    8010550d <fetchstr+0x4f>
801054ff:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105502:	8b 45 0c             	mov    0xc(%ebp),%eax
80105505:	8b 00                	mov    (%eax),%eax
80105507:	29 c2                	sub    %eax,%edx
80105509:	89 d0                	mov    %edx,%eax
8010550b:	eb 11                	jmp    8010551e <fetchstr+0x60>
8010550d:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80105511:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105514:	3b 45 f8             	cmp    -0x8(%ebp),%eax
80105517:	72 dc                	jb     801054f5 <fetchstr+0x37>
80105519:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010551e:	c9                   	leave  
8010551f:	c3                   	ret    

80105520 <argint>:
80105520:	55                   	push   %ebp
80105521:	89 e5                	mov    %esp,%ebp
80105523:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105529:	8b 40 18             	mov    0x18(%eax),%eax
8010552c:	8b 40 44             	mov    0x44(%eax),%eax
8010552f:	8b 55 08             	mov    0x8(%ebp),%edx
80105532:	c1 e2 02             	shl    $0x2,%edx
80105535:	01 d0                	add    %edx,%eax
80105537:	83 c0 04             	add    $0x4,%eax
8010553a:	ff 75 0c             	pushl  0xc(%ebp)
8010553d:	50                   	push   %eax
8010553e:	e8 41 ff ff ff       	call   80105484 <fetchint>
80105543:	83 c4 08             	add    $0x8,%esp
80105546:	c9                   	leave  
80105547:	c3                   	ret    

80105548 <argptr>:
80105548:	55                   	push   %ebp
80105549:	89 e5                	mov    %esp,%ebp
8010554b:	83 ec 10             	sub    $0x10,%esp
8010554e:	8d 45 fc             	lea    -0x4(%ebp),%eax
80105551:	50                   	push   %eax
80105552:	ff 75 08             	pushl  0x8(%ebp)
80105555:	e8 c6 ff ff ff       	call   80105520 <argint>
8010555a:	83 c4 08             	add    $0x8,%esp
8010555d:	85 c0                	test   %eax,%eax
8010555f:	79 07                	jns    80105568 <argptr+0x20>
80105561:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105566:	eb 3b                	jmp    801055a3 <argptr+0x5b>
80105568:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010556e:	8b 00                	mov    (%eax),%eax
80105570:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105573:	39 d0                	cmp    %edx,%eax
80105575:	76 16                	jbe    8010558d <argptr+0x45>
80105577:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010557a:	89 c2                	mov    %eax,%edx
8010557c:	8b 45 10             	mov    0x10(%ebp),%eax
8010557f:	01 c2                	add    %eax,%edx
80105581:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105587:	8b 00                	mov    (%eax),%eax
80105589:	39 c2                	cmp    %eax,%edx
8010558b:	76 07                	jbe    80105594 <argptr+0x4c>
8010558d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105592:	eb 0f                	jmp    801055a3 <argptr+0x5b>
80105594:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105597:	89 c2                	mov    %eax,%edx
80105599:	8b 45 0c             	mov    0xc(%ebp),%eax
8010559c:	89 10                	mov    %edx,(%eax)
8010559e:	b8 00 00 00 00       	mov    $0x0,%eax
801055a3:	c9                   	leave  
801055a4:	c3                   	ret    

801055a5 <argstr>:
801055a5:	55                   	push   %ebp
801055a6:	89 e5                	mov    %esp,%ebp
801055a8:	83 ec 10             	sub    $0x10,%esp
801055ab:	8d 45 fc             	lea    -0x4(%ebp),%eax
801055ae:	50                   	push   %eax
801055af:	ff 75 08             	pushl  0x8(%ebp)
801055b2:	e8 69 ff ff ff       	call   80105520 <argint>
801055b7:	83 c4 08             	add    $0x8,%esp
801055ba:	85 c0                	test   %eax,%eax
801055bc:	79 07                	jns    801055c5 <argstr+0x20>
801055be:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801055c3:	eb 0f                	jmp    801055d4 <argstr+0x2f>
801055c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
801055c8:	ff 75 0c             	pushl  0xc(%ebp)
801055cb:	50                   	push   %eax
801055cc:	e8 ed fe ff ff       	call   801054be <fetchstr>
801055d1:	83 c4 08             	add    $0x8,%esp
801055d4:	c9                   	leave  
801055d5:	c3                   	ret    

801055d6 <syscall>:
801055d6:	55                   	push   %ebp
801055d7:	89 e5                	mov    %esp,%ebp
801055d9:	53                   	push   %ebx
801055da:	83 ec 14             	sub    $0x14,%esp
801055dd:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801055e3:	8b 40 18             	mov    0x18(%eax),%eax
801055e6:	8b 40 1c             	mov    0x1c(%eax),%eax
801055e9:	89 45 f4             	mov    %eax,-0xc(%ebp)
801055ec:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801055f0:	7e 30                	jle    80105622 <syscall+0x4c>
801055f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801055f5:	83 f8 15             	cmp    $0x15,%eax
801055f8:	77 28                	ja     80105622 <syscall+0x4c>
801055fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
801055fd:	8b 04 85 40 b0 10 80 	mov    -0x7fef4fc0(,%eax,4),%eax
80105604:	85 c0                	test   %eax,%eax
80105606:	74 1a                	je     80105622 <syscall+0x4c>
80105608:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010560e:	8b 58 18             	mov    0x18(%eax),%ebx
80105611:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105614:	8b 04 85 40 b0 10 80 	mov    -0x7fef4fc0(,%eax,4),%eax
8010561b:	ff d0                	call   *%eax
8010561d:	89 43 1c             	mov    %eax,0x1c(%ebx)
80105620:	eb 34                	jmp    80105656 <syscall+0x80>
80105622:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105628:	8d 50 6c             	lea    0x6c(%eax),%edx
8010562b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105631:	8b 40 10             	mov    0x10(%eax),%eax
80105634:	ff 75 f4             	pushl  -0xc(%ebp)
80105637:	52                   	push   %edx
80105638:	50                   	push   %eax
80105639:	68 0b 89 10 80       	push   $0x8010890b
8010563e:	e8 5d ad ff ff       	call   801003a0 <cprintf>
80105643:	83 c4 10             	add    $0x10,%esp
80105646:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010564c:	8b 40 18             	mov    0x18(%eax),%eax
8010564f:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
80105656:	90                   	nop
80105657:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010565a:	c9                   	leave  
8010565b:	c3                   	ret    

8010565c <argfd>:
8010565c:	55                   	push   %ebp
8010565d:	89 e5                	mov    %esp,%ebp
8010565f:	83 ec 18             	sub    $0x18,%esp
80105662:	83 ec 08             	sub    $0x8,%esp
80105665:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105668:	50                   	push   %eax
80105669:	ff 75 08             	pushl  0x8(%ebp)
8010566c:	e8 af fe ff ff       	call   80105520 <argint>
80105671:	83 c4 10             	add    $0x10,%esp
80105674:	85 c0                	test   %eax,%eax
80105676:	79 07                	jns    8010567f <argfd+0x23>
80105678:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010567d:	eb 50                	jmp    801056cf <argfd+0x73>
8010567f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105682:	85 c0                	test   %eax,%eax
80105684:	78 21                	js     801056a7 <argfd+0x4b>
80105686:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105689:	83 f8 0f             	cmp    $0xf,%eax
8010568c:	7f 19                	jg     801056a7 <argfd+0x4b>
8010568e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105694:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105697:	83 c2 08             	add    $0x8,%edx
8010569a:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
8010569e:	89 45 f4             	mov    %eax,-0xc(%ebp)
801056a1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801056a5:	75 07                	jne    801056ae <argfd+0x52>
801056a7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056ac:	eb 21                	jmp    801056cf <argfd+0x73>
801056ae:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
801056b2:	74 08                	je     801056bc <argfd+0x60>
801056b4:	8b 55 f0             	mov    -0x10(%ebp),%edx
801056b7:	8b 45 0c             	mov    0xc(%ebp),%eax
801056ba:	89 10                	mov    %edx,(%eax)
801056bc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801056c0:	74 08                	je     801056ca <argfd+0x6e>
801056c2:	8b 45 10             	mov    0x10(%ebp),%eax
801056c5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801056c8:	89 10                	mov    %edx,(%eax)
801056ca:	b8 00 00 00 00       	mov    $0x0,%eax
801056cf:	c9                   	leave  
801056d0:	c3                   	ret    

801056d1 <fdalloc>:
801056d1:	55                   	push   %ebp
801056d2:	89 e5                	mov    %esp,%ebp
801056d4:	83 ec 10             	sub    $0x10,%esp
801056d7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
801056de:	eb 30                	jmp    80105710 <fdalloc+0x3f>
801056e0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801056e6:	8b 55 fc             	mov    -0x4(%ebp),%edx
801056e9:	83 c2 08             	add    $0x8,%edx
801056ec:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801056f0:	85 c0                	test   %eax,%eax
801056f2:	75 18                	jne    8010570c <fdalloc+0x3b>
801056f4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801056fa:	8b 55 fc             	mov    -0x4(%ebp),%edx
801056fd:	8d 4a 08             	lea    0x8(%edx),%ecx
80105700:	8b 55 08             	mov    0x8(%ebp),%edx
80105703:	89 54 88 08          	mov    %edx,0x8(%eax,%ecx,4)
80105707:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010570a:	eb 0f                	jmp    8010571b <fdalloc+0x4a>
8010570c:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80105710:	83 7d fc 0f          	cmpl   $0xf,-0x4(%ebp)
80105714:	7e ca                	jle    801056e0 <fdalloc+0xf>
80105716:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010571b:	c9                   	leave  
8010571c:	c3                   	ret    

8010571d <sys_dup>:
8010571d:	55                   	push   %ebp
8010571e:	89 e5                	mov    %esp,%ebp
80105720:	83 ec 18             	sub    $0x18,%esp
80105723:	83 ec 04             	sub    $0x4,%esp
80105726:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105729:	50                   	push   %eax
8010572a:	6a 00                	push   $0x0
8010572c:	6a 00                	push   $0x0
8010572e:	e8 29 ff ff ff       	call   8010565c <argfd>
80105733:	83 c4 10             	add    $0x10,%esp
80105736:	85 c0                	test   %eax,%eax
80105738:	79 07                	jns    80105741 <sys_dup+0x24>
8010573a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010573f:	eb 31                	jmp    80105772 <sys_dup+0x55>
80105741:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105744:	83 ec 0c             	sub    $0xc,%esp
80105747:	50                   	push   %eax
80105748:	e8 84 ff ff ff       	call   801056d1 <fdalloc>
8010574d:	83 c4 10             	add    $0x10,%esp
80105750:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105753:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105757:	79 07                	jns    80105760 <sys_dup+0x43>
80105759:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010575e:	eb 12                	jmp    80105772 <sys_dup+0x55>
80105760:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105763:	83 ec 0c             	sub    $0xc,%esp
80105766:	50                   	push   %eax
80105767:	e8 2d b8 ff ff       	call   80100f99 <filedup>
8010576c:	83 c4 10             	add    $0x10,%esp
8010576f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105772:	c9                   	leave  
80105773:	c3                   	ret    

80105774 <sys_read>:
80105774:	55                   	push   %ebp
80105775:	89 e5                	mov    %esp,%ebp
80105777:	83 ec 18             	sub    $0x18,%esp
8010577a:	83 ec 04             	sub    $0x4,%esp
8010577d:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105780:	50                   	push   %eax
80105781:	6a 00                	push   $0x0
80105783:	6a 00                	push   $0x0
80105785:	e8 d2 fe ff ff       	call   8010565c <argfd>
8010578a:	83 c4 10             	add    $0x10,%esp
8010578d:	85 c0                	test   %eax,%eax
8010578f:	78 2e                	js     801057bf <sys_read+0x4b>
80105791:	83 ec 08             	sub    $0x8,%esp
80105794:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105797:	50                   	push   %eax
80105798:	6a 02                	push   $0x2
8010579a:	e8 81 fd ff ff       	call   80105520 <argint>
8010579f:	83 c4 10             	add    $0x10,%esp
801057a2:	85 c0                	test   %eax,%eax
801057a4:	78 19                	js     801057bf <sys_read+0x4b>
801057a6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801057a9:	83 ec 04             	sub    $0x4,%esp
801057ac:	50                   	push   %eax
801057ad:	8d 45 ec             	lea    -0x14(%ebp),%eax
801057b0:	50                   	push   %eax
801057b1:	6a 01                	push   $0x1
801057b3:	e8 90 fd ff ff       	call   80105548 <argptr>
801057b8:	83 c4 10             	add    $0x10,%esp
801057bb:	85 c0                	test   %eax,%eax
801057bd:	79 07                	jns    801057c6 <sys_read+0x52>
801057bf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057c4:	eb 17                	jmp    801057dd <sys_read+0x69>
801057c6:	8b 4d f0             	mov    -0x10(%ebp),%ecx
801057c9:	8b 55 ec             	mov    -0x14(%ebp),%edx
801057cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801057cf:	83 ec 04             	sub    $0x4,%esp
801057d2:	51                   	push   %ecx
801057d3:	52                   	push   %edx
801057d4:	50                   	push   %eax
801057d5:	e8 4f b9 ff ff       	call   80101129 <fileread>
801057da:	83 c4 10             	add    $0x10,%esp
801057dd:	c9                   	leave  
801057de:	c3                   	ret    

801057df <sys_write>:
801057df:	55                   	push   %ebp
801057e0:	89 e5                	mov    %esp,%ebp
801057e2:	83 ec 18             	sub    $0x18,%esp
801057e5:	83 ec 04             	sub    $0x4,%esp
801057e8:	8d 45 f4             	lea    -0xc(%ebp),%eax
801057eb:	50                   	push   %eax
801057ec:	6a 00                	push   $0x0
801057ee:	6a 00                	push   $0x0
801057f0:	e8 67 fe ff ff       	call   8010565c <argfd>
801057f5:	83 c4 10             	add    $0x10,%esp
801057f8:	85 c0                	test   %eax,%eax
801057fa:	78 2e                	js     8010582a <sys_write+0x4b>
801057fc:	83 ec 08             	sub    $0x8,%esp
801057ff:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105802:	50                   	push   %eax
80105803:	6a 02                	push   $0x2
80105805:	e8 16 fd ff ff       	call   80105520 <argint>
8010580a:	83 c4 10             	add    $0x10,%esp
8010580d:	85 c0                	test   %eax,%eax
8010580f:	78 19                	js     8010582a <sys_write+0x4b>
80105811:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105814:	83 ec 04             	sub    $0x4,%esp
80105817:	50                   	push   %eax
80105818:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010581b:	50                   	push   %eax
8010581c:	6a 01                	push   $0x1
8010581e:	e8 25 fd ff ff       	call   80105548 <argptr>
80105823:	83 c4 10             	add    $0x10,%esp
80105826:	85 c0                	test   %eax,%eax
80105828:	79 07                	jns    80105831 <sys_write+0x52>
8010582a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010582f:	eb 17                	jmp    80105848 <sys_write+0x69>
80105831:	8b 4d f0             	mov    -0x10(%ebp),%ecx
80105834:	8b 55 ec             	mov    -0x14(%ebp),%edx
80105837:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010583a:	83 ec 04             	sub    $0x4,%esp
8010583d:	51                   	push   %ecx
8010583e:	52                   	push   %edx
8010583f:	50                   	push   %eax
80105840:	e8 9c b9 ff ff       	call   801011e1 <filewrite>
80105845:	83 c4 10             	add    $0x10,%esp
80105848:	c9                   	leave  
80105849:	c3                   	ret    

8010584a <sys_close>:
8010584a:	55                   	push   %ebp
8010584b:	89 e5                	mov    %esp,%ebp
8010584d:	83 ec 18             	sub    $0x18,%esp
80105850:	83 ec 04             	sub    $0x4,%esp
80105853:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105856:	50                   	push   %eax
80105857:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010585a:	50                   	push   %eax
8010585b:	6a 00                	push   $0x0
8010585d:	e8 fa fd ff ff       	call   8010565c <argfd>
80105862:	83 c4 10             	add    $0x10,%esp
80105865:	85 c0                	test   %eax,%eax
80105867:	79 07                	jns    80105870 <sys_close+0x26>
80105869:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010586e:	eb 28                	jmp    80105898 <sys_close+0x4e>
80105870:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105876:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105879:	83 c2 08             	add    $0x8,%edx
8010587c:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
80105883:	00 
80105884:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105887:	83 ec 0c             	sub    $0xc,%esp
8010588a:	50                   	push   %eax
8010588b:	e8 5a b7 ff ff       	call   80100fea <fileclose>
80105890:	83 c4 10             	add    $0x10,%esp
80105893:	b8 00 00 00 00       	mov    $0x0,%eax
80105898:	c9                   	leave  
80105899:	c3                   	ret    

8010589a <sys_fstat>:
8010589a:	55                   	push   %ebp
8010589b:	89 e5                	mov    %esp,%ebp
8010589d:	83 ec 18             	sub    $0x18,%esp
801058a0:	83 ec 04             	sub    $0x4,%esp
801058a3:	8d 45 f4             	lea    -0xc(%ebp),%eax
801058a6:	50                   	push   %eax
801058a7:	6a 00                	push   $0x0
801058a9:	6a 00                	push   $0x0
801058ab:	e8 ac fd ff ff       	call   8010565c <argfd>
801058b0:	83 c4 10             	add    $0x10,%esp
801058b3:	85 c0                	test   %eax,%eax
801058b5:	78 17                	js     801058ce <sys_fstat+0x34>
801058b7:	83 ec 04             	sub    $0x4,%esp
801058ba:	6a 14                	push   $0x14
801058bc:	8d 45 f0             	lea    -0x10(%ebp),%eax
801058bf:	50                   	push   %eax
801058c0:	6a 01                	push   $0x1
801058c2:	e8 81 fc ff ff       	call   80105548 <argptr>
801058c7:	83 c4 10             	add    $0x10,%esp
801058ca:	85 c0                	test   %eax,%eax
801058cc:	79 07                	jns    801058d5 <sys_fstat+0x3b>
801058ce:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058d3:	eb 13                	jmp    801058e8 <sys_fstat+0x4e>
801058d5:	8b 55 f0             	mov    -0x10(%ebp),%edx
801058d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801058db:	83 ec 08             	sub    $0x8,%esp
801058de:	52                   	push   %edx
801058df:	50                   	push   %eax
801058e0:	e8 ed b7 ff ff       	call   801010d2 <filestat>
801058e5:	83 c4 10             	add    $0x10,%esp
801058e8:	c9                   	leave  
801058e9:	c3                   	ret    

801058ea <sys_link>:
801058ea:	55                   	push   %ebp
801058eb:	89 e5                	mov    %esp,%ebp
801058ed:	83 ec 28             	sub    $0x28,%esp
801058f0:	83 ec 08             	sub    $0x8,%esp
801058f3:	8d 45 d8             	lea    -0x28(%ebp),%eax
801058f6:	50                   	push   %eax
801058f7:	6a 00                	push   $0x0
801058f9:	e8 a7 fc ff ff       	call   801055a5 <argstr>
801058fe:	83 c4 10             	add    $0x10,%esp
80105901:	85 c0                	test   %eax,%eax
80105903:	78 15                	js     8010591a <sys_link+0x30>
80105905:	83 ec 08             	sub    $0x8,%esp
80105908:	8d 45 dc             	lea    -0x24(%ebp),%eax
8010590b:	50                   	push   %eax
8010590c:	6a 01                	push   $0x1
8010590e:	e8 92 fc ff ff       	call   801055a5 <argstr>
80105913:	83 c4 10             	add    $0x10,%esp
80105916:	85 c0                	test   %eax,%eax
80105918:	79 0a                	jns    80105924 <sys_link+0x3a>
8010591a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010591f:	e9 68 01 00 00       	jmp    80105a8c <sys_link+0x1a2>
80105924:	e8 bd db ff ff       	call   801034e6 <begin_op>
80105929:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010592c:	83 ec 0c             	sub    $0xc,%esp
8010592f:	50                   	push   %eax
80105930:	e8 8c cb ff ff       	call   801024c1 <namei>
80105935:	83 c4 10             	add    $0x10,%esp
80105938:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010593b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010593f:	75 0f                	jne    80105950 <sys_link+0x66>
80105941:	e8 2c dc ff ff       	call   80103572 <end_op>
80105946:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010594b:	e9 3c 01 00 00       	jmp    80105a8c <sys_link+0x1a2>
80105950:	83 ec 0c             	sub    $0xc,%esp
80105953:	ff 75 f4             	pushl  -0xc(%ebp)
80105956:	e8 a8 bf ff ff       	call   80101903 <ilock>
8010595b:	83 c4 10             	add    $0x10,%esp
8010595e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105961:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105965:	66 83 f8 01          	cmp    $0x1,%ax
80105969:	75 1d                	jne    80105988 <sys_link+0x9e>
8010596b:	83 ec 0c             	sub    $0xc,%esp
8010596e:	ff 75 f4             	pushl  -0xc(%ebp)
80105971:	e8 4d c2 ff ff       	call   80101bc3 <iunlockput>
80105976:	83 c4 10             	add    $0x10,%esp
80105979:	e8 f4 db ff ff       	call   80103572 <end_op>
8010597e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105983:	e9 04 01 00 00       	jmp    80105a8c <sys_link+0x1a2>
80105988:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010598b:	0f b7 40 16          	movzwl 0x16(%eax),%eax
8010598f:	83 c0 01             	add    $0x1,%eax
80105992:	89 c2                	mov    %eax,%edx
80105994:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105997:	66 89 50 16          	mov    %dx,0x16(%eax)
8010599b:	83 ec 0c             	sub    $0xc,%esp
8010599e:	ff 75 f4             	pushl  -0xc(%ebp)
801059a1:	e8 83 bd ff ff       	call   80101729 <iupdate>
801059a6:	83 c4 10             	add    $0x10,%esp
801059a9:	83 ec 0c             	sub    $0xc,%esp
801059ac:	ff 75 f4             	pushl  -0xc(%ebp)
801059af:	e8 ad c0 ff ff       	call   80101a61 <iunlock>
801059b4:	83 c4 10             	add    $0x10,%esp
801059b7:	8b 45 dc             	mov    -0x24(%ebp),%eax
801059ba:	83 ec 08             	sub    $0x8,%esp
801059bd:	8d 55 e2             	lea    -0x1e(%ebp),%edx
801059c0:	52                   	push   %edx
801059c1:	50                   	push   %eax
801059c2:	e8 16 cb ff ff       	call   801024dd <nameiparent>
801059c7:	83 c4 10             	add    $0x10,%esp
801059ca:	89 45 f0             	mov    %eax,-0x10(%ebp)
801059cd:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801059d1:	74 71                	je     80105a44 <sys_link+0x15a>
801059d3:	83 ec 0c             	sub    $0xc,%esp
801059d6:	ff 75 f0             	pushl  -0x10(%ebp)
801059d9:	e8 25 bf ff ff       	call   80101903 <ilock>
801059de:	83 c4 10             	add    $0x10,%esp
801059e1:	8b 45 f0             	mov    -0x10(%ebp),%eax
801059e4:	8b 10                	mov    (%eax),%edx
801059e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801059e9:	8b 00                	mov    (%eax),%eax
801059eb:	39 c2                	cmp    %eax,%edx
801059ed:	75 1d                	jne    80105a0c <sys_link+0x122>
801059ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
801059f2:	8b 40 04             	mov    0x4(%eax),%eax
801059f5:	83 ec 04             	sub    $0x4,%esp
801059f8:	50                   	push   %eax
801059f9:	8d 45 e2             	lea    -0x1e(%ebp),%eax
801059fc:	50                   	push   %eax
801059fd:	ff 75 f0             	pushl  -0x10(%ebp)
80105a00:	e8 20 c8 ff ff       	call   80102225 <dirlink>
80105a05:	83 c4 10             	add    $0x10,%esp
80105a08:	85 c0                	test   %eax,%eax
80105a0a:	79 10                	jns    80105a1c <sys_link+0x132>
80105a0c:	83 ec 0c             	sub    $0xc,%esp
80105a0f:	ff 75 f0             	pushl  -0x10(%ebp)
80105a12:	e8 ac c1 ff ff       	call   80101bc3 <iunlockput>
80105a17:	83 c4 10             	add    $0x10,%esp
80105a1a:	eb 29                	jmp    80105a45 <sys_link+0x15b>
80105a1c:	83 ec 0c             	sub    $0xc,%esp
80105a1f:	ff 75 f0             	pushl  -0x10(%ebp)
80105a22:	e8 9c c1 ff ff       	call   80101bc3 <iunlockput>
80105a27:	83 c4 10             	add    $0x10,%esp
80105a2a:	83 ec 0c             	sub    $0xc,%esp
80105a2d:	ff 75 f4             	pushl  -0xc(%ebp)
80105a30:	e8 9e c0 ff ff       	call   80101ad3 <iput>
80105a35:	83 c4 10             	add    $0x10,%esp
80105a38:	e8 35 db ff ff       	call   80103572 <end_op>
80105a3d:	b8 00 00 00 00       	mov    $0x0,%eax
80105a42:	eb 48                	jmp    80105a8c <sys_link+0x1a2>
80105a44:	90                   	nop
80105a45:	83 ec 0c             	sub    $0xc,%esp
80105a48:	ff 75 f4             	pushl  -0xc(%ebp)
80105a4b:	e8 b3 be ff ff       	call   80101903 <ilock>
80105a50:	83 c4 10             	add    $0x10,%esp
80105a53:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a56:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105a5a:	83 e8 01             	sub    $0x1,%eax
80105a5d:	89 c2                	mov    %eax,%edx
80105a5f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a62:	66 89 50 16          	mov    %dx,0x16(%eax)
80105a66:	83 ec 0c             	sub    $0xc,%esp
80105a69:	ff 75 f4             	pushl  -0xc(%ebp)
80105a6c:	e8 b8 bc ff ff       	call   80101729 <iupdate>
80105a71:	83 c4 10             	add    $0x10,%esp
80105a74:	83 ec 0c             	sub    $0xc,%esp
80105a77:	ff 75 f4             	pushl  -0xc(%ebp)
80105a7a:	e8 44 c1 ff ff       	call   80101bc3 <iunlockput>
80105a7f:	83 c4 10             	add    $0x10,%esp
80105a82:	e8 eb da ff ff       	call   80103572 <end_op>
80105a87:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a8c:	c9                   	leave  
80105a8d:	c3                   	ret    

80105a8e <isdirempty>:
80105a8e:	55                   	push   %ebp
80105a8f:	89 e5                	mov    %esp,%ebp
80105a91:	83 ec 28             	sub    $0x28,%esp
80105a94:	c7 45 f4 20 00 00 00 	movl   $0x20,-0xc(%ebp)
80105a9b:	eb 40                	jmp    80105add <isdirempty+0x4f>
80105a9d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105aa0:	6a 10                	push   $0x10
80105aa2:	50                   	push   %eax
80105aa3:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105aa6:	50                   	push   %eax
80105aa7:	ff 75 08             	pushl  0x8(%ebp)
80105aaa:	e8 c2 c3 ff ff       	call   80101e71 <readi>
80105aaf:	83 c4 10             	add    $0x10,%esp
80105ab2:	83 f8 10             	cmp    $0x10,%eax
80105ab5:	74 0d                	je     80105ac4 <isdirempty+0x36>
80105ab7:	83 ec 0c             	sub    $0xc,%esp
80105aba:	68 27 89 10 80       	push   $0x80108927
80105abf:	e8 76 aa ff ff       	call   8010053a <panic>
80105ac4:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80105ac8:	66 85 c0             	test   %ax,%ax
80105acb:	74 07                	je     80105ad4 <isdirempty+0x46>
80105acd:	b8 00 00 00 00       	mov    $0x0,%eax
80105ad2:	eb 1b                	jmp    80105aef <isdirempty+0x61>
80105ad4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ad7:	83 c0 10             	add    $0x10,%eax
80105ada:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105add:	8b 45 08             	mov    0x8(%ebp),%eax
80105ae0:	8b 50 18             	mov    0x18(%eax),%edx
80105ae3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ae6:	39 c2                	cmp    %eax,%edx
80105ae8:	77 b3                	ja     80105a9d <isdirempty+0xf>
80105aea:	b8 01 00 00 00       	mov    $0x1,%eax
80105aef:	c9                   	leave  
80105af0:	c3                   	ret    

80105af1 <sys_unlink>:
80105af1:	55                   	push   %ebp
80105af2:	89 e5                	mov    %esp,%ebp
80105af4:	83 ec 38             	sub    $0x38,%esp
80105af7:	83 ec 08             	sub    $0x8,%esp
80105afa:	8d 45 cc             	lea    -0x34(%ebp),%eax
80105afd:	50                   	push   %eax
80105afe:	6a 00                	push   $0x0
80105b00:	e8 a0 fa ff ff       	call   801055a5 <argstr>
80105b05:	83 c4 10             	add    $0x10,%esp
80105b08:	85 c0                	test   %eax,%eax
80105b0a:	79 0a                	jns    80105b16 <sys_unlink+0x25>
80105b0c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b11:	e9 bc 01 00 00       	jmp    80105cd2 <sys_unlink+0x1e1>
80105b16:	e8 cb d9 ff ff       	call   801034e6 <begin_op>
80105b1b:	8b 45 cc             	mov    -0x34(%ebp),%eax
80105b1e:	83 ec 08             	sub    $0x8,%esp
80105b21:	8d 55 d2             	lea    -0x2e(%ebp),%edx
80105b24:	52                   	push   %edx
80105b25:	50                   	push   %eax
80105b26:	e8 b2 c9 ff ff       	call   801024dd <nameiparent>
80105b2b:	83 c4 10             	add    $0x10,%esp
80105b2e:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105b31:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105b35:	75 0f                	jne    80105b46 <sys_unlink+0x55>
80105b37:	e8 36 da ff ff       	call   80103572 <end_op>
80105b3c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b41:	e9 8c 01 00 00       	jmp    80105cd2 <sys_unlink+0x1e1>
80105b46:	83 ec 0c             	sub    $0xc,%esp
80105b49:	ff 75 f4             	pushl  -0xc(%ebp)
80105b4c:	e8 b2 bd ff ff       	call   80101903 <ilock>
80105b51:	83 c4 10             	add    $0x10,%esp
80105b54:	83 ec 08             	sub    $0x8,%esp
80105b57:	68 39 89 10 80       	push   $0x80108939
80105b5c:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105b5f:	50                   	push   %eax
80105b60:	e8 eb c5 ff ff       	call   80102150 <namecmp>
80105b65:	83 c4 10             	add    $0x10,%esp
80105b68:	85 c0                	test   %eax,%eax
80105b6a:	0f 84 4a 01 00 00    	je     80105cba <sys_unlink+0x1c9>
80105b70:	83 ec 08             	sub    $0x8,%esp
80105b73:	68 3b 89 10 80       	push   $0x8010893b
80105b78:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105b7b:	50                   	push   %eax
80105b7c:	e8 cf c5 ff ff       	call   80102150 <namecmp>
80105b81:	83 c4 10             	add    $0x10,%esp
80105b84:	85 c0                	test   %eax,%eax
80105b86:	0f 84 2e 01 00 00    	je     80105cba <sys_unlink+0x1c9>
80105b8c:	83 ec 04             	sub    $0x4,%esp
80105b8f:	8d 45 c8             	lea    -0x38(%ebp),%eax
80105b92:	50                   	push   %eax
80105b93:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105b96:	50                   	push   %eax
80105b97:	ff 75 f4             	pushl  -0xc(%ebp)
80105b9a:	e8 cc c5 ff ff       	call   8010216b <dirlookup>
80105b9f:	83 c4 10             	add    $0x10,%esp
80105ba2:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105ba5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105ba9:	0f 84 0a 01 00 00    	je     80105cb9 <sys_unlink+0x1c8>
80105baf:	83 ec 0c             	sub    $0xc,%esp
80105bb2:	ff 75 f0             	pushl  -0x10(%ebp)
80105bb5:	e8 49 bd ff ff       	call   80101903 <ilock>
80105bba:	83 c4 10             	add    $0x10,%esp
80105bbd:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105bc0:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105bc4:	66 85 c0             	test   %ax,%ax
80105bc7:	7f 0d                	jg     80105bd6 <sys_unlink+0xe5>
80105bc9:	83 ec 0c             	sub    $0xc,%esp
80105bcc:	68 3e 89 10 80       	push   $0x8010893e
80105bd1:	e8 64 a9 ff ff       	call   8010053a <panic>
80105bd6:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105bd9:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105bdd:	66 83 f8 01          	cmp    $0x1,%ax
80105be1:	75 25                	jne    80105c08 <sys_unlink+0x117>
80105be3:	83 ec 0c             	sub    $0xc,%esp
80105be6:	ff 75 f0             	pushl  -0x10(%ebp)
80105be9:	e8 a0 fe ff ff       	call   80105a8e <isdirempty>
80105bee:	83 c4 10             	add    $0x10,%esp
80105bf1:	85 c0                	test   %eax,%eax
80105bf3:	75 13                	jne    80105c08 <sys_unlink+0x117>
80105bf5:	83 ec 0c             	sub    $0xc,%esp
80105bf8:	ff 75 f0             	pushl  -0x10(%ebp)
80105bfb:	e8 c3 bf ff ff       	call   80101bc3 <iunlockput>
80105c00:	83 c4 10             	add    $0x10,%esp
80105c03:	e9 b2 00 00 00       	jmp    80105cba <sys_unlink+0x1c9>
80105c08:	83 ec 04             	sub    $0x4,%esp
80105c0b:	6a 10                	push   $0x10
80105c0d:	6a 00                	push   $0x0
80105c0f:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105c12:	50                   	push   %eax
80105c13:	e8 e3 f5 ff ff       	call   801051fb <memset>
80105c18:	83 c4 10             	add    $0x10,%esp
80105c1b:	8b 45 c8             	mov    -0x38(%ebp),%eax
80105c1e:	6a 10                	push   $0x10
80105c20:	50                   	push   %eax
80105c21:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105c24:	50                   	push   %eax
80105c25:	ff 75 f4             	pushl  -0xc(%ebp)
80105c28:	e8 9b c3 ff ff       	call   80101fc8 <writei>
80105c2d:	83 c4 10             	add    $0x10,%esp
80105c30:	83 f8 10             	cmp    $0x10,%eax
80105c33:	74 0d                	je     80105c42 <sys_unlink+0x151>
80105c35:	83 ec 0c             	sub    $0xc,%esp
80105c38:	68 50 89 10 80       	push   $0x80108950
80105c3d:	e8 f8 a8 ff ff       	call   8010053a <panic>
80105c42:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c45:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105c49:	66 83 f8 01          	cmp    $0x1,%ax
80105c4d:	75 21                	jne    80105c70 <sys_unlink+0x17f>
80105c4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c52:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105c56:	83 e8 01             	sub    $0x1,%eax
80105c59:	89 c2                	mov    %eax,%edx
80105c5b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c5e:	66 89 50 16          	mov    %dx,0x16(%eax)
80105c62:	83 ec 0c             	sub    $0xc,%esp
80105c65:	ff 75 f4             	pushl  -0xc(%ebp)
80105c68:	e8 bc ba ff ff       	call   80101729 <iupdate>
80105c6d:	83 c4 10             	add    $0x10,%esp
80105c70:	83 ec 0c             	sub    $0xc,%esp
80105c73:	ff 75 f4             	pushl  -0xc(%ebp)
80105c76:	e8 48 bf ff ff       	call   80101bc3 <iunlockput>
80105c7b:	83 c4 10             	add    $0x10,%esp
80105c7e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c81:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105c85:	83 e8 01             	sub    $0x1,%eax
80105c88:	89 c2                	mov    %eax,%edx
80105c8a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c8d:	66 89 50 16          	mov    %dx,0x16(%eax)
80105c91:	83 ec 0c             	sub    $0xc,%esp
80105c94:	ff 75 f0             	pushl  -0x10(%ebp)
80105c97:	e8 8d ba ff ff       	call   80101729 <iupdate>
80105c9c:	83 c4 10             	add    $0x10,%esp
80105c9f:	83 ec 0c             	sub    $0xc,%esp
80105ca2:	ff 75 f0             	pushl  -0x10(%ebp)
80105ca5:	e8 19 bf ff ff       	call   80101bc3 <iunlockput>
80105caa:	83 c4 10             	add    $0x10,%esp
80105cad:	e8 c0 d8 ff ff       	call   80103572 <end_op>
80105cb2:	b8 00 00 00 00       	mov    $0x0,%eax
80105cb7:	eb 19                	jmp    80105cd2 <sys_unlink+0x1e1>
80105cb9:	90                   	nop
80105cba:	83 ec 0c             	sub    $0xc,%esp
80105cbd:	ff 75 f4             	pushl  -0xc(%ebp)
80105cc0:	e8 fe be ff ff       	call   80101bc3 <iunlockput>
80105cc5:	83 c4 10             	add    $0x10,%esp
80105cc8:	e8 a5 d8 ff ff       	call   80103572 <end_op>
80105ccd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105cd2:	c9                   	leave  
80105cd3:	c3                   	ret    

80105cd4 <create>:
80105cd4:	55                   	push   %ebp
80105cd5:	89 e5                	mov    %esp,%ebp
80105cd7:	83 ec 38             	sub    $0x38,%esp
80105cda:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80105cdd:	8b 55 10             	mov    0x10(%ebp),%edx
80105ce0:	8b 45 14             	mov    0x14(%ebp),%eax
80105ce3:	66 89 4d d4          	mov    %cx,-0x2c(%ebp)
80105ce7:	66 89 55 d0          	mov    %dx,-0x30(%ebp)
80105ceb:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
80105cef:	83 ec 08             	sub    $0x8,%esp
80105cf2:	8d 45 de             	lea    -0x22(%ebp),%eax
80105cf5:	50                   	push   %eax
80105cf6:	ff 75 08             	pushl  0x8(%ebp)
80105cf9:	e8 df c7 ff ff       	call   801024dd <nameiparent>
80105cfe:	83 c4 10             	add    $0x10,%esp
80105d01:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105d04:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105d08:	75 0a                	jne    80105d14 <create+0x40>
80105d0a:	b8 00 00 00 00       	mov    $0x0,%eax
80105d0f:	e9 90 01 00 00       	jmp    80105ea4 <create+0x1d0>
80105d14:	83 ec 0c             	sub    $0xc,%esp
80105d17:	ff 75 f4             	pushl  -0xc(%ebp)
80105d1a:	e8 e4 bb ff ff       	call   80101903 <ilock>
80105d1f:	83 c4 10             	add    $0x10,%esp
80105d22:	83 ec 04             	sub    $0x4,%esp
80105d25:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105d28:	50                   	push   %eax
80105d29:	8d 45 de             	lea    -0x22(%ebp),%eax
80105d2c:	50                   	push   %eax
80105d2d:	ff 75 f4             	pushl  -0xc(%ebp)
80105d30:	e8 36 c4 ff ff       	call   8010216b <dirlookup>
80105d35:	83 c4 10             	add    $0x10,%esp
80105d38:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105d3b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105d3f:	74 50                	je     80105d91 <create+0xbd>
80105d41:	83 ec 0c             	sub    $0xc,%esp
80105d44:	ff 75 f4             	pushl  -0xc(%ebp)
80105d47:	e8 77 be ff ff       	call   80101bc3 <iunlockput>
80105d4c:	83 c4 10             	add    $0x10,%esp
80105d4f:	83 ec 0c             	sub    $0xc,%esp
80105d52:	ff 75 f0             	pushl  -0x10(%ebp)
80105d55:	e8 a9 bb ff ff       	call   80101903 <ilock>
80105d5a:	83 c4 10             	add    $0x10,%esp
80105d5d:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80105d62:	75 15                	jne    80105d79 <create+0xa5>
80105d64:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105d67:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105d6b:	66 83 f8 02          	cmp    $0x2,%ax
80105d6f:	75 08                	jne    80105d79 <create+0xa5>
80105d71:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105d74:	e9 2b 01 00 00       	jmp    80105ea4 <create+0x1d0>
80105d79:	83 ec 0c             	sub    $0xc,%esp
80105d7c:	ff 75 f0             	pushl  -0x10(%ebp)
80105d7f:	e8 3f be ff ff       	call   80101bc3 <iunlockput>
80105d84:	83 c4 10             	add    $0x10,%esp
80105d87:	b8 00 00 00 00       	mov    $0x0,%eax
80105d8c:	e9 13 01 00 00       	jmp    80105ea4 <create+0x1d0>
80105d91:	0f bf 55 d4          	movswl -0x2c(%ebp),%edx
80105d95:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d98:	8b 00                	mov    (%eax),%eax
80105d9a:	83 ec 08             	sub    $0x8,%esp
80105d9d:	52                   	push   %edx
80105d9e:	50                   	push   %eax
80105d9f:	e8 ae b8 ff ff       	call   80101652 <ialloc>
80105da4:	83 c4 10             	add    $0x10,%esp
80105da7:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105daa:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105dae:	75 0d                	jne    80105dbd <create+0xe9>
80105db0:	83 ec 0c             	sub    $0xc,%esp
80105db3:	68 5f 89 10 80       	push   $0x8010895f
80105db8:	e8 7d a7 ff ff       	call   8010053a <panic>
80105dbd:	83 ec 0c             	sub    $0xc,%esp
80105dc0:	ff 75 f0             	pushl  -0x10(%ebp)
80105dc3:	e8 3b bb ff ff       	call   80101903 <ilock>
80105dc8:	83 c4 10             	add    $0x10,%esp
80105dcb:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105dce:	0f b7 55 d0          	movzwl -0x30(%ebp),%edx
80105dd2:	66 89 50 12          	mov    %dx,0x12(%eax)
80105dd6:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105dd9:	0f b7 55 cc          	movzwl -0x34(%ebp),%edx
80105ddd:	66 89 50 14          	mov    %dx,0x14(%eax)
80105de1:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105de4:	66 c7 40 16 01 00    	movw   $0x1,0x16(%eax)
80105dea:	83 ec 0c             	sub    $0xc,%esp
80105ded:	ff 75 f0             	pushl  -0x10(%ebp)
80105df0:	e8 34 b9 ff ff       	call   80101729 <iupdate>
80105df5:	83 c4 10             	add    $0x10,%esp
80105df8:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80105dfd:	75 6a                	jne    80105e69 <create+0x195>
80105dff:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e02:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105e06:	83 c0 01             	add    $0x1,%eax
80105e09:	89 c2                	mov    %eax,%edx
80105e0b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e0e:	66 89 50 16          	mov    %dx,0x16(%eax)
80105e12:	83 ec 0c             	sub    $0xc,%esp
80105e15:	ff 75 f4             	pushl  -0xc(%ebp)
80105e18:	e8 0c b9 ff ff       	call   80101729 <iupdate>
80105e1d:	83 c4 10             	add    $0x10,%esp
80105e20:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105e23:	8b 40 04             	mov    0x4(%eax),%eax
80105e26:	83 ec 04             	sub    $0x4,%esp
80105e29:	50                   	push   %eax
80105e2a:	68 39 89 10 80       	push   $0x80108939
80105e2f:	ff 75 f0             	pushl  -0x10(%ebp)
80105e32:	e8 ee c3 ff ff       	call   80102225 <dirlink>
80105e37:	83 c4 10             	add    $0x10,%esp
80105e3a:	85 c0                	test   %eax,%eax
80105e3c:	78 1e                	js     80105e5c <create+0x188>
80105e3e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e41:	8b 40 04             	mov    0x4(%eax),%eax
80105e44:	83 ec 04             	sub    $0x4,%esp
80105e47:	50                   	push   %eax
80105e48:	68 3b 89 10 80       	push   $0x8010893b
80105e4d:	ff 75 f0             	pushl  -0x10(%ebp)
80105e50:	e8 d0 c3 ff ff       	call   80102225 <dirlink>
80105e55:	83 c4 10             	add    $0x10,%esp
80105e58:	85 c0                	test   %eax,%eax
80105e5a:	79 0d                	jns    80105e69 <create+0x195>
80105e5c:	83 ec 0c             	sub    $0xc,%esp
80105e5f:	68 6e 89 10 80       	push   $0x8010896e
80105e64:	e8 d1 a6 ff ff       	call   8010053a <panic>
80105e69:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105e6c:	8b 40 04             	mov    0x4(%eax),%eax
80105e6f:	83 ec 04             	sub    $0x4,%esp
80105e72:	50                   	push   %eax
80105e73:	8d 45 de             	lea    -0x22(%ebp),%eax
80105e76:	50                   	push   %eax
80105e77:	ff 75 f4             	pushl  -0xc(%ebp)
80105e7a:	e8 a6 c3 ff ff       	call   80102225 <dirlink>
80105e7f:	83 c4 10             	add    $0x10,%esp
80105e82:	85 c0                	test   %eax,%eax
80105e84:	79 0d                	jns    80105e93 <create+0x1bf>
80105e86:	83 ec 0c             	sub    $0xc,%esp
80105e89:	68 7a 89 10 80       	push   $0x8010897a
80105e8e:	e8 a7 a6 ff ff       	call   8010053a <panic>
80105e93:	83 ec 0c             	sub    $0xc,%esp
80105e96:	ff 75 f4             	pushl  -0xc(%ebp)
80105e99:	e8 25 bd ff ff       	call   80101bc3 <iunlockput>
80105e9e:	83 c4 10             	add    $0x10,%esp
80105ea1:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ea4:	c9                   	leave  
80105ea5:	c3                   	ret    

80105ea6 <sys_open>:
80105ea6:	55                   	push   %ebp
80105ea7:	89 e5                	mov    %esp,%ebp
80105ea9:	83 ec 28             	sub    $0x28,%esp
80105eac:	83 ec 08             	sub    $0x8,%esp
80105eaf:	8d 45 e8             	lea    -0x18(%ebp),%eax
80105eb2:	50                   	push   %eax
80105eb3:	6a 00                	push   $0x0
80105eb5:	e8 eb f6 ff ff       	call   801055a5 <argstr>
80105eba:	83 c4 10             	add    $0x10,%esp
80105ebd:	85 c0                	test   %eax,%eax
80105ebf:	78 15                	js     80105ed6 <sys_open+0x30>
80105ec1:	83 ec 08             	sub    $0x8,%esp
80105ec4:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105ec7:	50                   	push   %eax
80105ec8:	6a 01                	push   $0x1
80105eca:	e8 51 f6 ff ff       	call   80105520 <argint>
80105ecf:	83 c4 10             	add    $0x10,%esp
80105ed2:	85 c0                	test   %eax,%eax
80105ed4:	79 0a                	jns    80105ee0 <sys_open+0x3a>
80105ed6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105edb:	e9 61 01 00 00       	jmp    80106041 <sys_open+0x19b>
80105ee0:	e8 01 d6 ff ff       	call   801034e6 <begin_op>
80105ee5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105ee8:	25 00 02 00 00       	and    $0x200,%eax
80105eed:	85 c0                	test   %eax,%eax
80105eef:	74 2a                	je     80105f1b <sys_open+0x75>
80105ef1:	8b 45 e8             	mov    -0x18(%ebp),%eax
80105ef4:	6a 00                	push   $0x0
80105ef6:	6a 00                	push   $0x0
80105ef8:	6a 02                	push   $0x2
80105efa:	50                   	push   %eax
80105efb:	e8 d4 fd ff ff       	call   80105cd4 <create>
80105f00:	83 c4 10             	add    $0x10,%esp
80105f03:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105f06:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105f0a:	75 75                	jne    80105f81 <sys_open+0xdb>
80105f0c:	e8 61 d6 ff ff       	call   80103572 <end_op>
80105f11:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f16:	e9 26 01 00 00       	jmp    80106041 <sys_open+0x19b>
80105f1b:	8b 45 e8             	mov    -0x18(%ebp),%eax
80105f1e:	83 ec 0c             	sub    $0xc,%esp
80105f21:	50                   	push   %eax
80105f22:	e8 9a c5 ff ff       	call   801024c1 <namei>
80105f27:	83 c4 10             	add    $0x10,%esp
80105f2a:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105f2d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105f31:	75 0f                	jne    80105f42 <sys_open+0x9c>
80105f33:	e8 3a d6 ff ff       	call   80103572 <end_op>
80105f38:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f3d:	e9 ff 00 00 00       	jmp    80106041 <sys_open+0x19b>
80105f42:	83 ec 0c             	sub    $0xc,%esp
80105f45:	ff 75 f4             	pushl  -0xc(%ebp)
80105f48:	e8 b6 b9 ff ff       	call   80101903 <ilock>
80105f4d:	83 c4 10             	add    $0x10,%esp
80105f50:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105f53:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105f57:	66 83 f8 01          	cmp    $0x1,%ax
80105f5b:	75 24                	jne    80105f81 <sys_open+0xdb>
80105f5d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105f60:	85 c0                	test   %eax,%eax
80105f62:	74 1d                	je     80105f81 <sys_open+0xdb>
80105f64:	83 ec 0c             	sub    $0xc,%esp
80105f67:	ff 75 f4             	pushl  -0xc(%ebp)
80105f6a:	e8 54 bc ff ff       	call   80101bc3 <iunlockput>
80105f6f:	83 c4 10             	add    $0x10,%esp
80105f72:	e8 fb d5 ff ff       	call   80103572 <end_op>
80105f77:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f7c:	e9 c0 00 00 00       	jmp    80106041 <sys_open+0x19b>
80105f81:	e8 a6 af ff ff       	call   80100f2c <filealloc>
80105f86:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105f89:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105f8d:	74 17                	je     80105fa6 <sys_open+0x100>
80105f8f:	83 ec 0c             	sub    $0xc,%esp
80105f92:	ff 75 f0             	pushl  -0x10(%ebp)
80105f95:	e8 37 f7 ff ff       	call   801056d1 <fdalloc>
80105f9a:	83 c4 10             	add    $0x10,%esp
80105f9d:	89 45 ec             	mov    %eax,-0x14(%ebp)
80105fa0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80105fa4:	79 2e                	jns    80105fd4 <sys_open+0x12e>
80105fa6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105faa:	74 0e                	je     80105fba <sys_open+0x114>
80105fac:	83 ec 0c             	sub    $0xc,%esp
80105faf:	ff 75 f0             	pushl  -0x10(%ebp)
80105fb2:	e8 33 b0 ff ff       	call   80100fea <fileclose>
80105fb7:	83 c4 10             	add    $0x10,%esp
80105fba:	83 ec 0c             	sub    $0xc,%esp
80105fbd:	ff 75 f4             	pushl  -0xc(%ebp)
80105fc0:	e8 fe bb ff ff       	call   80101bc3 <iunlockput>
80105fc5:	83 c4 10             	add    $0x10,%esp
80105fc8:	e8 a5 d5 ff ff       	call   80103572 <end_op>
80105fcd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105fd2:	eb 6d                	jmp    80106041 <sys_open+0x19b>
80105fd4:	83 ec 0c             	sub    $0xc,%esp
80105fd7:	ff 75 f4             	pushl  -0xc(%ebp)
80105fda:	e8 82 ba ff ff       	call   80101a61 <iunlock>
80105fdf:	83 c4 10             	add    $0x10,%esp
80105fe2:	e8 8b d5 ff ff       	call   80103572 <end_op>
80105fe7:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105fea:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
80105ff0:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ff3:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105ff6:	89 50 10             	mov    %edx,0x10(%eax)
80105ff9:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ffc:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
80106003:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106006:	83 e0 01             	and    $0x1,%eax
80106009:	85 c0                	test   %eax,%eax
8010600b:	0f 94 c0             	sete   %al
8010600e:	89 c2                	mov    %eax,%edx
80106010:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106013:	88 50 08             	mov    %dl,0x8(%eax)
80106016:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106019:	83 e0 01             	and    $0x1,%eax
8010601c:	85 c0                	test   %eax,%eax
8010601e:	75 0a                	jne    8010602a <sys_open+0x184>
80106020:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106023:	83 e0 02             	and    $0x2,%eax
80106026:	85 c0                	test   %eax,%eax
80106028:	74 07                	je     80106031 <sys_open+0x18b>
8010602a:	b8 01 00 00 00       	mov    $0x1,%eax
8010602f:	eb 05                	jmp    80106036 <sys_open+0x190>
80106031:	b8 00 00 00 00       	mov    $0x0,%eax
80106036:	89 c2                	mov    %eax,%edx
80106038:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010603b:	88 50 09             	mov    %dl,0x9(%eax)
8010603e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106041:	c9                   	leave  
80106042:	c3                   	ret    

80106043 <sys_mkdir>:
80106043:	55                   	push   %ebp
80106044:	89 e5                	mov    %esp,%ebp
80106046:	83 ec 18             	sub    $0x18,%esp
80106049:	e8 98 d4 ff ff       	call   801034e6 <begin_op>
8010604e:	83 ec 08             	sub    $0x8,%esp
80106051:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106054:	50                   	push   %eax
80106055:	6a 00                	push   $0x0
80106057:	e8 49 f5 ff ff       	call   801055a5 <argstr>
8010605c:	83 c4 10             	add    $0x10,%esp
8010605f:	85 c0                	test   %eax,%eax
80106061:	78 1b                	js     8010607e <sys_mkdir+0x3b>
80106063:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106066:	6a 00                	push   $0x0
80106068:	6a 00                	push   $0x0
8010606a:	6a 01                	push   $0x1
8010606c:	50                   	push   %eax
8010606d:	e8 62 fc ff ff       	call   80105cd4 <create>
80106072:	83 c4 10             	add    $0x10,%esp
80106075:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106078:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010607c:	75 0c                	jne    8010608a <sys_mkdir+0x47>
8010607e:	e8 ef d4 ff ff       	call   80103572 <end_op>
80106083:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106088:	eb 18                	jmp    801060a2 <sys_mkdir+0x5f>
8010608a:	83 ec 0c             	sub    $0xc,%esp
8010608d:	ff 75 f4             	pushl  -0xc(%ebp)
80106090:	e8 2e bb ff ff       	call   80101bc3 <iunlockput>
80106095:	83 c4 10             	add    $0x10,%esp
80106098:	e8 d5 d4 ff ff       	call   80103572 <end_op>
8010609d:	b8 00 00 00 00       	mov    $0x0,%eax
801060a2:	c9                   	leave  
801060a3:	c3                   	ret    

801060a4 <sys_mknod>:
801060a4:	55                   	push   %ebp
801060a5:	89 e5                	mov    %esp,%ebp
801060a7:	83 ec 28             	sub    $0x28,%esp
801060aa:	e8 37 d4 ff ff       	call   801034e6 <begin_op>
801060af:	83 ec 08             	sub    $0x8,%esp
801060b2:	8d 45 ec             	lea    -0x14(%ebp),%eax
801060b5:	50                   	push   %eax
801060b6:	6a 00                	push   $0x0
801060b8:	e8 e8 f4 ff ff       	call   801055a5 <argstr>
801060bd:	83 c4 10             	add    $0x10,%esp
801060c0:	89 45 f4             	mov    %eax,-0xc(%ebp)
801060c3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801060c7:	78 4f                	js     80106118 <sys_mknod+0x74>
801060c9:	83 ec 08             	sub    $0x8,%esp
801060cc:	8d 45 e8             	lea    -0x18(%ebp),%eax
801060cf:	50                   	push   %eax
801060d0:	6a 01                	push   $0x1
801060d2:	e8 49 f4 ff ff       	call   80105520 <argint>
801060d7:	83 c4 10             	add    $0x10,%esp
801060da:	85 c0                	test   %eax,%eax
801060dc:	78 3a                	js     80106118 <sys_mknod+0x74>
801060de:	83 ec 08             	sub    $0x8,%esp
801060e1:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801060e4:	50                   	push   %eax
801060e5:	6a 02                	push   $0x2
801060e7:	e8 34 f4 ff ff       	call   80105520 <argint>
801060ec:	83 c4 10             	add    $0x10,%esp
801060ef:	85 c0                	test   %eax,%eax
801060f1:	78 25                	js     80106118 <sys_mknod+0x74>
801060f3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801060f6:	0f bf c8             	movswl %ax,%ecx
801060f9:	8b 45 e8             	mov    -0x18(%ebp),%eax
801060fc:	0f bf d0             	movswl %ax,%edx
801060ff:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106102:	51                   	push   %ecx
80106103:	52                   	push   %edx
80106104:	6a 03                	push   $0x3
80106106:	50                   	push   %eax
80106107:	e8 c8 fb ff ff       	call   80105cd4 <create>
8010610c:	83 c4 10             	add    $0x10,%esp
8010610f:	89 45 f0             	mov    %eax,-0x10(%ebp)
80106112:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80106116:	75 0c                	jne    80106124 <sys_mknod+0x80>
80106118:	e8 55 d4 ff ff       	call   80103572 <end_op>
8010611d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106122:	eb 18                	jmp    8010613c <sys_mknod+0x98>
80106124:	83 ec 0c             	sub    $0xc,%esp
80106127:	ff 75 f0             	pushl  -0x10(%ebp)
8010612a:	e8 94 ba ff ff       	call   80101bc3 <iunlockput>
8010612f:	83 c4 10             	add    $0x10,%esp
80106132:	e8 3b d4 ff ff       	call   80103572 <end_op>
80106137:	b8 00 00 00 00       	mov    $0x0,%eax
8010613c:	c9                   	leave  
8010613d:	c3                   	ret    

8010613e <sys_chdir>:
8010613e:	55                   	push   %ebp
8010613f:	89 e5                	mov    %esp,%ebp
80106141:	83 ec 18             	sub    $0x18,%esp
80106144:	e8 9d d3 ff ff       	call   801034e6 <begin_op>
80106149:	83 ec 08             	sub    $0x8,%esp
8010614c:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010614f:	50                   	push   %eax
80106150:	6a 00                	push   $0x0
80106152:	e8 4e f4 ff ff       	call   801055a5 <argstr>
80106157:	83 c4 10             	add    $0x10,%esp
8010615a:	85 c0                	test   %eax,%eax
8010615c:	78 18                	js     80106176 <sys_chdir+0x38>
8010615e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106161:	83 ec 0c             	sub    $0xc,%esp
80106164:	50                   	push   %eax
80106165:	e8 57 c3 ff ff       	call   801024c1 <namei>
8010616a:	83 c4 10             	add    $0x10,%esp
8010616d:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106170:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106174:	75 0c                	jne    80106182 <sys_chdir+0x44>
80106176:	e8 f7 d3 ff ff       	call   80103572 <end_op>
8010617b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106180:	eb 6e                	jmp    801061f0 <sys_chdir+0xb2>
80106182:	83 ec 0c             	sub    $0xc,%esp
80106185:	ff 75 f4             	pushl  -0xc(%ebp)
80106188:	e8 76 b7 ff ff       	call   80101903 <ilock>
8010618d:	83 c4 10             	add    $0x10,%esp
80106190:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106193:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80106197:	66 83 f8 01          	cmp    $0x1,%ax
8010619b:	74 1a                	je     801061b7 <sys_chdir+0x79>
8010619d:	83 ec 0c             	sub    $0xc,%esp
801061a0:	ff 75 f4             	pushl  -0xc(%ebp)
801061a3:	e8 1b ba ff ff       	call   80101bc3 <iunlockput>
801061a8:	83 c4 10             	add    $0x10,%esp
801061ab:	e8 c2 d3 ff ff       	call   80103572 <end_op>
801061b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801061b5:	eb 39                	jmp    801061f0 <sys_chdir+0xb2>
801061b7:	83 ec 0c             	sub    $0xc,%esp
801061ba:	ff 75 f4             	pushl  -0xc(%ebp)
801061bd:	e8 9f b8 ff ff       	call   80101a61 <iunlock>
801061c2:	83 c4 10             	add    $0x10,%esp
801061c5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801061cb:	8b 40 68             	mov    0x68(%eax),%eax
801061ce:	83 ec 0c             	sub    $0xc,%esp
801061d1:	50                   	push   %eax
801061d2:	e8 fc b8 ff ff       	call   80101ad3 <iput>
801061d7:	83 c4 10             	add    $0x10,%esp
801061da:	e8 93 d3 ff ff       	call   80103572 <end_op>
801061df:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801061e5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801061e8:	89 50 68             	mov    %edx,0x68(%eax)
801061eb:	b8 00 00 00 00       	mov    $0x0,%eax
801061f0:	c9                   	leave  
801061f1:	c3                   	ret    

801061f2 <sys_exec>:
801061f2:	55                   	push   %ebp
801061f3:	89 e5                	mov    %esp,%ebp
801061f5:	81 ec 98 00 00 00    	sub    $0x98,%esp
801061fb:	83 ec 08             	sub    $0x8,%esp
801061fe:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106201:	50                   	push   %eax
80106202:	6a 00                	push   $0x0
80106204:	e8 9c f3 ff ff       	call   801055a5 <argstr>
80106209:	83 c4 10             	add    $0x10,%esp
8010620c:	85 c0                	test   %eax,%eax
8010620e:	78 18                	js     80106228 <sys_exec+0x36>
80106210:	83 ec 08             	sub    $0x8,%esp
80106213:	8d 85 6c ff ff ff    	lea    -0x94(%ebp),%eax
80106219:	50                   	push   %eax
8010621a:	6a 01                	push   $0x1
8010621c:	e8 ff f2 ff ff       	call   80105520 <argint>
80106221:	83 c4 10             	add    $0x10,%esp
80106224:	85 c0                	test   %eax,%eax
80106226:	79 0a                	jns    80106232 <sys_exec+0x40>
80106228:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010622d:	e9 c6 00 00 00       	jmp    801062f8 <sys_exec+0x106>
80106232:	83 ec 04             	sub    $0x4,%esp
80106235:	68 80 00 00 00       	push   $0x80
8010623a:	6a 00                	push   $0x0
8010623c:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
80106242:	50                   	push   %eax
80106243:	e8 b3 ef ff ff       	call   801051fb <memset>
80106248:	83 c4 10             	add    $0x10,%esp
8010624b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80106252:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106255:	83 f8 1f             	cmp    $0x1f,%eax
80106258:	76 0a                	jbe    80106264 <sys_exec+0x72>
8010625a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010625f:	e9 94 00 00 00       	jmp    801062f8 <sys_exec+0x106>
80106264:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106267:	c1 e0 02             	shl    $0x2,%eax
8010626a:	89 c2                	mov    %eax,%edx
8010626c:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
80106272:	01 c2                	add    %eax,%edx
80106274:	83 ec 08             	sub    $0x8,%esp
80106277:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
8010627d:	50                   	push   %eax
8010627e:	52                   	push   %edx
8010627f:	e8 00 f2 ff ff       	call   80105484 <fetchint>
80106284:	83 c4 10             	add    $0x10,%esp
80106287:	85 c0                	test   %eax,%eax
80106289:	79 07                	jns    80106292 <sys_exec+0xa0>
8010628b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106290:	eb 66                	jmp    801062f8 <sys_exec+0x106>
80106292:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
80106298:	85 c0                	test   %eax,%eax
8010629a:	75 27                	jne    801062c3 <sys_exec+0xd1>
8010629c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010629f:	c7 84 85 70 ff ff ff 	movl   $0x0,-0x90(%ebp,%eax,4)
801062a6:	00 00 00 00 
801062aa:	90                   	nop
801062ab:	8b 45 f0             	mov    -0x10(%ebp),%eax
801062ae:	83 ec 08             	sub    $0x8,%esp
801062b1:	8d 95 70 ff ff ff    	lea    -0x90(%ebp),%edx
801062b7:	52                   	push   %edx
801062b8:	50                   	push   %eax
801062b9:	e8 4c a8 ff ff       	call   80100b0a <exec>
801062be:	83 c4 10             	add    $0x10,%esp
801062c1:	eb 35                	jmp    801062f8 <sys_exec+0x106>
801062c3:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
801062c9:	8b 55 f4             	mov    -0xc(%ebp),%edx
801062cc:	c1 e2 02             	shl    $0x2,%edx
801062cf:	01 c2                	add    %eax,%edx
801062d1:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
801062d7:	83 ec 08             	sub    $0x8,%esp
801062da:	52                   	push   %edx
801062db:	50                   	push   %eax
801062dc:	e8 dd f1 ff ff       	call   801054be <fetchstr>
801062e1:	83 c4 10             	add    $0x10,%esp
801062e4:	85 c0                	test   %eax,%eax
801062e6:	79 07                	jns    801062ef <sys_exec+0xfd>
801062e8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801062ed:	eb 09                	jmp    801062f8 <sys_exec+0x106>
801062ef:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801062f3:	e9 5a ff ff ff       	jmp    80106252 <sys_exec+0x60>
801062f8:	c9                   	leave  
801062f9:	c3                   	ret    

801062fa <sys_pipe>:
801062fa:	55                   	push   %ebp
801062fb:	89 e5                	mov    %esp,%ebp
801062fd:	83 ec 28             	sub    $0x28,%esp
80106300:	83 ec 04             	sub    $0x4,%esp
80106303:	6a 08                	push   $0x8
80106305:	8d 45 ec             	lea    -0x14(%ebp),%eax
80106308:	50                   	push   %eax
80106309:	6a 00                	push   $0x0
8010630b:	e8 38 f2 ff ff       	call   80105548 <argptr>
80106310:	83 c4 10             	add    $0x10,%esp
80106313:	85 c0                	test   %eax,%eax
80106315:	79 0a                	jns    80106321 <sys_pipe+0x27>
80106317:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010631c:	e9 af 00 00 00       	jmp    801063d0 <sys_pipe+0xd6>
80106321:	83 ec 08             	sub    $0x8,%esp
80106324:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106327:	50                   	push   %eax
80106328:	8d 45 e8             	lea    -0x18(%ebp),%eax
8010632b:	50                   	push   %eax
8010632c:	e8 a9 dc ff ff       	call   80103fda <pipealloc>
80106331:	83 c4 10             	add    $0x10,%esp
80106334:	85 c0                	test   %eax,%eax
80106336:	79 0a                	jns    80106342 <sys_pipe+0x48>
80106338:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010633d:	e9 8e 00 00 00       	jmp    801063d0 <sys_pipe+0xd6>
80106342:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
80106349:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010634c:	83 ec 0c             	sub    $0xc,%esp
8010634f:	50                   	push   %eax
80106350:	e8 7c f3 ff ff       	call   801056d1 <fdalloc>
80106355:	83 c4 10             	add    $0x10,%esp
80106358:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010635b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010635f:	78 18                	js     80106379 <sys_pipe+0x7f>
80106361:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106364:	83 ec 0c             	sub    $0xc,%esp
80106367:	50                   	push   %eax
80106368:	e8 64 f3 ff ff       	call   801056d1 <fdalloc>
8010636d:	83 c4 10             	add    $0x10,%esp
80106370:	89 45 f0             	mov    %eax,-0x10(%ebp)
80106373:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80106377:	79 3f                	jns    801063b8 <sys_pipe+0xbe>
80106379:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010637d:	78 14                	js     80106393 <sys_pipe+0x99>
8010637f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106385:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106388:	83 c2 08             	add    $0x8,%edx
8010638b:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
80106392:	00 
80106393:	8b 45 e8             	mov    -0x18(%ebp),%eax
80106396:	83 ec 0c             	sub    $0xc,%esp
80106399:	50                   	push   %eax
8010639a:	e8 4b ac ff ff       	call   80100fea <fileclose>
8010639f:	83 c4 10             	add    $0x10,%esp
801063a2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801063a5:	83 ec 0c             	sub    $0xc,%esp
801063a8:	50                   	push   %eax
801063a9:	e8 3c ac ff ff       	call   80100fea <fileclose>
801063ae:	83 c4 10             	add    $0x10,%esp
801063b1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801063b6:	eb 18                	jmp    801063d0 <sys_pipe+0xd6>
801063b8:	8b 45 ec             	mov    -0x14(%ebp),%eax
801063bb:	8b 55 f4             	mov    -0xc(%ebp),%edx
801063be:	89 10                	mov    %edx,(%eax)
801063c0:	8b 45 ec             	mov    -0x14(%ebp),%eax
801063c3:	8d 50 04             	lea    0x4(%eax),%edx
801063c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801063c9:	89 02                	mov    %eax,(%edx)
801063cb:	b8 00 00 00 00       	mov    $0x0,%eax
801063d0:	c9                   	leave  
801063d1:	c3                   	ret    

801063d2 <sys_fork>:
801063d2:	55                   	push   %ebp
801063d3:	89 e5                	mov    %esp,%ebp
801063d5:	83 ec 08             	sub    $0x8,%esp
801063d8:	e8 f3 e2 ff ff       	call   801046d0 <fork>
801063dd:	c9                   	leave  
801063de:	c3                   	ret    

801063df <sys_exit>:
801063df:	55                   	push   %ebp
801063e0:	89 e5                	mov    %esp,%ebp
801063e2:	83 ec 08             	sub    $0x8,%esp
801063e5:	e8 77 e4 ff ff       	call   80104861 <exit>
801063ea:	b8 00 00 00 00       	mov    $0x0,%eax
801063ef:	c9                   	leave  
801063f0:	c3                   	ret    

801063f1 <sys_wait>:
801063f1:	55                   	push   %ebp
801063f2:	89 e5                	mov    %esp,%ebp
801063f4:	83 ec 08             	sub    $0x8,%esp
801063f7:	e8 9d e5 ff ff       	call   80104999 <wait>
801063fc:	c9                   	leave  
801063fd:	c3                   	ret    

801063fe <sys_kill>:
801063fe:	55                   	push   %ebp
801063ff:	89 e5                	mov    %esp,%ebp
80106401:	83 ec 18             	sub    $0x18,%esp
80106404:	83 ec 08             	sub    $0x8,%esp
80106407:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010640a:	50                   	push   %eax
8010640b:	6a 00                	push   $0x0
8010640d:	e8 0e f1 ff ff       	call   80105520 <argint>
80106412:	83 c4 10             	add    $0x10,%esp
80106415:	85 c0                	test   %eax,%eax
80106417:	79 07                	jns    80106420 <sys_kill+0x22>
80106419:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010641e:	eb 0f                	jmp    8010642f <sys_kill+0x31>
80106420:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106423:	83 ec 0c             	sub    $0xc,%esp
80106426:	50                   	push   %eax
80106427:	e8 95 e9 ff ff       	call   80104dc1 <kill>
8010642c:	83 c4 10             	add    $0x10,%esp
8010642f:	c9                   	leave  
80106430:	c3                   	ret    

80106431 <sys_getpid>:
80106431:	55                   	push   %ebp
80106432:	89 e5                	mov    %esp,%ebp
80106434:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010643a:	8b 40 10             	mov    0x10(%eax),%eax
8010643d:	5d                   	pop    %ebp
8010643e:	c3                   	ret    

8010643f <sys_sbrk>:
8010643f:	55                   	push   %ebp
80106440:	89 e5                	mov    %esp,%ebp
80106442:	83 ec 18             	sub    $0x18,%esp
80106445:	83 ec 08             	sub    $0x8,%esp
80106448:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010644b:	50                   	push   %eax
8010644c:	6a 00                	push   $0x0
8010644e:	e8 cd f0 ff ff       	call   80105520 <argint>
80106453:	83 c4 10             	add    $0x10,%esp
80106456:	85 c0                	test   %eax,%eax
80106458:	79 07                	jns    80106461 <sys_sbrk+0x22>
8010645a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010645f:	eb 28                	jmp    80106489 <sys_sbrk+0x4a>
80106461:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106467:	8b 00                	mov    (%eax),%eax
80106469:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010646c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010646f:	83 ec 0c             	sub    $0xc,%esp
80106472:	50                   	push   %eax
80106473:	e8 b5 e1 ff ff       	call   8010462d <growproc>
80106478:	83 c4 10             	add    $0x10,%esp
8010647b:	85 c0                	test   %eax,%eax
8010647d:	79 07                	jns    80106486 <sys_sbrk+0x47>
8010647f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106484:	eb 03                	jmp    80106489 <sys_sbrk+0x4a>
80106486:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106489:	c9                   	leave  
8010648a:	c3                   	ret    

8010648b <sys_sleep>:
8010648b:	55                   	push   %ebp
8010648c:	89 e5                	mov    %esp,%ebp
8010648e:	83 ec 18             	sub    $0x18,%esp
80106491:	83 ec 08             	sub    $0x8,%esp
80106494:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106497:	50                   	push   %eax
80106498:	6a 00                	push   $0x0
8010649a:	e8 81 f0 ff ff       	call   80105520 <argint>
8010649f:	83 c4 10             	add    $0x10,%esp
801064a2:	85 c0                	test   %eax,%eax
801064a4:	79 07                	jns    801064ad <sys_sleep+0x22>
801064a6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801064ab:	eb 77                	jmp    80106524 <sys_sleep+0x99>
801064ad:	83 ec 0c             	sub    $0xc,%esp
801064b0:	68 a0 48 11 80       	push   $0x801148a0
801064b5:	e8 de ea ff ff       	call   80104f98 <acquire>
801064ba:	83 c4 10             	add    $0x10,%esp
801064bd:	a1 e0 50 11 80       	mov    0x801150e0,%eax
801064c2:	89 45 f4             	mov    %eax,-0xc(%ebp)
801064c5:	eb 39                	jmp    80106500 <sys_sleep+0x75>
801064c7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801064cd:	8b 40 24             	mov    0x24(%eax),%eax
801064d0:	85 c0                	test   %eax,%eax
801064d2:	74 17                	je     801064eb <sys_sleep+0x60>
801064d4:	83 ec 0c             	sub    $0xc,%esp
801064d7:	68 a0 48 11 80       	push   $0x801148a0
801064dc:	e8 1e eb ff ff       	call   80104fff <release>
801064e1:	83 c4 10             	add    $0x10,%esp
801064e4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801064e9:	eb 39                	jmp    80106524 <sys_sleep+0x99>
801064eb:	83 ec 08             	sub    $0x8,%esp
801064ee:	68 a0 48 11 80       	push   $0x801148a0
801064f3:	68 e0 50 11 80       	push   $0x801150e0
801064f8:	e8 a2 e7 ff ff       	call   80104c9f <sleep>
801064fd:	83 c4 10             	add    $0x10,%esp
80106500:	a1 e0 50 11 80       	mov    0x801150e0,%eax
80106505:	2b 45 f4             	sub    -0xc(%ebp),%eax
80106508:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010650b:	39 d0                	cmp    %edx,%eax
8010650d:	72 b8                	jb     801064c7 <sys_sleep+0x3c>
8010650f:	83 ec 0c             	sub    $0xc,%esp
80106512:	68 a0 48 11 80       	push   $0x801148a0
80106517:	e8 e3 ea ff ff       	call   80104fff <release>
8010651c:	83 c4 10             	add    $0x10,%esp
8010651f:	b8 00 00 00 00       	mov    $0x0,%eax
80106524:	c9                   	leave  
80106525:	c3                   	ret    

80106526 <sys_uptime>:
80106526:	55                   	push   %ebp
80106527:	89 e5                	mov    %esp,%ebp
80106529:	83 ec 18             	sub    $0x18,%esp
8010652c:	83 ec 0c             	sub    $0xc,%esp
8010652f:	68 a0 48 11 80       	push   $0x801148a0
80106534:	e8 5f ea ff ff       	call   80104f98 <acquire>
80106539:	83 c4 10             	add    $0x10,%esp
8010653c:	a1 e0 50 11 80       	mov    0x801150e0,%eax
80106541:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106544:	83 ec 0c             	sub    $0xc,%esp
80106547:	68 a0 48 11 80       	push   $0x801148a0
8010654c:	e8 ae ea ff ff       	call   80104fff <release>
80106551:	83 c4 10             	add    $0x10,%esp
80106554:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106557:	c9                   	leave  
80106558:	c3                   	ret    

80106559 <outb>:
80106559:	55                   	push   %ebp
8010655a:	89 e5                	mov    %esp,%ebp
8010655c:	83 ec 08             	sub    $0x8,%esp
8010655f:	8b 55 08             	mov    0x8(%ebp),%edx
80106562:	8b 45 0c             	mov    0xc(%ebp),%eax
80106565:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80106569:	88 45 f8             	mov    %al,-0x8(%ebp)
8010656c:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80106570:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80106574:	ee                   	out    %al,(%dx)
80106575:	90                   	nop
80106576:	c9                   	leave  
80106577:	c3                   	ret    

80106578 <timerinit>:
80106578:	55                   	push   %ebp
80106579:	89 e5                	mov    %esp,%ebp
8010657b:	83 ec 08             	sub    $0x8,%esp
8010657e:	6a 34                	push   $0x34
80106580:	6a 43                	push   $0x43
80106582:	e8 d2 ff ff ff       	call   80106559 <outb>
80106587:	83 c4 08             	add    $0x8,%esp
8010658a:	68 9c 00 00 00       	push   $0x9c
8010658f:	6a 40                	push   $0x40
80106591:	e8 c3 ff ff ff       	call   80106559 <outb>
80106596:	83 c4 08             	add    $0x8,%esp
80106599:	6a 2e                	push   $0x2e
8010659b:	6a 40                	push   $0x40
8010659d:	e8 b7 ff ff ff       	call   80106559 <outb>
801065a2:	83 c4 08             	add    $0x8,%esp
801065a5:	83 ec 0c             	sub    $0xc,%esp
801065a8:	6a 00                	push   $0x0
801065aa:	e8 15 d9 ff ff       	call   80103ec4 <picenable>
801065af:	83 c4 10             	add    $0x10,%esp
801065b2:	90                   	nop
801065b3:	c9                   	leave  
801065b4:	c3                   	ret    

801065b5 <alltraps>:
801065b5:	1e                   	push   %ds
801065b6:	06                   	push   %es
801065b7:	0f a0                	push   %fs
801065b9:	0f a8                	push   %gs
801065bb:	60                   	pusha  
801065bc:	66 b8 10 00          	mov    $0x10,%ax
801065c0:	8e d8                	mov    %eax,%ds
801065c2:	8e c0                	mov    %eax,%es
801065c4:	66 b8 18 00          	mov    $0x18,%ax
801065c8:	8e e0                	mov    %eax,%fs
801065ca:	8e e8                	mov    %eax,%gs
801065cc:	54                   	push   %esp
801065cd:	e8 d7 01 00 00       	call   801067a9 <trap>
801065d2:	83 c4 04             	add    $0x4,%esp

801065d5 <trapret>:
801065d5:	61                   	popa   
801065d6:	0f a9                	pop    %gs
801065d8:	0f a1                	pop    %fs
801065da:	07                   	pop    %es
801065db:	1f                   	pop    %ds
801065dc:	83 c4 08             	add    $0x8,%esp
801065df:	cf                   	iret   

801065e0 <lidt>:
801065e0:	55                   	push   %ebp
801065e1:	89 e5                	mov    %esp,%ebp
801065e3:	83 ec 10             	sub    $0x10,%esp
801065e6:	8b 45 0c             	mov    0xc(%ebp),%eax
801065e9:	83 e8 01             	sub    $0x1,%eax
801065ec:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
801065f0:	8b 45 08             	mov    0x8(%ebp),%eax
801065f3:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
801065f7:	8b 45 08             	mov    0x8(%ebp),%eax
801065fa:	c1 e8 10             	shr    $0x10,%eax
801065fd:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
80106601:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106604:	0f 01 18             	lidtl  (%eax)
80106607:	90                   	nop
80106608:	c9                   	leave  
80106609:	c3                   	ret    

8010660a <rcr2>:
8010660a:	55                   	push   %ebp
8010660b:	89 e5                	mov    %esp,%ebp
8010660d:	83 ec 10             	sub    $0x10,%esp
80106610:	0f 20 d0             	mov    %cr2,%eax
80106613:	89 45 fc             	mov    %eax,-0x4(%ebp)
80106616:	8b 45 fc             	mov    -0x4(%ebp),%eax
80106619:	c9                   	leave  
8010661a:	c3                   	ret    

8010661b <tvinit>:
8010661b:	55                   	push   %ebp
8010661c:	89 e5                	mov    %esp,%ebp
8010661e:	83 ec 18             	sub    $0x18,%esp
80106621:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80106628:	e9 c3 00 00 00       	jmp    801066f0 <tvinit+0xd5>
8010662d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106630:	8b 04 85 98 b0 10 80 	mov    -0x7fef4f68(,%eax,4),%eax
80106637:	89 c2                	mov    %eax,%edx
80106639:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010663c:	66 89 14 c5 e0 48 11 	mov    %dx,-0x7feeb720(,%eax,8)
80106643:	80 
80106644:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106647:	66 c7 04 c5 e2 48 11 	movw   $0x8,-0x7feeb71e(,%eax,8)
8010664e:	80 08 00 
80106651:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106654:	0f b6 14 c5 e4 48 11 	movzbl -0x7feeb71c(,%eax,8),%edx
8010665b:	80 
8010665c:	83 e2 e0             	and    $0xffffffe0,%edx
8010665f:	88 14 c5 e4 48 11 80 	mov    %dl,-0x7feeb71c(,%eax,8)
80106666:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106669:	0f b6 14 c5 e4 48 11 	movzbl -0x7feeb71c(,%eax,8),%edx
80106670:	80 
80106671:	83 e2 1f             	and    $0x1f,%edx
80106674:	88 14 c5 e4 48 11 80 	mov    %dl,-0x7feeb71c(,%eax,8)
8010667b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010667e:	0f b6 14 c5 e5 48 11 	movzbl -0x7feeb71b(,%eax,8),%edx
80106685:	80 
80106686:	83 e2 f0             	and    $0xfffffff0,%edx
80106689:	83 ca 0e             	or     $0xe,%edx
8010668c:	88 14 c5 e5 48 11 80 	mov    %dl,-0x7feeb71b(,%eax,8)
80106693:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106696:	0f b6 14 c5 e5 48 11 	movzbl -0x7feeb71b(,%eax,8),%edx
8010669d:	80 
8010669e:	83 e2 ef             	and    $0xffffffef,%edx
801066a1:	88 14 c5 e5 48 11 80 	mov    %dl,-0x7feeb71b(,%eax,8)
801066a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801066ab:	0f b6 14 c5 e5 48 11 	movzbl -0x7feeb71b(,%eax,8),%edx
801066b2:	80 
801066b3:	83 e2 9f             	and    $0xffffff9f,%edx
801066b6:	88 14 c5 e5 48 11 80 	mov    %dl,-0x7feeb71b(,%eax,8)
801066bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801066c0:	0f b6 14 c5 e5 48 11 	movzbl -0x7feeb71b(,%eax,8),%edx
801066c7:	80 
801066c8:	83 ca 80             	or     $0xffffff80,%edx
801066cb:	88 14 c5 e5 48 11 80 	mov    %dl,-0x7feeb71b(,%eax,8)
801066d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801066d5:	8b 04 85 98 b0 10 80 	mov    -0x7fef4f68(,%eax,4),%eax
801066dc:	c1 e8 10             	shr    $0x10,%eax
801066df:	89 c2                	mov    %eax,%edx
801066e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801066e4:	66 89 14 c5 e6 48 11 	mov    %dx,-0x7feeb71a(,%eax,8)
801066eb:	80 
801066ec:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801066f0:	81 7d f4 ff 00 00 00 	cmpl   $0xff,-0xc(%ebp)
801066f7:	0f 8e 30 ff ff ff    	jle    8010662d <tvinit+0x12>
801066fd:	a1 98 b1 10 80       	mov    0x8010b198,%eax
80106702:	66 a3 e0 4a 11 80    	mov    %ax,0x80114ae0
80106708:	66 c7 05 e2 4a 11 80 	movw   $0x8,0x80114ae2
8010670f:	08 00 
80106711:	0f b6 05 e4 4a 11 80 	movzbl 0x80114ae4,%eax
80106718:	83 e0 e0             	and    $0xffffffe0,%eax
8010671b:	a2 e4 4a 11 80       	mov    %al,0x80114ae4
80106720:	0f b6 05 e4 4a 11 80 	movzbl 0x80114ae4,%eax
80106727:	83 e0 1f             	and    $0x1f,%eax
8010672a:	a2 e4 4a 11 80       	mov    %al,0x80114ae4
8010672f:	0f b6 05 e5 4a 11 80 	movzbl 0x80114ae5,%eax
80106736:	83 c8 0f             	or     $0xf,%eax
80106739:	a2 e5 4a 11 80       	mov    %al,0x80114ae5
8010673e:	0f b6 05 e5 4a 11 80 	movzbl 0x80114ae5,%eax
80106745:	83 e0 ef             	and    $0xffffffef,%eax
80106748:	a2 e5 4a 11 80       	mov    %al,0x80114ae5
8010674d:	0f b6 05 e5 4a 11 80 	movzbl 0x80114ae5,%eax
80106754:	83 c8 60             	or     $0x60,%eax
80106757:	a2 e5 4a 11 80       	mov    %al,0x80114ae5
8010675c:	0f b6 05 e5 4a 11 80 	movzbl 0x80114ae5,%eax
80106763:	83 c8 80             	or     $0xffffff80,%eax
80106766:	a2 e5 4a 11 80       	mov    %al,0x80114ae5
8010676b:	a1 98 b1 10 80       	mov    0x8010b198,%eax
80106770:	c1 e8 10             	shr    $0x10,%eax
80106773:	66 a3 e6 4a 11 80    	mov    %ax,0x80114ae6
80106779:	83 ec 08             	sub    $0x8,%esp
8010677c:	68 8c 89 10 80       	push   $0x8010898c
80106781:	68 a0 48 11 80       	push   $0x801148a0
80106786:	e8 eb e7 ff ff       	call   80104f76 <initlock>
8010678b:	83 c4 10             	add    $0x10,%esp
8010678e:	90                   	nop
8010678f:	c9                   	leave  
80106790:	c3                   	ret    

80106791 <idtinit>:
80106791:	55                   	push   %ebp
80106792:	89 e5                	mov    %esp,%ebp
80106794:	68 00 08 00 00       	push   $0x800
80106799:	68 e0 48 11 80       	push   $0x801148e0
8010679e:	e8 3d fe ff ff       	call   801065e0 <lidt>
801067a3:	83 c4 08             	add    $0x8,%esp
801067a6:	90                   	nop
801067a7:	c9                   	leave  
801067a8:	c3                   	ret    

801067a9 <trap>:
801067a9:	55                   	push   %ebp
801067aa:	89 e5                	mov    %esp,%ebp
801067ac:	57                   	push   %edi
801067ad:	56                   	push   %esi
801067ae:	53                   	push   %ebx
801067af:	83 ec 1c             	sub    $0x1c,%esp
801067b2:	8b 45 08             	mov    0x8(%ebp),%eax
801067b5:	8b 40 30             	mov    0x30(%eax),%eax
801067b8:	83 f8 40             	cmp    $0x40,%eax
801067bb:	75 3e                	jne    801067fb <trap+0x52>
801067bd:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801067c3:	8b 40 24             	mov    0x24(%eax),%eax
801067c6:	85 c0                	test   %eax,%eax
801067c8:	74 05                	je     801067cf <trap+0x26>
801067ca:	e8 92 e0 ff ff       	call   80104861 <exit>
801067cf:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801067d5:	8b 55 08             	mov    0x8(%ebp),%edx
801067d8:	89 50 18             	mov    %edx,0x18(%eax)
801067db:	e8 f6 ed ff ff       	call   801055d6 <syscall>
801067e0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801067e6:	8b 40 24             	mov    0x24(%eax),%eax
801067e9:	85 c0                	test   %eax,%eax
801067eb:	0f 84 1b 02 00 00    	je     80106a0c <trap+0x263>
801067f1:	e8 6b e0 ff ff       	call   80104861 <exit>
801067f6:	e9 11 02 00 00       	jmp    80106a0c <trap+0x263>
801067fb:	8b 45 08             	mov    0x8(%ebp),%eax
801067fe:	8b 40 30             	mov    0x30(%eax),%eax
80106801:	83 e8 20             	sub    $0x20,%eax
80106804:	83 f8 1f             	cmp    $0x1f,%eax
80106807:	0f 87 c0 00 00 00    	ja     801068cd <trap+0x124>
8010680d:	8b 04 85 34 8a 10 80 	mov    -0x7fef75cc(,%eax,4),%eax
80106814:	ff e0                	jmp    *%eax
80106816:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010681c:	0f b6 00             	movzbl (%eax),%eax
8010681f:	84 c0                	test   %al,%al
80106821:	75 3d                	jne    80106860 <trap+0xb7>
80106823:	83 ec 0c             	sub    $0xc,%esp
80106826:	68 a0 48 11 80       	push   $0x801148a0
8010682b:	e8 68 e7 ff ff       	call   80104f98 <acquire>
80106830:	83 c4 10             	add    $0x10,%esp
80106833:	a1 e0 50 11 80       	mov    0x801150e0,%eax
80106838:	83 c0 01             	add    $0x1,%eax
8010683b:	a3 e0 50 11 80       	mov    %eax,0x801150e0
80106840:	83 ec 0c             	sub    $0xc,%esp
80106843:	68 e0 50 11 80       	push   $0x801150e0
80106848:	e8 3d e5 ff ff       	call   80104d8a <wakeup>
8010684d:	83 c4 10             	add    $0x10,%esp
80106850:	83 ec 0c             	sub    $0xc,%esp
80106853:	68 a0 48 11 80       	push   $0x801148a0
80106858:	e8 a2 e7 ff ff       	call   80104fff <release>
8010685d:	83 c4 10             	add    $0x10,%esp
80106860:	e8 59 c7 ff ff       	call   80102fbe <lapiceoi>
80106865:	e9 1c 01 00 00       	jmp    80106986 <trap+0x1dd>
8010686a:	e8 62 bf ff ff       	call   801027d1 <ideintr>
8010686f:	e8 4a c7 ff ff       	call   80102fbe <lapiceoi>
80106874:	e9 0d 01 00 00       	jmp    80106986 <trap+0x1dd>
80106879:	e8 42 c5 ff ff       	call   80102dc0 <kbdintr>
8010687e:	e8 3b c7 ff ff       	call   80102fbe <lapiceoi>
80106883:	e9 fe 00 00 00       	jmp    80106986 <trap+0x1dd>
80106888:	e8 60 03 00 00       	call   80106bed <uartintr>
8010688d:	e8 2c c7 ff ff       	call   80102fbe <lapiceoi>
80106892:	e9 ef 00 00 00       	jmp    80106986 <trap+0x1dd>
80106897:	8b 45 08             	mov    0x8(%ebp),%eax
8010689a:	8b 48 38             	mov    0x38(%eax),%ecx
8010689d:	8b 45 08             	mov    0x8(%ebp),%eax
801068a0:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
801068a4:	0f b7 d0             	movzwl %ax,%edx
801068a7:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801068ad:	0f b6 00             	movzbl (%eax),%eax
801068b0:	0f b6 c0             	movzbl %al,%eax
801068b3:	51                   	push   %ecx
801068b4:	52                   	push   %edx
801068b5:	50                   	push   %eax
801068b6:	68 94 89 10 80       	push   $0x80108994
801068bb:	e8 e0 9a ff ff       	call   801003a0 <cprintf>
801068c0:	83 c4 10             	add    $0x10,%esp
801068c3:	e8 f6 c6 ff ff       	call   80102fbe <lapiceoi>
801068c8:	e9 b9 00 00 00       	jmp    80106986 <trap+0x1dd>
801068cd:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801068d3:	85 c0                	test   %eax,%eax
801068d5:	74 11                	je     801068e8 <trap+0x13f>
801068d7:	8b 45 08             	mov    0x8(%ebp),%eax
801068da:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
801068de:	0f b7 c0             	movzwl %ax,%eax
801068e1:	83 e0 03             	and    $0x3,%eax
801068e4:	85 c0                	test   %eax,%eax
801068e6:	75 40                	jne    80106928 <trap+0x17f>
801068e8:	e8 1d fd ff ff       	call   8010660a <rcr2>
801068ed:	89 c3                	mov    %eax,%ebx
801068ef:	8b 45 08             	mov    0x8(%ebp),%eax
801068f2:	8b 48 38             	mov    0x38(%eax),%ecx
801068f5:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801068fb:	0f b6 00             	movzbl (%eax),%eax
801068fe:	0f b6 d0             	movzbl %al,%edx
80106901:	8b 45 08             	mov    0x8(%ebp),%eax
80106904:	8b 40 30             	mov    0x30(%eax),%eax
80106907:	83 ec 0c             	sub    $0xc,%esp
8010690a:	53                   	push   %ebx
8010690b:	51                   	push   %ecx
8010690c:	52                   	push   %edx
8010690d:	50                   	push   %eax
8010690e:	68 b8 89 10 80       	push   $0x801089b8
80106913:	e8 88 9a ff ff       	call   801003a0 <cprintf>
80106918:	83 c4 20             	add    $0x20,%esp
8010691b:	83 ec 0c             	sub    $0xc,%esp
8010691e:	68 ea 89 10 80       	push   $0x801089ea
80106923:	e8 12 9c ff ff       	call   8010053a <panic>
80106928:	e8 dd fc ff ff       	call   8010660a <rcr2>
8010692d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106930:	8b 45 08             	mov    0x8(%ebp),%eax
80106933:	8b 70 38             	mov    0x38(%eax),%esi
80106936:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010693c:	0f b6 00             	movzbl (%eax),%eax
8010693f:	0f b6 d8             	movzbl %al,%ebx
80106942:	8b 45 08             	mov    0x8(%ebp),%eax
80106945:	8b 48 34             	mov    0x34(%eax),%ecx
80106948:	8b 45 08             	mov    0x8(%ebp),%eax
8010694b:	8b 50 30             	mov    0x30(%eax),%edx
8010694e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106954:	8d 78 6c             	lea    0x6c(%eax),%edi
80106957:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010695d:	8b 40 10             	mov    0x10(%eax),%eax
80106960:	ff 75 e4             	pushl  -0x1c(%ebp)
80106963:	56                   	push   %esi
80106964:	53                   	push   %ebx
80106965:	51                   	push   %ecx
80106966:	52                   	push   %edx
80106967:	57                   	push   %edi
80106968:	50                   	push   %eax
80106969:	68 f0 89 10 80       	push   $0x801089f0
8010696e:	e8 2d 9a ff ff       	call   801003a0 <cprintf>
80106973:	83 c4 20             	add    $0x20,%esp
80106976:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010697c:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80106983:	eb 01                	jmp    80106986 <trap+0x1dd>
80106985:	90                   	nop
80106986:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010698c:	85 c0                	test   %eax,%eax
8010698e:	74 24                	je     801069b4 <trap+0x20b>
80106990:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106996:	8b 40 24             	mov    0x24(%eax),%eax
80106999:	85 c0                	test   %eax,%eax
8010699b:	74 17                	je     801069b4 <trap+0x20b>
8010699d:	8b 45 08             	mov    0x8(%ebp),%eax
801069a0:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
801069a4:	0f b7 c0             	movzwl %ax,%eax
801069a7:	83 e0 03             	and    $0x3,%eax
801069aa:	83 f8 03             	cmp    $0x3,%eax
801069ad:	75 05                	jne    801069b4 <trap+0x20b>
801069af:	e8 ad de ff ff       	call   80104861 <exit>
801069b4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801069ba:	85 c0                	test   %eax,%eax
801069bc:	74 1e                	je     801069dc <trap+0x233>
801069be:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801069c4:	8b 40 0c             	mov    0xc(%eax),%eax
801069c7:	83 f8 04             	cmp    $0x4,%eax
801069ca:	75 10                	jne    801069dc <trap+0x233>
801069cc:	8b 45 08             	mov    0x8(%ebp),%eax
801069cf:	8b 40 30             	mov    0x30(%eax),%eax
801069d2:	83 f8 20             	cmp    $0x20,%eax
801069d5:	75 05                	jne    801069dc <trap+0x233>
801069d7:	e8 42 e2 ff ff       	call   80104c1e <yield>
801069dc:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801069e2:	85 c0                	test   %eax,%eax
801069e4:	74 27                	je     80106a0d <trap+0x264>
801069e6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801069ec:	8b 40 24             	mov    0x24(%eax),%eax
801069ef:	85 c0                	test   %eax,%eax
801069f1:	74 1a                	je     80106a0d <trap+0x264>
801069f3:	8b 45 08             	mov    0x8(%ebp),%eax
801069f6:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
801069fa:	0f b7 c0             	movzwl %ax,%eax
801069fd:	83 e0 03             	and    $0x3,%eax
80106a00:	83 f8 03             	cmp    $0x3,%eax
80106a03:	75 08                	jne    80106a0d <trap+0x264>
80106a05:	e8 57 de ff ff       	call   80104861 <exit>
80106a0a:	eb 01                	jmp    80106a0d <trap+0x264>
80106a0c:	90                   	nop
80106a0d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106a10:	5b                   	pop    %ebx
80106a11:	5e                   	pop    %esi
80106a12:	5f                   	pop    %edi
80106a13:	5d                   	pop    %ebp
80106a14:	c3                   	ret    

80106a15 <inb>:
80106a15:	55                   	push   %ebp
80106a16:	89 e5                	mov    %esp,%ebp
80106a18:	83 ec 14             	sub    $0x14,%esp
80106a1b:	8b 45 08             	mov    0x8(%ebp),%eax
80106a1e:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
80106a22:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80106a26:	89 c2                	mov    %eax,%edx
80106a28:	ec                   	in     (%dx),%al
80106a29:	88 45 ff             	mov    %al,-0x1(%ebp)
80106a2c:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
80106a30:	c9                   	leave  
80106a31:	c3                   	ret    

80106a32 <outb>:
80106a32:	55                   	push   %ebp
80106a33:	89 e5                	mov    %esp,%ebp
80106a35:	83 ec 08             	sub    $0x8,%esp
80106a38:	8b 55 08             	mov    0x8(%ebp),%edx
80106a3b:	8b 45 0c             	mov    0xc(%ebp),%eax
80106a3e:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80106a42:	88 45 f8             	mov    %al,-0x8(%ebp)
80106a45:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80106a49:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80106a4d:	ee                   	out    %al,(%dx)
80106a4e:	90                   	nop
80106a4f:	c9                   	leave  
80106a50:	c3                   	ret    

80106a51 <uartinit>:
80106a51:	55                   	push   %ebp
80106a52:	89 e5                	mov    %esp,%ebp
80106a54:	83 ec 18             	sub    $0x18,%esp
80106a57:	6a 00                	push   $0x0
80106a59:	68 fa 03 00 00       	push   $0x3fa
80106a5e:	e8 cf ff ff ff       	call   80106a32 <outb>
80106a63:	83 c4 08             	add    $0x8,%esp
80106a66:	68 80 00 00 00       	push   $0x80
80106a6b:	68 fb 03 00 00       	push   $0x3fb
80106a70:	e8 bd ff ff ff       	call   80106a32 <outb>
80106a75:	83 c4 08             	add    $0x8,%esp
80106a78:	6a 0c                	push   $0xc
80106a7a:	68 f8 03 00 00       	push   $0x3f8
80106a7f:	e8 ae ff ff ff       	call   80106a32 <outb>
80106a84:	83 c4 08             	add    $0x8,%esp
80106a87:	6a 00                	push   $0x0
80106a89:	68 f9 03 00 00       	push   $0x3f9
80106a8e:	e8 9f ff ff ff       	call   80106a32 <outb>
80106a93:	83 c4 08             	add    $0x8,%esp
80106a96:	6a 03                	push   $0x3
80106a98:	68 fb 03 00 00       	push   $0x3fb
80106a9d:	e8 90 ff ff ff       	call   80106a32 <outb>
80106aa2:	83 c4 08             	add    $0x8,%esp
80106aa5:	6a 00                	push   $0x0
80106aa7:	68 fc 03 00 00       	push   $0x3fc
80106aac:	e8 81 ff ff ff       	call   80106a32 <outb>
80106ab1:	83 c4 08             	add    $0x8,%esp
80106ab4:	6a 01                	push   $0x1
80106ab6:	68 f9 03 00 00       	push   $0x3f9
80106abb:	e8 72 ff ff ff       	call   80106a32 <outb>
80106ac0:	83 c4 08             	add    $0x8,%esp
80106ac3:	68 fd 03 00 00       	push   $0x3fd
80106ac8:	e8 48 ff ff ff       	call   80106a15 <inb>
80106acd:	83 c4 04             	add    $0x4,%esp
80106ad0:	3c ff                	cmp    $0xff,%al
80106ad2:	74 6e                	je     80106b42 <uartinit+0xf1>
80106ad4:	c7 05 4c b6 10 80 01 	movl   $0x1,0x8010b64c
80106adb:	00 00 00 
80106ade:	68 fa 03 00 00       	push   $0x3fa
80106ae3:	e8 2d ff ff ff       	call   80106a15 <inb>
80106ae8:	83 c4 04             	add    $0x4,%esp
80106aeb:	68 f8 03 00 00       	push   $0x3f8
80106af0:	e8 20 ff ff ff       	call   80106a15 <inb>
80106af5:	83 c4 04             	add    $0x4,%esp
80106af8:	83 ec 0c             	sub    $0xc,%esp
80106afb:	6a 04                	push   $0x4
80106afd:	e8 c2 d3 ff ff       	call   80103ec4 <picenable>
80106b02:	83 c4 10             	add    $0x10,%esp
80106b05:	83 ec 08             	sub    $0x8,%esp
80106b08:	6a 00                	push   $0x0
80106b0a:	6a 04                	push   $0x4
80106b0c:	e8 62 bf ff ff       	call   80102a73 <ioapicenable>
80106b11:	83 c4 10             	add    $0x10,%esp
80106b14:	c7 45 f4 b4 8a 10 80 	movl   $0x80108ab4,-0xc(%ebp)
80106b1b:	eb 19                	jmp    80106b36 <uartinit+0xe5>
80106b1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106b20:	0f b6 00             	movzbl (%eax),%eax
80106b23:	0f be c0             	movsbl %al,%eax
80106b26:	83 ec 0c             	sub    $0xc,%esp
80106b29:	50                   	push   %eax
80106b2a:	e8 16 00 00 00       	call   80106b45 <uartputc>
80106b2f:	83 c4 10             	add    $0x10,%esp
80106b32:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80106b36:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106b39:	0f b6 00             	movzbl (%eax),%eax
80106b3c:	84 c0                	test   %al,%al
80106b3e:	75 dd                	jne    80106b1d <uartinit+0xcc>
80106b40:	eb 01                	jmp    80106b43 <uartinit+0xf2>
80106b42:	90                   	nop
80106b43:	c9                   	leave  
80106b44:	c3                   	ret    

80106b45 <uartputc>:
80106b45:	55                   	push   %ebp
80106b46:	89 e5                	mov    %esp,%ebp
80106b48:	83 ec 18             	sub    $0x18,%esp
80106b4b:	a1 4c b6 10 80       	mov    0x8010b64c,%eax
80106b50:	85 c0                	test   %eax,%eax
80106b52:	74 53                	je     80106ba7 <uartputc+0x62>
80106b54:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80106b5b:	eb 11                	jmp    80106b6e <uartputc+0x29>
80106b5d:	83 ec 0c             	sub    $0xc,%esp
80106b60:	6a 0a                	push   $0xa
80106b62:	e8 72 c4 ff ff       	call   80102fd9 <microdelay>
80106b67:	83 c4 10             	add    $0x10,%esp
80106b6a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80106b6e:	83 7d f4 7f          	cmpl   $0x7f,-0xc(%ebp)
80106b72:	7f 1a                	jg     80106b8e <uartputc+0x49>
80106b74:	83 ec 0c             	sub    $0xc,%esp
80106b77:	68 fd 03 00 00       	push   $0x3fd
80106b7c:	e8 94 fe ff ff       	call   80106a15 <inb>
80106b81:	83 c4 10             	add    $0x10,%esp
80106b84:	0f b6 c0             	movzbl %al,%eax
80106b87:	83 e0 20             	and    $0x20,%eax
80106b8a:	85 c0                	test   %eax,%eax
80106b8c:	74 cf                	je     80106b5d <uartputc+0x18>
80106b8e:	8b 45 08             	mov    0x8(%ebp),%eax
80106b91:	0f b6 c0             	movzbl %al,%eax
80106b94:	83 ec 08             	sub    $0x8,%esp
80106b97:	50                   	push   %eax
80106b98:	68 f8 03 00 00       	push   $0x3f8
80106b9d:	e8 90 fe ff ff       	call   80106a32 <outb>
80106ba2:	83 c4 10             	add    $0x10,%esp
80106ba5:	eb 01                	jmp    80106ba8 <uartputc+0x63>
80106ba7:	90                   	nop
80106ba8:	c9                   	leave  
80106ba9:	c3                   	ret    

80106baa <uartgetc>:
80106baa:	55                   	push   %ebp
80106bab:	89 e5                	mov    %esp,%ebp
80106bad:	a1 4c b6 10 80       	mov    0x8010b64c,%eax
80106bb2:	85 c0                	test   %eax,%eax
80106bb4:	75 07                	jne    80106bbd <uartgetc+0x13>
80106bb6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106bbb:	eb 2e                	jmp    80106beb <uartgetc+0x41>
80106bbd:	68 fd 03 00 00       	push   $0x3fd
80106bc2:	e8 4e fe ff ff       	call   80106a15 <inb>
80106bc7:	83 c4 04             	add    $0x4,%esp
80106bca:	0f b6 c0             	movzbl %al,%eax
80106bcd:	83 e0 01             	and    $0x1,%eax
80106bd0:	85 c0                	test   %eax,%eax
80106bd2:	75 07                	jne    80106bdb <uartgetc+0x31>
80106bd4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106bd9:	eb 10                	jmp    80106beb <uartgetc+0x41>
80106bdb:	68 f8 03 00 00       	push   $0x3f8
80106be0:	e8 30 fe ff ff       	call   80106a15 <inb>
80106be5:	83 c4 04             	add    $0x4,%esp
80106be8:	0f b6 c0             	movzbl %al,%eax
80106beb:	c9                   	leave  
80106bec:	c3                   	ret    

80106bed <uartintr>:
80106bed:	55                   	push   %ebp
80106bee:	89 e5                	mov    %esp,%ebp
80106bf0:	83 ec 08             	sub    $0x8,%esp
80106bf3:	83 ec 0c             	sub    $0xc,%esp
80106bf6:	68 aa 6b 10 80       	push   $0x80106baa
80106bfb:	e8 c8 9b ff ff       	call   801007c8 <consoleintr>
80106c00:	83 c4 10             	add    $0x10,%esp
80106c03:	90                   	nop
80106c04:	c9                   	leave  
80106c05:	c3                   	ret    

80106c06 <vector0>:
80106c06:	6a 00                	push   $0x0
80106c08:	6a 00                	push   $0x0
80106c0a:	e9 a6 f9 ff ff       	jmp    801065b5 <alltraps>

80106c0f <vector1>:
80106c0f:	6a 00                	push   $0x0
80106c11:	6a 01                	push   $0x1
80106c13:	e9 9d f9 ff ff       	jmp    801065b5 <alltraps>

80106c18 <vector2>:
80106c18:	6a 00                	push   $0x0
80106c1a:	6a 02                	push   $0x2
80106c1c:	e9 94 f9 ff ff       	jmp    801065b5 <alltraps>

80106c21 <vector3>:
80106c21:	6a 00                	push   $0x0
80106c23:	6a 03                	push   $0x3
80106c25:	e9 8b f9 ff ff       	jmp    801065b5 <alltraps>

80106c2a <vector4>:
80106c2a:	6a 00                	push   $0x0
80106c2c:	6a 04                	push   $0x4
80106c2e:	e9 82 f9 ff ff       	jmp    801065b5 <alltraps>

80106c33 <vector5>:
80106c33:	6a 00                	push   $0x0
80106c35:	6a 05                	push   $0x5
80106c37:	e9 79 f9 ff ff       	jmp    801065b5 <alltraps>

80106c3c <vector6>:
80106c3c:	6a 00                	push   $0x0
80106c3e:	6a 06                	push   $0x6
80106c40:	e9 70 f9 ff ff       	jmp    801065b5 <alltraps>

80106c45 <vector7>:
80106c45:	6a 00                	push   $0x0
80106c47:	6a 07                	push   $0x7
80106c49:	e9 67 f9 ff ff       	jmp    801065b5 <alltraps>

80106c4e <vector8>:
80106c4e:	6a 08                	push   $0x8
80106c50:	e9 60 f9 ff ff       	jmp    801065b5 <alltraps>

80106c55 <vector9>:
80106c55:	6a 00                	push   $0x0
80106c57:	6a 09                	push   $0x9
80106c59:	e9 57 f9 ff ff       	jmp    801065b5 <alltraps>

80106c5e <vector10>:
80106c5e:	6a 0a                	push   $0xa
80106c60:	e9 50 f9 ff ff       	jmp    801065b5 <alltraps>

80106c65 <vector11>:
80106c65:	6a 0b                	push   $0xb
80106c67:	e9 49 f9 ff ff       	jmp    801065b5 <alltraps>

80106c6c <vector12>:
80106c6c:	6a 0c                	push   $0xc
80106c6e:	e9 42 f9 ff ff       	jmp    801065b5 <alltraps>

80106c73 <vector13>:
80106c73:	6a 0d                	push   $0xd
80106c75:	e9 3b f9 ff ff       	jmp    801065b5 <alltraps>

80106c7a <vector14>:
80106c7a:	6a 0e                	push   $0xe
80106c7c:	e9 34 f9 ff ff       	jmp    801065b5 <alltraps>

80106c81 <vector15>:
80106c81:	6a 00                	push   $0x0
80106c83:	6a 0f                	push   $0xf
80106c85:	e9 2b f9 ff ff       	jmp    801065b5 <alltraps>

80106c8a <vector16>:
80106c8a:	6a 00                	push   $0x0
80106c8c:	6a 10                	push   $0x10
80106c8e:	e9 22 f9 ff ff       	jmp    801065b5 <alltraps>

80106c93 <vector17>:
80106c93:	6a 11                	push   $0x11
80106c95:	e9 1b f9 ff ff       	jmp    801065b5 <alltraps>

80106c9a <vector18>:
80106c9a:	6a 00                	push   $0x0
80106c9c:	6a 12                	push   $0x12
80106c9e:	e9 12 f9 ff ff       	jmp    801065b5 <alltraps>

80106ca3 <vector19>:
80106ca3:	6a 00                	push   $0x0
80106ca5:	6a 13                	push   $0x13
80106ca7:	e9 09 f9 ff ff       	jmp    801065b5 <alltraps>

80106cac <vector20>:
80106cac:	6a 00                	push   $0x0
80106cae:	6a 14                	push   $0x14
80106cb0:	e9 00 f9 ff ff       	jmp    801065b5 <alltraps>

80106cb5 <vector21>:
80106cb5:	6a 00                	push   $0x0
80106cb7:	6a 15                	push   $0x15
80106cb9:	e9 f7 f8 ff ff       	jmp    801065b5 <alltraps>

80106cbe <vector22>:
80106cbe:	6a 00                	push   $0x0
80106cc0:	6a 16                	push   $0x16
80106cc2:	e9 ee f8 ff ff       	jmp    801065b5 <alltraps>

80106cc7 <vector23>:
80106cc7:	6a 00                	push   $0x0
80106cc9:	6a 17                	push   $0x17
80106ccb:	e9 e5 f8 ff ff       	jmp    801065b5 <alltraps>

80106cd0 <vector24>:
80106cd0:	6a 00                	push   $0x0
80106cd2:	6a 18                	push   $0x18
80106cd4:	e9 dc f8 ff ff       	jmp    801065b5 <alltraps>

80106cd9 <vector25>:
80106cd9:	6a 00                	push   $0x0
80106cdb:	6a 19                	push   $0x19
80106cdd:	e9 d3 f8 ff ff       	jmp    801065b5 <alltraps>

80106ce2 <vector26>:
80106ce2:	6a 00                	push   $0x0
80106ce4:	6a 1a                	push   $0x1a
80106ce6:	e9 ca f8 ff ff       	jmp    801065b5 <alltraps>

80106ceb <vector27>:
80106ceb:	6a 00                	push   $0x0
80106ced:	6a 1b                	push   $0x1b
80106cef:	e9 c1 f8 ff ff       	jmp    801065b5 <alltraps>

80106cf4 <vector28>:
80106cf4:	6a 00                	push   $0x0
80106cf6:	6a 1c                	push   $0x1c
80106cf8:	e9 b8 f8 ff ff       	jmp    801065b5 <alltraps>

80106cfd <vector29>:
80106cfd:	6a 00                	push   $0x0
80106cff:	6a 1d                	push   $0x1d
80106d01:	e9 af f8 ff ff       	jmp    801065b5 <alltraps>

80106d06 <vector30>:
80106d06:	6a 00                	push   $0x0
80106d08:	6a 1e                	push   $0x1e
80106d0a:	e9 a6 f8 ff ff       	jmp    801065b5 <alltraps>

80106d0f <vector31>:
80106d0f:	6a 00                	push   $0x0
80106d11:	6a 1f                	push   $0x1f
80106d13:	e9 9d f8 ff ff       	jmp    801065b5 <alltraps>

80106d18 <vector32>:
80106d18:	6a 00                	push   $0x0
80106d1a:	6a 20                	push   $0x20
80106d1c:	e9 94 f8 ff ff       	jmp    801065b5 <alltraps>

80106d21 <vector33>:
80106d21:	6a 00                	push   $0x0
80106d23:	6a 21                	push   $0x21
80106d25:	e9 8b f8 ff ff       	jmp    801065b5 <alltraps>

80106d2a <vector34>:
80106d2a:	6a 00                	push   $0x0
80106d2c:	6a 22                	push   $0x22
80106d2e:	e9 82 f8 ff ff       	jmp    801065b5 <alltraps>

80106d33 <vector35>:
80106d33:	6a 00                	push   $0x0
80106d35:	6a 23                	push   $0x23
80106d37:	e9 79 f8 ff ff       	jmp    801065b5 <alltraps>

80106d3c <vector36>:
80106d3c:	6a 00                	push   $0x0
80106d3e:	6a 24                	push   $0x24
80106d40:	e9 70 f8 ff ff       	jmp    801065b5 <alltraps>

80106d45 <vector37>:
80106d45:	6a 00                	push   $0x0
80106d47:	6a 25                	push   $0x25
80106d49:	e9 67 f8 ff ff       	jmp    801065b5 <alltraps>

80106d4e <vector38>:
80106d4e:	6a 00                	push   $0x0
80106d50:	6a 26                	push   $0x26
80106d52:	e9 5e f8 ff ff       	jmp    801065b5 <alltraps>

80106d57 <vector39>:
80106d57:	6a 00                	push   $0x0
80106d59:	6a 27                	push   $0x27
80106d5b:	e9 55 f8 ff ff       	jmp    801065b5 <alltraps>

80106d60 <vector40>:
80106d60:	6a 00                	push   $0x0
80106d62:	6a 28                	push   $0x28
80106d64:	e9 4c f8 ff ff       	jmp    801065b5 <alltraps>

80106d69 <vector41>:
80106d69:	6a 00                	push   $0x0
80106d6b:	6a 29                	push   $0x29
80106d6d:	e9 43 f8 ff ff       	jmp    801065b5 <alltraps>

80106d72 <vector42>:
80106d72:	6a 00                	push   $0x0
80106d74:	6a 2a                	push   $0x2a
80106d76:	e9 3a f8 ff ff       	jmp    801065b5 <alltraps>

80106d7b <vector43>:
80106d7b:	6a 00                	push   $0x0
80106d7d:	6a 2b                	push   $0x2b
80106d7f:	e9 31 f8 ff ff       	jmp    801065b5 <alltraps>

80106d84 <vector44>:
80106d84:	6a 00                	push   $0x0
80106d86:	6a 2c                	push   $0x2c
80106d88:	e9 28 f8 ff ff       	jmp    801065b5 <alltraps>

80106d8d <vector45>:
80106d8d:	6a 00                	push   $0x0
80106d8f:	6a 2d                	push   $0x2d
80106d91:	e9 1f f8 ff ff       	jmp    801065b5 <alltraps>

80106d96 <vector46>:
80106d96:	6a 00                	push   $0x0
80106d98:	6a 2e                	push   $0x2e
80106d9a:	e9 16 f8 ff ff       	jmp    801065b5 <alltraps>

80106d9f <vector47>:
80106d9f:	6a 00                	push   $0x0
80106da1:	6a 2f                	push   $0x2f
80106da3:	e9 0d f8 ff ff       	jmp    801065b5 <alltraps>

80106da8 <vector48>:
80106da8:	6a 00                	push   $0x0
80106daa:	6a 30                	push   $0x30
80106dac:	e9 04 f8 ff ff       	jmp    801065b5 <alltraps>

80106db1 <vector49>:
80106db1:	6a 00                	push   $0x0
80106db3:	6a 31                	push   $0x31
80106db5:	e9 fb f7 ff ff       	jmp    801065b5 <alltraps>

80106dba <vector50>:
80106dba:	6a 00                	push   $0x0
80106dbc:	6a 32                	push   $0x32
80106dbe:	e9 f2 f7 ff ff       	jmp    801065b5 <alltraps>

80106dc3 <vector51>:
80106dc3:	6a 00                	push   $0x0
80106dc5:	6a 33                	push   $0x33
80106dc7:	e9 e9 f7 ff ff       	jmp    801065b5 <alltraps>

80106dcc <vector52>:
80106dcc:	6a 00                	push   $0x0
80106dce:	6a 34                	push   $0x34
80106dd0:	e9 e0 f7 ff ff       	jmp    801065b5 <alltraps>

80106dd5 <vector53>:
80106dd5:	6a 00                	push   $0x0
80106dd7:	6a 35                	push   $0x35
80106dd9:	e9 d7 f7 ff ff       	jmp    801065b5 <alltraps>

80106dde <vector54>:
80106dde:	6a 00                	push   $0x0
80106de0:	6a 36                	push   $0x36
80106de2:	e9 ce f7 ff ff       	jmp    801065b5 <alltraps>

80106de7 <vector55>:
80106de7:	6a 00                	push   $0x0
80106de9:	6a 37                	push   $0x37
80106deb:	e9 c5 f7 ff ff       	jmp    801065b5 <alltraps>

80106df0 <vector56>:
80106df0:	6a 00                	push   $0x0
80106df2:	6a 38                	push   $0x38
80106df4:	e9 bc f7 ff ff       	jmp    801065b5 <alltraps>

80106df9 <vector57>:
80106df9:	6a 00                	push   $0x0
80106dfb:	6a 39                	push   $0x39
80106dfd:	e9 b3 f7 ff ff       	jmp    801065b5 <alltraps>

80106e02 <vector58>:
80106e02:	6a 00                	push   $0x0
80106e04:	6a 3a                	push   $0x3a
80106e06:	e9 aa f7 ff ff       	jmp    801065b5 <alltraps>

80106e0b <vector59>:
80106e0b:	6a 00                	push   $0x0
80106e0d:	6a 3b                	push   $0x3b
80106e0f:	e9 a1 f7 ff ff       	jmp    801065b5 <alltraps>

80106e14 <vector60>:
80106e14:	6a 00                	push   $0x0
80106e16:	6a 3c                	push   $0x3c
80106e18:	e9 98 f7 ff ff       	jmp    801065b5 <alltraps>

80106e1d <vector61>:
80106e1d:	6a 00                	push   $0x0
80106e1f:	6a 3d                	push   $0x3d
80106e21:	e9 8f f7 ff ff       	jmp    801065b5 <alltraps>

80106e26 <vector62>:
80106e26:	6a 00                	push   $0x0
80106e28:	6a 3e                	push   $0x3e
80106e2a:	e9 86 f7 ff ff       	jmp    801065b5 <alltraps>

80106e2f <vector63>:
80106e2f:	6a 00                	push   $0x0
80106e31:	6a 3f                	push   $0x3f
80106e33:	e9 7d f7 ff ff       	jmp    801065b5 <alltraps>

80106e38 <vector64>:
80106e38:	6a 00                	push   $0x0
80106e3a:	6a 40                	push   $0x40
80106e3c:	e9 74 f7 ff ff       	jmp    801065b5 <alltraps>

80106e41 <vector65>:
80106e41:	6a 00                	push   $0x0
80106e43:	6a 41                	push   $0x41
80106e45:	e9 6b f7 ff ff       	jmp    801065b5 <alltraps>

80106e4a <vector66>:
80106e4a:	6a 00                	push   $0x0
80106e4c:	6a 42                	push   $0x42
80106e4e:	e9 62 f7 ff ff       	jmp    801065b5 <alltraps>

80106e53 <vector67>:
80106e53:	6a 00                	push   $0x0
80106e55:	6a 43                	push   $0x43
80106e57:	e9 59 f7 ff ff       	jmp    801065b5 <alltraps>

80106e5c <vector68>:
80106e5c:	6a 00                	push   $0x0
80106e5e:	6a 44                	push   $0x44
80106e60:	e9 50 f7 ff ff       	jmp    801065b5 <alltraps>

80106e65 <vector69>:
80106e65:	6a 00                	push   $0x0
80106e67:	6a 45                	push   $0x45
80106e69:	e9 47 f7 ff ff       	jmp    801065b5 <alltraps>

80106e6e <vector70>:
80106e6e:	6a 00                	push   $0x0
80106e70:	6a 46                	push   $0x46
80106e72:	e9 3e f7 ff ff       	jmp    801065b5 <alltraps>

80106e77 <vector71>:
80106e77:	6a 00                	push   $0x0
80106e79:	6a 47                	push   $0x47
80106e7b:	e9 35 f7 ff ff       	jmp    801065b5 <alltraps>

80106e80 <vector72>:
80106e80:	6a 00                	push   $0x0
80106e82:	6a 48                	push   $0x48
80106e84:	e9 2c f7 ff ff       	jmp    801065b5 <alltraps>

80106e89 <vector73>:
80106e89:	6a 00                	push   $0x0
80106e8b:	6a 49                	push   $0x49
80106e8d:	e9 23 f7 ff ff       	jmp    801065b5 <alltraps>

80106e92 <vector74>:
80106e92:	6a 00                	push   $0x0
80106e94:	6a 4a                	push   $0x4a
80106e96:	e9 1a f7 ff ff       	jmp    801065b5 <alltraps>

80106e9b <vector75>:
80106e9b:	6a 00                	push   $0x0
80106e9d:	6a 4b                	push   $0x4b
80106e9f:	e9 11 f7 ff ff       	jmp    801065b5 <alltraps>

80106ea4 <vector76>:
80106ea4:	6a 00                	push   $0x0
80106ea6:	6a 4c                	push   $0x4c
80106ea8:	e9 08 f7 ff ff       	jmp    801065b5 <alltraps>

80106ead <vector77>:
80106ead:	6a 00                	push   $0x0
80106eaf:	6a 4d                	push   $0x4d
80106eb1:	e9 ff f6 ff ff       	jmp    801065b5 <alltraps>

80106eb6 <vector78>:
80106eb6:	6a 00                	push   $0x0
80106eb8:	6a 4e                	push   $0x4e
80106eba:	e9 f6 f6 ff ff       	jmp    801065b5 <alltraps>

80106ebf <vector79>:
80106ebf:	6a 00                	push   $0x0
80106ec1:	6a 4f                	push   $0x4f
80106ec3:	e9 ed f6 ff ff       	jmp    801065b5 <alltraps>

80106ec8 <vector80>:
80106ec8:	6a 00                	push   $0x0
80106eca:	6a 50                	push   $0x50
80106ecc:	e9 e4 f6 ff ff       	jmp    801065b5 <alltraps>

80106ed1 <vector81>:
80106ed1:	6a 00                	push   $0x0
80106ed3:	6a 51                	push   $0x51
80106ed5:	e9 db f6 ff ff       	jmp    801065b5 <alltraps>

80106eda <vector82>:
80106eda:	6a 00                	push   $0x0
80106edc:	6a 52                	push   $0x52
80106ede:	e9 d2 f6 ff ff       	jmp    801065b5 <alltraps>

80106ee3 <vector83>:
80106ee3:	6a 00                	push   $0x0
80106ee5:	6a 53                	push   $0x53
80106ee7:	e9 c9 f6 ff ff       	jmp    801065b5 <alltraps>

80106eec <vector84>:
80106eec:	6a 00                	push   $0x0
80106eee:	6a 54                	push   $0x54
80106ef0:	e9 c0 f6 ff ff       	jmp    801065b5 <alltraps>

80106ef5 <vector85>:
80106ef5:	6a 00                	push   $0x0
80106ef7:	6a 55                	push   $0x55
80106ef9:	e9 b7 f6 ff ff       	jmp    801065b5 <alltraps>

80106efe <vector86>:
80106efe:	6a 00                	push   $0x0
80106f00:	6a 56                	push   $0x56
80106f02:	e9 ae f6 ff ff       	jmp    801065b5 <alltraps>

80106f07 <vector87>:
80106f07:	6a 00                	push   $0x0
80106f09:	6a 57                	push   $0x57
80106f0b:	e9 a5 f6 ff ff       	jmp    801065b5 <alltraps>

80106f10 <vector88>:
80106f10:	6a 00                	push   $0x0
80106f12:	6a 58                	push   $0x58
80106f14:	e9 9c f6 ff ff       	jmp    801065b5 <alltraps>

80106f19 <vector89>:
80106f19:	6a 00                	push   $0x0
80106f1b:	6a 59                	push   $0x59
80106f1d:	e9 93 f6 ff ff       	jmp    801065b5 <alltraps>

80106f22 <vector90>:
80106f22:	6a 00                	push   $0x0
80106f24:	6a 5a                	push   $0x5a
80106f26:	e9 8a f6 ff ff       	jmp    801065b5 <alltraps>

80106f2b <vector91>:
80106f2b:	6a 00                	push   $0x0
80106f2d:	6a 5b                	push   $0x5b
80106f2f:	e9 81 f6 ff ff       	jmp    801065b5 <alltraps>

80106f34 <vector92>:
80106f34:	6a 00                	push   $0x0
80106f36:	6a 5c                	push   $0x5c
80106f38:	e9 78 f6 ff ff       	jmp    801065b5 <alltraps>

80106f3d <vector93>:
80106f3d:	6a 00                	push   $0x0
80106f3f:	6a 5d                	push   $0x5d
80106f41:	e9 6f f6 ff ff       	jmp    801065b5 <alltraps>

80106f46 <vector94>:
80106f46:	6a 00                	push   $0x0
80106f48:	6a 5e                	push   $0x5e
80106f4a:	e9 66 f6 ff ff       	jmp    801065b5 <alltraps>

80106f4f <vector95>:
80106f4f:	6a 00                	push   $0x0
80106f51:	6a 5f                	push   $0x5f
80106f53:	e9 5d f6 ff ff       	jmp    801065b5 <alltraps>

80106f58 <vector96>:
80106f58:	6a 00                	push   $0x0
80106f5a:	6a 60                	push   $0x60
80106f5c:	e9 54 f6 ff ff       	jmp    801065b5 <alltraps>

80106f61 <vector97>:
80106f61:	6a 00                	push   $0x0
80106f63:	6a 61                	push   $0x61
80106f65:	e9 4b f6 ff ff       	jmp    801065b5 <alltraps>

80106f6a <vector98>:
80106f6a:	6a 00                	push   $0x0
80106f6c:	6a 62                	push   $0x62
80106f6e:	e9 42 f6 ff ff       	jmp    801065b5 <alltraps>

80106f73 <vector99>:
80106f73:	6a 00                	push   $0x0
80106f75:	6a 63                	push   $0x63
80106f77:	e9 39 f6 ff ff       	jmp    801065b5 <alltraps>

80106f7c <vector100>:
80106f7c:	6a 00                	push   $0x0
80106f7e:	6a 64                	push   $0x64
80106f80:	e9 30 f6 ff ff       	jmp    801065b5 <alltraps>

80106f85 <vector101>:
80106f85:	6a 00                	push   $0x0
80106f87:	6a 65                	push   $0x65
80106f89:	e9 27 f6 ff ff       	jmp    801065b5 <alltraps>

80106f8e <vector102>:
80106f8e:	6a 00                	push   $0x0
80106f90:	6a 66                	push   $0x66
80106f92:	e9 1e f6 ff ff       	jmp    801065b5 <alltraps>

80106f97 <vector103>:
80106f97:	6a 00                	push   $0x0
80106f99:	6a 67                	push   $0x67
80106f9b:	e9 15 f6 ff ff       	jmp    801065b5 <alltraps>

80106fa0 <vector104>:
80106fa0:	6a 00                	push   $0x0
80106fa2:	6a 68                	push   $0x68
80106fa4:	e9 0c f6 ff ff       	jmp    801065b5 <alltraps>

80106fa9 <vector105>:
80106fa9:	6a 00                	push   $0x0
80106fab:	6a 69                	push   $0x69
80106fad:	e9 03 f6 ff ff       	jmp    801065b5 <alltraps>

80106fb2 <vector106>:
80106fb2:	6a 00                	push   $0x0
80106fb4:	6a 6a                	push   $0x6a
80106fb6:	e9 fa f5 ff ff       	jmp    801065b5 <alltraps>

80106fbb <vector107>:
80106fbb:	6a 00                	push   $0x0
80106fbd:	6a 6b                	push   $0x6b
80106fbf:	e9 f1 f5 ff ff       	jmp    801065b5 <alltraps>

80106fc4 <vector108>:
80106fc4:	6a 00                	push   $0x0
80106fc6:	6a 6c                	push   $0x6c
80106fc8:	e9 e8 f5 ff ff       	jmp    801065b5 <alltraps>

80106fcd <vector109>:
80106fcd:	6a 00                	push   $0x0
80106fcf:	6a 6d                	push   $0x6d
80106fd1:	e9 df f5 ff ff       	jmp    801065b5 <alltraps>

80106fd6 <vector110>:
80106fd6:	6a 00                	push   $0x0
80106fd8:	6a 6e                	push   $0x6e
80106fda:	e9 d6 f5 ff ff       	jmp    801065b5 <alltraps>

80106fdf <vector111>:
80106fdf:	6a 00                	push   $0x0
80106fe1:	6a 6f                	push   $0x6f
80106fe3:	e9 cd f5 ff ff       	jmp    801065b5 <alltraps>

80106fe8 <vector112>:
80106fe8:	6a 00                	push   $0x0
80106fea:	6a 70                	push   $0x70
80106fec:	e9 c4 f5 ff ff       	jmp    801065b5 <alltraps>

80106ff1 <vector113>:
80106ff1:	6a 00                	push   $0x0
80106ff3:	6a 71                	push   $0x71
80106ff5:	e9 bb f5 ff ff       	jmp    801065b5 <alltraps>

80106ffa <vector114>:
80106ffa:	6a 00                	push   $0x0
80106ffc:	6a 72                	push   $0x72
80106ffe:	e9 b2 f5 ff ff       	jmp    801065b5 <alltraps>

80107003 <vector115>:
80107003:	6a 00                	push   $0x0
80107005:	6a 73                	push   $0x73
80107007:	e9 a9 f5 ff ff       	jmp    801065b5 <alltraps>

8010700c <vector116>:
8010700c:	6a 00                	push   $0x0
8010700e:	6a 74                	push   $0x74
80107010:	e9 a0 f5 ff ff       	jmp    801065b5 <alltraps>

80107015 <vector117>:
80107015:	6a 00                	push   $0x0
80107017:	6a 75                	push   $0x75
80107019:	e9 97 f5 ff ff       	jmp    801065b5 <alltraps>

8010701e <vector118>:
8010701e:	6a 00                	push   $0x0
80107020:	6a 76                	push   $0x76
80107022:	e9 8e f5 ff ff       	jmp    801065b5 <alltraps>

80107027 <vector119>:
80107027:	6a 00                	push   $0x0
80107029:	6a 77                	push   $0x77
8010702b:	e9 85 f5 ff ff       	jmp    801065b5 <alltraps>

80107030 <vector120>:
80107030:	6a 00                	push   $0x0
80107032:	6a 78                	push   $0x78
80107034:	e9 7c f5 ff ff       	jmp    801065b5 <alltraps>

80107039 <vector121>:
80107039:	6a 00                	push   $0x0
8010703b:	6a 79                	push   $0x79
8010703d:	e9 73 f5 ff ff       	jmp    801065b5 <alltraps>

80107042 <vector122>:
80107042:	6a 00                	push   $0x0
80107044:	6a 7a                	push   $0x7a
80107046:	e9 6a f5 ff ff       	jmp    801065b5 <alltraps>

8010704b <vector123>:
8010704b:	6a 00                	push   $0x0
8010704d:	6a 7b                	push   $0x7b
8010704f:	e9 61 f5 ff ff       	jmp    801065b5 <alltraps>

80107054 <vector124>:
80107054:	6a 00                	push   $0x0
80107056:	6a 7c                	push   $0x7c
80107058:	e9 58 f5 ff ff       	jmp    801065b5 <alltraps>

8010705d <vector125>:
8010705d:	6a 00                	push   $0x0
8010705f:	6a 7d                	push   $0x7d
80107061:	e9 4f f5 ff ff       	jmp    801065b5 <alltraps>

80107066 <vector126>:
80107066:	6a 00                	push   $0x0
80107068:	6a 7e                	push   $0x7e
8010706a:	e9 46 f5 ff ff       	jmp    801065b5 <alltraps>

8010706f <vector127>:
8010706f:	6a 00                	push   $0x0
80107071:	6a 7f                	push   $0x7f
80107073:	e9 3d f5 ff ff       	jmp    801065b5 <alltraps>

80107078 <vector128>:
80107078:	6a 00                	push   $0x0
8010707a:	68 80 00 00 00       	push   $0x80
8010707f:	e9 31 f5 ff ff       	jmp    801065b5 <alltraps>

80107084 <vector129>:
80107084:	6a 00                	push   $0x0
80107086:	68 81 00 00 00       	push   $0x81
8010708b:	e9 25 f5 ff ff       	jmp    801065b5 <alltraps>

80107090 <vector130>:
80107090:	6a 00                	push   $0x0
80107092:	68 82 00 00 00       	push   $0x82
80107097:	e9 19 f5 ff ff       	jmp    801065b5 <alltraps>

8010709c <vector131>:
8010709c:	6a 00                	push   $0x0
8010709e:	68 83 00 00 00       	push   $0x83
801070a3:	e9 0d f5 ff ff       	jmp    801065b5 <alltraps>

801070a8 <vector132>:
801070a8:	6a 00                	push   $0x0
801070aa:	68 84 00 00 00       	push   $0x84
801070af:	e9 01 f5 ff ff       	jmp    801065b5 <alltraps>

801070b4 <vector133>:
801070b4:	6a 00                	push   $0x0
801070b6:	68 85 00 00 00       	push   $0x85
801070bb:	e9 f5 f4 ff ff       	jmp    801065b5 <alltraps>

801070c0 <vector134>:
801070c0:	6a 00                	push   $0x0
801070c2:	68 86 00 00 00       	push   $0x86
801070c7:	e9 e9 f4 ff ff       	jmp    801065b5 <alltraps>

801070cc <vector135>:
801070cc:	6a 00                	push   $0x0
801070ce:	68 87 00 00 00       	push   $0x87
801070d3:	e9 dd f4 ff ff       	jmp    801065b5 <alltraps>

801070d8 <vector136>:
801070d8:	6a 00                	push   $0x0
801070da:	68 88 00 00 00       	push   $0x88
801070df:	e9 d1 f4 ff ff       	jmp    801065b5 <alltraps>

801070e4 <vector137>:
801070e4:	6a 00                	push   $0x0
801070e6:	68 89 00 00 00       	push   $0x89
801070eb:	e9 c5 f4 ff ff       	jmp    801065b5 <alltraps>

801070f0 <vector138>:
801070f0:	6a 00                	push   $0x0
801070f2:	68 8a 00 00 00       	push   $0x8a
801070f7:	e9 b9 f4 ff ff       	jmp    801065b5 <alltraps>

801070fc <vector139>:
801070fc:	6a 00                	push   $0x0
801070fe:	68 8b 00 00 00       	push   $0x8b
80107103:	e9 ad f4 ff ff       	jmp    801065b5 <alltraps>

80107108 <vector140>:
80107108:	6a 00                	push   $0x0
8010710a:	68 8c 00 00 00       	push   $0x8c
8010710f:	e9 a1 f4 ff ff       	jmp    801065b5 <alltraps>

80107114 <vector141>:
80107114:	6a 00                	push   $0x0
80107116:	68 8d 00 00 00       	push   $0x8d
8010711b:	e9 95 f4 ff ff       	jmp    801065b5 <alltraps>

80107120 <vector142>:
80107120:	6a 00                	push   $0x0
80107122:	68 8e 00 00 00       	push   $0x8e
80107127:	e9 89 f4 ff ff       	jmp    801065b5 <alltraps>

8010712c <vector143>:
8010712c:	6a 00                	push   $0x0
8010712e:	68 8f 00 00 00       	push   $0x8f
80107133:	e9 7d f4 ff ff       	jmp    801065b5 <alltraps>

80107138 <vector144>:
80107138:	6a 00                	push   $0x0
8010713a:	68 90 00 00 00       	push   $0x90
8010713f:	e9 71 f4 ff ff       	jmp    801065b5 <alltraps>

80107144 <vector145>:
80107144:	6a 00                	push   $0x0
80107146:	68 91 00 00 00       	push   $0x91
8010714b:	e9 65 f4 ff ff       	jmp    801065b5 <alltraps>

80107150 <vector146>:
80107150:	6a 00                	push   $0x0
80107152:	68 92 00 00 00       	push   $0x92
80107157:	e9 59 f4 ff ff       	jmp    801065b5 <alltraps>

8010715c <vector147>:
8010715c:	6a 00                	push   $0x0
8010715e:	68 93 00 00 00       	push   $0x93
80107163:	e9 4d f4 ff ff       	jmp    801065b5 <alltraps>

80107168 <vector148>:
80107168:	6a 00                	push   $0x0
8010716a:	68 94 00 00 00       	push   $0x94
8010716f:	e9 41 f4 ff ff       	jmp    801065b5 <alltraps>

80107174 <vector149>:
80107174:	6a 00                	push   $0x0
80107176:	68 95 00 00 00       	push   $0x95
8010717b:	e9 35 f4 ff ff       	jmp    801065b5 <alltraps>

80107180 <vector150>:
80107180:	6a 00                	push   $0x0
80107182:	68 96 00 00 00       	push   $0x96
80107187:	e9 29 f4 ff ff       	jmp    801065b5 <alltraps>

8010718c <vector151>:
8010718c:	6a 00                	push   $0x0
8010718e:	68 97 00 00 00       	push   $0x97
80107193:	e9 1d f4 ff ff       	jmp    801065b5 <alltraps>

80107198 <vector152>:
80107198:	6a 00                	push   $0x0
8010719a:	68 98 00 00 00       	push   $0x98
8010719f:	e9 11 f4 ff ff       	jmp    801065b5 <alltraps>

801071a4 <vector153>:
801071a4:	6a 00                	push   $0x0
801071a6:	68 99 00 00 00       	push   $0x99
801071ab:	e9 05 f4 ff ff       	jmp    801065b5 <alltraps>

801071b0 <vector154>:
801071b0:	6a 00                	push   $0x0
801071b2:	68 9a 00 00 00       	push   $0x9a
801071b7:	e9 f9 f3 ff ff       	jmp    801065b5 <alltraps>

801071bc <vector155>:
801071bc:	6a 00                	push   $0x0
801071be:	68 9b 00 00 00       	push   $0x9b
801071c3:	e9 ed f3 ff ff       	jmp    801065b5 <alltraps>

801071c8 <vector156>:
801071c8:	6a 00                	push   $0x0
801071ca:	68 9c 00 00 00       	push   $0x9c
801071cf:	e9 e1 f3 ff ff       	jmp    801065b5 <alltraps>

801071d4 <vector157>:
801071d4:	6a 00                	push   $0x0
801071d6:	68 9d 00 00 00       	push   $0x9d
801071db:	e9 d5 f3 ff ff       	jmp    801065b5 <alltraps>

801071e0 <vector158>:
801071e0:	6a 00                	push   $0x0
801071e2:	68 9e 00 00 00       	push   $0x9e
801071e7:	e9 c9 f3 ff ff       	jmp    801065b5 <alltraps>

801071ec <vector159>:
801071ec:	6a 00                	push   $0x0
801071ee:	68 9f 00 00 00       	push   $0x9f
801071f3:	e9 bd f3 ff ff       	jmp    801065b5 <alltraps>

801071f8 <vector160>:
801071f8:	6a 00                	push   $0x0
801071fa:	68 a0 00 00 00       	push   $0xa0
801071ff:	e9 b1 f3 ff ff       	jmp    801065b5 <alltraps>

80107204 <vector161>:
80107204:	6a 00                	push   $0x0
80107206:	68 a1 00 00 00       	push   $0xa1
8010720b:	e9 a5 f3 ff ff       	jmp    801065b5 <alltraps>

80107210 <vector162>:
80107210:	6a 00                	push   $0x0
80107212:	68 a2 00 00 00       	push   $0xa2
80107217:	e9 99 f3 ff ff       	jmp    801065b5 <alltraps>

8010721c <vector163>:
8010721c:	6a 00                	push   $0x0
8010721e:	68 a3 00 00 00       	push   $0xa3
80107223:	e9 8d f3 ff ff       	jmp    801065b5 <alltraps>

80107228 <vector164>:
80107228:	6a 00                	push   $0x0
8010722a:	68 a4 00 00 00       	push   $0xa4
8010722f:	e9 81 f3 ff ff       	jmp    801065b5 <alltraps>

80107234 <vector165>:
80107234:	6a 00                	push   $0x0
80107236:	68 a5 00 00 00       	push   $0xa5
8010723b:	e9 75 f3 ff ff       	jmp    801065b5 <alltraps>

80107240 <vector166>:
80107240:	6a 00                	push   $0x0
80107242:	68 a6 00 00 00       	push   $0xa6
80107247:	e9 69 f3 ff ff       	jmp    801065b5 <alltraps>

8010724c <vector167>:
8010724c:	6a 00                	push   $0x0
8010724e:	68 a7 00 00 00       	push   $0xa7
80107253:	e9 5d f3 ff ff       	jmp    801065b5 <alltraps>

80107258 <vector168>:
80107258:	6a 00                	push   $0x0
8010725a:	68 a8 00 00 00       	push   $0xa8
8010725f:	e9 51 f3 ff ff       	jmp    801065b5 <alltraps>

80107264 <vector169>:
80107264:	6a 00                	push   $0x0
80107266:	68 a9 00 00 00       	push   $0xa9
8010726b:	e9 45 f3 ff ff       	jmp    801065b5 <alltraps>

80107270 <vector170>:
80107270:	6a 00                	push   $0x0
80107272:	68 aa 00 00 00       	push   $0xaa
80107277:	e9 39 f3 ff ff       	jmp    801065b5 <alltraps>

8010727c <vector171>:
8010727c:	6a 00                	push   $0x0
8010727e:	68 ab 00 00 00       	push   $0xab
80107283:	e9 2d f3 ff ff       	jmp    801065b5 <alltraps>

80107288 <vector172>:
80107288:	6a 00                	push   $0x0
8010728a:	68 ac 00 00 00       	push   $0xac
8010728f:	e9 21 f3 ff ff       	jmp    801065b5 <alltraps>

80107294 <vector173>:
80107294:	6a 00                	push   $0x0
80107296:	68 ad 00 00 00       	push   $0xad
8010729b:	e9 15 f3 ff ff       	jmp    801065b5 <alltraps>

801072a0 <vector174>:
801072a0:	6a 00                	push   $0x0
801072a2:	68 ae 00 00 00       	push   $0xae
801072a7:	e9 09 f3 ff ff       	jmp    801065b5 <alltraps>

801072ac <vector175>:
801072ac:	6a 00                	push   $0x0
801072ae:	68 af 00 00 00       	push   $0xaf
801072b3:	e9 fd f2 ff ff       	jmp    801065b5 <alltraps>

801072b8 <vector176>:
801072b8:	6a 00                	push   $0x0
801072ba:	68 b0 00 00 00       	push   $0xb0
801072bf:	e9 f1 f2 ff ff       	jmp    801065b5 <alltraps>

801072c4 <vector177>:
801072c4:	6a 00                	push   $0x0
801072c6:	68 b1 00 00 00       	push   $0xb1
801072cb:	e9 e5 f2 ff ff       	jmp    801065b5 <alltraps>

801072d0 <vector178>:
801072d0:	6a 00                	push   $0x0
801072d2:	68 b2 00 00 00       	push   $0xb2
801072d7:	e9 d9 f2 ff ff       	jmp    801065b5 <alltraps>

801072dc <vector179>:
801072dc:	6a 00                	push   $0x0
801072de:	68 b3 00 00 00       	push   $0xb3
801072e3:	e9 cd f2 ff ff       	jmp    801065b5 <alltraps>

801072e8 <vector180>:
801072e8:	6a 00                	push   $0x0
801072ea:	68 b4 00 00 00       	push   $0xb4
801072ef:	e9 c1 f2 ff ff       	jmp    801065b5 <alltraps>

801072f4 <vector181>:
801072f4:	6a 00                	push   $0x0
801072f6:	68 b5 00 00 00       	push   $0xb5
801072fb:	e9 b5 f2 ff ff       	jmp    801065b5 <alltraps>

80107300 <vector182>:
80107300:	6a 00                	push   $0x0
80107302:	68 b6 00 00 00       	push   $0xb6
80107307:	e9 a9 f2 ff ff       	jmp    801065b5 <alltraps>

8010730c <vector183>:
8010730c:	6a 00                	push   $0x0
8010730e:	68 b7 00 00 00       	push   $0xb7
80107313:	e9 9d f2 ff ff       	jmp    801065b5 <alltraps>

80107318 <vector184>:
80107318:	6a 00                	push   $0x0
8010731a:	68 b8 00 00 00       	push   $0xb8
8010731f:	e9 91 f2 ff ff       	jmp    801065b5 <alltraps>

80107324 <vector185>:
80107324:	6a 00                	push   $0x0
80107326:	68 b9 00 00 00       	push   $0xb9
8010732b:	e9 85 f2 ff ff       	jmp    801065b5 <alltraps>

80107330 <vector186>:
80107330:	6a 00                	push   $0x0
80107332:	68 ba 00 00 00       	push   $0xba
80107337:	e9 79 f2 ff ff       	jmp    801065b5 <alltraps>

8010733c <vector187>:
8010733c:	6a 00                	push   $0x0
8010733e:	68 bb 00 00 00       	push   $0xbb
80107343:	e9 6d f2 ff ff       	jmp    801065b5 <alltraps>

80107348 <vector188>:
80107348:	6a 00                	push   $0x0
8010734a:	68 bc 00 00 00       	push   $0xbc
8010734f:	e9 61 f2 ff ff       	jmp    801065b5 <alltraps>

80107354 <vector189>:
80107354:	6a 00                	push   $0x0
80107356:	68 bd 00 00 00       	push   $0xbd
8010735b:	e9 55 f2 ff ff       	jmp    801065b5 <alltraps>

80107360 <vector190>:
80107360:	6a 00                	push   $0x0
80107362:	68 be 00 00 00       	push   $0xbe
80107367:	e9 49 f2 ff ff       	jmp    801065b5 <alltraps>

8010736c <vector191>:
8010736c:	6a 00                	push   $0x0
8010736e:	68 bf 00 00 00       	push   $0xbf
80107373:	e9 3d f2 ff ff       	jmp    801065b5 <alltraps>

80107378 <vector192>:
80107378:	6a 00                	push   $0x0
8010737a:	68 c0 00 00 00       	push   $0xc0
8010737f:	e9 31 f2 ff ff       	jmp    801065b5 <alltraps>

80107384 <vector193>:
80107384:	6a 00                	push   $0x0
80107386:	68 c1 00 00 00       	push   $0xc1
8010738b:	e9 25 f2 ff ff       	jmp    801065b5 <alltraps>

80107390 <vector194>:
80107390:	6a 00                	push   $0x0
80107392:	68 c2 00 00 00       	push   $0xc2
80107397:	e9 19 f2 ff ff       	jmp    801065b5 <alltraps>

8010739c <vector195>:
8010739c:	6a 00                	push   $0x0
8010739e:	68 c3 00 00 00       	push   $0xc3
801073a3:	e9 0d f2 ff ff       	jmp    801065b5 <alltraps>

801073a8 <vector196>:
801073a8:	6a 00                	push   $0x0
801073aa:	68 c4 00 00 00       	push   $0xc4
801073af:	e9 01 f2 ff ff       	jmp    801065b5 <alltraps>

801073b4 <vector197>:
801073b4:	6a 00                	push   $0x0
801073b6:	68 c5 00 00 00       	push   $0xc5
801073bb:	e9 f5 f1 ff ff       	jmp    801065b5 <alltraps>

801073c0 <vector198>:
801073c0:	6a 00                	push   $0x0
801073c2:	68 c6 00 00 00       	push   $0xc6
801073c7:	e9 e9 f1 ff ff       	jmp    801065b5 <alltraps>

801073cc <vector199>:
801073cc:	6a 00                	push   $0x0
801073ce:	68 c7 00 00 00       	push   $0xc7
801073d3:	e9 dd f1 ff ff       	jmp    801065b5 <alltraps>

801073d8 <vector200>:
801073d8:	6a 00                	push   $0x0
801073da:	68 c8 00 00 00       	push   $0xc8
801073df:	e9 d1 f1 ff ff       	jmp    801065b5 <alltraps>

801073e4 <vector201>:
801073e4:	6a 00                	push   $0x0
801073e6:	68 c9 00 00 00       	push   $0xc9
801073eb:	e9 c5 f1 ff ff       	jmp    801065b5 <alltraps>

801073f0 <vector202>:
801073f0:	6a 00                	push   $0x0
801073f2:	68 ca 00 00 00       	push   $0xca
801073f7:	e9 b9 f1 ff ff       	jmp    801065b5 <alltraps>

801073fc <vector203>:
801073fc:	6a 00                	push   $0x0
801073fe:	68 cb 00 00 00       	push   $0xcb
80107403:	e9 ad f1 ff ff       	jmp    801065b5 <alltraps>

80107408 <vector204>:
80107408:	6a 00                	push   $0x0
8010740a:	68 cc 00 00 00       	push   $0xcc
8010740f:	e9 a1 f1 ff ff       	jmp    801065b5 <alltraps>

80107414 <vector205>:
80107414:	6a 00                	push   $0x0
80107416:	68 cd 00 00 00       	push   $0xcd
8010741b:	e9 95 f1 ff ff       	jmp    801065b5 <alltraps>

80107420 <vector206>:
80107420:	6a 00                	push   $0x0
80107422:	68 ce 00 00 00       	push   $0xce
80107427:	e9 89 f1 ff ff       	jmp    801065b5 <alltraps>

8010742c <vector207>:
8010742c:	6a 00                	push   $0x0
8010742e:	68 cf 00 00 00       	push   $0xcf
80107433:	e9 7d f1 ff ff       	jmp    801065b5 <alltraps>

80107438 <vector208>:
80107438:	6a 00                	push   $0x0
8010743a:	68 d0 00 00 00       	push   $0xd0
8010743f:	e9 71 f1 ff ff       	jmp    801065b5 <alltraps>

80107444 <vector209>:
80107444:	6a 00                	push   $0x0
80107446:	68 d1 00 00 00       	push   $0xd1
8010744b:	e9 65 f1 ff ff       	jmp    801065b5 <alltraps>

80107450 <vector210>:
80107450:	6a 00                	push   $0x0
80107452:	68 d2 00 00 00       	push   $0xd2
80107457:	e9 59 f1 ff ff       	jmp    801065b5 <alltraps>

8010745c <vector211>:
8010745c:	6a 00                	push   $0x0
8010745e:	68 d3 00 00 00       	push   $0xd3
80107463:	e9 4d f1 ff ff       	jmp    801065b5 <alltraps>

80107468 <vector212>:
80107468:	6a 00                	push   $0x0
8010746a:	68 d4 00 00 00       	push   $0xd4
8010746f:	e9 41 f1 ff ff       	jmp    801065b5 <alltraps>

80107474 <vector213>:
80107474:	6a 00                	push   $0x0
80107476:	68 d5 00 00 00       	push   $0xd5
8010747b:	e9 35 f1 ff ff       	jmp    801065b5 <alltraps>

80107480 <vector214>:
80107480:	6a 00                	push   $0x0
80107482:	68 d6 00 00 00       	push   $0xd6
80107487:	e9 29 f1 ff ff       	jmp    801065b5 <alltraps>

8010748c <vector215>:
8010748c:	6a 00                	push   $0x0
8010748e:	68 d7 00 00 00       	push   $0xd7
80107493:	e9 1d f1 ff ff       	jmp    801065b5 <alltraps>

80107498 <vector216>:
80107498:	6a 00                	push   $0x0
8010749a:	68 d8 00 00 00       	push   $0xd8
8010749f:	e9 11 f1 ff ff       	jmp    801065b5 <alltraps>

801074a4 <vector217>:
801074a4:	6a 00                	push   $0x0
801074a6:	68 d9 00 00 00       	push   $0xd9
801074ab:	e9 05 f1 ff ff       	jmp    801065b5 <alltraps>

801074b0 <vector218>:
801074b0:	6a 00                	push   $0x0
801074b2:	68 da 00 00 00       	push   $0xda
801074b7:	e9 f9 f0 ff ff       	jmp    801065b5 <alltraps>

801074bc <vector219>:
801074bc:	6a 00                	push   $0x0
801074be:	68 db 00 00 00       	push   $0xdb
801074c3:	e9 ed f0 ff ff       	jmp    801065b5 <alltraps>

801074c8 <vector220>:
801074c8:	6a 00                	push   $0x0
801074ca:	68 dc 00 00 00       	push   $0xdc
801074cf:	e9 e1 f0 ff ff       	jmp    801065b5 <alltraps>

801074d4 <vector221>:
801074d4:	6a 00                	push   $0x0
801074d6:	68 dd 00 00 00       	push   $0xdd
801074db:	e9 d5 f0 ff ff       	jmp    801065b5 <alltraps>

801074e0 <vector222>:
801074e0:	6a 00                	push   $0x0
801074e2:	68 de 00 00 00       	push   $0xde
801074e7:	e9 c9 f0 ff ff       	jmp    801065b5 <alltraps>

801074ec <vector223>:
801074ec:	6a 00                	push   $0x0
801074ee:	68 df 00 00 00       	push   $0xdf
801074f3:	e9 bd f0 ff ff       	jmp    801065b5 <alltraps>

801074f8 <vector224>:
801074f8:	6a 00                	push   $0x0
801074fa:	68 e0 00 00 00       	push   $0xe0
801074ff:	e9 b1 f0 ff ff       	jmp    801065b5 <alltraps>

80107504 <vector225>:
80107504:	6a 00                	push   $0x0
80107506:	68 e1 00 00 00       	push   $0xe1
8010750b:	e9 a5 f0 ff ff       	jmp    801065b5 <alltraps>

80107510 <vector226>:
80107510:	6a 00                	push   $0x0
80107512:	68 e2 00 00 00       	push   $0xe2
80107517:	e9 99 f0 ff ff       	jmp    801065b5 <alltraps>

8010751c <vector227>:
8010751c:	6a 00                	push   $0x0
8010751e:	68 e3 00 00 00       	push   $0xe3
80107523:	e9 8d f0 ff ff       	jmp    801065b5 <alltraps>

80107528 <vector228>:
80107528:	6a 00                	push   $0x0
8010752a:	68 e4 00 00 00       	push   $0xe4
8010752f:	e9 81 f0 ff ff       	jmp    801065b5 <alltraps>

80107534 <vector229>:
80107534:	6a 00                	push   $0x0
80107536:	68 e5 00 00 00       	push   $0xe5
8010753b:	e9 75 f0 ff ff       	jmp    801065b5 <alltraps>

80107540 <vector230>:
80107540:	6a 00                	push   $0x0
80107542:	68 e6 00 00 00       	push   $0xe6
80107547:	e9 69 f0 ff ff       	jmp    801065b5 <alltraps>

8010754c <vector231>:
8010754c:	6a 00                	push   $0x0
8010754e:	68 e7 00 00 00       	push   $0xe7
80107553:	e9 5d f0 ff ff       	jmp    801065b5 <alltraps>

80107558 <vector232>:
80107558:	6a 00                	push   $0x0
8010755a:	68 e8 00 00 00       	push   $0xe8
8010755f:	e9 51 f0 ff ff       	jmp    801065b5 <alltraps>

80107564 <vector233>:
80107564:	6a 00                	push   $0x0
80107566:	68 e9 00 00 00       	push   $0xe9
8010756b:	e9 45 f0 ff ff       	jmp    801065b5 <alltraps>

80107570 <vector234>:
80107570:	6a 00                	push   $0x0
80107572:	68 ea 00 00 00       	push   $0xea
80107577:	e9 39 f0 ff ff       	jmp    801065b5 <alltraps>

8010757c <vector235>:
8010757c:	6a 00                	push   $0x0
8010757e:	68 eb 00 00 00       	push   $0xeb
80107583:	e9 2d f0 ff ff       	jmp    801065b5 <alltraps>

80107588 <vector236>:
80107588:	6a 00                	push   $0x0
8010758a:	68 ec 00 00 00       	push   $0xec
8010758f:	e9 21 f0 ff ff       	jmp    801065b5 <alltraps>

80107594 <vector237>:
80107594:	6a 00                	push   $0x0
80107596:	68 ed 00 00 00       	push   $0xed
8010759b:	e9 15 f0 ff ff       	jmp    801065b5 <alltraps>

801075a0 <vector238>:
801075a0:	6a 00                	push   $0x0
801075a2:	68 ee 00 00 00       	push   $0xee
801075a7:	e9 09 f0 ff ff       	jmp    801065b5 <alltraps>

801075ac <vector239>:
801075ac:	6a 00                	push   $0x0
801075ae:	68 ef 00 00 00       	push   $0xef
801075b3:	e9 fd ef ff ff       	jmp    801065b5 <alltraps>

801075b8 <vector240>:
801075b8:	6a 00                	push   $0x0
801075ba:	68 f0 00 00 00       	push   $0xf0
801075bf:	e9 f1 ef ff ff       	jmp    801065b5 <alltraps>

801075c4 <vector241>:
801075c4:	6a 00                	push   $0x0
801075c6:	68 f1 00 00 00       	push   $0xf1
801075cb:	e9 e5 ef ff ff       	jmp    801065b5 <alltraps>

801075d0 <vector242>:
801075d0:	6a 00                	push   $0x0
801075d2:	68 f2 00 00 00       	push   $0xf2
801075d7:	e9 d9 ef ff ff       	jmp    801065b5 <alltraps>

801075dc <vector243>:
801075dc:	6a 00                	push   $0x0
801075de:	68 f3 00 00 00       	push   $0xf3
801075e3:	e9 cd ef ff ff       	jmp    801065b5 <alltraps>

801075e8 <vector244>:
801075e8:	6a 00                	push   $0x0
801075ea:	68 f4 00 00 00       	push   $0xf4
801075ef:	e9 c1 ef ff ff       	jmp    801065b5 <alltraps>

801075f4 <vector245>:
801075f4:	6a 00                	push   $0x0
801075f6:	68 f5 00 00 00       	push   $0xf5
801075fb:	e9 b5 ef ff ff       	jmp    801065b5 <alltraps>

80107600 <vector246>:
80107600:	6a 00                	push   $0x0
80107602:	68 f6 00 00 00       	push   $0xf6
80107607:	e9 a9 ef ff ff       	jmp    801065b5 <alltraps>

8010760c <vector247>:
8010760c:	6a 00                	push   $0x0
8010760e:	68 f7 00 00 00       	push   $0xf7
80107613:	e9 9d ef ff ff       	jmp    801065b5 <alltraps>

80107618 <vector248>:
80107618:	6a 00                	push   $0x0
8010761a:	68 f8 00 00 00       	push   $0xf8
8010761f:	e9 91 ef ff ff       	jmp    801065b5 <alltraps>

80107624 <vector249>:
80107624:	6a 00                	push   $0x0
80107626:	68 f9 00 00 00       	push   $0xf9
8010762b:	e9 85 ef ff ff       	jmp    801065b5 <alltraps>

80107630 <vector250>:
80107630:	6a 00                	push   $0x0
80107632:	68 fa 00 00 00       	push   $0xfa
80107637:	e9 79 ef ff ff       	jmp    801065b5 <alltraps>

8010763c <vector251>:
8010763c:	6a 00                	push   $0x0
8010763e:	68 fb 00 00 00       	push   $0xfb
80107643:	e9 6d ef ff ff       	jmp    801065b5 <alltraps>

80107648 <vector252>:
80107648:	6a 00                	push   $0x0
8010764a:	68 fc 00 00 00       	push   $0xfc
8010764f:	e9 61 ef ff ff       	jmp    801065b5 <alltraps>

80107654 <vector253>:
80107654:	6a 00                	push   $0x0
80107656:	68 fd 00 00 00       	push   $0xfd
8010765b:	e9 55 ef ff ff       	jmp    801065b5 <alltraps>

80107660 <vector254>:
80107660:	6a 00                	push   $0x0
80107662:	68 fe 00 00 00       	push   $0xfe
80107667:	e9 49 ef ff ff       	jmp    801065b5 <alltraps>

8010766c <vector255>:
8010766c:	6a 00                	push   $0x0
8010766e:	68 ff 00 00 00       	push   $0xff
80107673:	e9 3d ef ff ff       	jmp    801065b5 <alltraps>

80107678 <lgdt>:
80107678:	55                   	push   %ebp
80107679:	89 e5                	mov    %esp,%ebp
8010767b:	83 ec 10             	sub    $0x10,%esp
8010767e:	8b 45 0c             	mov    0xc(%ebp),%eax
80107681:	83 e8 01             	sub    $0x1,%eax
80107684:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
80107688:	8b 45 08             	mov    0x8(%ebp),%eax
8010768b:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
8010768f:	8b 45 08             	mov    0x8(%ebp),%eax
80107692:	c1 e8 10             	shr    $0x10,%eax
80107695:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
80107699:	8d 45 fa             	lea    -0x6(%ebp),%eax
8010769c:	0f 01 10             	lgdtl  (%eax)
8010769f:	90                   	nop
801076a0:	c9                   	leave  
801076a1:	c3                   	ret    

801076a2 <ltr>:
801076a2:	55                   	push   %ebp
801076a3:	89 e5                	mov    %esp,%ebp
801076a5:	83 ec 04             	sub    $0x4,%esp
801076a8:	8b 45 08             	mov    0x8(%ebp),%eax
801076ab:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
801076af:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
801076b3:	0f 00 d8             	ltr    %ax
801076b6:	90                   	nop
801076b7:	c9                   	leave  
801076b8:	c3                   	ret    

801076b9 <loadgs>:
801076b9:	55                   	push   %ebp
801076ba:	89 e5                	mov    %esp,%ebp
801076bc:	83 ec 04             	sub    $0x4,%esp
801076bf:	8b 45 08             	mov    0x8(%ebp),%eax
801076c2:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
801076c6:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
801076ca:	8e e8                	mov    %eax,%gs
801076cc:	90                   	nop
801076cd:	c9                   	leave  
801076ce:	c3                   	ret    

801076cf <lcr3>:
801076cf:	55                   	push   %ebp
801076d0:	89 e5                	mov    %esp,%ebp
801076d2:	8b 45 08             	mov    0x8(%ebp),%eax
801076d5:	0f 22 d8             	mov    %eax,%cr3
801076d8:	90                   	nop
801076d9:	5d                   	pop    %ebp
801076da:	c3                   	ret    

801076db <v2p>:
801076db:	55                   	push   %ebp
801076dc:	89 e5                	mov    %esp,%ebp
801076de:	8b 45 08             	mov    0x8(%ebp),%eax
801076e1:	05 00 00 00 80       	add    $0x80000000,%eax
801076e6:	5d                   	pop    %ebp
801076e7:	c3                   	ret    

801076e8 <p2v>:
801076e8:	55                   	push   %ebp
801076e9:	89 e5                	mov    %esp,%ebp
801076eb:	8b 45 08             	mov    0x8(%ebp),%eax
801076ee:	05 00 00 00 80       	add    $0x80000000,%eax
801076f3:	5d                   	pop    %ebp
801076f4:	c3                   	ret    

801076f5 <seginit>:
801076f5:	55                   	push   %ebp
801076f6:	89 e5                	mov    %esp,%ebp
801076f8:	53                   	push   %ebx
801076f9:	83 ec 14             	sub    $0x14,%esp
801076fc:	e8 64 b8 ff ff       	call   80102f65 <cpunum>
80107701:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80107707:	05 60 23 11 80       	add    $0x80112360,%eax
8010770c:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010770f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107712:	66 c7 40 78 ff ff    	movw   $0xffff,0x78(%eax)
80107718:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010771b:	66 c7 40 7a 00 00    	movw   $0x0,0x7a(%eax)
80107721:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107724:	c6 40 7c 00          	movb   $0x0,0x7c(%eax)
80107728:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010772b:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
8010772f:	83 e2 f0             	and    $0xfffffff0,%edx
80107732:	83 ca 0a             	or     $0xa,%edx
80107735:	88 50 7d             	mov    %dl,0x7d(%eax)
80107738:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010773b:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
8010773f:	83 ca 10             	or     $0x10,%edx
80107742:	88 50 7d             	mov    %dl,0x7d(%eax)
80107745:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107748:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
8010774c:	83 e2 9f             	and    $0xffffff9f,%edx
8010774f:	88 50 7d             	mov    %dl,0x7d(%eax)
80107752:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107755:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80107759:	83 ca 80             	or     $0xffffff80,%edx
8010775c:	88 50 7d             	mov    %dl,0x7d(%eax)
8010775f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107762:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107766:	83 ca 0f             	or     $0xf,%edx
80107769:	88 50 7e             	mov    %dl,0x7e(%eax)
8010776c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010776f:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107773:	83 e2 ef             	and    $0xffffffef,%edx
80107776:	88 50 7e             	mov    %dl,0x7e(%eax)
80107779:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010777c:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107780:	83 e2 df             	and    $0xffffffdf,%edx
80107783:	88 50 7e             	mov    %dl,0x7e(%eax)
80107786:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107789:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
8010778d:	83 ca 40             	or     $0x40,%edx
80107790:	88 50 7e             	mov    %dl,0x7e(%eax)
80107793:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107796:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
8010779a:	83 ca 80             	or     $0xffffff80,%edx
8010779d:	88 50 7e             	mov    %dl,0x7e(%eax)
801077a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077a3:	c6 40 7f 00          	movb   $0x0,0x7f(%eax)
801077a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077aa:	66 c7 80 80 00 00 00 	movw   $0xffff,0x80(%eax)
801077b1:	ff ff 
801077b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077b6:	66 c7 80 82 00 00 00 	movw   $0x0,0x82(%eax)
801077bd:	00 00 
801077bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077c2:	c6 80 84 00 00 00 00 	movb   $0x0,0x84(%eax)
801077c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077cc:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
801077d3:	83 e2 f0             	and    $0xfffffff0,%edx
801077d6:	83 ca 02             	or     $0x2,%edx
801077d9:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
801077df:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077e2:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
801077e9:	83 ca 10             	or     $0x10,%edx
801077ec:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
801077f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077f5:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
801077fc:	83 e2 9f             	and    $0xffffff9f,%edx
801077ff:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80107805:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107808:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
8010780f:	83 ca 80             	or     $0xffffff80,%edx
80107812:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80107818:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010781b:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107822:	83 ca 0f             	or     $0xf,%edx
80107825:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
8010782b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010782e:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107835:	83 e2 ef             	and    $0xffffffef,%edx
80107838:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
8010783e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107841:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107848:	83 e2 df             	and    $0xffffffdf,%edx
8010784b:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107851:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107854:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
8010785b:	83 ca 40             	or     $0x40,%edx
8010785e:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107864:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107867:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
8010786e:	83 ca 80             	or     $0xffffff80,%edx
80107871:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107877:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010787a:	c6 80 87 00 00 00 00 	movb   $0x0,0x87(%eax)
80107881:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107884:	66 c7 80 90 00 00 00 	movw   $0xffff,0x90(%eax)
8010788b:	ff ff 
8010788d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107890:	66 c7 80 92 00 00 00 	movw   $0x0,0x92(%eax)
80107897:	00 00 
80107899:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010789c:	c6 80 94 00 00 00 00 	movb   $0x0,0x94(%eax)
801078a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078a6:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
801078ad:	83 e2 f0             	and    $0xfffffff0,%edx
801078b0:	83 ca 0a             	or     $0xa,%edx
801078b3:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
801078b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078bc:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
801078c3:	83 ca 10             	or     $0x10,%edx
801078c6:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
801078cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078cf:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
801078d6:	83 ca 60             	or     $0x60,%edx
801078d9:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
801078df:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078e2:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
801078e9:	83 ca 80             	or     $0xffffff80,%edx
801078ec:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
801078f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078f5:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
801078fc:	83 ca 0f             	or     $0xf,%edx
801078ff:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107905:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107908:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
8010790f:	83 e2 ef             	and    $0xffffffef,%edx
80107912:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107918:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010791b:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107922:	83 e2 df             	and    $0xffffffdf,%edx
80107925:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
8010792b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010792e:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107935:	83 ca 40             	or     $0x40,%edx
80107938:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
8010793e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107941:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107948:	83 ca 80             	or     $0xffffff80,%edx
8010794b:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107951:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107954:	c6 80 97 00 00 00 00 	movb   $0x0,0x97(%eax)
8010795b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010795e:	66 c7 80 98 00 00 00 	movw   $0xffff,0x98(%eax)
80107965:	ff ff 
80107967:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010796a:	66 c7 80 9a 00 00 00 	movw   $0x0,0x9a(%eax)
80107971:	00 00 
80107973:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107976:	c6 80 9c 00 00 00 00 	movb   $0x0,0x9c(%eax)
8010797d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107980:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107987:	83 e2 f0             	and    $0xfffffff0,%edx
8010798a:	83 ca 02             	or     $0x2,%edx
8010798d:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107993:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107996:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
8010799d:	83 ca 10             	or     $0x10,%edx
801079a0:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
801079a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079a9:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
801079b0:	83 ca 60             	or     $0x60,%edx
801079b3:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
801079b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079bc:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
801079c3:	83 ca 80             	or     $0xffffff80,%edx
801079c6:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
801079cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079cf:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
801079d6:	83 ca 0f             	or     $0xf,%edx
801079d9:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
801079df:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079e2:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
801079e9:	83 e2 ef             	and    $0xffffffef,%edx
801079ec:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
801079f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079f5:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
801079fc:	83 e2 df             	and    $0xffffffdf,%edx
801079ff:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107a05:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a08:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107a0f:	83 ca 40             	or     $0x40,%edx
80107a12:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107a18:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a1b:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107a22:	83 ca 80             	or     $0xffffff80,%edx
80107a25:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107a2b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a2e:	c6 80 9f 00 00 00 00 	movb   $0x0,0x9f(%eax)
80107a35:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a38:	05 b4 00 00 00       	add    $0xb4,%eax
80107a3d:	89 c3                	mov    %eax,%ebx
80107a3f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a42:	05 b4 00 00 00       	add    $0xb4,%eax
80107a47:	c1 e8 10             	shr    $0x10,%eax
80107a4a:	89 c2                	mov    %eax,%edx
80107a4c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a4f:	05 b4 00 00 00       	add    $0xb4,%eax
80107a54:	c1 e8 18             	shr    $0x18,%eax
80107a57:	89 c1                	mov    %eax,%ecx
80107a59:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a5c:	66 c7 80 88 00 00 00 	movw   $0x0,0x88(%eax)
80107a63:	00 00 
80107a65:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a68:	66 89 98 8a 00 00 00 	mov    %bx,0x8a(%eax)
80107a6f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a72:	88 90 8c 00 00 00    	mov    %dl,0x8c(%eax)
80107a78:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a7b:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107a82:	83 e2 f0             	and    $0xfffffff0,%edx
80107a85:	83 ca 02             	or     $0x2,%edx
80107a88:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107a8e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a91:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107a98:	83 ca 10             	or     $0x10,%edx
80107a9b:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107aa1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107aa4:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107aab:	83 e2 9f             	and    $0xffffff9f,%edx
80107aae:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107ab4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ab7:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107abe:	83 ca 80             	or     $0xffffff80,%edx
80107ac1:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107ac7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107aca:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107ad1:	83 e2 f0             	and    $0xfffffff0,%edx
80107ad4:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107ada:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107add:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107ae4:	83 e2 ef             	and    $0xffffffef,%edx
80107ae7:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107aed:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107af0:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107af7:	83 e2 df             	and    $0xffffffdf,%edx
80107afa:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107b00:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b03:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107b0a:	83 ca 40             	or     $0x40,%edx
80107b0d:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107b13:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b16:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80107b1d:	83 ca 80             	or     $0xffffff80,%edx
80107b20:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80107b26:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b29:	88 88 8f 00 00 00    	mov    %cl,0x8f(%eax)
80107b2f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b32:	83 c0 70             	add    $0x70,%eax
80107b35:	83 ec 08             	sub    $0x8,%esp
80107b38:	6a 38                	push   $0x38
80107b3a:	50                   	push   %eax
80107b3b:	e8 38 fb ff ff       	call   80107678 <lgdt>
80107b40:	83 c4 10             	add    $0x10,%esp
80107b43:	83 ec 0c             	sub    $0xc,%esp
80107b46:	6a 18                	push   $0x18
80107b48:	e8 6c fb ff ff       	call   801076b9 <loadgs>
80107b4d:	83 c4 10             	add    $0x10,%esp
80107b50:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b53:	65 a3 00 00 00 00    	mov    %eax,%gs:0x0
80107b59:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80107b60:	00 00 00 00 
80107b64:	90                   	nop
80107b65:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107b68:	c9                   	leave  
80107b69:	c3                   	ret    

80107b6a <walkpgdir>:
80107b6a:	55                   	push   %ebp
80107b6b:	89 e5                	mov    %esp,%ebp
80107b6d:	83 ec 18             	sub    $0x18,%esp
80107b70:	8b 45 0c             	mov    0xc(%ebp),%eax
80107b73:	c1 e8 16             	shr    $0x16,%eax
80107b76:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80107b7d:	8b 45 08             	mov    0x8(%ebp),%eax
80107b80:	01 d0                	add    %edx,%eax
80107b82:	89 45 f0             	mov    %eax,-0x10(%ebp)
80107b85:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107b88:	8b 00                	mov    (%eax),%eax
80107b8a:	83 e0 01             	and    $0x1,%eax
80107b8d:	85 c0                	test   %eax,%eax
80107b8f:	74 18                	je     80107ba9 <walkpgdir+0x3f>
80107b91:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107b94:	8b 00                	mov    (%eax),%eax
80107b96:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107b9b:	50                   	push   %eax
80107b9c:	e8 47 fb ff ff       	call   801076e8 <p2v>
80107ba1:	83 c4 04             	add    $0x4,%esp
80107ba4:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107ba7:	eb 48                	jmp    80107bf1 <walkpgdir+0x87>
80107ba9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80107bad:	74 0e                	je     80107bbd <walkpgdir+0x53>
80107baf:	e8 4b b0 ff ff       	call   80102bff <kalloc>
80107bb4:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107bb7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80107bbb:	75 07                	jne    80107bc4 <walkpgdir+0x5a>
80107bbd:	b8 00 00 00 00       	mov    $0x0,%eax
80107bc2:	eb 44                	jmp    80107c08 <walkpgdir+0x9e>
80107bc4:	83 ec 04             	sub    $0x4,%esp
80107bc7:	68 00 10 00 00       	push   $0x1000
80107bcc:	6a 00                	push   $0x0
80107bce:	ff 75 f4             	pushl  -0xc(%ebp)
80107bd1:	e8 25 d6 ff ff       	call   801051fb <memset>
80107bd6:	83 c4 10             	add    $0x10,%esp
80107bd9:	83 ec 0c             	sub    $0xc,%esp
80107bdc:	ff 75 f4             	pushl  -0xc(%ebp)
80107bdf:	e8 f7 fa ff ff       	call   801076db <v2p>
80107be4:	83 c4 10             	add    $0x10,%esp
80107be7:	83 c8 07             	or     $0x7,%eax
80107bea:	89 c2                	mov    %eax,%edx
80107bec:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107bef:	89 10                	mov    %edx,(%eax)
80107bf1:	8b 45 0c             	mov    0xc(%ebp),%eax
80107bf4:	c1 e8 0c             	shr    $0xc,%eax
80107bf7:	25 ff 03 00 00       	and    $0x3ff,%eax
80107bfc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80107c03:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c06:	01 d0                	add    %edx,%eax
80107c08:	c9                   	leave  
80107c09:	c3                   	ret    

80107c0a <mappages>:
80107c0a:	55                   	push   %ebp
80107c0b:	89 e5                	mov    %esp,%ebp
80107c0d:	83 ec 18             	sub    $0x18,%esp
80107c10:	8b 45 0c             	mov    0xc(%ebp),%eax
80107c13:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107c18:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107c1b:	8b 55 0c             	mov    0xc(%ebp),%edx
80107c1e:	8b 45 10             	mov    0x10(%ebp),%eax
80107c21:	01 d0                	add    %edx,%eax
80107c23:	83 e8 01             	sub    $0x1,%eax
80107c26:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107c2b:	89 45 f0             	mov    %eax,-0x10(%ebp)
80107c2e:	83 ec 04             	sub    $0x4,%esp
80107c31:	6a 01                	push   $0x1
80107c33:	ff 75 f4             	pushl  -0xc(%ebp)
80107c36:	ff 75 08             	pushl  0x8(%ebp)
80107c39:	e8 2c ff ff ff       	call   80107b6a <walkpgdir>
80107c3e:	83 c4 10             	add    $0x10,%esp
80107c41:	89 45 ec             	mov    %eax,-0x14(%ebp)
80107c44:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80107c48:	75 07                	jne    80107c51 <mappages+0x47>
80107c4a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107c4f:	eb 47                	jmp    80107c98 <mappages+0x8e>
80107c51:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107c54:	8b 00                	mov    (%eax),%eax
80107c56:	83 e0 01             	and    $0x1,%eax
80107c59:	85 c0                	test   %eax,%eax
80107c5b:	74 0d                	je     80107c6a <mappages+0x60>
80107c5d:	83 ec 0c             	sub    $0xc,%esp
80107c60:	68 bc 8a 10 80       	push   $0x80108abc
80107c65:	e8 d0 88 ff ff       	call   8010053a <panic>
80107c6a:	8b 45 18             	mov    0x18(%ebp),%eax
80107c6d:	0b 45 14             	or     0x14(%ebp),%eax
80107c70:	83 c8 01             	or     $0x1,%eax
80107c73:	89 c2                	mov    %eax,%edx
80107c75:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107c78:	89 10                	mov    %edx,(%eax)
80107c7a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c7d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80107c80:	74 10                	je     80107c92 <mappages+0x88>
80107c82:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80107c89:	81 45 14 00 10 00 00 	addl   $0x1000,0x14(%ebp)
80107c90:	eb 9c                	jmp    80107c2e <mappages+0x24>
80107c92:	90                   	nop
80107c93:	b8 00 00 00 00       	mov    $0x0,%eax
80107c98:	c9                   	leave  
80107c99:	c3                   	ret    

80107c9a <setupkvm>:
80107c9a:	55                   	push   %ebp
80107c9b:	89 e5                	mov    %esp,%ebp
80107c9d:	53                   	push   %ebx
80107c9e:	83 ec 14             	sub    $0x14,%esp
80107ca1:	e8 59 af ff ff       	call   80102bff <kalloc>
80107ca6:	89 45 f0             	mov    %eax,-0x10(%ebp)
80107ca9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80107cad:	75 0a                	jne    80107cb9 <setupkvm+0x1f>
80107caf:	b8 00 00 00 00       	mov    $0x0,%eax
80107cb4:	e9 8e 00 00 00       	jmp    80107d47 <setupkvm+0xad>
80107cb9:	83 ec 04             	sub    $0x4,%esp
80107cbc:	68 00 10 00 00       	push   $0x1000
80107cc1:	6a 00                	push   $0x0
80107cc3:	ff 75 f0             	pushl  -0x10(%ebp)
80107cc6:	e8 30 d5 ff ff       	call   801051fb <memset>
80107ccb:	83 c4 10             	add    $0x10,%esp
80107cce:	83 ec 0c             	sub    $0xc,%esp
80107cd1:	68 00 00 00 0e       	push   $0xe000000
80107cd6:	e8 0d fa ff ff       	call   801076e8 <p2v>
80107cdb:	83 c4 10             	add    $0x10,%esp
80107cde:	3d 00 00 00 fe       	cmp    $0xfe000000,%eax
80107ce3:	76 0d                	jbe    80107cf2 <setupkvm+0x58>
80107ce5:	83 ec 0c             	sub    $0xc,%esp
80107ce8:	68 c2 8a 10 80       	push   $0x80108ac2
80107ced:	e8 48 88 ff ff       	call   8010053a <panic>
80107cf2:	c7 45 f4 a0 b4 10 80 	movl   $0x8010b4a0,-0xc(%ebp)
80107cf9:	eb 40                	jmp    80107d3b <setupkvm+0xa1>
80107cfb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107cfe:	8b 48 0c             	mov    0xc(%eax),%ecx
80107d01:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d04:	8b 50 04             	mov    0x4(%eax),%edx
80107d07:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d0a:	8b 58 08             	mov    0x8(%eax),%ebx
80107d0d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d10:	8b 40 04             	mov    0x4(%eax),%eax
80107d13:	29 c3                	sub    %eax,%ebx
80107d15:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d18:	8b 00                	mov    (%eax),%eax
80107d1a:	83 ec 0c             	sub    $0xc,%esp
80107d1d:	51                   	push   %ecx
80107d1e:	52                   	push   %edx
80107d1f:	53                   	push   %ebx
80107d20:	50                   	push   %eax
80107d21:	ff 75 f0             	pushl  -0x10(%ebp)
80107d24:	e8 e1 fe ff ff       	call   80107c0a <mappages>
80107d29:	83 c4 20             	add    $0x20,%esp
80107d2c:	85 c0                	test   %eax,%eax
80107d2e:	79 07                	jns    80107d37 <setupkvm+0x9d>
80107d30:	b8 00 00 00 00       	mov    $0x0,%eax
80107d35:	eb 10                	jmp    80107d47 <setupkvm+0xad>
80107d37:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80107d3b:	81 7d f4 e0 b4 10 80 	cmpl   $0x8010b4e0,-0xc(%ebp)
80107d42:	72 b7                	jb     80107cfb <setupkvm+0x61>
80107d44:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107d47:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107d4a:	c9                   	leave  
80107d4b:	c3                   	ret    

80107d4c <kvmalloc>:
80107d4c:	55                   	push   %ebp
80107d4d:	89 e5                	mov    %esp,%ebp
80107d4f:	83 ec 08             	sub    $0x8,%esp
80107d52:	e8 43 ff ff ff       	call   80107c9a <setupkvm>
80107d57:	a3 38 51 11 80       	mov    %eax,0x80115138
80107d5c:	e8 03 00 00 00       	call   80107d64 <switchkvm>
80107d61:	90                   	nop
80107d62:	c9                   	leave  
80107d63:	c3                   	ret    

80107d64 <switchkvm>:
80107d64:	55                   	push   %ebp
80107d65:	89 e5                	mov    %esp,%ebp
80107d67:	a1 38 51 11 80       	mov    0x80115138,%eax
80107d6c:	50                   	push   %eax
80107d6d:	e8 69 f9 ff ff       	call   801076db <v2p>
80107d72:	83 c4 04             	add    $0x4,%esp
80107d75:	50                   	push   %eax
80107d76:	e8 54 f9 ff ff       	call   801076cf <lcr3>
80107d7b:	83 c4 04             	add    $0x4,%esp
80107d7e:	90                   	nop
80107d7f:	c9                   	leave  
80107d80:	c3                   	ret    

80107d81 <switchuvm>:
80107d81:	55                   	push   %ebp
80107d82:	89 e5                	mov    %esp,%ebp
80107d84:	56                   	push   %esi
80107d85:	53                   	push   %ebx
80107d86:	e8 6a d3 ff ff       	call   801050f5 <pushcli>
80107d8b:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107d91:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80107d98:	83 c2 08             	add    $0x8,%edx
80107d9b:	89 d6                	mov    %edx,%esi
80107d9d:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80107da4:	83 c2 08             	add    $0x8,%edx
80107da7:	c1 ea 10             	shr    $0x10,%edx
80107daa:	89 d3                	mov    %edx,%ebx
80107dac:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80107db3:	83 c2 08             	add    $0x8,%edx
80107db6:	c1 ea 18             	shr    $0x18,%edx
80107db9:	89 d1                	mov    %edx,%ecx
80107dbb:	66 c7 80 a0 00 00 00 	movw   $0x67,0xa0(%eax)
80107dc2:	67 00 
80107dc4:	66 89 b0 a2 00 00 00 	mov    %si,0xa2(%eax)
80107dcb:	88 98 a4 00 00 00    	mov    %bl,0xa4(%eax)
80107dd1:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107dd8:	83 e2 f0             	and    $0xfffffff0,%edx
80107ddb:	83 ca 09             	or     $0x9,%edx
80107dde:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80107de4:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107deb:	83 ca 10             	or     $0x10,%edx
80107dee:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80107df4:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107dfb:	83 e2 9f             	and    $0xffffff9f,%edx
80107dfe:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80107e04:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107e0b:	83 ca 80             	or     $0xffffff80,%edx
80107e0e:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80107e14:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80107e1b:	83 e2 f0             	and    $0xfffffff0,%edx
80107e1e:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107e24:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80107e2b:	83 e2 ef             	and    $0xffffffef,%edx
80107e2e:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107e34:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80107e3b:	83 e2 df             	and    $0xffffffdf,%edx
80107e3e:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107e44:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80107e4b:	83 ca 40             	or     $0x40,%edx
80107e4e:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107e54:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80107e5b:	83 e2 7f             	and    $0x7f,%edx
80107e5e:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107e64:	88 88 a7 00 00 00    	mov    %cl,0xa7(%eax)
80107e6a:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107e70:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107e77:	83 e2 ef             	and    $0xffffffef,%edx
80107e7a:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80107e80:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107e86:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
80107e8c:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107e92:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80107e99:	8b 52 08             	mov    0x8(%edx),%edx
80107e9c:	81 c2 00 10 00 00    	add    $0x1000,%edx
80107ea2:	89 50 0c             	mov    %edx,0xc(%eax)
80107ea5:	83 ec 0c             	sub    $0xc,%esp
80107ea8:	6a 30                	push   $0x30
80107eaa:	e8 f3 f7 ff ff       	call   801076a2 <ltr>
80107eaf:	83 c4 10             	add    $0x10,%esp
80107eb2:	8b 45 08             	mov    0x8(%ebp),%eax
80107eb5:	8b 40 04             	mov    0x4(%eax),%eax
80107eb8:	85 c0                	test   %eax,%eax
80107eba:	75 0d                	jne    80107ec9 <switchuvm+0x148>
80107ebc:	83 ec 0c             	sub    $0xc,%esp
80107ebf:	68 d3 8a 10 80       	push   $0x80108ad3
80107ec4:	e8 71 86 ff ff       	call   8010053a <panic>
80107ec9:	8b 45 08             	mov    0x8(%ebp),%eax
80107ecc:	8b 40 04             	mov    0x4(%eax),%eax
80107ecf:	83 ec 0c             	sub    $0xc,%esp
80107ed2:	50                   	push   %eax
80107ed3:	e8 03 f8 ff ff       	call   801076db <v2p>
80107ed8:	83 c4 10             	add    $0x10,%esp
80107edb:	83 ec 0c             	sub    $0xc,%esp
80107ede:	50                   	push   %eax
80107edf:	e8 eb f7 ff ff       	call   801076cf <lcr3>
80107ee4:	83 c4 10             	add    $0x10,%esp
80107ee7:	e8 4e d2 ff ff       	call   8010513a <popcli>
80107eec:	90                   	nop
80107eed:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107ef0:	5b                   	pop    %ebx
80107ef1:	5e                   	pop    %esi
80107ef2:	5d                   	pop    %ebp
80107ef3:	c3                   	ret    

80107ef4 <inituvm>:
80107ef4:	55                   	push   %ebp
80107ef5:	89 e5                	mov    %esp,%ebp
80107ef7:	83 ec 18             	sub    $0x18,%esp
80107efa:	81 7d 10 ff 0f 00 00 	cmpl   $0xfff,0x10(%ebp)
80107f01:	76 0d                	jbe    80107f10 <inituvm+0x1c>
80107f03:	83 ec 0c             	sub    $0xc,%esp
80107f06:	68 e7 8a 10 80       	push   $0x80108ae7
80107f0b:	e8 2a 86 ff ff       	call   8010053a <panic>
80107f10:	e8 ea ac ff ff       	call   80102bff <kalloc>
80107f15:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107f18:	83 ec 04             	sub    $0x4,%esp
80107f1b:	68 00 10 00 00       	push   $0x1000
80107f20:	6a 00                	push   $0x0
80107f22:	ff 75 f4             	pushl  -0xc(%ebp)
80107f25:	e8 d1 d2 ff ff       	call   801051fb <memset>
80107f2a:	83 c4 10             	add    $0x10,%esp
80107f2d:	83 ec 0c             	sub    $0xc,%esp
80107f30:	ff 75 f4             	pushl  -0xc(%ebp)
80107f33:	e8 a3 f7 ff ff       	call   801076db <v2p>
80107f38:	83 c4 10             	add    $0x10,%esp
80107f3b:	83 ec 0c             	sub    $0xc,%esp
80107f3e:	6a 06                	push   $0x6
80107f40:	50                   	push   %eax
80107f41:	68 00 10 00 00       	push   $0x1000
80107f46:	6a 00                	push   $0x0
80107f48:	ff 75 08             	pushl  0x8(%ebp)
80107f4b:	e8 ba fc ff ff       	call   80107c0a <mappages>
80107f50:	83 c4 20             	add    $0x20,%esp
80107f53:	83 ec 04             	sub    $0x4,%esp
80107f56:	ff 75 10             	pushl  0x10(%ebp)
80107f59:	ff 75 0c             	pushl  0xc(%ebp)
80107f5c:	ff 75 f4             	pushl  -0xc(%ebp)
80107f5f:	e8 56 d3 ff ff       	call   801052ba <memmove>
80107f64:	83 c4 10             	add    $0x10,%esp
80107f67:	90                   	nop
80107f68:	c9                   	leave  
80107f69:	c3                   	ret    

80107f6a <loaduvm>:
80107f6a:	55                   	push   %ebp
80107f6b:	89 e5                	mov    %esp,%ebp
80107f6d:	53                   	push   %ebx
80107f6e:	83 ec 14             	sub    $0x14,%esp
80107f71:	8b 45 0c             	mov    0xc(%ebp),%eax
80107f74:	25 ff 0f 00 00       	and    $0xfff,%eax
80107f79:	85 c0                	test   %eax,%eax
80107f7b:	74 0d                	je     80107f8a <loaduvm+0x20>
80107f7d:	83 ec 0c             	sub    $0xc,%esp
80107f80:	68 04 8b 10 80       	push   $0x80108b04
80107f85:	e8 b0 85 ff ff       	call   8010053a <panic>
80107f8a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80107f91:	e9 95 00 00 00       	jmp    8010802b <loaduvm+0xc1>
80107f96:	8b 55 0c             	mov    0xc(%ebp),%edx
80107f99:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f9c:	01 d0                	add    %edx,%eax
80107f9e:	83 ec 04             	sub    $0x4,%esp
80107fa1:	6a 00                	push   $0x0
80107fa3:	50                   	push   %eax
80107fa4:	ff 75 08             	pushl  0x8(%ebp)
80107fa7:	e8 be fb ff ff       	call   80107b6a <walkpgdir>
80107fac:	83 c4 10             	add    $0x10,%esp
80107faf:	89 45 ec             	mov    %eax,-0x14(%ebp)
80107fb2:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80107fb6:	75 0d                	jne    80107fc5 <loaduvm+0x5b>
80107fb8:	83 ec 0c             	sub    $0xc,%esp
80107fbb:	68 27 8b 10 80       	push   $0x80108b27
80107fc0:	e8 75 85 ff ff       	call   8010053a <panic>
80107fc5:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107fc8:	8b 00                	mov    (%eax),%eax
80107fca:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107fcf:	89 45 e8             	mov    %eax,-0x18(%ebp)
80107fd2:	8b 45 18             	mov    0x18(%ebp),%eax
80107fd5:	2b 45 f4             	sub    -0xc(%ebp),%eax
80107fd8:	3d ff 0f 00 00       	cmp    $0xfff,%eax
80107fdd:	77 0b                	ja     80107fea <loaduvm+0x80>
80107fdf:	8b 45 18             	mov    0x18(%ebp),%eax
80107fe2:	2b 45 f4             	sub    -0xc(%ebp),%eax
80107fe5:	89 45 f0             	mov    %eax,-0x10(%ebp)
80107fe8:	eb 07                	jmp    80107ff1 <loaduvm+0x87>
80107fea:	c7 45 f0 00 10 00 00 	movl   $0x1000,-0x10(%ebp)
80107ff1:	8b 55 14             	mov    0x14(%ebp),%edx
80107ff4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ff7:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
80107ffa:	83 ec 0c             	sub    $0xc,%esp
80107ffd:	ff 75 e8             	pushl  -0x18(%ebp)
80108000:	e8 e3 f6 ff ff       	call   801076e8 <p2v>
80108005:	83 c4 10             	add    $0x10,%esp
80108008:	ff 75 f0             	pushl  -0x10(%ebp)
8010800b:	53                   	push   %ebx
8010800c:	50                   	push   %eax
8010800d:	ff 75 10             	pushl  0x10(%ebp)
80108010:	e8 5c 9e ff ff       	call   80101e71 <readi>
80108015:	83 c4 10             	add    $0x10,%esp
80108018:	3b 45 f0             	cmp    -0x10(%ebp),%eax
8010801b:	74 07                	je     80108024 <loaduvm+0xba>
8010801d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80108022:	eb 18                	jmp    8010803c <loaduvm+0xd2>
80108024:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
8010802b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010802e:	3b 45 18             	cmp    0x18(%ebp),%eax
80108031:	0f 82 5f ff ff ff    	jb     80107f96 <loaduvm+0x2c>
80108037:	b8 00 00 00 00       	mov    $0x0,%eax
8010803c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010803f:	c9                   	leave  
80108040:	c3                   	ret    

80108041 <allocuvm>:
80108041:	55                   	push   %ebp
80108042:	89 e5                	mov    %esp,%ebp
80108044:	83 ec 18             	sub    $0x18,%esp
80108047:	8b 45 10             	mov    0x10(%ebp),%eax
8010804a:	85 c0                	test   %eax,%eax
8010804c:	79 0a                	jns    80108058 <allocuvm+0x17>
8010804e:	b8 00 00 00 00       	mov    $0x0,%eax
80108053:	e9 b0 00 00 00       	jmp    80108108 <allocuvm+0xc7>
80108058:	8b 45 10             	mov    0x10(%ebp),%eax
8010805b:	3b 45 0c             	cmp    0xc(%ebp),%eax
8010805e:	73 08                	jae    80108068 <allocuvm+0x27>
80108060:	8b 45 0c             	mov    0xc(%ebp),%eax
80108063:	e9 a0 00 00 00       	jmp    80108108 <allocuvm+0xc7>
80108068:	8b 45 0c             	mov    0xc(%ebp),%eax
8010806b:	05 ff 0f 00 00       	add    $0xfff,%eax
80108070:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108075:	89 45 f4             	mov    %eax,-0xc(%ebp)
80108078:	eb 7f                	jmp    801080f9 <allocuvm+0xb8>
8010807a:	e8 80 ab ff ff       	call   80102bff <kalloc>
8010807f:	89 45 f0             	mov    %eax,-0x10(%ebp)
80108082:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80108086:	75 2b                	jne    801080b3 <allocuvm+0x72>
80108088:	83 ec 0c             	sub    $0xc,%esp
8010808b:	68 45 8b 10 80       	push   $0x80108b45
80108090:	e8 0b 83 ff ff       	call   801003a0 <cprintf>
80108095:	83 c4 10             	add    $0x10,%esp
80108098:	83 ec 04             	sub    $0x4,%esp
8010809b:	ff 75 0c             	pushl  0xc(%ebp)
8010809e:	ff 75 10             	pushl  0x10(%ebp)
801080a1:	ff 75 08             	pushl  0x8(%ebp)
801080a4:	e8 61 00 00 00       	call   8010810a <deallocuvm>
801080a9:	83 c4 10             	add    $0x10,%esp
801080ac:	b8 00 00 00 00       	mov    $0x0,%eax
801080b1:	eb 55                	jmp    80108108 <allocuvm+0xc7>
801080b3:	83 ec 04             	sub    $0x4,%esp
801080b6:	68 00 10 00 00       	push   $0x1000
801080bb:	6a 00                	push   $0x0
801080bd:	ff 75 f0             	pushl  -0x10(%ebp)
801080c0:	e8 36 d1 ff ff       	call   801051fb <memset>
801080c5:	83 c4 10             	add    $0x10,%esp
801080c8:	83 ec 0c             	sub    $0xc,%esp
801080cb:	ff 75 f0             	pushl  -0x10(%ebp)
801080ce:	e8 08 f6 ff ff       	call   801076db <v2p>
801080d3:	83 c4 10             	add    $0x10,%esp
801080d6:	89 c2                	mov    %eax,%edx
801080d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801080db:	83 ec 0c             	sub    $0xc,%esp
801080de:	6a 06                	push   $0x6
801080e0:	52                   	push   %edx
801080e1:	68 00 10 00 00       	push   $0x1000
801080e6:	50                   	push   %eax
801080e7:	ff 75 08             	pushl  0x8(%ebp)
801080ea:	e8 1b fb ff ff       	call   80107c0a <mappages>
801080ef:	83 c4 20             	add    $0x20,%esp
801080f2:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
801080f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801080fc:	3b 45 10             	cmp    0x10(%ebp),%eax
801080ff:	0f 82 75 ff ff ff    	jb     8010807a <allocuvm+0x39>
80108105:	8b 45 10             	mov    0x10(%ebp),%eax
80108108:	c9                   	leave  
80108109:	c3                   	ret    

8010810a <deallocuvm>:
8010810a:	55                   	push   %ebp
8010810b:	89 e5                	mov    %esp,%ebp
8010810d:	83 ec 18             	sub    $0x18,%esp
80108110:	8b 45 10             	mov    0x10(%ebp),%eax
80108113:	3b 45 0c             	cmp    0xc(%ebp),%eax
80108116:	72 08                	jb     80108120 <deallocuvm+0x16>
80108118:	8b 45 0c             	mov    0xc(%ebp),%eax
8010811b:	e9 a5 00 00 00       	jmp    801081c5 <deallocuvm+0xbb>
80108120:	8b 45 10             	mov    0x10(%ebp),%eax
80108123:	05 ff 0f 00 00       	add    $0xfff,%eax
80108128:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010812d:	89 45 f4             	mov    %eax,-0xc(%ebp)
80108130:	e9 81 00 00 00       	jmp    801081b6 <deallocuvm+0xac>
80108135:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108138:	83 ec 04             	sub    $0x4,%esp
8010813b:	6a 00                	push   $0x0
8010813d:	50                   	push   %eax
8010813e:	ff 75 08             	pushl  0x8(%ebp)
80108141:	e8 24 fa ff ff       	call   80107b6a <walkpgdir>
80108146:	83 c4 10             	add    $0x10,%esp
80108149:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010814c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80108150:	75 09                	jne    8010815b <deallocuvm+0x51>
80108152:	81 45 f4 00 f0 3f 00 	addl   $0x3ff000,-0xc(%ebp)
80108159:	eb 54                	jmp    801081af <deallocuvm+0xa5>
8010815b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010815e:	8b 00                	mov    (%eax),%eax
80108160:	83 e0 01             	and    $0x1,%eax
80108163:	85 c0                	test   %eax,%eax
80108165:	74 48                	je     801081af <deallocuvm+0xa5>
80108167:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010816a:	8b 00                	mov    (%eax),%eax
8010816c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108171:	89 45 ec             	mov    %eax,-0x14(%ebp)
80108174:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80108178:	75 0d                	jne    80108187 <deallocuvm+0x7d>
8010817a:	83 ec 0c             	sub    $0xc,%esp
8010817d:	68 5d 8b 10 80       	push   $0x80108b5d
80108182:	e8 b3 83 ff ff       	call   8010053a <panic>
80108187:	83 ec 0c             	sub    $0xc,%esp
8010818a:	ff 75 ec             	pushl  -0x14(%ebp)
8010818d:	e8 56 f5 ff ff       	call   801076e8 <p2v>
80108192:	83 c4 10             	add    $0x10,%esp
80108195:	89 45 e8             	mov    %eax,-0x18(%ebp)
80108198:	83 ec 0c             	sub    $0xc,%esp
8010819b:	ff 75 e8             	pushl  -0x18(%ebp)
8010819e:	e8 bf a9 ff ff       	call   80102b62 <kfree>
801081a3:	83 c4 10             	add    $0x10,%esp
801081a6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801081a9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
801081af:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
801081b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801081b9:	3b 45 0c             	cmp    0xc(%ebp),%eax
801081bc:	0f 82 73 ff ff ff    	jb     80108135 <deallocuvm+0x2b>
801081c2:	8b 45 10             	mov    0x10(%ebp),%eax
801081c5:	c9                   	leave  
801081c6:	c3                   	ret    

801081c7 <freevm>:
801081c7:	55                   	push   %ebp
801081c8:	89 e5                	mov    %esp,%ebp
801081ca:	83 ec 18             	sub    $0x18,%esp
801081cd:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801081d1:	75 0d                	jne    801081e0 <freevm+0x19>
801081d3:	83 ec 0c             	sub    $0xc,%esp
801081d6:	68 63 8b 10 80       	push   $0x80108b63
801081db:	e8 5a 83 ff ff       	call   8010053a <panic>
801081e0:	83 ec 04             	sub    $0x4,%esp
801081e3:	6a 00                	push   $0x0
801081e5:	68 00 00 00 80       	push   $0x80000000
801081ea:	ff 75 08             	pushl  0x8(%ebp)
801081ed:	e8 18 ff ff ff       	call   8010810a <deallocuvm>
801081f2:	83 c4 10             	add    $0x10,%esp
801081f5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801081fc:	eb 4f                	jmp    8010824d <freevm+0x86>
801081fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108201:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80108208:	8b 45 08             	mov    0x8(%ebp),%eax
8010820b:	01 d0                	add    %edx,%eax
8010820d:	8b 00                	mov    (%eax),%eax
8010820f:	83 e0 01             	and    $0x1,%eax
80108212:	85 c0                	test   %eax,%eax
80108214:	74 33                	je     80108249 <freevm+0x82>
80108216:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108219:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80108220:	8b 45 08             	mov    0x8(%ebp),%eax
80108223:	01 d0                	add    %edx,%eax
80108225:	8b 00                	mov    (%eax),%eax
80108227:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010822c:	83 ec 0c             	sub    $0xc,%esp
8010822f:	50                   	push   %eax
80108230:	e8 b3 f4 ff ff       	call   801076e8 <p2v>
80108235:	83 c4 10             	add    $0x10,%esp
80108238:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010823b:	83 ec 0c             	sub    $0xc,%esp
8010823e:	ff 75 f0             	pushl  -0x10(%ebp)
80108241:	e8 1c a9 ff ff       	call   80102b62 <kfree>
80108246:	83 c4 10             	add    $0x10,%esp
80108249:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010824d:	81 7d f4 ff 03 00 00 	cmpl   $0x3ff,-0xc(%ebp)
80108254:	76 a8                	jbe    801081fe <freevm+0x37>
80108256:	83 ec 0c             	sub    $0xc,%esp
80108259:	ff 75 08             	pushl  0x8(%ebp)
8010825c:	e8 01 a9 ff ff       	call   80102b62 <kfree>
80108261:	83 c4 10             	add    $0x10,%esp
80108264:	90                   	nop
80108265:	c9                   	leave  
80108266:	c3                   	ret    

80108267 <clearpteu>:
80108267:	55                   	push   %ebp
80108268:	89 e5                	mov    %esp,%ebp
8010826a:	83 ec 18             	sub    $0x18,%esp
8010826d:	83 ec 04             	sub    $0x4,%esp
80108270:	6a 00                	push   $0x0
80108272:	ff 75 0c             	pushl  0xc(%ebp)
80108275:	ff 75 08             	pushl  0x8(%ebp)
80108278:	e8 ed f8 ff ff       	call   80107b6a <walkpgdir>
8010827d:	83 c4 10             	add    $0x10,%esp
80108280:	89 45 f4             	mov    %eax,-0xc(%ebp)
80108283:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80108287:	75 0d                	jne    80108296 <clearpteu+0x2f>
80108289:	83 ec 0c             	sub    $0xc,%esp
8010828c:	68 74 8b 10 80       	push   $0x80108b74
80108291:	e8 a4 82 ff ff       	call   8010053a <panic>
80108296:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108299:	8b 00                	mov    (%eax),%eax
8010829b:	83 e0 fb             	and    $0xfffffffb,%eax
8010829e:	89 c2                	mov    %eax,%edx
801082a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801082a3:	89 10                	mov    %edx,(%eax)
801082a5:	90                   	nop
801082a6:	c9                   	leave  
801082a7:	c3                   	ret    

801082a8 <copyuvm>:
801082a8:	55                   	push   %ebp
801082a9:	89 e5                	mov    %esp,%ebp
801082ab:	53                   	push   %ebx
801082ac:	83 ec 24             	sub    $0x24,%esp
801082af:	e8 e6 f9 ff ff       	call   80107c9a <setupkvm>
801082b4:	89 45 f0             	mov    %eax,-0x10(%ebp)
801082b7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801082bb:	75 0a                	jne    801082c7 <copyuvm+0x1f>
801082bd:	b8 00 00 00 00       	mov    $0x0,%eax
801082c2:	e9 f8 00 00 00       	jmp    801083bf <copyuvm+0x117>
801082c7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801082ce:	e9 c4 00 00 00       	jmp    80108397 <copyuvm+0xef>
801082d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801082d6:	83 ec 04             	sub    $0x4,%esp
801082d9:	6a 00                	push   $0x0
801082db:	50                   	push   %eax
801082dc:	ff 75 08             	pushl  0x8(%ebp)
801082df:	e8 86 f8 ff ff       	call   80107b6a <walkpgdir>
801082e4:	83 c4 10             	add    $0x10,%esp
801082e7:	89 45 ec             	mov    %eax,-0x14(%ebp)
801082ea:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801082ee:	75 0d                	jne    801082fd <copyuvm+0x55>
801082f0:	83 ec 0c             	sub    $0xc,%esp
801082f3:	68 7e 8b 10 80       	push   $0x80108b7e
801082f8:	e8 3d 82 ff ff       	call   8010053a <panic>
801082fd:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108300:	8b 00                	mov    (%eax),%eax
80108302:	83 e0 01             	and    $0x1,%eax
80108305:	85 c0                	test   %eax,%eax
80108307:	75 0d                	jne    80108316 <copyuvm+0x6e>
80108309:	83 ec 0c             	sub    $0xc,%esp
8010830c:	68 98 8b 10 80       	push   $0x80108b98
80108311:	e8 24 82 ff ff       	call   8010053a <panic>
80108316:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108319:	8b 00                	mov    (%eax),%eax
8010831b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108320:	89 45 e8             	mov    %eax,-0x18(%ebp)
80108323:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108326:	8b 00                	mov    (%eax),%eax
80108328:	25 ff 0f 00 00       	and    $0xfff,%eax
8010832d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80108330:	e8 ca a8 ff ff       	call   80102bff <kalloc>
80108335:	89 45 e0             	mov    %eax,-0x20(%ebp)
80108338:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
8010833c:	74 6a                	je     801083a8 <copyuvm+0x100>
8010833e:	83 ec 0c             	sub    $0xc,%esp
80108341:	ff 75 e8             	pushl  -0x18(%ebp)
80108344:	e8 9f f3 ff ff       	call   801076e8 <p2v>
80108349:	83 c4 10             	add    $0x10,%esp
8010834c:	83 ec 04             	sub    $0x4,%esp
8010834f:	68 00 10 00 00       	push   $0x1000
80108354:	50                   	push   %eax
80108355:	ff 75 e0             	pushl  -0x20(%ebp)
80108358:	e8 5d cf ff ff       	call   801052ba <memmove>
8010835d:	83 c4 10             	add    $0x10,%esp
80108360:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80108363:	83 ec 0c             	sub    $0xc,%esp
80108366:	ff 75 e0             	pushl  -0x20(%ebp)
80108369:	e8 6d f3 ff ff       	call   801076db <v2p>
8010836e:	83 c4 10             	add    $0x10,%esp
80108371:	89 c2                	mov    %eax,%edx
80108373:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108376:	83 ec 0c             	sub    $0xc,%esp
80108379:	53                   	push   %ebx
8010837a:	52                   	push   %edx
8010837b:	68 00 10 00 00       	push   $0x1000
80108380:	50                   	push   %eax
80108381:	ff 75 f0             	pushl  -0x10(%ebp)
80108384:	e8 81 f8 ff ff       	call   80107c0a <mappages>
80108389:	83 c4 20             	add    $0x20,%esp
8010838c:	85 c0                	test   %eax,%eax
8010838e:	78 1b                	js     801083ab <copyuvm+0x103>
80108390:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80108397:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010839a:	3b 45 0c             	cmp    0xc(%ebp),%eax
8010839d:	0f 82 30 ff ff ff    	jb     801082d3 <copyuvm+0x2b>
801083a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801083a6:	eb 17                	jmp    801083bf <copyuvm+0x117>
801083a8:	90                   	nop
801083a9:	eb 01                	jmp    801083ac <copyuvm+0x104>
801083ab:	90                   	nop
801083ac:	83 ec 0c             	sub    $0xc,%esp
801083af:	ff 75 f0             	pushl  -0x10(%ebp)
801083b2:	e8 10 fe ff ff       	call   801081c7 <freevm>
801083b7:	83 c4 10             	add    $0x10,%esp
801083ba:	b8 00 00 00 00       	mov    $0x0,%eax
801083bf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801083c2:	c9                   	leave  
801083c3:	c3                   	ret    

801083c4 <uva2ka>:
801083c4:	55                   	push   %ebp
801083c5:	89 e5                	mov    %esp,%ebp
801083c7:	83 ec 18             	sub    $0x18,%esp
801083ca:	83 ec 04             	sub    $0x4,%esp
801083cd:	6a 00                	push   $0x0
801083cf:	ff 75 0c             	pushl  0xc(%ebp)
801083d2:	ff 75 08             	pushl  0x8(%ebp)
801083d5:	e8 90 f7 ff ff       	call   80107b6a <walkpgdir>
801083da:	83 c4 10             	add    $0x10,%esp
801083dd:	89 45 f4             	mov    %eax,-0xc(%ebp)
801083e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801083e3:	8b 00                	mov    (%eax),%eax
801083e5:	83 e0 01             	and    $0x1,%eax
801083e8:	85 c0                	test   %eax,%eax
801083ea:	75 07                	jne    801083f3 <uva2ka+0x2f>
801083ec:	b8 00 00 00 00       	mov    $0x0,%eax
801083f1:	eb 29                	jmp    8010841c <uva2ka+0x58>
801083f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801083f6:	8b 00                	mov    (%eax),%eax
801083f8:	83 e0 04             	and    $0x4,%eax
801083fb:	85 c0                	test   %eax,%eax
801083fd:	75 07                	jne    80108406 <uva2ka+0x42>
801083ff:	b8 00 00 00 00       	mov    $0x0,%eax
80108404:	eb 16                	jmp    8010841c <uva2ka+0x58>
80108406:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108409:	8b 00                	mov    (%eax),%eax
8010840b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108410:	83 ec 0c             	sub    $0xc,%esp
80108413:	50                   	push   %eax
80108414:	e8 cf f2 ff ff       	call   801076e8 <p2v>
80108419:	83 c4 10             	add    $0x10,%esp
8010841c:	c9                   	leave  
8010841d:	c3                   	ret    

8010841e <copyout>:
8010841e:	55                   	push   %ebp
8010841f:	89 e5                	mov    %esp,%ebp
80108421:	83 ec 18             	sub    $0x18,%esp
80108424:	8b 45 10             	mov    0x10(%ebp),%eax
80108427:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010842a:	eb 7f                	jmp    801084ab <copyout+0x8d>
8010842c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010842f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108434:	89 45 ec             	mov    %eax,-0x14(%ebp)
80108437:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010843a:	83 ec 08             	sub    $0x8,%esp
8010843d:	50                   	push   %eax
8010843e:	ff 75 08             	pushl  0x8(%ebp)
80108441:	e8 7e ff ff ff       	call   801083c4 <uva2ka>
80108446:	83 c4 10             	add    $0x10,%esp
80108449:	89 45 e8             	mov    %eax,-0x18(%ebp)
8010844c:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80108450:	75 07                	jne    80108459 <copyout+0x3b>
80108452:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80108457:	eb 61                	jmp    801084ba <copyout+0x9c>
80108459:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010845c:	2b 45 0c             	sub    0xc(%ebp),%eax
8010845f:	05 00 10 00 00       	add    $0x1000,%eax
80108464:	89 45 f0             	mov    %eax,-0x10(%ebp)
80108467:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010846a:	3b 45 14             	cmp    0x14(%ebp),%eax
8010846d:	76 06                	jbe    80108475 <copyout+0x57>
8010846f:	8b 45 14             	mov    0x14(%ebp),%eax
80108472:	89 45 f0             	mov    %eax,-0x10(%ebp)
80108475:	8b 45 0c             	mov    0xc(%ebp),%eax
80108478:	2b 45 ec             	sub    -0x14(%ebp),%eax
8010847b:	89 c2                	mov    %eax,%edx
8010847d:	8b 45 e8             	mov    -0x18(%ebp),%eax
80108480:	01 d0                	add    %edx,%eax
80108482:	83 ec 04             	sub    $0x4,%esp
80108485:	ff 75 f0             	pushl  -0x10(%ebp)
80108488:	ff 75 f4             	pushl  -0xc(%ebp)
8010848b:	50                   	push   %eax
8010848c:	e8 29 ce ff ff       	call   801052ba <memmove>
80108491:	83 c4 10             	add    $0x10,%esp
80108494:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108497:	29 45 14             	sub    %eax,0x14(%ebp)
8010849a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010849d:	01 45 f4             	add    %eax,-0xc(%ebp)
801084a0:	8b 45 ec             	mov    -0x14(%ebp),%eax
801084a3:	05 00 10 00 00       	add    $0x1000,%eax
801084a8:	89 45 0c             	mov    %eax,0xc(%ebp)
801084ab:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
801084af:	0f 85 77 ff ff ff    	jne    8010842c <copyout+0xe>
801084b5:	b8 00 00 00 00       	mov    $0x0,%eax
801084ba:	c9                   	leave  
801084bb:	c3                   	ret    
