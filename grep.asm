
_grep:     file format elf32-i386


Disassembly of section .text:

00000000 <grep>:
char buf[1024];
int match(char*, char*);

void
grep(char *pattern, int fd)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 18             	sub    $0x18,%esp
  int n, m;
  char *p, *q;
  
  m = 0;
   6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
   d:	e9 b8 00 00 00       	jmp    ca <grep+0xca>
    m += n;
  12:	8b 45 ec             	mov    -0x14(%ebp),%eax
  15:	01 45 f4             	add    %eax,-0xc(%ebp)
    buf[m] = '\0';
  18:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1b:	05 00 10 00 00       	add    $0x1000,%eax
  20:	c6 00 00             	movb   $0x0,(%eax)
    p = buf;
  23:	c7 45 f0 00 10 00 00 	movl   $0x1000,-0x10(%ebp)
    while((q = strchr(p, '\n')) != 0){
  2a:	eb 4a                	jmp    76 <grep+0x76>
      *q = 0;
  2c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  2f:	c6 00 00             	movb   $0x0,(%eax)
      if(match(pattern, p)){
  32:	83 ec 08             	sub    $0x8,%esp
  35:	ff 75 f0             	pushl  -0x10(%ebp)
  38:	ff 75 08             	pushl  0x8(%ebp)
  3b:	e8 9c 01 00 00       	call   1dc <match>
  40:	83 c4 10             	add    $0x10,%esp
  43:	85 c0                	test   %eax,%eax
  45:	74 26                	je     6d <grep+0x6d>
        *q = '\n';
  47:	8b 45 e8             	mov    -0x18(%ebp),%eax
  4a:	c6 00 0a             	movb   $0xa,(%eax)
        write(1, p, q+1 - p);
  4d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  50:	83 c0 01             	add    $0x1,%eax
  53:	89 c2                	mov    %eax,%edx
  55:	8b 45 f0             	mov    -0x10(%ebp),%eax
  58:	29 c2                	sub    %eax,%edx
  5a:	89 d0                	mov    %edx,%eax
  5c:	83 ec 04             	sub    $0x4,%esp
  5f:	50                   	push   %eax
  60:	ff 75 f0             	pushl  -0x10(%ebp)
  63:	6a 01                	push   $0x1
  65:	e8 df 06 00 00       	call   749 <write>
  6a:	83 c4 10             	add    $0x10,%esp
      }
      p = q+1;
  6d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  70:	83 c0 01             	add    $0x1,%eax
  73:	89 45 f0             	mov    %eax,-0x10(%ebp)
  m = 0;
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
    m += n;
    buf[m] = '\0';
    p = buf;
    while((q = strchr(p, '\n')) != 0){
  76:	83 ec 08             	sub    $0x8,%esp
  79:	6a 0a                	push   $0xa
  7b:	ff 75 f0             	pushl  -0x10(%ebp)
  7e:	e8 8b 03 00 00       	call   40e <strchr>
  83:	83 c4 10             	add    $0x10,%esp
  86:	89 45 e8             	mov    %eax,-0x18(%ebp)
  89:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  8d:	75 9d                	jne    2c <grep+0x2c>
        *q = '\n';
        write(1, p, q+1 - p);
      }
      p = q+1;
    }
    if(p == buf)
  8f:	81 7d f0 00 10 00 00 	cmpl   $0x1000,-0x10(%ebp)
  96:	75 07                	jne    9f <grep+0x9f>
      m = 0;
  98:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(m > 0){
  9f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  a3:	7e 25                	jle    ca <grep+0xca>
      m -= p - buf;
  a5:	ba 00 10 00 00       	mov    $0x1000,%edx
  aa:	8b 45 f0             	mov    -0x10(%ebp),%eax
  ad:	29 c2                	sub    %eax,%edx
  af:	89 d0                	mov    %edx,%eax
  b1:	01 45 f4             	add    %eax,-0xc(%ebp)
      memmove(buf, p, m);
  b4:	83 ec 04             	sub    $0x4,%esp
  b7:	ff 75 f4             	pushl  -0xc(%ebp)
  ba:	ff 75 f0             	pushl  -0x10(%ebp)
  bd:	68 00 10 00 00       	push   $0x1000
  c2:	e8 83 04 00 00       	call   54a <memmove>
  c7:	83 c4 10             	add    $0x10,%esp
{
  int n, m;
  char *p, *q;
  
  m = 0;
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
  ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
  cd:	ba ff 03 00 00       	mov    $0x3ff,%edx
  d2:	29 c2                	sub    %eax,%edx
  d4:	89 d0                	mov    %edx,%eax
  d6:	89 c2                	mov    %eax,%edx
  d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  db:	05 00 10 00 00       	add    $0x1000,%eax
  e0:	83 ec 04             	sub    $0x4,%esp
  e3:	52                   	push   %edx
  e4:	50                   	push   %eax
  e5:	ff 75 0c             	pushl  0xc(%ebp)
  e8:	e8 54 06 00 00       	call   741 <read>
  ed:	83 c4 10             	add    $0x10,%esp
  f0:	89 45 ec             	mov    %eax,-0x14(%ebp)
  f3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  f7:	0f 8f 15 ff ff ff    	jg     12 <grep+0x12>
    if(m > 0){
      m -= p - buf;
      memmove(buf, p, m);
    }
  }
}
  fd:	90                   	nop
  fe:	c9                   	leave  
  ff:	c3                   	ret    

00000100 <main>:

