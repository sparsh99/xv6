
_ls:     file format elf32-i386


Disassembly of section .text:

00000000 <fmtname>:
#include "user.h"
#include "fs.h"

char*
fmtname(char *path)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	53                   	push   %ebx
   4:	83 ec 14             	sub    $0x14,%esp
  static char buf[DIRSIZ+1];
  char *p;
  
  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
   7:	83 ec 0c             	sub    $0xc,%esp
   a:	ff 75 08             	pushl  0x8(%ebp)
   d:	e8 c9 03 00 00       	call   3db <strlen>
  12:	83 c4 10             	add    $0x10,%esp
  15:	89 c2                	mov    %eax,%edx
  17:	8b 45 08             	mov    0x8(%ebp),%eax
  1a:	01 d0                	add    %edx,%eax
  1c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1f:	eb 04                	jmp    25 <fmtname+0x25>
  21:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
  25:	8b 45 f4             	mov    -0xc(%ebp),%eax
  28:	3b 45 08             	cmp    0x8(%ebp),%eax
  2b:	72 0a                	jb     37 <fmtname+0x37>
  2d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  30:	0f b6 00             	movzbl (%eax),%eax
  33:	3c 2f                	cmp    $0x2f,%al
  35:	75 ea                	jne    21 <fmtname+0x21>
    ;
  p++;
  37:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  
  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
  3b:	83 ec 0c             	sub    $0xc,%esp
  3e:	ff 75 f4             	pushl  -0xc(%ebp)
  41:	e8 95 03 00 00       	call   3db <strlen>
  46:	83 c4 10             	add    $0x10,%esp
  49:	83 f8 0d             	cmp    $0xd,%eax
  4c:	76 05                	jbe    53 <fmtname+0x53>
    return p;
  4e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  51:	eb 60                	jmp    b3 <fmtname+0xb3>
  memmove(buf, p, strlen(p));
  53:	83 ec 0c             	sub    $0xc,%esp
  56:	ff 75 f4             	pushl  -0xc(%ebp)
  59:	e8 7d 03 00 00       	call   3db <strlen>
  5e:	83 c4 10             	add    $0x10,%esp
  61:	83 ec 04             	sub    $0x4,%esp
  64:	50                   	push   %eax
  65:	ff 75 f4             	pushl  -0xc(%ebp)
  68:	68 d0 0f 00 00       	push   $0xfd0
  6d:	e8 e6 04 00 00       	call   558 <memmove>
  72:	83 c4 10             	add    $0x10,%esp
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  75:	83 ec 0c             	sub    $0xc,%esp
  78:	ff 75 f4             	pushl  -0xc(%ebp)
  7b:	e8 5b 03 00 00       	call   3db <strlen>
  80:	83 c4 10             	add    $0x10,%esp
  83:	ba 0e 00 00 00       	mov    $0xe,%edx
  88:	89 d3                	mov    %edx,%ebx
  8a:	29 c3                	sub    %eax,%ebx
  8c:	83 ec 0c             	sub    $0xc,%esp
  8f:	ff 75 f4             	pushl  -0xc(%ebp)
  92:	e8 44 03 00 00       	call   3db <strlen>
  97:	83 c4 10             	add    $0x10,%esp
  9a:	05 d0 0f 00 00       	add    $0xfd0,%eax
  9f:	83 ec 04             	sub    $0x4,%esp
  a2:	53                   	push   %ebx
  a3:	6a 20                	push   $0x20
  a5:	50                   	push   %eax
  a6:	e8 57 03 00 00       	call   402 <memset>
  ab:	83 c4 10             	add    $0x10,%esp
  return buf;
  ae:	b8 d0 0f 00 00       	mov    $0xfd0,%eax
}
  b3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  b6:	c9                   	leave  
  b7:	c3                   	ret    

000000b8 <ls>:

void
ls(char *path)
{
  b8:	55                   	push   %ebp
  b9:	89 e5                	mov    %esp,%ebp
  bb:	57                   	push   %edi
  bc:	56                   	push   %esi
  bd:	53                   	push   %ebx
  be:	81 ec 3c 02 00 00    	sub    $0x23c,%esp
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;
  
  if((fd = open(path, 0)) < 0){
  c4:	83 ec 08             	sub    $0x8,%esp
  c7:	6a 00                	push   $0x0
  c9:	ff 75 08             	pushl  0x8(%ebp)
  cc:	e8 a6 06 00 00       	call   777 <open>
  d1:	83 c4 10             	add    $0x10,%esp
  d4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  d7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  db:	79 1a                	jns    f7 <ls+0x3f>
    printf(2, "ls: cannot open %s\n", path);
  dd:	83 ec 04             	sub    $0x4,%esp
  e0:	ff 75 08             	pushl  0x8(%ebp)
  e3:	68 64 0c 00 00       	push   $0xc64
  e8:	6a 02                	push   $0x2
  ea:	e8 bf 07 00 00       	call   8ae <printf>
  ef:	83 c4 10             	add    $0x10,%esp
    return;
  f2:	e9 e3 01 00 00       	jmp    2da <ls+0x222>
  }
  
  if(fstat(fd, &st) < 0){
  f7:	83 ec 08             	sub    $0x8,%esp
  fa:	8d 85 bc fd ff ff    	lea    -0x244(%ebp),%eax
 100:	50                   	push   %eax
 101:	ff 75 e4             	pushl  -0x1c(%ebp)
 104:	e8 86 06 00 00       	call   78f <fstat>
 109:	83 c4 10             	add    $0x10,%esp
 10c:	85 c0                	test   %eax,%eax
 10e:	79 28                	jns    138 <ls+0x80>
    printf(2, "ls: cannot stat %s\n", path);
 110:	83 ec 04             	sub    $0x4,%esp
 113:	ff 75 08             	pushl  0x8(%ebp)
 116:	68 78 0c 00 00       	push   $0xc78
 11b:	6a 02                	push   $0x2
 11d:	e8 8c 07 00 00       	call   8ae <printf>
 122:	83 c4 10             	add    $0x10,%esp
    close(fd);
 125:	83 ec 0c             	sub    $0xc,%esp
 128:	ff 75 e4             	pushl  -0x1c(%ebp)
 12b:	e8 2f 06 00 00       	call   75f <close>
 130:	83 c4 10             	add    $0x10,%esp
    return;
 133:	e9 a2 01 00 00       	jmp    2da <ls+0x222>
  }
  
  switch(st.type){
 138:	0f b7 85 bc fd ff ff 	movzwl -0x244(%ebp),%eax
 13f:	98                   	cwtl   
 140:	83 f8 01             	cmp    $0x1,%eax
 143:	74 48                	je     18d <ls+0xd5>
 145:	83 f8 02             	cmp    $0x2,%eax
 148:	0f 85 7e 01 00 00    	jne    2cc <ls+0x214>
  case T_FILE:
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
 14e:	8b bd cc fd ff ff    	mov    -0x234(%ebp),%edi
 154:	8b b5 c4 fd ff ff    	mov    -0x23c(%ebp),%esi
 15a:	0f b7 85 bc fd ff ff 	movzwl -0x244(%ebp),%eax
 161:	0f bf d8             	movswl %ax,%ebx
 164:	83 ec 0c             	sub    $0xc,%esp
 167:	ff 75 08             	pushl  0x8(%ebp)
 16a:	e8 91 fe ff ff       	call   0 <fmtname>
 16f:	83 c4 10             	add    $0x10,%esp
 172:	83 ec 08             	sub    $0x8,%esp
 175:	57                   	push   %edi
 176:	56                   	push   %esi
 177:	53                   	push   %ebx
 178:	50                   	push   %eax
 179:	68 8c 0c 00 00       	push   $0xc8c
 17e:	6a 01                	push   $0x1
 180:	e8 29 07 00 00       	call   8ae <printf>
 185:	83 c4 20             	add    $0x20,%esp
    break;
 188:	e9 3f 01 00 00       	jmp    2cc <ls+0x214>
  
  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 18d:	83 ec 0c             	sub    $0xc,%esp
 190:	ff 75 08             	pushl  0x8(%ebp)
 193:	e8 43 02 00 00       	call   3db <strlen>
 198:	83 c4 10             	add    $0x10,%esp
 19b:	83 c0 10             	add    $0x10,%eax
 19e:	3d 00 02 00 00       	cmp    $0x200,%eax
 1a3:	76 17                	jbe    1bc <ls+0x104>
      printf(1, "ls: path too long\n");
 1a5:	83 ec 08             	sub    $0x8,%esp
 1a8:	68 99 0c 00 00       	push   $0xc99
 1ad:	6a 01                	push   $0x1
 1af:	e8 fa 06 00 00       	call   8ae <printf>
 1b4:	83 c4 10             	add    $0x10,%esp
      break;
 1b7:	e9 10 01 00 00       	jmp    2cc <ls+0x214>
    }
    strcpy(buf, path);
 1bc:	83 ec 08             	sub    $0x8,%esp
 1bf:	ff 75 08             	pushl  0x8(%ebp)
 1c2:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
 1c8:	50                   	push   %eax
 1c9:	e8 9e 01 00 00       	call   36c <strcpy>
 1ce:	83 c4 10             	add    $0x10,%esp
    p = buf+strlen(buf);
 1d1:	83 ec 0c             	sub    $0xc,%esp
 1d4:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
 1da:	50                   	push   %eax
 1db:	e8 fb 01 00 00       	call   3db <strlen>
 1e0:	83 c4 10             	add    $0x10,%esp
 1e3:	89 c2                	mov    %eax,%edx
 1e5:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
 1eb:	01 d0                	add    %edx,%eax
 1ed:	89 45 e0             	mov    %eax,-0x20(%ebp)
    *p++ = '/';
 1f0:	8b 45 e0             	mov    -0x20(%ebp),%eax
 1f3:	8d 50 01             	lea    0x1(%eax),%edx
 1f6:	89 55 e0             	mov    %edx,-0x20(%ebp)
 1f9:	c6 00 2f             	movb   $0x2f,(%eax)
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1fc:	e9 aa 00 00 00       	jmp    2ab <ls+0x1f3>
      if(de.inum == 0)
 201:	0f b7 85 d0 fd ff ff 	movzwl -0x230(%ebp),%eax
 208:	66 85 c0             	test   %ax,%ax
 20b:	75 05                	jne    212 <ls+0x15a>
        continue;
 20d:	e9 99 00 00 00       	jmp    2ab <ls+0x1f3>
      memmove(p, de.name, DIRSIZ);
 212:	83 ec 04             	sub    $0x4,%esp
 215:	6a 0e                	push   $0xe
 217:	8d 85 d0 fd ff ff    	lea    -0x230(%ebp),%eax
 21d:	83 c0 02             	add    $0x2,%eax
 220:	50                   	push   %eax
 221:	ff 75 e0             	pushl  -0x20(%ebp)
 224:	e8 2f 03 00 00       	call   558 <memmove>
 229:	83 c4 10             	add    $0x10,%esp
      p[DIRSIZ] = 0;
 22c:	8b 45 e0             	mov    -0x20(%ebp),%eax
 22f:	83 c0 0e             	add    $0xe,%eax
 232:	c6 00 00             	movb   $0x0,(%eax)
      if(stat(buf, &st) < 0){
 235:	83 ec 08             	sub    $0x8,%esp
 238:	8d 85 bc fd ff ff    	lea    -0x244(%ebp),%eax
 23e:	50                   	push   %eax
 23f:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
 245:	50                   	push   %eax
 246:	e8 73 02 00 00       	call   4be <stat>
 24b:	83 c4 10             	add    $0x10,%esp
 24e:	85 c0                	test   %eax,%eax
 250:	79 1b                	jns    26d <ls+0x1b5>
        printf(1, "ls: cannot stat %s\n", buf);
 252:	83 ec 04             	sub    $0x4,%esp
 255:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
 25b:	50                   	push   %eax
 25c:	68 78 0c 00 00       	push   $0xc78
 261:	6a 01                	push   $0x1
 263:	e8 46 06 00 00       	call   8ae <printf>
 268:	83 c4 10             	add    $0x10,%esp
        continue;
 26b:	eb 3e                	jmp    2ab <ls+0x1f3>
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 26d:	8b bd cc fd ff ff    	mov    -0x234(%ebp),%edi
 273:	8b b5 c4 fd ff ff    	mov    -0x23c(%ebp),%esi
 279:	0f b7 85 bc fd ff ff 	movzwl -0x244(%ebp),%eax
 280:	0f bf d8             	movswl %ax,%ebx
 283:	83 ec 0c             	sub    $0xc,%esp
 286:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
 28c:	50                   	push   %eax
 28d:	e8 6e fd ff ff       	call   0 <fmtname>
 292:	83 c4 10             	add    $0x10,%esp
 295:	83 ec 08             	sub    $0x8,%esp
 298:	57                   	push   %edi
 299:	56                   	push   %esi
 29a:	53                   	push   %ebx
 29b:	50                   	push   %eax
 29c:	68 8c 0c 00 00       	push   $0xc8c
 2a1:	6a 01                	push   $0x1
 2a3:	e8 06 06 00 00       	call   8ae <printf>
 2a8:	83 c4 20             	add    $0x20,%esp
      break;
    }
    strcpy(buf, path);
    p = buf+strlen(buf);
    *p++ = '/';
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 2ab:	83 ec 04             	sub    $0x4,%esp
 2ae:	6a 10                	push   $0x10
 2b0:	8d 85 d0 fd ff ff    	lea    -0x230(%ebp),%eax
 2b6:	50                   	push   %eax
 2b7:	ff 75 e4             	pushl  -0x1c(%ebp)
 2ba:	e8 90 04 00 00       	call   74f <read>
 2bf:	83 c4 10             	add    $0x10,%esp
 2c2:	83 f8 10             	cmp    $0x10,%eax
 2c5:	0f 84 36 ff ff ff    	je     201 <ls+0x149>
        printf(1, "ls: cannot stat %s\n", buf);
        continue;
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
 2cb:	90                   	nop
  }
  close(fd);
 2cc:	83 ec 0c             	sub    $0xc,%esp
 2cf:	ff 75 e4             	pushl  -0x1c(%ebp)
 2d2:	e8 88 04 00 00       	call   75f <close>
 2d7:	83 c4 10             	add    $0x10,%esp
}
 2da:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2dd:	5b                   	pop    %ebx
 2de:	5e                   	pop    %esi
 2df:	5f                   	pop    %edi
 2e0:	5d                   	pop    %ebp
 2e1:	c3                   	ret    

000002e2 <main>:

int
main(int argc, char *argv[])
{
 2e2:	8d 4c 24 04          	lea    0x4(%esp),%ecx
 2e6:	83 e4 f0             	and    $0xfffffff0,%esp
 2e9:	ff 71 fc             	pushl  -0x4(%ecx)
 2ec:	55                   	push   %ebp
 2ed:	89 e5                	mov    %esp,%ebp
 2ef:	53                   	push   %ebx
 2f0:	51                   	push   %ecx
 2f1:	83 ec 10             	sub    $0x10,%esp
 2f4:	89 cb                	mov    %ecx,%ebx
  int i;

  if(argc < 2){
 2f6:	83 3b 01             	cmpl   $0x1,(%ebx)
 2f9:	7f 15                	jg     310 <main+0x2e>
    ls(".");
 2fb:	83 ec 0c             	sub    $0xc,%esp
 2fe:	68 ac 0c 00 00       	push   $0xcac
 303:	e8 b0 fd ff ff       	call   b8 <ls>
 308:	83 c4 10             	add    $0x10,%esp
    exit();
 30b:	e8 27 04 00 00       	call   737 <exit>
  }
  for(i=1; i<argc; i++)
 310:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
 317:	eb 21                	jmp    33a <main+0x58>
    ls(argv[i]);
 319:	8b 45 f4             	mov    -0xc(%ebp),%eax
 31c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 323:	8b 43 04             	mov    0x4(%ebx),%eax
 326:	01 d0                	add    %edx,%eax
 328:	8b 00                	mov    (%eax),%eax
 32a:	83 ec 0c             	sub    $0xc,%esp
 32d:	50                   	push   %eax
 32e:	e8 85 fd ff ff       	call   b8 <ls>
 333:	83 c4 10             	add    $0x10,%esp

  if(argc < 2){
    ls(".");
    exit();
  }
  for(i=1; i<argc; i++)
 336:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 33a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 33d:	3b 03                	cmp    (%ebx),%eax
 33f:	7c d8                	jl     319 <main+0x37>
    ls(argv[i]);
  exit();
 341:	e8 f1 03 00 00       	call   737 <exit>

00000346 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 346:	55                   	push   %ebp
 347:	89 e5                	mov    %esp,%ebp
 349:	57                   	push   %edi
 34a:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 34b:	8b 4d 08             	mov    0x8(%ebp),%ecx
 34e:	8b 55 10             	mov    0x10(%ebp),%edx
 351:	8b 45 0c             	mov    0xc(%ebp),%eax
 354:	89 cb                	mov    %ecx,%ebx
 356:	89 df                	mov    %ebx,%edi
 358:	89 d1                	mov    %edx,%ecx
 35a:	fc                   	cld    
 35b:	f3 aa                	rep stos %al,%es:(%edi)
 35d:	89 ca                	mov    %ecx,%edx
 35f:	89 fb                	mov    %edi,%ebx
 361:	89 5d 08             	mov    %ebx,0x8(%ebp)
 364:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 367:	90                   	nop
 368:	5b                   	pop    %ebx
 369:	5f                   	pop    %edi
 36a:	5d                   	pop    %ebp
 36b:	c3                   	ret    

0000036c <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 36c:	55                   	push   %ebp
 36d:	89 e5                	mov    %esp,%ebp
 36f:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 372:	8b 45 08             	mov    0x8(%ebp),%eax
 375:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 378:	90                   	nop
 379:	8b 45 08             	mov    0x8(%ebp),%eax
 37c:	8d 50 01             	lea    0x1(%eax),%edx
 37f:	89 55 08             	mov    %edx,0x8(%ebp)
 382:	8b 55 0c             	mov    0xc(%ebp),%edx
 385:	8d 4a 01             	lea    0x1(%edx),%ecx
 388:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 38b:	0f b6 12             	movzbl (%edx),%edx
 38e:	88 10                	mov    %dl,(%eax)
 390:	0f b6 00             	movzbl (%eax),%eax
 393:	84 c0                	test   %al,%al
 395:	75 e2                	jne    379 <strcpy+0xd>
    ;
  return os;
 397:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 39a:	c9                   	leave  
 39b:	c3                   	ret    

0000039c <strcmp>:

int
strcmp(const char *p, const char *q)
{
 39c:	55                   	push   %ebp
 39d:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 39f:	eb 08                	jmp    3a9 <strcmp+0xd>
    p++, q++;
 3a1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 3a5:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 3a9:	8b 45 08             	mov    0x8(%ebp),%eax
 3ac:	0f b6 00             	movzbl (%eax),%eax
 3af:	84 c0                	test   %al,%al
 3b1:	74 10                	je     3c3 <strcmp+0x27>
 3b3:	8b 45 08             	mov    0x8(%ebp),%eax
 3b6:	0f b6 10             	movzbl (%eax),%edx
 3b9:	8b 45 0c             	mov    0xc(%ebp),%eax
 3bc:	0f b6 00             	movzbl (%eax),%eax
 3bf:	38 c2                	cmp    %al,%dl
 3c1:	74 de                	je     3a1 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 3c3:	8b 45 08             	mov    0x8(%ebp),%eax
 3c6:	0f b6 00             	movzbl (%eax),%eax
 3c9:	0f b6 d0             	movzbl %al,%edx
 3cc:	8b 45 0c             	mov    0xc(%ebp),%eax
 3cf:	0f b6 00             	movzbl (%eax),%eax
 3d2:	0f b6 c0             	movzbl %al,%eax
 3d5:	29 c2                	sub    %eax,%edx
 3d7:	89 d0                	mov    %edx,%eax
}
 3d9:	5d                   	pop    %ebp
 3da:	c3                   	ret    

000003db <strlen>:

uint
strlen(char *s)
{
 3db:	55                   	push   %ebp
 3dc:	89 e5                	mov    %esp,%ebp
 3de:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 3e1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 3e8:	eb 04                	jmp    3ee <strlen+0x13>
 3ea:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 3ee:	8b 55 fc             	mov    -0x4(%ebp),%edx
 3f1:	8b 45 08             	mov    0x8(%ebp),%eax
 3f4:	01 d0                	add    %edx,%eax
 3f6:	0f b6 00             	movzbl (%eax),%eax
 3f9:	84 c0                	test   %al,%al
 3fb:	75 ed                	jne    3ea <strlen+0xf>
    ;
  return n;
 3fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 400:	c9                   	leave  
 401:	c3                   	ret    

00000402 <memset>:

void*
memset(void *dst, int c, uint n)
{
 402:	55                   	push   %ebp
 403:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 405:	8b 45 10             	mov    0x10(%ebp),%eax
 408:	50                   	push   %eax
 409:	ff 75 0c             	pushl  0xc(%ebp)
 40c:	ff 75 08             	pushl  0x8(%ebp)
 40f:	e8 32 ff ff ff       	call   346 <stosb>
 414:	83 c4 0c             	add    $0xc,%esp
  return dst;
 417:	8b 45 08             	mov    0x8(%ebp),%eax
}
 41a:	c9                   	leave  
 41b:	c3                   	ret    

0000041c <strchr>:

char*
strchr(const char *s, char c)
{
 41c:	55                   	push   %ebp
 41d:	89 e5                	mov    %esp,%ebp
 41f:	83 ec 04             	sub    $0x4,%esp
 422:	8b 45 0c             	mov    0xc(%ebp),%eax
 425:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 428:	eb 14                	jmp    43e <strchr+0x22>
    if(*s == c)
 42a:	8b 45 08             	mov    0x8(%ebp),%eax
 42d:	0f b6 00             	movzbl (%eax),%eax
 430:	3a 45 fc             	cmp    -0x4(%ebp),%al
 433:	75 05                	jne    43a <strchr+0x1e>
      return (char*)s;
 435:	8b 45 08             	mov    0x8(%ebp),%eax
 438:	eb 13                	jmp    44d <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 43a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 43e:	8b 45 08             	mov    0x8(%ebp),%eax
 441:	0f b6 00             	movzbl (%eax),%eax
 444:	84 c0                	test   %al,%al
 446:	75 e2                	jne    42a <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 448:	b8 00 00 00 00       	mov    $0x0,%eax
}
 44d:	c9                   	leave  
 44e:	c3                   	ret    

0000044f <gets>:

char*
gets(char *buf, int max)
{
 44f:	55                   	push   %ebp
 450:	89 e5                	mov    %esp,%ebp
 452:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 455:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 45c:	eb 42                	jmp    4a0 <gets+0x51>
    cc = read(0, &c, 1);
 45e:	83 ec 04             	sub    $0x4,%esp
 461:	6a 01                	push   $0x1
 463:	8d 45 ef             	lea    -0x11(%ebp),%eax
 466:	50                   	push   %eax
 467:	6a 00                	push   $0x0
 469:	e8 e1 02 00 00       	call   74f <read>
 46e:	83 c4 10             	add    $0x10,%esp
 471:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 474:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 478:	7e 33                	jle    4ad <gets+0x5e>
      break;
    buf[i++] = c;
 47a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 47d:	8d 50 01             	lea    0x1(%eax),%edx
 480:	89 55 f4             	mov    %edx,-0xc(%ebp)
 483:	89 c2                	mov    %eax,%edx
 485:	8b 45 08             	mov    0x8(%ebp),%eax
 488:	01 c2                	add    %eax,%edx
 48a:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 48e:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 490:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 494:	3c 0a                	cmp    $0xa,%al
 496:	74 16                	je     4ae <gets+0x5f>
 498:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 49c:	3c 0d                	cmp    $0xd,%al
 49e:	74 0e                	je     4ae <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 4a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4a3:	83 c0 01             	add    $0x1,%eax
 4a6:	3b 45 0c             	cmp    0xc(%ebp),%eax
 4a9:	7c b3                	jl     45e <gets+0xf>
 4ab:	eb 01                	jmp    4ae <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 4ad:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 4ae:	8b 55 f4             	mov    -0xc(%ebp),%edx
 4b1:	8b 45 08             	mov    0x8(%ebp),%eax
 4b4:	01 d0                	add    %edx,%eax
 4b6:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 4b9:	8b 45 08             	mov    0x8(%ebp),%eax
}
 4bc:	c9                   	leave  
 4bd:	c3                   	ret    

000004be <stat>:

int
stat(char *n, struct stat *st)
{
 4be:	55                   	push   %ebp
 4bf:	89 e5                	mov    %esp,%ebp
 4c1:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4c4:	83 ec 08             	sub    $0x8,%esp
 4c7:	6a 00                	push   $0x0
 4c9:	ff 75 08             	pushl  0x8(%ebp)
 4cc:	e8 a6 02 00 00       	call   777 <open>
 4d1:	83 c4 10             	add    $0x10,%esp
 4d4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 4d7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4db:	79 07                	jns    4e4 <stat+0x26>
    return -1;
 4dd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 4e2:	eb 25                	jmp    509 <stat+0x4b>
  r = fstat(fd, st);
 4e4:	83 ec 08             	sub    $0x8,%esp
 4e7:	ff 75 0c             	pushl  0xc(%ebp)
 4ea:	ff 75 f4             	pushl  -0xc(%ebp)
 4ed:	e8 9d 02 00 00       	call   78f <fstat>
 4f2:	83 c4 10             	add    $0x10,%esp
 4f5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 4f8:	83 ec 0c             	sub    $0xc,%esp
 4fb:	ff 75 f4             	pushl  -0xc(%ebp)
 4fe:	e8 5c 02 00 00       	call   75f <close>
 503:	83 c4 10             	add    $0x10,%esp
  return r;
 506:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 509:	c9                   	leave  
 50a:	c3                   	ret    

0000050b <atoi>:

int
atoi(const char *s)
{
 50b:	55                   	push   %ebp
 50c:	89 e5                	mov    %esp,%ebp
 50e:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 511:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 518:	eb 25                	jmp    53f <atoi+0x34>
    n = n*10 + *s++ - '0';
 51a:	8b 55 fc             	mov    -0x4(%ebp),%edx
 51d:	89 d0                	mov    %edx,%eax
 51f:	c1 e0 02             	shl    $0x2,%eax
 522:	01 d0                	add    %edx,%eax
 524:	01 c0                	add    %eax,%eax
 526:	89 c1                	mov    %eax,%ecx
 528:	8b 45 08             	mov    0x8(%ebp),%eax
 52b:	8d 50 01             	lea    0x1(%eax),%edx
 52e:	89 55 08             	mov    %edx,0x8(%ebp)
 531:	0f b6 00             	movzbl (%eax),%eax
 534:	0f be c0             	movsbl %al,%eax
 537:	01 c8                	add    %ecx,%eax
 539:	83 e8 30             	sub    $0x30,%eax
 53c:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 53f:	8b 45 08             	mov    0x8(%ebp),%eax
 542:	0f b6 00             	movzbl (%eax),%eax
 545:	3c 2f                	cmp    $0x2f,%al
 547:	7e 0a                	jle    553 <atoi+0x48>
 549:	8b 45 08             	mov    0x8(%ebp),%eax
 54c:	0f b6 00             	movzbl (%eax),%eax
 54f:	3c 39                	cmp    $0x39,%al
 551:	7e c7                	jle    51a <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 553:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 556:	c9                   	leave  
 557:	c3                   	ret    

00000558 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 558:	55                   	push   %ebp
 559:	89 e5                	mov    %esp,%ebp
 55b:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 55e:	8b 45 08             	mov    0x8(%ebp),%eax
 561:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 564:	8b 45 0c             	mov    0xc(%ebp),%eax
 567:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 56a:	eb 17                	jmp    583 <memmove+0x2b>
    *dst++ = *src++;
 56c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 56f:	8d 50 01             	lea    0x1(%eax),%edx
 572:	89 55 fc             	mov    %edx,-0x4(%ebp)
 575:	8b 55 f8             	mov    -0x8(%ebp),%edx
 578:	8d 4a 01             	lea    0x1(%edx),%ecx
 57b:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 57e:	0f b6 12             	movzbl (%edx),%edx
 581:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 583:	8b 45 10             	mov    0x10(%ebp),%eax
 586:	8d 50 ff             	lea    -0x1(%eax),%edx
 589:	89 55 10             	mov    %edx,0x10(%ebp)
 58c:	85 c0                	test   %eax,%eax
 58e:	7f dc                	jg     56c <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 590:	8b 45 08             	mov    0x8(%ebp),%eax
}
 593:	c9                   	leave  
 594:	c3                   	ret    

00000595 <historyAdd>:

void
historyAdd(char *buf1){
 595:	55                   	push   %ebp
 596:	89 e5                	mov    %esp,%ebp
 598:	53                   	push   %ebx
 599:	81 ec f4 07 00 00    	sub    $0x7f4,%esp

     int fd;
     char hist[10]={'h','\0'};
 59f:	c7 45 e6 00 00 00 00 	movl   $0x0,-0x1a(%ebp)
 5a6:	c7 45 ea 00 00 00 00 	movl   $0x0,-0x16(%ebp)
 5ad:	66 c7 45 ee 00 00    	movw   $0x0,-0x12(%ebp)
 5b3:	c6 45 e6 68          	movb   $0x68,-0x1a(%ebp)
     //printf(1,"here\n");
     char buf[1000],buf2[1000];

     if((fd = open(hist, 0)) < 0){
 5b7:	83 ec 08             	sub    $0x8,%esp
 5ba:	6a 00                	push   $0x0
 5bc:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 5bf:	50                   	push   %eax
 5c0:	e8 b2 01 00 00       	call   777 <open>
 5c5:	83 c4 10             	add    $0x10,%esp
 5c8:	89 45 f0             	mov    %eax,-0x10(%ebp)
 5cb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 5cf:	79 1b                	jns    5ec <historyAdd+0x57>
       printf(1, "History: cannot open %s\n", hist);
 5d1:	83 ec 04             	sub    $0x4,%esp
 5d4:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 5d7:	50                   	push   %eax
 5d8:	68 b0 0c 00 00       	push   $0xcb0
 5dd:	6a 01                	push   $0x1
 5df:	e8 ca 02 00 00       	call   8ae <printf>
 5e4:	83 c4 10             	add    $0x10,%esp
       exit();
 5e7:	e8 4b 01 00 00       	call   737 <exit>
     }

     int i=0;
 5ec:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     while(buf1[i]!=0)
 5f3:	eb 1c                	jmp    611 <historyAdd+0x7c>
     { 	//printf(1,"%d has %d\n",i,buf1[i]);
	buf[i]=buf1[i]; 
 5f5:	8b 55 f4             	mov    -0xc(%ebp),%edx
 5f8:	8b 45 08             	mov    0x8(%ebp),%eax
 5fb:	01 d0                	add    %edx,%eax
 5fd:	0f b6 00             	movzbl (%eax),%eax
 600:	8d 8d fe fb ff ff    	lea    -0x402(%ebp),%ecx
 606:	8b 55 f4             	mov    -0xc(%ebp),%edx
 609:	01 ca                	add    %ecx,%edx
 60b:	88 02                	mov    %al,(%edx)
	i++;
 60d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
       printf(1, "History: cannot open %s\n", hist);
       exit();
     }

     int i=0;
     while(buf1[i]!=0)
 611:	8b 55 f4             	mov    -0xc(%ebp),%edx
 614:	8b 45 08             	mov    0x8(%ebp),%eax
 617:	01 d0                	add    %edx,%eax
 619:	0f b6 00             	movzbl (%eax),%eax
 61c:	84 c0                	test   %al,%al
 61e:	75 d5                	jne    5f5 <historyAdd+0x60>
     { 	//printf(1,"%d has %d\n",i,buf1[i]);
	buf[i]=buf1[i]; 
	i++;
     }
	buf[i]=0;	
 620:	8d 95 fe fb ff ff    	lea    -0x402(%ebp),%edx
 626:	8b 45 f4             	mov    -0xc(%ebp),%eax
 629:	01 d0                	add    %edx,%eax
 62b:	c6 00 00             	movb   $0x0,(%eax)
    // int n;
     while((read(fd, buf2, 1000)) > 0){
 62e:	eb 5a                	jmp    68a <historyAdd+0xf5>
	
	//printf(1,"%d %d\n",strlen(buf),strlen(buf2));
	
	while(i<strlen(buf2)+strlen(buf1)){
		//printf(1,"%c\n",buf2[i]);
		buf[i]=buf2[i-strlen(buf1)];
 630:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 633:	83 ec 0c             	sub    $0xc,%esp
 636:	ff 75 08             	pushl  0x8(%ebp)
 639:	e8 9d fd ff ff       	call   3db <strlen>
 63e:	83 c4 10             	add    $0x10,%esp
 641:	29 c3                	sub    %eax,%ebx
 643:	89 d8                	mov    %ebx,%eax
 645:	0f b6 84 05 16 f8 ff 	movzbl -0x7ea(%ebp,%eax,1),%eax
 64c:	ff 
 64d:	8d 8d fe fb ff ff    	lea    -0x402(%ebp),%ecx
 653:	8b 55 f4             	mov    -0xc(%ebp),%edx
 656:	01 ca                	add    %ecx,%edx
 658:	88 02                	mov    %al,(%edx)
		i++;
 65a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
	//buf[1001]=0;
	//int i=0;
	
	//printf(1,"%d %d\n",strlen(buf),strlen(buf2));
	
	while(i<strlen(buf2)+strlen(buf1)){
 65e:	83 ec 0c             	sub    $0xc,%esp
 661:	8d 85 16 f8 ff ff    	lea    -0x7ea(%ebp),%eax
 667:	50                   	push   %eax
 668:	e8 6e fd ff ff       	call   3db <strlen>
 66d:	83 c4 10             	add    $0x10,%esp
 670:	89 c3                	mov    %eax,%ebx
 672:	83 ec 0c             	sub    $0xc,%esp
 675:	ff 75 08             	pushl  0x8(%ebp)
 678:	e8 5e fd ff ff       	call   3db <strlen>
 67d:	83 c4 10             	add    $0x10,%esp
 680:	8d 14 03             	lea    (%ebx,%eax,1),%edx
 683:	8b 45 f4             	mov    -0xc(%ebp),%eax
 686:	39 c2                	cmp    %eax,%edx
 688:	77 a6                	ja     630 <historyAdd+0x9b>
	buf[i]=buf1[i]; 
	i++;
     }
	buf[i]=0;	
    // int n;
     while((read(fd, buf2, 1000)) > 0){
 68a:	83 ec 04             	sub    $0x4,%esp
 68d:	68 e8 03 00 00       	push   $0x3e8
 692:	8d 85 16 f8 ff ff    	lea    -0x7ea(%ebp),%eax
 698:	50                   	push   %eax
 699:	ff 75 f0             	pushl  -0x10(%ebp)
 69c:	e8 ae 00 00 00       	call   74f <read>
 6a1:	83 c4 10             	add    $0x10,%esp
 6a4:	85 c0                	test   %eax,%eax
 6a6:	7f b6                	jg     65e <historyAdd+0xc9>
	}
	
	//printf(1,"strlen: %d %s\n",strlen(buf),buf);	
     }
     //history(fd);
     close(fd);
 6a8:	83 ec 0c             	sub    $0xc,%esp
 6ab:	ff 75 f0             	pushl  -0x10(%ebp)
 6ae:	e8 ac 00 00 00       	call   75f <close>
 6b3:	83 c4 10             	add    $0x10,%esp

     if((fd = open(hist,O_CREATE|O_RDWR)) < 0){
 6b6:	83 ec 08             	sub    $0x8,%esp
 6b9:	68 02 02 00 00       	push   $0x202
 6be:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 6c1:	50                   	push   %eax
 6c2:	e8 b0 00 00 00       	call   777 <open>
 6c7:	83 c4 10             	add    $0x10,%esp
 6ca:	89 45 f0             	mov    %eax,-0x10(%ebp)
 6cd:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 6d1:	79 1b                	jns    6ee <historyAdd+0x159>
       printf(1, "History: cannot open %s\n", hist);
 6d3:	83 ec 04             	sub    $0x4,%esp
 6d6:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 6d9:	50                   	push   %eax
 6da:	68 b0 0c 00 00       	push   $0xcb0
 6df:	6a 01                	push   $0x1
 6e1:	e8 c8 01 00 00       	call   8ae <printf>
 6e6:	83 c4 10             	add    $0x10,%esp
       exit();
 6e9:	e8 49 00 00 00       	call   737 <exit>
     }
	
     if(write(fd, buf, 1000) != 1000){
 6ee:	83 ec 04             	sub    $0x4,%esp
 6f1:	68 e8 03 00 00       	push   $0x3e8
 6f6:	8d 85 fe fb ff ff    	lea    -0x402(%ebp),%eax
 6fc:	50                   	push   %eax
 6fd:	ff 75 f0             	pushl  -0x10(%ebp)
 700:	e8 52 00 00 00       	call   757 <write>
 705:	83 c4 10             	add    $0x10,%esp
 708:	3d e8 03 00 00       	cmp    $0x3e8,%eax
 70d:	74 1a                	je     729 <historyAdd+0x194>
       printf(1, "error: write aa %d new file failed\n", i);
 70f:	83 ec 04             	sub    $0x4,%esp
 712:	ff 75 f4             	pushl  -0xc(%ebp)
 715:	68 cc 0c 00 00       	push   $0xccc
 71a:	6a 01                	push   $0x1
 71c:	e8 8d 01 00 00       	call   8ae <printf>
 721:	83 c4 10             	add    $0x10,%esp
       exit();
 724:	e8 0e 00 00 00       	call   737 <exit>
     }
    
}
 729:	90                   	nop
 72a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 72d:	c9                   	leave  
 72e:	c3                   	ret    

0000072f <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 72f:	b8 01 00 00 00       	mov    $0x1,%eax
 734:	cd 40                	int    $0x40
 736:	c3                   	ret    

00000737 <exit>:
SYSCALL(exit)
 737:	b8 02 00 00 00       	mov    $0x2,%eax
 73c:	cd 40                	int    $0x40
 73e:	c3                   	ret    

0000073f <wait>:
SYSCALL(wait)
 73f:	b8 03 00 00 00       	mov    $0x3,%eax
 744:	cd 40                	int    $0x40
 746:	c3                   	ret    

00000747 <pipe>:
SYSCALL(pipe)
 747:	b8 04 00 00 00       	mov    $0x4,%eax
 74c:	cd 40                	int    $0x40
 74e:	c3                   	ret    

0000074f <read>:
SYSCALL(read)
 74f:	b8 05 00 00 00       	mov    $0x5,%eax
 754:	cd 40                	int    $0x40
 756:	c3                   	ret    

00000757 <write>:
SYSCALL(write)
 757:	b8 10 00 00 00       	mov    $0x10,%eax
 75c:	cd 40                	int    $0x40
 75e:	c3                   	ret    

0000075f <close>:
SYSCALL(close)
 75f:	b8 15 00 00 00       	mov    $0x15,%eax
 764:	cd 40                	int    $0x40
 766:	c3                   	ret    

00000767 <kill>:
SYSCALL(kill)
 767:	b8 06 00 00 00       	mov    $0x6,%eax
 76c:	cd 40                	int    $0x40
 76e:	c3                   	ret    

0000076f <exec>:
SYSCALL(exec)
 76f:	b8 07 00 00 00       	mov    $0x7,%eax
 774:	cd 40                	int    $0x40
 776:	c3                   	ret    

00000777 <open>:
SYSCALL(open)
 777:	b8 0f 00 00 00       	mov    $0xf,%eax
 77c:	cd 40                	int    $0x40
 77e:	c3                   	ret    

0000077f <mknod>:
SYSCALL(mknod)
 77f:	b8 11 00 00 00       	mov    $0x11,%eax
 784:	cd 40                	int    $0x40
 786:	c3                   	ret    

00000787 <unlink>:
SYSCALL(unlink)
 787:	b8 12 00 00 00       	mov    $0x12,%eax
 78c:	cd 40                	int    $0x40
 78e:	c3                   	ret    

0000078f <fstat>:
SYSCALL(fstat)
 78f:	b8 08 00 00 00       	mov    $0x8,%eax
 794:	cd 40                	int    $0x40
 796:	c3                   	ret    

00000797 <link>:
SYSCALL(link)
 797:	b8 13 00 00 00       	mov    $0x13,%eax
 79c:	cd 40                	int    $0x40
 79e:	c3                   	ret    

0000079f <mkdir>:
SYSCALL(mkdir)
 79f:	b8 14 00 00 00       	mov    $0x14,%eax
 7a4:	cd 40                	int    $0x40
 7a6:	c3                   	ret    

000007a7 <chdir>:
SYSCALL(chdir)
 7a7:	b8 09 00 00 00       	mov    $0x9,%eax
 7ac:	cd 40                	int    $0x40
 7ae:	c3                   	ret    

000007af <dup>:
SYSCALL(dup)
 7af:	b8 0a 00 00 00       	mov    $0xa,%eax
 7b4:	cd 40                	int    $0x40
 7b6:	c3                   	ret    

000007b7 <getpid>:
SYSCALL(getpid)
 7b7:	b8 0b 00 00 00       	mov    $0xb,%eax
 7bc:	cd 40                	int    $0x40
 7be:	c3                   	ret    

000007bf <sbrk>:
SYSCALL(sbrk)
 7bf:	b8 0c 00 00 00       	mov    $0xc,%eax
 7c4:	cd 40                	int    $0x40
 7c6:	c3                   	ret    

000007c7 <sleep>:
SYSCALL(sleep)
 7c7:	b8 0d 00 00 00       	mov    $0xd,%eax
 7cc:	cd 40                	int    $0x40
 7ce:	c3                   	ret    

000007cf <uptime>:
SYSCALL(uptime)
 7cf:	b8 0e 00 00 00       	mov    $0xe,%eax
 7d4:	cd 40                	int    $0x40
 7d6:	c3                   	ret    

000007d7 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 7d7:	55                   	push   %ebp
 7d8:	89 e5                	mov    %esp,%ebp
 7da:	83 ec 18             	sub    $0x18,%esp
 7dd:	8b 45 0c             	mov    0xc(%ebp),%eax
 7e0:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 7e3:	83 ec 04             	sub    $0x4,%esp
 7e6:	6a 01                	push   $0x1
 7e8:	8d 45 f4             	lea    -0xc(%ebp),%eax
 7eb:	50                   	push   %eax
 7ec:	ff 75 08             	pushl  0x8(%ebp)
 7ef:	e8 63 ff ff ff       	call   757 <write>
 7f4:	83 c4 10             	add    $0x10,%esp
}
 7f7:	90                   	nop
 7f8:	c9                   	leave  
 7f9:	c3                   	ret    

000007fa <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 7fa:	55                   	push   %ebp
 7fb:	89 e5                	mov    %esp,%ebp
 7fd:	53                   	push   %ebx
 7fe:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 801:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 808:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 80c:	74 17                	je     825 <printint+0x2b>
 80e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 812:	79 11                	jns    825 <printint+0x2b>
    neg = 1;
 814:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 81b:	8b 45 0c             	mov    0xc(%ebp),%eax
 81e:	f7 d8                	neg    %eax
 820:	89 45 ec             	mov    %eax,-0x14(%ebp)
 823:	eb 06                	jmp    82b <printint+0x31>
  } else {
    x = xx;
 825:	8b 45 0c             	mov    0xc(%ebp),%eax
 828:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 82b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 832:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 835:	8d 41 01             	lea    0x1(%ecx),%eax
 838:	89 45 f4             	mov    %eax,-0xc(%ebp)
 83b:	8b 5d 10             	mov    0x10(%ebp),%ebx
 83e:	8b 45 ec             	mov    -0x14(%ebp),%eax
 841:	ba 00 00 00 00       	mov    $0x0,%edx
 846:	f7 f3                	div    %ebx
 848:	89 d0                	mov    %edx,%eax
 84a:	0f b6 80 bc 0f 00 00 	movzbl 0xfbc(%eax),%eax
 851:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 855:	8b 5d 10             	mov    0x10(%ebp),%ebx
 858:	8b 45 ec             	mov    -0x14(%ebp),%eax
 85b:	ba 00 00 00 00       	mov    $0x0,%edx
 860:	f7 f3                	div    %ebx
 862:	89 45 ec             	mov    %eax,-0x14(%ebp)
 865:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 869:	75 c7                	jne    832 <printint+0x38>
  if(neg)
 86b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 86f:	74 2d                	je     89e <printint+0xa4>
    buf[i++] = '-';
 871:	8b 45 f4             	mov    -0xc(%ebp),%eax
 874:	8d 50 01             	lea    0x1(%eax),%edx
 877:	89 55 f4             	mov    %edx,-0xc(%ebp)
 87a:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 87f:	eb 1d                	jmp    89e <printint+0xa4>
    putc(fd, buf[i]);
 881:	8d 55 dc             	lea    -0x24(%ebp),%edx
 884:	8b 45 f4             	mov    -0xc(%ebp),%eax
 887:	01 d0                	add    %edx,%eax
 889:	0f b6 00             	movzbl (%eax),%eax
 88c:	0f be c0             	movsbl %al,%eax
 88f:	83 ec 08             	sub    $0x8,%esp
 892:	50                   	push   %eax
 893:	ff 75 08             	pushl  0x8(%ebp)
 896:	e8 3c ff ff ff       	call   7d7 <putc>
 89b:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 89e:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 8a2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 8a6:	79 d9                	jns    881 <printint+0x87>
    putc(fd, buf[i]);
}
 8a8:	90                   	nop
 8a9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 8ac:	c9                   	leave  
 8ad:	c3                   	ret    

000008ae <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 8ae:	55                   	push   %ebp
 8af:	89 e5                	mov    %esp,%ebp
 8b1:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 8b4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 8bb:	8d 45 0c             	lea    0xc(%ebp),%eax
 8be:	83 c0 04             	add    $0x4,%eax
 8c1:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 8c4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 8cb:	e9 59 01 00 00       	jmp    a29 <printf+0x17b>
    c = fmt[i] & 0xff;
 8d0:	8b 55 0c             	mov    0xc(%ebp),%edx
 8d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8d6:	01 d0                	add    %edx,%eax
 8d8:	0f b6 00             	movzbl (%eax),%eax
 8db:	0f be c0             	movsbl %al,%eax
 8de:	25 ff 00 00 00       	and    $0xff,%eax
 8e3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 8e6:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 8ea:	75 2c                	jne    918 <printf+0x6a>
      if(c == '%'){
 8ec:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 8f0:	75 0c                	jne    8fe <printf+0x50>
        state = '%';
 8f2:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 8f9:	e9 27 01 00 00       	jmp    a25 <printf+0x177>
      } else {
        putc(fd, c);
 8fe:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 901:	0f be c0             	movsbl %al,%eax
 904:	83 ec 08             	sub    $0x8,%esp
 907:	50                   	push   %eax
 908:	ff 75 08             	pushl  0x8(%ebp)
 90b:	e8 c7 fe ff ff       	call   7d7 <putc>
 910:	83 c4 10             	add    $0x10,%esp
 913:	e9 0d 01 00 00       	jmp    a25 <printf+0x177>
      }
    } else if(state == '%'){
 918:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 91c:	0f 85 03 01 00 00    	jne    a25 <printf+0x177>
      if(c == 'd'){
 922:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 926:	75 1e                	jne    946 <printf+0x98>
        printint(fd, *ap, 10, 1);
 928:	8b 45 e8             	mov    -0x18(%ebp),%eax
 92b:	8b 00                	mov    (%eax),%eax
 92d:	6a 01                	push   $0x1
 92f:	6a 0a                	push   $0xa
 931:	50                   	push   %eax
 932:	ff 75 08             	pushl  0x8(%ebp)
 935:	e8 c0 fe ff ff       	call   7fa <printint>
 93a:	83 c4 10             	add    $0x10,%esp
        ap++;
 93d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 941:	e9 d8 00 00 00       	jmp    a1e <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 946:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 94a:	74 06                	je     952 <printf+0xa4>
 94c:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 950:	75 1e                	jne    970 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 952:	8b 45 e8             	mov    -0x18(%ebp),%eax
 955:	8b 00                	mov    (%eax),%eax
 957:	6a 00                	push   $0x0
 959:	6a 10                	push   $0x10
 95b:	50                   	push   %eax
 95c:	ff 75 08             	pushl  0x8(%ebp)
 95f:	e8 96 fe ff ff       	call   7fa <printint>
 964:	83 c4 10             	add    $0x10,%esp
        ap++;
 967:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 96b:	e9 ae 00 00 00       	jmp    a1e <printf+0x170>
      } else if(c == 's'){
 970:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 974:	75 43                	jne    9b9 <printf+0x10b>
        s = (char*)*ap;
 976:	8b 45 e8             	mov    -0x18(%ebp),%eax
 979:	8b 00                	mov    (%eax),%eax
 97b:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 97e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 982:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 986:	75 25                	jne    9ad <printf+0xff>
          s = "(null)";
 988:	c7 45 f4 f0 0c 00 00 	movl   $0xcf0,-0xc(%ebp)
        while(*s != 0){
 98f:	eb 1c                	jmp    9ad <printf+0xff>
          putc(fd, *s);
 991:	8b 45 f4             	mov    -0xc(%ebp),%eax
 994:	0f b6 00             	movzbl (%eax),%eax
 997:	0f be c0             	movsbl %al,%eax
 99a:	83 ec 08             	sub    $0x8,%esp
 99d:	50                   	push   %eax
 99e:	ff 75 08             	pushl  0x8(%ebp)
 9a1:	e8 31 fe ff ff       	call   7d7 <putc>
 9a6:	83 c4 10             	add    $0x10,%esp
          s++;
 9a9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 9ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9b0:	0f b6 00             	movzbl (%eax),%eax
 9b3:	84 c0                	test   %al,%al
 9b5:	75 da                	jne    991 <printf+0xe3>
 9b7:	eb 65                	jmp    a1e <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 9b9:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 9bd:	75 1d                	jne    9dc <printf+0x12e>
        putc(fd, *ap);
 9bf:	8b 45 e8             	mov    -0x18(%ebp),%eax
 9c2:	8b 00                	mov    (%eax),%eax
 9c4:	0f be c0             	movsbl %al,%eax
 9c7:	83 ec 08             	sub    $0x8,%esp
 9ca:	50                   	push   %eax
 9cb:	ff 75 08             	pushl  0x8(%ebp)
 9ce:	e8 04 fe ff ff       	call   7d7 <putc>
 9d3:	83 c4 10             	add    $0x10,%esp
        ap++;
 9d6:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 9da:	eb 42                	jmp    a1e <printf+0x170>
      } else if(c == '%'){
 9dc:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 9e0:	75 17                	jne    9f9 <printf+0x14b>
        putc(fd, c);
 9e2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 9e5:	0f be c0             	movsbl %al,%eax
 9e8:	83 ec 08             	sub    $0x8,%esp
 9eb:	50                   	push   %eax
 9ec:	ff 75 08             	pushl  0x8(%ebp)
 9ef:	e8 e3 fd ff ff       	call   7d7 <putc>
 9f4:	83 c4 10             	add    $0x10,%esp
 9f7:	eb 25                	jmp    a1e <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 9f9:	83 ec 08             	sub    $0x8,%esp
 9fc:	6a 25                	push   $0x25
 9fe:	ff 75 08             	pushl  0x8(%ebp)
 a01:	e8 d1 fd ff ff       	call   7d7 <putc>
 a06:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 a09:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 a0c:	0f be c0             	movsbl %al,%eax
 a0f:	83 ec 08             	sub    $0x8,%esp
 a12:	50                   	push   %eax
 a13:	ff 75 08             	pushl  0x8(%ebp)
 a16:	e8 bc fd ff ff       	call   7d7 <putc>
 a1b:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 a1e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 a25:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 a29:	8b 55 0c             	mov    0xc(%ebp),%edx
 a2c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a2f:	01 d0                	add    %edx,%eax
 a31:	0f b6 00             	movzbl (%eax),%eax
 a34:	84 c0                	test   %al,%al
 a36:	0f 85 94 fe ff ff    	jne    8d0 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 a3c:	90                   	nop
 a3d:	c9                   	leave  
 a3e:	c3                   	ret    

00000a3f <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a3f:	55                   	push   %ebp
 a40:	89 e5                	mov    %esp,%ebp
 a42:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 a45:	8b 45 08             	mov    0x8(%ebp),%eax
 a48:	83 e8 08             	sub    $0x8,%eax
 a4b:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a4e:	a1 e8 0f 00 00       	mov    0xfe8,%eax
 a53:	89 45 fc             	mov    %eax,-0x4(%ebp)
 a56:	eb 24                	jmp    a7c <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a58:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a5b:	8b 00                	mov    (%eax),%eax
 a5d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 a60:	77 12                	ja     a74 <free+0x35>
 a62:	8b 45 f8             	mov    -0x8(%ebp),%eax
 a65:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 a68:	77 24                	ja     a8e <free+0x4f>
 a6a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a6d:	8b 00                	mov    (%eax),%eax
 a6f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 a72:	77 1a                	ja     a8e <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a74:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a77:	8b 00                	mov    (%eax),%eax
 a79:	89 45 fc             	mov    %eax,-0x4(%ebp)
 a7c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 a7f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 a82:	76 d4                	jbe    a58 <free+0x19>
 a84:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a87:	8b 00                	mov    (%eax),%eax
 a89:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 a8c:	76 ca                	jbe    a58 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 a8e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 a91:	8b 40 04             	mov    0x4(%eax),%eax
 a94:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 a9b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 a9e:	01 c2                	add    %eax,%edx
 aa0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 aa3:	8b 00                	mov    (%eax),%eax
 aa5:	39 c2                	cmp    %eax,%edx
 aa7:	75 24                	jne    acd <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 aa9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 aac:	8b 50 04             	mov    0x4(%eax),%edx
 aaf:	8b 45 fc             	mov    -0x4(%ebp),%eax
 ab2:	8b 00                	mov    (%eax),%eax
 ab4:	8b 40 04             	mov    0x4(%eax),%eax
 ab7:	01 c2                	add    %eax,%edx
 ab9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 abc:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 abf:	8b 45 fc             	mov    -0x4(%ebp),%eax
 ac2:	8b 00                	mov    (%eax),%eax
 ac4:	8b 10                	mov    (%eax),%edx
 ac6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 ac9:	89 10                	mov    %edx,(%eax)
 acb:	eb 0a                	jmp    ad7 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 acd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 ad0:	8b 10                	mov    (%eax),%edx
 ad2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 ad5:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 ad7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 ada:	8b 40 04             	mov    0x4(%eax),%eax
 add:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 ae4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 ae7:	01 d0                	add    %edx,%eax
 ae9:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 aec:	75 20                	jne    b0e <free+0xcf>
    p->s.size += bp->s.size;
 aee:	8b 45 fc             	mov    -0x4(%ebp),%eax
 af1:	8b 50 04             	mov    0x4(%eax),%edx
 af4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 af7:	8b 40 04             	mov    0x4(%eax),%eax
 afa:	01 c2                	add    %eax,%edx
 afc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 aff:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 b02:	8b 45 f8             	mov    -0x8(%ebp),%eax
 b05:	8b 10                	mov    (%eax),%edx
 b07:	8b 45 fc             	mov    -0x4(%ebp),%eax
 b0a:	89 10                	mov    %edx,(%eax)
 b0c:	eb 08                	jmp    b16 <free+0xd7>
  } else
    p->s.ptr = bp;
 b0e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 b11:	8b 55 f8             	mov    -0x8(%ebp),%edx
 b14:	89 10                	mov    %edx,(%eax)
  freep = p;
 b16:	8b 45 fc             	mov    -0x4(%ebp),%eax
 b19:	a3 e8 0f 00 00       	mov    %eax,0xfe8
}
 b1e:	90                   	nop
 b1f:	c9                   	leave  
 b20:	c3                   	ret    

00000b21 <morecore>:

static Header*
morecore(uint nu)
{
 b21:	55                   	push   %ebp
 b22:	89 e5                	mov    %esp,%ebp
 b24:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 b27:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 b2e:	77 07                	ja     b37 <morecore+0x16>
    nu = 4096;
 b30:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 b37:	8b 45 08             	mov    0x8(%ebp),%eax
 b3a:	c1 e0 03             	shl    $0x3,%eax
 b3d:	83 ec 0c             	sub    $0xc,%esp
 b40:	50                   	push   %eax
 b41:	e8 79 fc ff ff       	call   7bf <sbrk>
 b46:	83 c4 10             	add    $0x10,%esp
 b49:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 b4c:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 b50:	75 07                	jne    b59 <morecore+0x38>
    return 0;
 b52:	b8 00 00 00 00       	mov    $0x0,%eax
 b57:	eb 26                	jmp    b7f <morecore+0x5e>
  hp = (Header*)p;
 b59:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b5c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 b5f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 b62:	8b 55 08             	mov    0x8(%ebp),%edx
 b65:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 b68:	8b 45 f0             	mov    -0x10(%ebp),%eax
 b6b:	83 c0 08             	add    $0x8,%eax
 b6e:	83 ec 0c             	sub    $0xc,%esp
 b71:	50                   	push   %eax
 b72:	e8 c8 fe ff ff       	call   a3f <free>
 b77:	83 c4 10             	add    $0x10,%esp
  return freep;
 b7a:	a1 e8 0f 00 00       	mov    0xfe8,%eax
}
 b7f:	c9                   	leave  
 b80:	c3                   	ret    

00000b81 <malloc>:

void*
malloc(uint nbytes)
{
 b81:	55                   	push   %ebp
 b82:	89 e5                	mov    %esp,%ebp
 b84:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b87:	8b 45 08             	mov    0x8(%ebp),%eax
 b8a:	83 c0 07             	add    $0x7,%eax
 b8d:	c1 e8 03             	shr    $0x3,%eax
 b90:	83 c0 01             	add    $0x1,%eax
 b93:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 b96:	a1 e8 0f 00 00       	mov    0xfe8,%eax
 b9b:	89 45 f0             	mov    %eax,-0x10(%ebp)
 b9e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 ba2:	75 23                	jne    bc7 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 ba4:	c7 45 f0 e0 0f 00 00 	movl   $0xfe0,-0x10(%ebp)
 bab:	8b 45 f0             	mov    -0x10(%ebp),%eax
 bae:	a3 e8 0f 00 00       	mov    %eax,0xfe8
 bb3:	a1 e8 0f 00 00       	mov    0xfe8,%eax
 bb8:	a3 e0 0f 00 00       	mov    %eax,0xfe0
    base.s.size = 0;
 bbd:	c7 05 e4 0f 00 00 00 	movl   $0x0,0xfe4
 bc4:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 bc7:	8b 45 f0             	mov    -0x10(%ebp),%eax
 bca:	8b 00                	mov    (%eax),%eax
 bcc:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 bcf:	8b 45 f4             	mov    -0xc(%ebp),%eax
 bd2:	8b 40 04             	mov    0x4(%eax),%eax
 bd5:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 bd8:	72 4d                	jb     c27 <malloc+0xa6>
      if(p->s.size == nunits)
 bda:	8b 45 f4             	mov    -0xc(%ebp),%eax
 bdd:	8b 40 04             	mov    0x4(%eax),%eax
 be0:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 be3:	75 0c                	jne    bf1 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 be5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 be8:	8b 10                	mov    (%eax),%edx
 bea:	8b 45 f0             	mov    -0x10(%ebp),%eax
 bed:	89 10                	mov    %edx,(%eax)
 bef:	eb 26                	jmp    c17 <malloc+0x96>
      else {
        p->s.size -= nunits;
 bf1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 bf4:	8b 40 04             	mov    0x4(%eax),%eax
 bf7:	2b 45 ec             	sub    -0x14(%ebp),%eax
 bfa:	89 c2                	mov    %eax,%edx
 bfc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 bff:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 c02:	8b 45 f4             	mov    -0xc(%ebp),%eax
 c05:	8b 40 04             	mov    0x4(%eax),%eax
 c08:	c1 e0 03             	shl    $0x3,%eax
 c0b:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 c0e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 c11:	8b 55 ec             	mov    -0x14(%ebp),%edx
 c14:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 c17:	8b 45 f0             	mov    -0x10(%ebp),%eax
 c1a:	a3 e8 0f 00 00       	mov    %eax,0xfe8
      return (void*)(p + 1);
 c1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 c22:	83 c0 08             	add    $0x8,%eax
 c25:	eb 3b                	jmp    c62 <malloc+0xe1>
    }
    if(p == freep)
 c27:	a1 e8 0f 00 00       	mov    0xfe8,%eax
 c2c:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 c2f:	75 1e                	jne    c4f <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 c31:	83 ec 0c             	sub    $0xc,%esp
 c34:	ff 75 ec             	pushl  -0x14(%ebp)
 c37:	e8 e5 fe ff ff       	call   b21 <morecore>
 c3c:	83 c4 10             	add    $0x10,%esp
 c3f:	89 45 f4             	mov    %eax,-0xc(%ebp)
 c42:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 c46:	75 07                	jne    c4f <malloc+0xce>
        return 0;
 c48:	b8 00 00 00 00       	mov    $0x0,%eax
 c4d:	eb 13                	jmp    c62 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 c52:	89 45 f0             	mov    %eax,-0x10(%ebp)
 c55:	8b 45 f4             	mov    -0xc(%ebp),%eax
 c58:	8b 00                	mov    (%eax),%eax
 c5a:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 c5d:	e9 6d ff ff ff       	jmp    bcf <malloc+0x4e>
}
 c62:	c9                   	leave  
 c63:	c3                   	ret    