int
main(int argc, char *argv[])
{
 100:	8d 4c 24 04          	lea    0x4(%esp),%ecx
 104:	83 e4 f0             	and    $0xfffffff0,%esp
 107:	ff 71 fc             	pushl  -0x4(%ecx)
 10a:	55                   	push   %ebp
 10b:	89 e5                	mov    %esp,%ebp
 10d:	53                   	push   %ebx
 10e:	51                   	push   %ecx
 10f:	83 ec 10             	sub    $0x10,%esp
 112:	89 cb                	mov    %ecx,%ebx
  int fd, i;
  char *pattern;
  
  if(argc <= 1){
 114:	83 3b 01             	cmpl   $0x1,(%ebx)
 117:	7f 17                	jg     130 <main+0x30>
    printf(2, "usage: grep pattern [file ...]\n");
 119:	83 ec 08             	sub    $0x8,%esp
 11c:	68 58 0c 00 00       	push   $0xc58
 121:	6a 02                	push   $0x2
 123:	e8 78 07 00 00       	call   8a0 <printf>
 128:	83 c4 10             	add    $0x10,%esp
    exit();
 12b:	e8 f9 05 00 00       	call   729 <exit>
  }
  pattern = argv[1];
 130:	8b 43 04             	mov    0x4(%ebx),%eax
 133:	8b 40 04             	mov    0x4(%eax),%eax
 136:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  if(argc <= 2){
 139:	83 3b 02             	cmpl   $0x2,(%ebx)
 13c:	7f 15                	jg     153 <main+0x53>
    grep(pattern, 0);
 13e:	83 ec 08             	sub    $0x8,%esp
 141:	6a 00                	push   $0x0
 143:	ff 75 f0             	pushl  -0x10(%ebp)
 146:	e8 b5 fe ff ff       	call   0 <grep>
 14b:	83 c4 10             	add    $0x10,%esp
    exit();
 14e:	e8 d6 05 00 00       	call   729 <exit>
  }

  for(i = 2; i < argc; i++){
 153:	c7 45 f4 02 00 00 00 	movl   $0x2,-0xc(%ebp)
 15a:	eb 74                	jmp    1d0 <main+0xd0>
    if((fd = open(argv[i], 0)) < 0){
 15c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 15f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 166:	8b 43 04             	mov    0x4(%ebx),%eax
 169:	01 d0                	add    %edx,%eax
 16b:	8b 00                	mov    (%eax),%eax
 16d:	83 ec 08             	sub    $0x8,%esp
 170:	6a 00                	push   $0x0
 172:	50                   	push   %eax
 173:	e8 f1 05 00 00       	call   769 <open>
 178:	83 c4 10             	add    $0x10,%esp
 17b:	89 45 ec             	mov    %eax,-0x14(%ebp)
 17e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 182:	79 29                	jns    1ad <main+0xad>
      printf(1, "grep: cannot open %s\n", argv[i]);
 184:	8b 45 f4             	mov    -0xc(%ebp),%eax
 187:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 18e:	8b 43 04             	mov    0x4(%ebx),%eax
 191:	01 d0                	add    %edx,%eax
 193:	8b 00                	mov    (%eax),%eax
 195:	83 ec 04             	sub    $0x4,%esp
 198:	50                   	push   %eax
 199:	68 78 0c 00 00       	push   $0xc78
 19e:	6a 01                	push   $0x1
 1a0:	e8 fb 06 00 00       	call   8a0 <printf>
 1a5:	83 c4 10             	add    $0x10,%esp
      exit();
 1a8:	e8 7c 05 00 00       	call   729 <exit>
    }
    grep(pattern, fd);
 1ad:	83 ec 08             	sub    $0x8,%esp
 1b0:	ff 75 ec             	pushl  -0x14(%ebp)
 1b3:	ff 75 f0             	pushl  -0x10(%ebp)
 1b6:	e8 45 fe ff ff       	call   0 <grep>
 1bb:	83 c4 10             	add    $0x10,%esp
    close(fd);
 1be:	83 ec 0c             	sub    $0xc,%esp
 1c1:	ff 75 ec             	pushl  -0x14(%ebp)
 1c4:	e8 88 05 00 00       	call   751 <close>
 1c9:	83 c4 10             	add    $0x10,%esp
  if(argc <= 2){
    grep(pattern, 0);
    exit();
  }

  for(i = 2; i < argc; i++){
 1cc:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 1d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1d3:	3b 03                	cmp    (%ebx),%eax
 1d5:	7c 85                	jl     15c <main+0x5c>
      exit();
    }
    grep(pattern, fd);
    close(fd);
  }
  exit();
 1d7:	e8 4d 05 00 00       	call   729 <exit>

000001dc <match>:
int matchhere(char*, char*);
int matchstar(int, char*, char*);

int
match(char *re, char *text)
{
 1dc:	55                   	push   %ebp
 1dd:	89 e5                	mov    %esp,%ebp
 1df:	83 ec 08             	sub    $0x8,%esp
  if(re[0] == '^')
 1e2:	8b 45 08             	mov    0x8(%ebp),%eax
 1e5:	0f b6 00             	movzbl (%eax),%eax
 1e8:	3c 5e                	cmp    $0x5e,%al
 1ea:	75 17                	jne    203 <match+0x27>
    return matchhere(re+1, text);
 1ec:	8b 45 08             	mov    0x8(%ebp),%eax
 1ef:	83 c0 01             	add    $0x1,%eax
 1f2:	83 ec 08             	sub    $0x8,%esp
 1f5:	ff 75 0c             	pushl  0xc(%ebp)
 1f8:	50                   	push   %eax
 1f9:	e8 38 00 00 00       	call   236 <matchhere>
 1fe:	83 c4 10             	add    $0x10,%esp
 201:	eb 31                	jmp    234 <match+0x58>
  do{  // must look at empty string
    if(matchhere(re, text))
 203:	83 ec 08             	sub    $0x8,%esp
 206:	ff 75 0c             	pushl  0xc(%ebp)
 209:	ff 75 08             	pushl  0x8(%ebp)
 20c:	e8 25 00 00 00       	call   236 <matchhere>
 211:	83 c4 10             	add    $0x10,%esp
 214:	85 c0                	test   %eax,%eax
 216:	74 07                	je     21f <match+0x43>
      return 1;
 218:	b8 01 00 00 00       	mov    $0x1,%eax
 21d:	eb 15                	jmp    234 <match+0x58>
  }while(*text++ != '\0');
 21f:	8b 45 0c             	mov    0xc(%ebp),%eax
 222:	8d 50 01             	lea    0x1(%eax),%edx
 225:	89 55 0c             	mov    %edx,0xc(%ebp)
 228:	0f b6 00             	movzbl (%eax),%eax
 22b:	84 c0                	test   %al,%al
 22d:	75 d4                	jne    203 <match+0x27>
  return 0;
 22f:	b8 00 00 00 00       	mov    $0x0,%eax
}
 234:	c9                   	leave  
 235:	c3                   	ret    

00000236 <matchhere>:

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
 236:	55                   	push   %ebp
 237:	89 e5                	mov    %esp,%ebp
 239:	83 ec 08             	sub    $0x8,%esp
  if(re[0] == '\0')
 23c:	8b 45 08             	mov    0x8(%ebp),%eax
 23f:	0f b6 00             	movzbl (%eax),%eax
 242:	84 c0                	test   %al,%al
 244:	75 0a                	jne    250 <matchhere+0x1a>
    return 1;
 246:	b8 01 00 00 00       	mov    $0x1,%eax
 24b:	e9 99 00 00 00       	jmp    2e9 <matchhere+0xb3>
  if(re[1] == '*')
 250:	8b 45 08             	mov    0x8(%ebp),%eax
 253:	83 c0 01             	add    $0x1,%eax
 256:	0f b6 00             	movzbl (%eax),%eax
 259:	3c 2a                	cmp    $0x2a,%al
 25b:	75 21                	jne    27e <matchhere+0x48>
    return matchstar(re[0], re+2, text);
 25d:	8b 45 08             	mov    0x8(%ebp),%eax
 260:	8d 50 02             	lea    0x2(%eax),%edx
 263:	8b 45 08             	mov    0x8(%ebp),%eax
 266:	0f b6 00             	movzbl (%eax),%eax
 269:	0f be c0             	movsbl %al,%eax
 26c:	83 ec 04             	sub    $0x4,%esp
 26f:	ff 75 0c             	pushl  0xc(%ebp)
 272:	52                   	push   %edx
 273:	50                   	push   %eax
 274:	e8 72 00 00 00       	call   2eb <matchstar>
 279:	83 c4 10             	add    $0x10,%esp
 27c:	eb 6b                	jmp    2e9 <matchhere+0xb3>
  if(re[0] == '$' && re[1] == '\0')
 27e:	8b 45 08             	mov    0x8(%ebp),%eax
 281:	0f b6 00             	movzbl (%eax),%eax
 284:	3c 24                	cmp    $0x24,%al
 286:	75 1d                	jne    2a5 <matchhere+0x6f>
 288:	8b 45 08             	mov    0x8(%ebp),%eax
 28b:	83 c0 01             	add    $0x1,%eax
 28e:	0f b6 00             	movzbl (%eax),%eax
 291:	84 c0                	test   %al,%al
 293:	75 10                	jne    2a5 <matchhere+0x6f>
    return *text == '\0';
 295:	8b 45 0c             	mov    0xc(%ebp),%eax
 298:	0f b6 00             	movzbl (%eax),%eax
 29b:	84 c0                	test   %al,%al
 29d:	0f 94 c0             	sete   %al
 2a0:	0f b6 c0             	movzbl %al,%eax
 2a3:	eb 44                	jmp    2e9 <matchhere+0xb3>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
 2a5:	8b 45 0c             	mov    0xc(%ebp),%eax
 2a8:	0f b6 00             	movzbl (%eax),%eax
 2ab:	84 c0                	test   %al,%al
 2ad:	74 35                	je     2e4 <matchhere+0xae>
 2af:	8b 45 08             	mov    0x8(%ebp),%eax
 2b2:	0f b6 00             	movzbl (%eax),%eax
 2b5:	3c 2e                	cmp    $0x2e,%al
 2b7:	74 10                	je     2c9 <matchhere+0x93>
 2b9:	8b 45 08             	mov    0x8(%ebp),%eax
 2bc:	0f b6 10             	movzbl (%eax),%edx
 2bf:	8b 45 0c             	mov    0xc(%ebp),%eax
 2c2:	0f b6 00             	movzbl (%eax),%eax
 2c5:	38 c2                	cmp    %al,%dl
 2c7:	75 1b                	jne    2e4 <matchhere+0xae>
    return matchhere(re+1, text+1);
 2c9:	8b 45 0c             	mov    0xc(%ebp),%eax
 2cc:	8d 50 01             	lea    0x1(%eax),%edx
 2cf:	8b 45 08             	mov    0x8(%ebp),%eax
 2d2:	83 c0 01             	add    $0x1,%eax
 2d5:	83 ec 08             	sub    $0x8,%esp
 2d8:	52                   	push   %edx
 2d9:	50                   	push   %eax
 2da:	e8 57 ff ff ff       	call   236 <matchhere>
 2df:	83 c4 10             	add    $0x10,%esp
 2e2:	eb 05                	jmp    2e9 <matchhere+0xb3>
  return 0;
 2e4:	b8 00 00 00 00       	mov    $0x0,%eax
}
 2e9:	c9                   	leave  
 2ea:	c3                   	ret    

000002eb <matchstar>:

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
 2eb:	55                   	push   %ebp
 2ec:	89 e5                	mov    %esp,%ebp
 2ee:	83 ec 08             	sub    $0x8,%esp
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
 2f1:	83 ec 08             	sub    $0x8,%esp
 2f4:	ff 75 10             	pushl  0x10(%ebp)
 2f7:	ff 75 0c             	pushl  0xc(%ebp)
 2fa:	e8 37 ff ff ff       	call   236 <matchhere>
 2ff:	83 c4 10             	add    $0x10,%esp
 302:	85 c0                	test   %eax,%eax
 304:	74 07                	je     30d <matchstar+0x22>
      return 1;
 306:	b8 01 00 00 00       	mov    $0x1,%eax
 30b:	eb 29                	jmp    336 <matchstar+0x4b>
  }while(*text!='\0' && (*text++==c || c=='.'));
 30d:	8b 45 10             	mov    0x10(%ebp),%eax
 310:	0f b6 00             	movzbl (%eax),%eax
 313:	84 c0                	test   %al,%al
 315:	74 1a                	je     331 <matchstar+0x46>
 317:	8b 45 10             	mov    0x10(%ebp),%eax
 31a:	8d 50 01             	lea    0x1(%eax),%edx
 31d:	89 55 10             	mov    %edx,0x10(%ebp)
 320:	0f b6 00             	movzbl (%eax),%eax
 323:	0f be c0             	movsbl %al,%eax
 326:	3b 45 08             	cmp    0x8(%ebp),%eax
 329:	74 c6                	je     2f1 <matchstar+0x6>
 32b:	83 7d 08 2e          	cmpl   $0x2e,0x8(%ebp)
 32f:	74 c0                	je     2f1 <matchstar+0x6>
  return 0;
 331:	b8 00 00 00 00       	mov    $0x0,%eax
}
 336:	c9                   	leave  
 337:	c3                   	ret    

00000338 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 338:	55                   	push   %ebp
 339:	89 e5                	mov    %esp,%ebp
 33b:	57                   	push   %edi
 33c:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 33d:	8b 4d 08             	mov    0x8(%ebp),%ecx
 340:	8b 55 10             	mov    0x10(%ebp),%edx
 343:	8b 45 0c             	mov    0xc(%ebp),%eax
 346:	89 cb                	mov    %ecx,%ebx
 348:	89 df                	mov    %ebx,%edi
 34a:	89 d1                	mov    %edx,%ecx
 34c:	fc                   	cld    
 34d:	f3 aa                	rep stos %al,%es:(%edi)
 34f:	89 ca                	mov    %ecx,%edx
 351:	89 fb                	mov    %edi,%ebx
 353:	89 5d 08             	mov    %ebx,0x8(%ebp)
 356:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 359:	90                   	nop
 35a:	5b                   	pop    %ebx
 35b:	5f                   	pop    %edi
 35c:	5d                   	pop    %ebp
 35d:	c3                   	ret    

0000035e <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 35e:	55                   	push   %ebp
 35f:	89 e5                	mov    %esp,%ebp
 361:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 364:	8b 45 08             	mov    0x8(%ebp),%eax
 367:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 36a:	90                   	nop
 36b:	8b 45 08             	mov    0x8(%ebp),%eax
 36e:	8d 50 01             	lea    0x1(%eax),%edx
 371:	89 55 08             	mov    %edx,0x8(%ebp)
 374:	8b 55 0c             	mov    0xc(%ebp),%edx
 377:	8d 4a 01             	lea    0x1(%edx),%ecx
 37a:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 37d:	0f b6 12             	movzbl (%edx),%edx
 380:	88 10                	mov    %dl,(%eax)
 382:	0f b6 00             	movzbl (%eax),%eax
 385:	84 c0                	test   %al,%al
 387:	75 e2                	jne    36b <strcpy+0xd>
    ;
  return os;
 389:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 38c:	c9                   	leave  
 38d:	c3                   	ret    

0000038e <strcmp>:

int
strcmp(const char *p, const char *q)
{
 38e:	55                   	push   %ebp
 38f:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 391:	eb 08                	jmp    39b <strcmp+0xd>
    p++, q++;
 393:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 397:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 39b:	8b 45 08             	mov    0x8(%ebp),%eax
 39e:	0f b6 00             	movzbl (%eax),%eax
 3a1:	84 c0                	test   %al,%al
 3a3:	74 10                	je     3b5 <strcmp+0x27>
 3a5:	8b 45 08             	mov    0x8(%ebp),%eax
 3a8:	0f b6 10             	movzbl (%eax),%edx
 3ab:	8b 45 0c             	mov    0xc(%ebp),%eax
 3ae:	0f b6 00             	movzbl (%eax),%eax
 3b1:	38 c2                	cmp    %al,%dl
 3b3:	74 de                	je     393 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 3b5:	8b 45 08             	mov    0x8(%ebp),%eax
 3b8:	0f b6 00             	movzbl (%eax),%eax
 3bb:	0f b6 d0             	movzbl %al,%edx
 3be:	8b 45 0c             	mov    0xc(%ebp),%eax
 3c1:	0f b6 00             	movzbl (%eax),%eax
 3c4:	0f b6 c0             	movzbl %al,%eax
 3c7:	29 c2                	sub    %eax,%edx
 3c9:	89 d0                	mov    %edx,%eax
}
 3cb:	5d                   	pop    %ebp
 3cc:	c3                   	ret    

000003cd <strlen>:

uint
strlen(char *s)
{
 3cd:	55                   	push   %ebp
 3ce:	89 e5                	mov    %esp,%ebp
 3d0:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 3d3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 3da:	eb 04                	jmp    3e0 <strlen+0x13>
 3dc:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 3e0:	8b 55 fc             	mov    -0x4(%ebp),%edx
 3e3:	8b 45 08             	mov    0x8(%ebp),%eax
 3e6:	01 d0                	add    %edx,%eax
 3e8:	0f b6 00             	movzbl (%eax),%eax
 3eb:	84 c0                	test   %al,%al
 3ed:	75 ed                	jne    3dc <strlen+0xf>
    ;
  return n;
 3ef:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 3f2:	c9                   	leave  
 3f3:	c3                   	ret    

000003f4 <memset>:

void*
memset(void *dst, int c, uint n)
{
 3f4:	55                   	push   %ebp
 3f5:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 3f7:	8b 45 10             	mov    0x10(%ebp),%eax
 3fa:	50                   	push   %eax
 3fb:	ff 75 0c             	pushl  0xc(%ebp)
 3fe:	ff 75 08             	pushl  0x8(%ebp)
 401:	e8 32 ff ff ff       	call   338 <stosb>
 406:	83 c4 0c             	add    $0xc,%esp
  return dst;
 409:	8b 45 08             	mov    0x8(%ebp),%eax
}
 40c:	c9                   	leave  
 40d:	c3                   	ret    

0000040e <strchr>:

char*
strchr(const char *s, char c)
{
 40e:	55                   	push   %ebp
 40f:	89 e5                	mov    %esp,%ebp
 411:	83 ec 04             	sub    $0x4,%esp
 414:	8b 45 0c             	mov    0xc(%ebp),%eax
 417:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 41a:	eb 14                	jmp    430 <strchr+0x22>
    if(*s == c)
 41c:	8b 45 08             	mov    0x8(%ebp),%eax
 41f:	0f b6 00             	movzbl (%eax),%eax
 422:	3a 45 fc             	cmp    -0x4(%ebp),%al
 425:	75 05                	jne    42c <strchr+0x1e>
      return (char*)s;
 427:	8b 45 08             	mov    0x8(%ebp),%eax
 42a:	eb 13                	jmp    43f <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 42c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 430:	8b 45 08             	mov    0x8(%ebp),%eax
 433:	0f b6 00             	movzbl (%eax),%eax
 436:	84 c0                	test   %al,%al
 438:	75 e2                	jne    41c <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 43a:	b8 00 00 00 00       	mov    $0x0,%eax
}
 43f:	c9                   	leave  
 440:	c3                   	ret    

00000441 <gets>:

char*
gets(char *buf, int max)
{
 441:	55                   	push   %ebp
 442:	89 e5                	mov    %esp,%ebp
 444:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 447:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 44e:	eb 42                	jmp    492 <gets+0x51>
    cc = read(0, &c, 1);
 450:	83 ec 04             	sub    $0x4,%esp
 453:	6a 01                	push   $0x1
 455:	8d 45 ef             	lea    -0x11(%ebp),%eax
 458:	50                   	push   %eax
 459:	6a 00                	push   $0x0
 45b:	e8 e1 02 00 00       	call   741 <read>
 460:	83 c4 10             	add    $0x10,%esp
 463:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 466:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 46a:	7e 33                	jle    49f <gets+0x5e>
      break;
    buf[i++] = c;
 46c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 46f:	8d 50 01             	lea    0x1(%eax),%edx
 472:	89 55 f4             	mov    %edx,-0xc(%ebp)
 475:	89 c2                	mov    %eax,%edx
 477:	8b 45 08             	mov    0x8(%ebp),%eax
 47a:	01 c2                	add    %eax,%edx
 47c:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 480:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 482:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 486:	3c 0a                	cmp    $0xa,%al
 488:	74 16                	je     4a0 <gets+0x5f>
 48a:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 48e:	3c 0d                	cmp    $0xd,%al
 490:	74 0e                	je     4a0 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 492:	8b 45 f4             	mov    -0xc(%ebp),%eax
 495:	83 c0 01             	add    $0x1,%eax
 498:	3b 45 0c             	cmp    0xc(%ebp),%eax
 49b:	7c b3                	jl     450 <gets+0xf>
 49d:	eb 01                	jmp    4a0 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 49f:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 4a0:	8b 55 f4             	mov    -0xc(%ebp),%edx
 4a3:	8b 45 08             	mov    0x8(%ebp),%eax
 4a6:	01 d0                	add    %edx,%eax
 4a8:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 4ab:	8b 45 08             	mov    0x8(%ebp),%eax
}
 4ae:	c9                   	leave  
 4af:	c3                   	ret    

000004b0 <stat>:

int
stat(char *n, struct stat *st)
{
 4b0:	55                   	push   %ebp
 4b1:	89 e5                	mov    %esp,%ebp
 4b3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4b6:	83 ec 08             	sub    $0x8,%esp
 4b9:	6a 00                	push   $0x0
 4bb:	ff 75 08             	pushl  0x8(%ebp)
 4be:	e8 a6 02 00 00       	call   769 <open>
 4c3:	83 c4 10             	add    $0x10,%esp
 4c6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 4c9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4cd:	79 07                	jns    4d6 <stat+0x26>
    return -1;
 4cf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 4d4:	eb 25                	jmp    4fb <stat+0x4b>
  r = fstat(fd, st);
 4d6:	83 ec 08             	sub    $0x8,%esp
 4d9:	ff 75 0c             	pushl  0xc(%ebp)
 4dc:	ff 75 f4             	pushl  -0xc(%ebp)
 4df:	e8 9d 02 00 00       	call   781 <fstat>
 4e4:	83 c4 10             	add    $0x10,%esp
 4e7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 4ea:	83 ec 0c             	sub    $0xc,%esp
 4ed:	ff 75 f4             	pushl  -0xc(%ebp)
 4f0:	e8 5c 02 00 00       	call   751 <close>
 4f5:	83 c4 10             	add    $0x10,%esp
  return r;
 4f8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 4fb:	c9                   	leave  
 4fc:	c3                   	ret    

000004fd <atoi>:

int
atoi(const char *s)
{
 4fd:	55                   	push   %ebp
 4fe:	89 e5                	mov    %esp,%ebp
 500:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 503:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 50a:	eb 25                	jmp    531 <atoi+0x34>
    n = n*10 + *s++ - '0';
 50c:	8b 55 fc             	mov    -0x4(%ebp),%edx
 50f:	89 d0                	mov    %edx,%eax
 511:	c1 e0 02             	shl    $0x2,%eax
 514:	01 d0                	add    %edx,%eax
 516:	01 c0                	add    %eax,%eax
 518:	89 c1                	mov    %eax,%ecx
 51a:	8b 45 08             	mov    0x8(%ebp),%eax
 51d:	8d 50 01             	lea    0x1(%eax),%edx
 520:	89 55 08             	mov    %edx,0x8(%ebp)
 523:	0f b6 00             	movzbl (%eax),%eax
 526:	0f be c0             	movsbl %al,%eax
 529:	01 c8                	add    %ecx,%eax
 52b:	83 e8 30             	sub    $0x30,%eax
 52e:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 531:	8b 45 08             	mov    0x8(%ebp),%eax
 534:	0f b6 00             	movzbl (%eax),%eax
 537:	3c 2f                	cmp    $0x2f,%al
 539:	7e 0a                	jle    545 <atoi+0x48>
 53b:	8b 45 08             	mov    0x8(%ebp),%eax
 53e:	0f b6 00             	movzbl (%eax),%eax
 541:	3c 39                	cmp    $0x39,%al
 543:	7e c7                	jle    50c <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 545:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 548:	c9                   	leave  
 549:	c3                   	ret    

0000054a <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 54a:	55                   	push   %ebp
 54b:	89 e5                	mov    %esp,%ebp
 54d:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 550:	8b 45 08             	mov    0x8(%ebp),%eax
 553:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 556:	8b 45 0c             	mov    0xc(%ebp),%eax
 559:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 55c:	eb 17                	jmp    575 <memmove+0x2b>
    *dst++ = *src++;
 55e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 561:	8d 50 01             	lea    0x1(%eax),%edx
 564:	89 55 fc             	mov    %edx,-0x4(%ebp)
 567:	8b 55 f8             	mov    -0x8(%ebp),%edx
 56a:	8d 4a 01             	lea    0x1(%edx),%ecx
 56d:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 570:	0f b6 12             	movzbl (%edx),%edx
 573:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 575:	8b 45 10             	mov    0x10(%ebp),%eax
 578:	8d 50 ff             	lea    -0x1(%eax),%edx
 57b:	89 55 10             	mov    %edx,0x10(%ebp)
 57e:	85 c0                	test   %eax,%eax
 580:	7f dc                	jg     55e <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 582:	8b 45 08             	mov    0x8(%ebp),%eax
}
 585:	c9                   	leave  
 586:	c3                   	ret    

00000587 <historyAdd>:

void
historyAdd(char *buf1){
 587:	55                   	push   %ebp
 588:	89 e5                	mov    %esp,%ebp
 58a:	53                   	push   %ebx
 58b:	81 ec f4 07 00 00    	sub    $0x7f4,%esp

     int fd;
     char hist[10]={'h','\0'};
 591:	c7 45 e6 00 00 00 00 	movl   $0x0,-0x1a(%ebp)
 598:	c7 45 ea 00 00 00 00 	movl   $0x0,-0x16(%ebp)
 59f:	66 c7 45 ee 00 00    	movw   $0x0,-0x12(%ebp)
 5a5:	c6 45 e6 68          	movb   $0x68,-0x1a(%ebp)
     //printf(1,"here\n");
     char buf[1000],buf2[1000];

     if((fd = open(hist, 0)) < 0){
 5a9:	83 ec 08             	sub    $0x8,%esp
 5ac:	6a 00                	push   $0x0
 5ae:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 5b1:	50                   	push   %eax
 5b2:	e8 b2 01 00 00       	call   769 <open>
 5b7:	83 c4 10             	add    $0x10,%esp
 5ba:	89 45 f0             	mov    %eax,-0x10(%ebp)
 5bd:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 5c1:	79 1b                	jns    5de <historyAdd+0x57>
       printf(1, "History: cannot open %s\n", hist);
 5c3:	83 ec 04             	sub    $0x4,%esp
 5c6:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 5c9:	50                   	push   %eax
 5ca:	68 90 0c 00 00       	push   $0xc90
 5cf:	6a 01                	push   $0x1
 5d1:	e8 ca 02 00 00       	call   8a0 <printf>
 5d6:	83 c4 10             	add    $0x10,%esp
       exit();
 5d9:	e8 4b 01 00 00       	call   729 <exit>
     }

     int i=0;
 5de:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     while(buf1[i]!=0)
 5e5:	eb 1c                	jmp    603 <historyAdd+0x7c>
     { 	//printf(1,"%d has %d\n",i,buf1[i]);
	buf[i]=buf1[i]; 
 5e7:	8b 55 f4             	mov    -0xc(%ebp),%edx
 5ea:	8b 45 08             	mov    0x8(%ebp),%eax
 5ed:	01 d0                	add    %edx,%eax
 5ef:	0f b6 00             	movzbl (%eax),%eax
 5f2:	8d 8d fe fb ff ff    	lea    -0x402(%ebp),%ecx
 5f8:	8b 55 f4             	mov    -0xc(%ebp),%edx
 5fb:	01 ca                	add    %ecx,%edx
 5fd:	88 02                	mov    %al,(%edx)
	i++;
 5ff:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
       printf(1, "History: cannot open %s\n", hist);
       exit();
     }

     int i=0;
     while(buf1[i]!=0)
 603:	8b 55 f4             	mov    -0xc(%ebp),%edx
 606:	8b 45 08             	mov    0x8(%ebp),%eax
 609:	01 d0                	add    %edx,%eax
 60b:	0f b6 00             	movzbl (%eax),%eax
 60e:	84 c0                	test   %al,%al
 610:	75 d5                	jne    5e7 <historyAdd+0x60>
     { 	//printf(1,"%d has %d\n",i,buf1[i]);
	buf[i]=buf1[i]; 
	i++;
     }
	buf[i]=0;	
 612:	8d 95 fe fb ff ff    	lea    -0x402(%ebp),%edx
 618:	8b 45 f4             	mov    -0xc(%ebp),%eax
 61b:	01 d0                	add    %edx,%eax
 61d:	c6 00 00             	movb   $0x0,(%eax)
    // int n;
     while((read(fd, buf2, 1000)) > 0){
 620:	eb 5a                	jmp    67c <historyAdd+0xf5>
	
	//printf(1,"%d %d\n",strlen(buf),strlen(buf2));
	
	while(i<strlen(buf2)+strlen(buf1)){
		//printf(1,"%c\n",buf2[i]);
		buf[i]=buf2[i-strlen(buf1)];
 622:	8b 5d f4             	mov    -0xc(%ebp),%ebx
 625:	83 ec 0c             	sub    $0xc,%esp
 628:	ff 75 08             	pushl  0x8(%ebp)
 62b:	e8 9d fd ff ff       	call   3cd <strlen>
 630:	83 c4 10             	add    $0x10,%esp
 633:	29 c3                	sub    %eax,%ebx
 635:	89 d8                	mov    %ebx,%eax
 637:	0f b6 84 05 16 f8 ff 	movzbl -0x7ea(%ebp,%eax,1),%eax
 63e:	ff 
 63f:	8d 8d fe fb ff ff    	lea    -0x402(%ebp),%ecx
 645:	8b 55 f4             	mov    -0xc(%ebp),%edx
 648:	01 ca                	add    %ecx,%edx
 64a:	88 02                	mov    %al,(%edx)
		i++;
 64c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
	//buf[1001]=0;
	//int i=0;
	
	//printf(1,"%d %d\n",strlen(buf),strlen(buf2));
	
	while(i<strlen(buf2)+strlen(buf1)){
 650:	83 ec 0c             	sub    $0xc,%esp
 653:	8d 85 16 f8 ff ff    	lea    -0x7ea(%ebp),%eax
 659:	50                   	push   %eax
 65a:	e8 6e fd ff ff       	call   3cd <strlen>
 65f:	83 c4 10             	add    $0x10,%esp
 662:	89 c3                	mov    %eax,%ebx
 664:	83 ec 0c             	sub    $0xc,%esp
 667:	ff 75 08             	pushl  0x8(%ebp)
 66a:	e8 5e fd ff ff       	call   3cd <strlen>
 66f:	83 c4 10             	add    $0x10,%esp
 672:	8d 14 03             	lea    (%ebx,%eax,1),%edx
 675:	8b 45 f4             	mov    -0xc(%ebp),%eax
 678:	39 c2                	cmp    %eax,%edx
 67a:	77 a6                	ja     622 <historyAdd+0x9b>
	buf[i]=buf1[i]; 
	i++;
     }
	buf[i]=0;	
    // int n;
     while((read(fd, buf2, 1000)) > 0){
 67c:	83 ec 04             	sub    $0x4,%esp
 67f:	68 e8 03 00 00       	push   $0x3e8
 684:	8d 85 16 f8 ff ff    	lea    -0x7ea(%ebp),%eax
 68a:	50                   	push   %eax
 68b:	ff 75 f0             	pushl  -0x10(%ebp)
 68e:	e8 ae 00 00 00       	call   741 <read>
 693:	83 c4 10             	add    $0x10,%esp
 696:	85 c0                	test   %eax,%eax
 698:	7f b6                	jg     650 <historyAdd+0xc9>
	}
	
	//printf(1,"strlen: %d %s\n",strlen(buf),buf);	
     }
     //history(fd);
     close(fd);
 69a:	83 ec 0c             	sub    $0xc,%esp
 69d:	ff 75 f0             	pushl  -0x10(%ebp)
 6a0:	e8 ac 00 00 00       	call   751 <close>
 6a5:	83 c4 10             	add    $0x10,%esp

     if((fd = open(hist,O_CREATE|O_RDWR)) < 0){
 6a8:	83 ec 08             	sub    $0x8,%esp
 6ab:	68 02 02 00 00       	push   $0x202
 6b0:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 6b3:	50                   	push   %eax
 6b4:	e8 b0 00 00 00       	call   769 <open>
 6b9:	83 c4 10             	add    $0x10,%esp
 6bc:	89 45 f0             	mov    %eax,-0x10(%ebp)
 6bf:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 6c3:	79 1b                	jns    6e0 <historyAdd+0x159>
       printf(1, "History: cannot open %s\n", hist);
 6c5:	83 ec 04             	sub    $0x4,%esp
 6c8:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 6cb:	50                   	push   %eax
 6cc:	68 90 0c 00 00       	push   $0xc90
 6d1:	6a 01                	push   $0x1
 6d3:	e8 c8 01 00 00       	call   8a0 <printf>
 6d8:	83 c4 10             	add    $0x10,%esp
       exit();
 6db:	e8 49 00 00 00       	call   729 <exit>
     }
	
     if(write(fd, buf, 1000) != 1000){
 6e0:	83 ec 04             	sub    $0x4,%esp
 6e3:	68 e8 03 00 00       	push   $0x3e8
 6e8:	8d 85 fe fb ff ff    	lea    -0x402(%ebp),%eax
 6ee:	50                   	push   %eax
 6ef:	ff 75 f0             	pushl  -0x10(%ebp)
 6f2:	e8 52 00 00 00       	call   749 <write>
 6f7:	83 c4 10             	add    $0x10,%esp
 6fa:	3d e8 03 00 00       	cmp    $0x3e8,%eax
 6ff:	74 1a                	je     71b <historyAdd+0x194>
       printf(1, "error: write aa %d new file failed\n", i);
 701:	83 ec 04             	sub    $0x4,%esp
 704:	ff 75 f4             	pushl  -0xc(%ebp)
 707:	68 ac 0c 00 00       	push   $0xcac
 70c:	6a 01                	push   $0x1
 70e:	e8 8d 01 00 00       	call   8a0 <printf>
 713:	83 c4 10             	add    $0x10,%esp
       exit();
 716:	e8 0e 00 00 00       	call   729 <exit>
     }
    
}
 71b:	90                   	nop
 71c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 71f:	c9                   	leave  
 720:	c3                   	ret    

00000721 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 721:	b8 01 00 00 00       	mov    $0x1,%eax
 726:	cd 40                	int    $0x40
 728:	c3                   	ret    

00000729 <exit>:
SYSCALL(exit)
 729:	b8 02 00 00 00       	mov    $0x2,%eax
 72e:	cd 40                	int    $0x40
 730:	c3                   	ret    

00000731 <wait>:
SYSCALL(wait)
 731:	b8 03 00 00 00       	mov    $0x3,%eax
 736:	cd 40                	int    $0x40
 738:	c3                   	ret    

00000739 <pipe>:
SYSCALL(pipe)
 739:	b8 04 00 00 00       	mov    $0x4,%eax
 73e:	cd 40                	int    $0x40
 740:	c3                   	ret    

00000741 <read>:
SYSCALL(read)
 741:	b8 05 00 00 00       	mov    $0x5,%eax
 746:	cd 40                	int    $0x40
 748:	c3                   	ret    

00000749 <write>:
SYSCALL(write)
 749:	b8 10 00 00 00       	mov    $0x10,%eax
 74e:	cd 40                	int    $0x40
 750:	c3                   	ret    

00000751 <close>:
SYSCALL(close)
 751:	b8 15 00 00 00       	mov    $0x15,%eax
 756:	cd 40                	int    $0x40
 758:	c3                   	ret    

00000759 <kill>:
SYSCALL(kill)
 759:	b8 06 00 00 00       	mov    $0x6,%eax
 75e:	cd 40                	int    $0x40
 760:	c3                   	ret    

00000761 <exec>:
SYSCALL(exec)
 761:	b8 07 00 00 00       	mov    $0x7,%eax
 766:	cd 40                	int    $0x40
 768:	c3                   	ret    

00000769 <open>:
SYSCALL(open)
 769:	b8 0f 00 00 00       	mov    $0xf,%eax
 76e:	cd 40                	int    $0x40
 770:	c3                   	ret    

00000771 <mknod>:
SYSCALL(mknod)
 771:	b8 11 00 00 00       	mov    $0x11,%eax
 776:	cd 40                	int    $0x40
 778:	c3                   	ret    

00000779 <unlink>:
SYSCALL(unlink)
 779:	b8 12 00 00 00       	mov    $0x12,%eax
 77e:	cd 40                	int    $0x40
 780:	c3                   	ret    

00000781 <fstat>:
SYSCALL(fstat)
 781:	b8 08 00 00 00       	mov    $0x8,%eax
 786:	cd 40                	int    $0x40
 788:	c3                   	ret    

00000789 <link>:
SYSCALL(link)
 789:	b8 13 00 00 00       	mov    $0x13,%eax
 78e:	cd 40                	int    $0x40
 790:	c3                   	ret    

00000791 <mkdir>:
SYSCALL(mkdir)
 791:	b8 14 00 00 00       	mov    $0x14,%eax
 796:	cd 40                	int    $0x40
 798:	c3                   	ret    

00000799 <chdir>:
SYSCALL(chdir)
 799:	b8 09 00 00 00       	mov    $0x9,%eax
 79e:	cd 40                	int    $0x40
 7a0:	c3                   	ret    

000007a1 <dup>:
SYSCALL(dup)
 7a1:	b8 0a 00 00 00       	mov    $0xa,%eax
 7a6:	cd 40                	int    $0x40
 7a8:	c3                   	ret    

000007a9 <getpid>:
SYSCALL(getpid)
 7a9:	b8 0b 00 00 00       	mov    $0xb,%eax
 7ae:	cd 40                	int    $0x40
 7b0:	c3                   	ret    

000007b1 <sbrk>:
SYSCALL(sbrk)
 7b1:	b8 0c 00 00 00       	mov    $0xc,%eax
 7b6:	cd 40                	int    $0x40
 7b8:	c3                   	ret    

000007b9 <sleep>:
SYSCALL(sleep)
 7b9:	b8 0d 00 00 00       	mov    $0xd,%eax
 7be:	cd 40                	int    $0x40
 7c0:	c3                   	ret    

000007c1 <uptime>:
SYSCALL(uptime)
 7c1:	b8 0e 00 00 00       	mov    $0xe,%eax
 7c6:	cd 40                	int    $0x40
 7c8:	c3                   	ret    

000007c9 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 7c9:	55                   	push   %ebp
 7ca:	89 e5                	mov    %esp,%ebp
 7cc:	83 ec 18             	sub    $0x18,%esp
 7cf:	8b 45 0c             	mov    0xc(%ebp),%eax
 7d2:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 7d5:	83 ec 04             	sub    $0x4,%esp
 7d8:	6a 01                	push   $0x1
 7da:	8d 45 f4             	lea    -0xc(%ebp),%eax
 7dd:	50                   	push   %eax
 7de:	ff 75 08             	pushl  0x8(%ebp)
 7e1:	e8 63 ff ff ff       	call   749 <write>
 7e6:	83 c4 10             	add    $0x10,%esp
}
 7e9:	90                   	nop
 7ea:	c9                   	leave  
 7eb:	c3                   	ret    

000007ec <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 7ec:	55                   	push   %ebp
 7ed:	89 e5                	mov    %esp,%ebp
 7ef:	53                   	push   %ebx
 7f0:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 7f3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 7fa:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 7fe:	74 17                	je     817 <printint+0x2b>
 800:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 804:	79 11                	jns    817 <printint+0x2b>
    neg = 1;
 806:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 80d:	8b 45 0c             	mov    0xc(%ebp),%eax
 810:	f7 d8                	neg    %eax
 812:	89 45 ec             	mov    %eax,-0x14(%ebp)
 815:	eb 06                	jmp    81d <printint+0x31>
  } else {
    x = xx;
 817:	8b 45 0c             	mov    0xc(%ebp),%eax
 81a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 81d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 824:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 827:	8d 41 01             	lea    0x1(%ecx),%eax
 82a:	89 45 f4             	mov    %eax,-0xc(%ebp)
 82d:	8b 5d 10             	mov    0x10(%ebp),%ebx
 830:	8b 45 ec             	mov    -0x14(%ebp),%eax
 833:	ba 00 00 00 00       	mov    $0x0,%edx
 838:	f7 f3                	div    %ebx
 83a:	89 d0                	mov    %edx,%eax
 83c:	0f b6 80 c8 0f 00 00 	movzbl 0xfc8(%eax),%eax
 843:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 847:	8b 5d 10             	mov    0x10(%ebp),%ebx
 84a:	8b 45 ec             	mov    -0x14(%ebp),%eax
 84d:	ba 00 00 00 00       	mov    $0x0,%edx
 852:	f7 f3                	div    %ebx
 854:	89 45 ec             	mov    %eax,-0x14(%ebp)
 857:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 85b:	75 c7                	jne    824 <printint+0x38>
  if(neg)
 85d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 861:	74 2d                	je     890 <printint+0xa4>
    buf[i++] = '-';
 863:	8b 45 f4             	mov    -0xc(%ebp),%eax
 866:	8d 50 01             	lea    0x1(%eax),%edx
 869:	89 55 f4             	mov    %edx,-0xc(%ebp)
 86c:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 871:	eb 1d                	jmp    890 <printint+0xa4>
    putc(fd, buf[i]);
 873:	8d 55 dc             	lea    -0x24(%ebp),%edx
 876:	8b 45 f4             	mov    -0xc(%ebp),%eax
 879:	01 d0                	add    %edx,%eax
 87b:	0f b6 00             	movzbl (%eax),%eax
 87e:	0f be c0             	movsbl %al,%eax
 881:	83 ec 08             	sub    $0x8,%esp
 884:	50                   	push   %eax
 885:	ff 75 08             	pushl  0x8(%ebp)
 888:	e8 3c ff ff ff       	call   7c9 <putc>
 88d:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 890:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 894:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 898:	79 d9                	jns    873 <printint+0x87>
    putc(fd, buf[i]);
}
 89a:	90                   	nop
 89b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 89e:	c9                   	leave  
 89f:	c3                   	ret    

000008a0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 8a0:	55                   	push   %ebp
 8a1:	89 e5                	mov    %esp,%ebp
 8a3:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 8a6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 8ad:	8d 45 0c             	lea    0xc(%ebp),%eax
 8b0:	83 c0 04             	add    $0x4,%eax
 8b3:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 8b6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 8bd:	e9 59 01 00 00       	jmp    a1b <printf+0x17b>
    c = fmt[i] & 0xff;
 8c2:	8b 55 0c             	mov    0xc(%ebp),%edx
 8c5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8c8:	01 d0                	add    %edx,%eax
 8ca:	0f b6 00             	movzbl (%eax),%eax
 8cd:	0f be c0             	movsbl %al,%eax
 8d0:	25 ff 00 00 00       	and    $0xff,%eax
 8d5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 8d8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 8dc:	75 2c                	jne    90a <printf+0x6a>
      if(c == '%'){
 8de:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 8e2:	75 0c                	jne    8f0 <printf+0x50>
        state = '%';
 8e4:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 8eb:	e9 27 01 00 00       	jmp    a17 <printf+0x177>
      } else {
        putc(fd, c);
 8f0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 8f3:	0f be c0             	movsbl %al,%eax
 8f6:	83 ec 08             	sub    $0x8,%esp
 8f9:	50                   	push   %eax
 8fa:	ff 75 08             	pushl  0x8(%ebp)
 8fd:	e8 c7 fe ff ff       	call   7c9 <putc>
 902:	83 c4 10             	add    $0x10,%esp
 905:	e9 0d 01 00 00       	jmp    a17 <printf+0x177>
      }
    } else if(state == '%'){
 90a:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 90e:	0f 85 03 01 00 00    	jne    a17 <printf+0x177>
      if(c == 'd'){
 914:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 918:	75 1e                	jne    938 <printf+0x98>
        printint(fd, *ap, 10, 1);
 91a:	8b 45 e8             	mov    -0x18(%ebp),%eax
 91d:	8b 00                	mov    (%eax),%eax
 91f:	6a 01                	push   $0x1
 921:	6a 0a                	push   $0xa
 923:	50                   	push   %eax
 924:	ff 75 08             	pushl  0x8(%ebp)
 927:	e8 c0 fe ff ff       	call   7ec <printint>
 92c:	83 c4 10             	add    $0x10,%esp
        ap++;
 92f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 933:	e9 d8 00 00 00       	jmp    a10 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 938:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 93c:	74 06                	je     944 <printf+0xa4>
 93e:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 942:	75 1e                	jne    962 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 944:	8b 45 e8             	mov    -0x18(%ebp),%eax
 947:	8b 00                	mov    (%eax),%eax
 949:	6a 00                	push   $0x0
 94b:	6a 10                	push   $0x10
 94d:	50                   	push   %eax
 94e:	ff 75 08             	pushl  0x8(%ebp)
 951:	e8 96 fe ff ff       	call   7ec <printint>
 956:	83 c4 10             	add    $0x10,%esp
        ap++;
 959:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 95d:	e9 ae 00 00 00       	jmp    a10 <printf+0x170>
      } else if(c == 's'){
 962:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 966:	75 43                	jne    9ab <printf+0x10b>
        s = (char*)*ap;
 968:	8b 45 e8             	mov    -0x18(%ebp),%eax
 96b:	8b 00                	mov    (%eax),%eax
 96d:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 970:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 974:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 978:	75 25                	jne    99f <printf+0xff>
          s = "(null)";
 97a:	c7 45 f4 d0 0c 00 00 	movl   $0xcd0,-0xc(%ebp)
        while(*s != 0){
 981:	eb 1c                	jmp    99f <printf+0xff>
          putc(fd, *s);
 983:	8b 45 f4             	mov    -0xc(%ebp),%eax
 986:	0f b6 00             	movzbl (%eax),%eax
 989:	0f be c0             	movsbl %al,%eax
 98c:	83 ec 08             	sub    $0x8,%esp
 98f:	50                   	push   %eax
 990:	ff 75 08             	pushl  0x8(%ebp)
 993:	e8 31 fe ff ff       	call   7c9 <putc>
 998:	83 c4 10             	add    $0x10,%esp
          s++;
 99b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 99f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9a2:	0f b6 00             	movzbl (%eax),%eax
 9a5:	84 c0                	test   %al,%al
 9a7:	75 da                	jne    983 <printf+0xe3>
 9a9:	eb 65                	jmp    a10 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 9ab:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 9af:	75 1d                	jne    9ce <printf+0x12e>
        putc(fd, *ap);
 9b1:	8b 45 e8             	mov    -0x18(%ebp),%eax
 9b4:	8b 00                	mov    (%eax),%eax
 9b6:	0f be c0             	movsbl %al,%eax
 9b9:	83 ec 08             	sub    $0x8,%esp
 9bc:	50                   	push   %eax
 9bd:	ff 75 08             	pushl  0x8(%ebp)
 9c0:	e8 04 fe ff ff       	call   7c9 <putc>
 9c5:	83 c4 10             	add    $0x10,%esp
        ap++;
 9c8:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 9cc:	eb 42                	jmp    a10 <printf+0x170>
      } else if(c == '%'){
 9ce:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 9d2:	75 17                	jne    9eb <printf+0x14b>
        putc(fd, c);
 9d4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 9d7:	0f be c0             	movsbl %al,%eax
 9da:	83 ec 08             	sub    $0x8,%esp
 9dd:	50                   	push   %eax
 9de:	ff 75 08             	pushl  0x8(%ebp)
 9e1:	e8 e3 fd ff ff       	call   7c9 <putc>
 9e6:	83 c4 10             	add    $0x10,%esp
 9e9:	eb 25                	jmp    a10 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 9eb:	83 ec 08             	sub    $0x8,%esp
 9ee:	6a 25                	push   $0x25
 9f0:	ff 75 08             	pushl  0x8(%ebp)
 9f3:	e8 d1 fd ff ff       	call   7c9 <putc>
 9f8:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 9fb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 9fe:	0f be c0             	movsbl %al,%eax
 a01:	83 ec 08             	sub    $0x8,%esp
 a04:	50                   	push   %eax
 a05:	ff 75 08             	pushl  0x8(%ebp)
 a08:	e8 bc fd ff ff       	call   7c9 <putc>
 a0d:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 a10:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 a17:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 a1b:	8b 55 0c             	mov    0xc(%ebp),%edx
 a1e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a21:	01 d0                	add    %edx,%eax
 a23:	0f b6 00             	movzbl (%eax),%eax
 a26:	84 c0                	test   %al,%al
 a28:	0f 85 94 fe ff ff    	jne    8c2 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 a2e:	90                   	nop
 a2f:	c9                   	leave  
 a30:	c3                   	ret    

00000a31 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a31:	55                   	push   %ebp
 a32:	89 e5                	mov    %esp,%ebp
 a34:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 a37:	8b 45 08             	mov    0x8(%ebp),%eax
 a3a:	83 e8 08             	sub    $0x8,%eax
 a3d:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a40:	a1 e8 0f 00 00       	mov    0xfe8,%eax
 a45:	89 45 fc             	mov    %eax,-0x4(%ebp)
 a48:	eb 24                	jmp    a6e <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a4a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a4d:	8b 00                	mov    (%eax),%eax
 a4f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 a52:	77 12                	ja     a66 <free+0x35>
 a54:	8b 45 f8             	mov    -0x8(%ebp),%eax
 a57:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 a5a:	77 24                	ja     a80 <free+0x4f>
 a5c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a5f:	8b 00                	mov    (%eax),%eax
 a61:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 a64:	77 1a                	ja     a80 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a66:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a69:	8b 00                	mov    (%eax),%eax
 a6b:	89 45 fc             	mov    %eax,-0x4(%ebp)
 a6e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 a71:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 a74:	76 d4                	jbe    a4a <free+0x19>
 a76:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a79:	8b 00                	mov    (%eax),%eax
 a7b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 a7e:	76 ca                	jbe    a4a <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 a80:	8b 45 f8             	mov    -0x8(%ebp),%eax
 a83:	8b 40 04             	mov    0x4(%eax),%eax
 a86:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 a8d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 a90:	01 c2                	add    %eax,%edx
 a92:	8b 45 fc             	mov    -0x4(%ebp),%eax
 a95:	8b 00                	mov    (%eax),%eax
 a97:	39 c2                	cmp    %eax,%edx
 a99:	75 24                	jne    abf <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 a9b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 a9e:	8b 50 04             	mov    0x4(%eax),%edx
 aa1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 aa4:	8b 00                	mov    (%eax),%eax
 aa6:	8b 40 04             	mov    0x4(%eax),%eax
 aa9:	01 c2                	add    %eax,%edx
 aab:	8b 45 f8             	mov    -0x8(%ebp),%eax
 aae:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 ab1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 ab4:	8b 00                	mov    (%eax),%eax
 ab6:	8b 10                	mov    (%eax),%edx
 ab8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 abb:	89 10                	mov    %edx,(%eax)
 abd:	eb 0a                	jmp    ac9 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 abf:	8b 45 fc             	mov    -0x4(%ebp),%eax
 ac2:	8b 10                	mov    (%eax),%edx
 ac4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 ac7:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 ac9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 acc:	8b 40 04             	mov    0x4(%eax),%eax
 acf:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 ad6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 ad9:	01 d0                	add    %edx,%eax
 adb:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 ade:	75 20                	jne    b00 <free+0xcf>
    p->s.size += bp->s.size;
 ae0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 ae3:	8b 50 04             	mov    0x4(%eax),%edx
 ae6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 ae9:	8b 40 04             	mov    0x4(%eax),%eax
 aec:	01 c2                	add    %eax,%edx
 aee:	8b 45 fc             	mov    -0x4(%ebp),%eax
 af1:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 af4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 af7:	8b 10                	mov    (%eax),%edx
 af9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 afc:	89 10                	mov    %edx,(%eax)
 afe:	eb 08                	jmp    b08 <free+0xd7>
  } else
    p->s.ptr = bp;
 b00:	8b 45 fc             	mov    -0x4(%ebp),%eax
 b03:	8b 55 f8             	mov    -0x8(%ebp),%edx
 b06:	89 10                	mov    %edx,(%eax)
  freep = p;
 b08:	8b 45 fc             	mov    -0x4(%ebp),%eax
 b0b:	a3 e8 0f 00 00       	mov    %eax,0xfe8
}
 b10:	90                   	nop
 b11:	c9                   	leave  
 b12:	c3                   	ret    

00000b13 <morecore>:

static Header*
morecore(uint nu)
{
 b13:	55                   	push   %ebp
 b14:	89 e5                	mov    %esp,%ebp
 b16:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 b19:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 b20:	77 07                	ja     b29 <morecore+0x16>
    nu = 4096;
 b22:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 b29:	8b 45 08             	mov    0x8(%ebp),%eax
 b2c:	c1 e0 03             	shl    $0x3,%eax
 b2f:	83 ec 0c             	sub    $0xc,%esp
 b32:	50                   	push   %eax
 b33:	e8 79 fc ff ff       	call   7b1 <sbrk>
 b38:	83 c4 10             	add    $0x10,%esp
 b3b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 b3e:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 b42:	75 07                	jne    b4b <morecore+0x38>
    return 0;
 b44:	b8 00 00 00 00       	mov    $0x0,%eax
 b49:	eb 26                	jmp    b71 <morecore+0x5e>
  hp = (Header*)p;
 b4b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b4e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 b51:	8b 45 f0             	mov    -0x10(%ebp),%eax
 b54:	8b 55 08             	mov    0x8(%ebp),%edx
 b57:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 b5a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 b5d:	83 c0 08             	add    $0x8,%eax
 b60:	83 ec 0c             	sub    $0xc,%esp
 b63:	50                   	push   %eax
 b64:	e8 c8 fe ff ff       	call   a31 <free>
 b69:	83 c4 10             	add    $0x10,%esp
  return freep;
 b6c:	a1 e8 0f 00 00       	mov    0xfe8,%eax
}
 b71:	c9                   	leave  
 b72:	c3                   	ret    

00000b73 <malloc>:

void*
malloc(uint nbytes)
{
 b73:	55                   	push   %ebp
 b74:	89 e5                	mov    %esp,%ebp
 b76:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b79:	8b 45 08             	mov    0x8(%ebp),%eax
 b7c:	83 c0 07             	add    $0x7,%eax
 b7f:	c1 e8 03             	shr    $0x3,%eax
 b82:	83 c0 01             	add    $0x1,%eax
 b85:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 b88:	a1 e8 0f 00 00       	mov    0xfe8,%eax
 b8d:	89 45 f0             	mov    %eax,-0x10(%ebp)
 b90:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 b94:	75 23                	jne    bb9 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 b96:	c7 45 f0 e0 0f 00 00 	movl   $0xfe0,-0x10(%ebp)
 b9d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 ba0:	a3 e8 0f 00 00       	mov    %eax,0xfe8
 ba5:	a1 e8 0f 00 00       	mov    0xfe8,%eax
 baa:	a3 e0 0f 00 00       	mov    %eax,0xfe0
    base.s.size = 0;
 baf:	c7 05 e4 0f 00 00 00 	movl   $0x0,0xfe4
 bb6:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 bb9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 bbc:	8b 00                	mov    (%eax),%eax
 bbe:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 bc1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 bc4:	8b 40 04             	mov    0x4(%eax),%eax
 bc7:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 bca:	72 4d                	jb     c19 <malloc+0xa6>
      if(p->s.size == nunits)
 bcc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 bcf:	8b 40 04             	mov    0x4(%eax),%eax
 bd2:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 bd5:	75 0c                	jne    be3 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 bd7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 bda:	8b 10                	mov    (%eax),%edx
 bdc:	8b 45 f0             	mov    -0x10(%ebp),%eax
 bdf:	89 10                	mov    %edx,(%eax)
 be1:	eb 26                	jmp    c09 <malloc+0x96>
      else {
        p->s.size -= nunits;
 be3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 be6:	8b 40 04             	mov    0x4(%eax),%eax
 be9:	2b 45 ec             	sub    -0x14(%ebp),%eax
 bec:	89 c2                	mov    %eax,%edx
 bee:	8b 45 f4             	mov    -0xc(%ebp),%eax
 bf1:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 bf4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 bf7:	8b 40 04             	mov    0x4(%eax),%eax
 bfa:	c1 e0 03             	shl    $0x3,%eax
 bfd:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 c00:	8b 45 f4             	mov    -0xc(%ebp),%eax
 c03:	8b 55 ec             	mov    -0x14(%ebp),%edx
 c06:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 c09:	8b 45 f0             	mov    -0x10(%ebp),%eax
 c0c:	a3 e8 0f 00 00       	mov    %eax,0xfe8
      return (void*)(p + 1);
 c11:	8b 45 f4             	mov    -0xc(%ebp),%eax
 c14:	83 c0 08             	add    $0x8,%eax
 c17:	eb 3b                	jmp    c54 <malloc+0xe1>
    }
    if(p == freep)
 c19:	a1 e8 0f 00 00       	mov    0xfe8,%eax
 c1e:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 c21:	75 1e                	jne    c41 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 c23:	83 ec 0c             	sub    $0xc,%esp
 c26:	ff 75 ec             	pushl  -0x14(%ebp)
 c29:	e8 e5 fe ff ff       	call   b13 <morecore>
 c2e:	83 c4 10             	add    $0x10,%esp
 c31:	89 45 f4             	mov    %eax,-0xc(%ebp)
 c34:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 c38:	75 07                	jne    c41 <malloc+0xce>
        return 0;
 c3a:	b8 00 00 00 00       	mov    $0x0,%eax
 c3f:	eb 13                	jmp    c54 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c41:	8b 45 f4             	mov    -0xc(%ebp),%eax
 c44:	89 45 f0             	mov    %eax,-0x10(%ebp)
 c47:	8b 45 f4             	mov    -0xc(%ebp),%eax
 c4a:	8b 00                	mov    (%eax),%eax
 c4c:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 c4f:	e9 6d ff ff ff       	jmp    bc1 <malloc+0x4e>
}
 c54:	c9                   	leave  
 c55:	c3                   	ret    
