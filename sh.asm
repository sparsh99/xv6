
_sh:     file format elf32-i386


Disassembly of section .text:

00000000 <runcmd>:
struct cmd *parsecmd(char*);

// Execute cmd.  Never returns.
void
runcmd(struct cmd *cmd)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 28             	sub    $0x28,%esp
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
       6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
       a:	75 05                	jne    11 <runcmd+0x11>
    exit();
       c:	e8 59 10 00 00       	call   106a <exit>
  
  switch(cmd->type){
      11:	8b 45 08             	mov    0x8(%ebp),%eax
      14:	8b 00                	mov    (%eax),%eax
      16:	83 f8 05             	cmp    $0x5,%eax
      19:	77 09                	ja     24 <runcmd+0x24>
      1b:	8b 04 85 c4 15 00 00 	mov    0x15c4(,%eax,4),%eax
      22:	ff e0                	jmp    *%eax
  default:
    panic("runcmd");
      24:	83 ec 0c             	sub    $0xc,%esp
      27:	68 98 15 00 00       	push   $0x1598
      2c:	e8 00 05 00 00       	call   531 <panic>
      31:	83 c4 10             	add    $0x10,%esp

  case EXEC:
    ecmd = (struct execcmd*)cmd;
      34:	8b 45 08             	mov    0x8(%ebp),%eax
      37:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(ecmd->argv[0] == 0)
      3a:	8b 45 f4             	mov    -0xc(%ebp),%eax
      3d:	8b 40 04             	mov    0x4(%eax),%eax
      40:	85 c0                	test   %eax,%eax
      42:	75 05                	jne    49 <runcmd+0x49>
      exit();
      44:	e8 21 10 00 00       	call   106a <exit>
    exec(ecmd->argv[0], ecmd->argv);
      49:	8b 45 f4             	mov    -0xc(%ebp),%eax
      4c:	8d 50 04             	lea    0x4(%eax),%edx
      4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
      52:	8b 40 04             	mov    0x4(%eax),%eax
      55:	83 ec 08             	sub    $0x8,%esp
      58:	52                   	push   %edx
      59:	50                   	push   %eax
      5a:	e8 43 10 00 00       	call   10a2 <exec>
      5f:	83 c4 10             	add    $0x10,%esp
    printf(2, "exec %s failed\n", ecmd->argv[0]);
      62:	8b 45 f4             	mov    -0xc(%ebp),%eax
      65:	8b 40 04             	mov    0x4(%eax),%eax
      68:	83 ec 04             	sub    $0x4,%esp
      6b:	50                   	push   %eax
      6c:	68 9f 15 00 00       	push   $0x159f
      71:	6a 02                	push   $0x2
      73:	e8 69 11 00 00       	call   11e1 <printf>
      78:	83 c4 10             	add    $0x10,%esp
    break;
      7b:	e9 c6 01 00 00       	jmp    246 <runcmd+0x246>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
      80:	8b 45 08             	mov    0x8(%ebp),%eax
      83:	89 45 f0             	mov    %eax,-0x10(%ebp)
    close(rcmd->fd);
      86:	8b 45 f0             	mov    -0x10(%ebp),%eax
      89:	8b 40 14             	mov    0x14(%eax),%eax
      8c:	83 ec 0c             	sub    $0xc,%esp
      8f:	50                   	push   %eax
      90:	e8 fd 0f 00 00       	call   1092 <close>
      95:	83 c4 10             	add    $0x10,%esp
    if(open(rcmd->file, rcmd->mode) < 0){
      98:	8b 45 f0             	mov    -0x10(%ebp),%eax
      9b:	8b 50 10             	mov    0x10(%eax),%edx
      9e:	8b 45 f0             	mov    -0x10(%ebp),%eax
      a1:	8b 40 08             	mov    0x8(%eax),%eax
      a4:	83 ec 08             	sub    $0x8,%esp
      a7:	52                   	push   %edx
      a8:	50                   	push   %eax
      a9:	e8 fc 0f 00 00       	call   10aa <open>
      ae:	83 c4 10             	add    $0x10,%esp
      b1:	85 c0                	test   %eax,%eax
      b3:	79 1e                	jns    d3 <runcmd+0xd3>
      printf(2, "open %s failed\n", rcmd->file);
      b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
      b8:	8b 40 08             	mov    0x8(%eax),%eax
      bb:	83 ec 04             	sub    $0x4,%esp
      be:	50                   	push   %eax
      bf:	68 af 15 00 00       	push   $0x15af
      c4:	6a 02                	push   $0x2
      c6:	e8 16 11 00 00       	call   11e1 <printf>
      cb:	83 c4 10             	add    $0x10,%esp
      exit();
      ce:	e8 97 0f 00 00       	call   106a <exit>
    }
    runcmd(rcmd->cmd);
      d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
      d6:	8b 40 04             	mov    0x4(%eax),%eax
      d9:	83 ec 0c             	sub    $0xc,%esp
      dc:	50                   	push   %eax
      dd:	e8 1e ff ff ff       	call   0 <runcmd>
      e2:	83 c4 10             	add    $0x10,%esp
    break;
      e5:	e9 5c 01 00 00       	jmp    246 <runcmd+0x246>

  case LIST:
    lcmd = (struct listcmd*)cmd;
      ea:	8b 45 08             	mov    0x8(%ebp),%eax
      ed:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(fork1() == 0)
      f0:	e8 5c 04 00 00       	call   551 <fork1>
      f5:	85 c0                	test   %eax,%eax
      f7:	75 12                	jne    10b <runcmd+0x10b>
      runcmd(lcmd->left);
      f9:	8b 45 ec             	mov    -0x14(%ebp),%eax
      fc:	8b 40 04             	mov    0x4(%eax),%eax
      ff:	83 ec 0c             	sub    $0xc,%esp
     102:	50                   	push   %eax
     103:	e8 f8 fe ff ff       	call   0 <runcmd>
     108:	83 c4 10             	add    $0x10,%esp
    wait();
     10b:	e8 62 0f 00 00       	call   1072 <wait>
    runcmd(lcmd->right);
     110:	8b 45 ec             	mov    -0x14(%ebp),%eax
     113:	8b 40 08             	mov    0x8(%eax),%eax
     116:	83 ec 0c             	sub    $0xc,%esp
     119:	50                   	push   %eax
     11a:	e8 e1 fe ff ff       	call   0 <runcmd>
     11f:	83 c4 10             	add    $0x10,%esp
    break;
     122:	e9 1f 01 00 00       	jmp    246 <runcmd+0x246>

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
     127:	8b 45 08             	mov    0x8(%ebp),%eax
     12a:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(pipe(p) < 0)
     12d:	83 ec 0c             	sub    $0xc,%esp
     130:	8d 45 dc             	lea    -0x24(%ebp),%eax
     133:	50                   	push   %eax
     134:	e8 41 0f 00 00       	call   107a <pipe>
     139:	83 c4 10             	add    $0x10,%esp
     13c:	85 c0                	test   %eax,%eax
     13e:	79 10                	jns    150 <runcmd+0x150>
      panic("pipe");
     140:	83 ec 0c             	sub    $0xc,%esp
     143:	68 bf 15 00 00       	push   $0x15bf
     148:	e8 e4 03 00 00       	call   531 <panic>
     14d:	83 c4 10             	add    $0x10,%esp
    if(fork1() == 0){
     150:	e8 fc 03 00 00       	call   551 <fork1>
     155:	85 c0                	test   %eax,%eax
     157:	75 4c                	jne    1a5 <runcmd+0x1a5>
      close(1);
     159:	83 ec 0c             	sub    $0xc,%esp
     15c:	6a 01                	push   $0x1
     15e:	e8 2f 0f 00 00       	call   1092 <close>
     163:	83 c4 10             	add    $0x10,%esp
      dup(p[1]);
     166:	8b 45 e0             	mov    -0x20(%ebp),%eax
     169:	83 ec 0c             	sub    $0xc,%esp
     16c:	50                   	push   %eax
     16d:	e8 70 0f 00 00       	call   10e2 <dup>
     172:	83 c4 10             	add    $0x10,%esp
      close(p[0]);
     175:	8b 45 dc             	mov    -0x24(%ebp),%eax
     178:	83 ec 0c             	sub    $0xc,%esp
     17b:	50                   	push   %eax
     17c:	e8 11 0f 00 00       	call   1092 <close>
     181:	83 c4 10             	add    $0x10,%esp
      close(p[1]);
     184:	8b 45 e0             	mov    -0x20(%ebp),%eax
     187:	83 ec 0c             	sub    $0xc,%esp
     18a:	50                   	push   %eax
     18b:	e8 02 0f 00 00       	call   1092 <close>
     190:	83 c4 10             	add    $0x10,%esp
      runcmd(pcmd->left);
     193:	8b 45 e8             	mov    -0x18(%ebp),%eax
     196:	8b 40 04             	mov    0x4(%eax),%eax
     199:	83 ec 0c             	sub    $0xc,%esp
     19c:	50                   	push   %eax
     19d:	e8 5e fe ff ff       	call   0 <runcmd>
     1a2:	83 c4 10             	add    $0x10,%esp
    }
    if(fork1() == 0){
     1a5:	e8 a7 03 00 00       	call   551 <fork1>
     1aa:	85 c0                	test   %eax,%eax
     1ac:	75 4c                	jne    1fa <runcmd+0x1fa>
      close(0);
     1ae:	83 ec 0c             	sub    $0xc,%esp
     1b1:	6a 00                	push   $0x0
     1b3:	e8 da 0e 00 00       	call   1092 <close>
     1b8:	83 c4 10             	add    $0x10,%esp
      dup(p[0]);
     1bb:	8b 45 dc             	mov    -0x24(%ebp),%eax
     1be:	83 ec 0c             	sub    $0xc,%esp
     1c1:	50                   	push   %eax
     1c2:	e8 1b 0f 00 00       	call   10e2 <dup>
     1c7:	83 c4 10             	add    $0x10,%esp
      close(p[0]);
     1ca:	8b 45 dc             	mov    -0x24(%ebp),%eax
     1cd:	83 ec 0c             	sub    $0xc,%esp
     1d0:	50                   	push   %eax
     1d1:	e8 bc 0e 00 00       	call   1092 <close>
     1d6:	83 c4 10             	add    $0x10,%esp
      close(p[1]);
     1d9:	8b 45 e0             	mov    -0x20(%ebp),%eax
     1dc:	83 ec 0c             	sub    $0xc,%esp
     1df:	50                   	push   %eax
     1e0:	e8 ad 0e 00 00       	call   1092 <close>
     1e5:	83 c4 10             	add    $0x10,%esp
      runcmd(pcmd->right);
     1e8:	8b 45 e8             	mov    -0x18(%ebp),%eax
     1eb:	8b 40 08             	mov    0x8(%eax),%eax
     1ee:	83 ec 0c             	sub    $0xc,%esp
     1f1:	50                   	push   %eax
     1f2:	e8 09 fe ff ff       	call   0 <runcmd>
     1f7:	83 c4 10             	add    $0x10,%esp
    }
    close(p[0]);
     1fa:	8b 45 dc             	mov    -0x24(%ebp),%eax
     1fd:	83 ec 0c             	sub    $0xc,%esp
     200:	50                   	push   %eax
     201:	e8 8c 0e 00 00       	call   1092 <close>
     206:	83 c4 10             	add    $0x10,%esp
    close(p[1]);
     209:	8b 45 e0             	mov    -0x20(%ebp),%eax
     20c:	83 ec 0c             	sub    $0xc,%esp
     20f:	50                   	push   %eax
     210:	e8 7d 0e 00 00       	call   1092 <close>
     215:	83 c4 10             	add    $0x10,%esp
    wait();
     218:	e8 55 0e 00 00       	call   1072 <wait>
    wait();
     21d:	e8 50 0e 00 00       	call   1072 <wait>
    break;
     222:	eb 22                	jmp    246 <runcmd+0x246>
    
  case BACK:
    bcmd = (struct backcmd*)cmd;
     224:	8b 45 08             	mov    0x8(%ebp),%eax
     227:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(fork1() == 0)
     22a:	e8 22 03 00 00       	call   551 <fork1>
     22f:	85 c0                	test   %eax,%eax
     231:	75 12                	jne    245 <runcmd+0x245>
      runcmd(bcmd->cmd);
     233:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     236:	8b 40 04             	mov    0x4(%eax),%eax
     239:	83 ec 0c             	sub    $0xc,%esp
     23c:	50                   	push   %eax
     23d:	e8 be fd ff ff       	call   0 <runcmd>
     242:	83 c4 10             	add    $0x10,%esp
    break;
     245:	90                   	nop
  }
  exit();
     246:	e8 1f 0e 00 00       	call   106a <exit>

0000024b <getcmd>:
}

int
getcmd(char *buf, int nbuf)
{
     24b:	55                   	push   %ebp
     24c:	89 e5                	mov    %esp,%ebp
     24e:	81 ec 88 00 00 00    	sub    $0x88,%esp
  printf(2, "$ ");
     254:	83 ec 08             	sub    $0x8,%esp
     257:	68 dc 15 00 00       	push   $0x15dc
     25c:	6a 02                	push   $0x2
     25e:	e8 7e 0f 00 00       	call   11e1 <printf>
     263:	83 c4 10             	add    $0x10,%esp
  memset(buf, 0, nbuf);
     266:	8b 45 0c             	mov    0xc(%ebp),%eax
     269:	83 ec 04             	sub    $0x4,%esp
     26c:	50                   	push   %eax
     26d:	6a 00                	push   $0x0
     26f:	ff 75 08             	pushl  0x8(%ebp)
     272:	e8 58 0c 00 00       	call   ecf <memset>
     277:	83 c4 10             	add    $0x10,%esp
  gets(buf, nbuf);
     27a:	83 ec 08             	sub    $0x8,%esp
     27d:	ff 75 0c             	pushl  0xc(%ebp)
     280:	ff 75 08             	pushl  0x8(%ebp)
     283:	e8 94 0c 00 00       	call   f1c <gets>
     288:	83 c4 10             	add    $0x10,%esp
  if(buf[0] == 0) // EOF
     28b:	8b 45 08             	mov    0x8(%ebp),%eax
     28e:	0f b6 00             	movzbl (%eax),%eax
     291:	84 c0                	test   %al,%al
     293:	75 0a                	jne    29f <getcmd+0x54>
    return -1; 
     295:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     29a:	e9 47 01 00 00       	jmp    3e6 <getcmd+0x19b>

  //history storing
  char his[120];
  his[0]='e';
     29f:	c6 85 78 ff ff ff 65 	movb   $0x65,-0x88(%ebp)
  his[1]='c';
     2a6:	c6 85 79 ff ff ff 63 	movb   $0x63,-0x87(%ebp)
  his[2]='h';
     2ad:	c6 85 7a ff ff ff 68 	movb   $0x68,-0x86(%ebp)
  his[3]='o';
     2b4:	c6 85 7b ff ff ff 6f 	movb   $0x6f,-0x85(%ebp)
  his[4]=' ';
     2bb:	c6 85 7c ff ff ff 20 	movb   $0x20,-0x84(%ebp)
  his[5]='?';
     2c2:	c6 85 7d ff ff ff 3f 	movb   $0x3f,-0x83(%ebp)
  int i=0;
     2c9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  printf(1,"strlen: %d\n",strlen(buf));
     2d0:	83 ec 0c             	sub    $0xc,%esp
     2d3:	ff 75 08             	pushl  0x8(%ebp)
     2d6:	e8 cd 0b 00 00       	call   ea8 <strlen>
     2db:	83 c4 10             	add    $0x10,%esp
     2de:	83 ec 04             	sub    $0x4,%esp
     2e1:	50                   	push   %eax
     2e2:	68 df 15 00 00       	push   $0x15df
     2e7:	6a 01                	push   $0x1
     2e9:	e8 f3 0e 00 00       	call   11e1 <printf>
     2ee:	83 c4 10             	add    $0x10,%esp
  while(i<strlen(buf)){
     2f1:	eb 1c                	jmp    30f <getcmd+0xc4>
	his[i+6]=buf[i];
     2f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     2f6:	8d 50 06             	lea    0x6(%eax),%edx
     2f9:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     2fc:	8b 45 08             	mov    0x8(%ebp),%eax
     2ff:	01 c8                	add    %ecx,%eax
     301:	0f b6 00             	movzbl (%eax),%eax
     304:	88 84 15 78 ff ff ff 	mov    %al,-0x88(%ebp,%edx,1)
	i++;
     30b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  his[3]='o';
  his[4]=' ';
  his[5]='?';
  int i=0;
  printf(1,"strlen: %d\n",strlen(buf));
  while(i<strlen(buf)){
     30f:	83 ec 0c             	sub    $0xc,%esp
     312:	ff 75 08             	pushl  0x8(%ebp)
     315:	e8 8e 0b 00 00       	call   ea8 <strlen>
     31a:	83 c4 10             	add    $0x10,%esp
     31d:	89 c2                	mov    %eax,%edx
     31f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     322:	39 c2                	cmp    %eax,%edx
     324:	77 cd                	ja     2f3 <getcmd+0xa8>
	his[i+6]=buf[i];
	i++;
  }
  int x=strlen(buf)+5;
     326:	83 ec 0c             	sub    $0xc,%esp
     329:	ff 75 08             	pushl  0x8(%ebp)
     32c:	e8 77 0b 00 00       	call   ea8 <strlen>
     331:	83 c4 10             	add    $0x10,%esp
     334:	83 c0 05             	add    $0x5,%eax
     337:	89 45 f0             	mov    %eax,-0x10(%ebp)
  his[x]='?';
     33a:	8d 95 78 ff ff ff    	lea    -0x88(%ebp),%edx
     340:	8b 45 f0             	mov    -0x10(%ebp),%eax
     343:	01 d0                	add    %edx,%eax
     345:	c6 00 3f             	movb   $0x3f,(%eax)
  his[x+1]=' ';
     348:	8b 45 f0             	mov    -0x10(%ebp),%eax
     34b:	83 c0 01             	add    $0x1,%eax
     34e:	c6 84 05 78 ff ff ff 	movb   $0x20,-0x88(%ebp,%eax,1)
     355:	20 
  his[x+2]='>';
     356:	8b 45 f0             	mov    -0x10(%ebp),%eax
     359:	83 c0 02             	add    $0x2,%eax
     35c:	c6 84 05 78 ff ff ff 	movb   $0x3e,-0x88(%ebp,%eax,1)
     363:	3e 
  his[x+3]='>';
     364:	8b 45 f0             	mov    -0x10(%ebp),%eax
     367:	83 c0 03             	add    $0x3,%eax
     36a:	c6 84 05 78 ff ff ff 	movb   $0x3e,-0x88(%ebp,%eax,1)
     371:	3e 
  his[x+4]=' ';
     372:	8b 45 f0             	mov    -0x10(%ebp),%eax
     375:	83 c0 04             	add    $0x4,%eax
     378:	c6 84 05 78 ff ff ff 	movb   $0x20,-0x88(%ebp,%eax,1)
     37f:	20 
  his[x+5]='h';
     380:	8b 45 f0             	mov    -0x10(%ebp),%eax
     383:	83 c0 05             	add    $0x5,%eax
     386:	c6 84 05 78 ff ff ff 	movb   $0x68,-0x88(%ebp,%eax,1)
     38d:	68 
  his[x+6]=0;
     38e:	8b 45 f0             	mov    -0x10(%ebp),%eax
     391:	83 c0 06             	add    $0x6,%eax
     394:	c6 84 05 78 ff ff ff 	movb   $0x0,-0x88(%ebp,%eax,1)
     39b:	00 
  printf(1,"History Added: %s\n",his);
     39c:	83 ec 04             	sub    $0x4,%esp
     39f:	8d 85 78 ff ff ff    	lea    -0x88(%ebp),%eax
     3a5:	50                   	push   %eax
     3a6:	68 eb 15 00 00       	push   $0x15eb
     3ab:	6a 01                	push   $0x1
     3ad:	e8 2f 0e 00 00       	call   11e1 <printf>
     3b2:	83 c4 10             	add    $0x10,%esp
  if(fork1() == 0)
     3b5:	e8 97 01 00 00       	call   551 <fork1>
     3ba:	85 c0                	test   %eax,%eax
     3bc:	75 1e                	jne    3dc <getcmd+0x191>
 	runcmd(parsecmd(his));
     3be:	83 ec 0c             	sub    $0xc,%esp
     3c1:	8d 85 78 ff ff ff    	lea    -0x88(%ebp),%eax
     3c7:	50                   	push   %eax
     3c8:	e8 dc 04 00 00       	call   8a9 <parsecmd>
     3cd:	83 c4 10             	add    $0x10,%esp
     3d0:	83 ec 0c             	sub    $0xc,%esp
     3d3:	50                   	push   %eax
     3d4:	e8 27 fc ff ff       	call   0 <runcmd>
     3d9:	83 c4 10             	add    $0x10,%esp
  wait();
     3dc:	e8 91 0c 00 00       	call   1072 <wait>
  return 0;
     3e1:	b8 00 00 00 00       	mov    $0x0,%eax
}
     3e6:	c9                   	leave  
     3e7:	c3                   	ret    

000003e8 <main>:

int
main(void)
{
     3e8:	8d 4c 24 04          	lea    0x4(%esp),%ecx
     3ec:	83 e4 f0             	and    $0xfffffff0,%esp
     3ef:	ff 71 fc             	pushl  -0x4(%ecx)
     3f2:	55                   	push   %ebp
     3f3:	89 e5                	mov    %esp,%ebp
     3f5:	51                   	push   %ecx
     3f6:	83 ec 44             	sub    $0x44,%esp
  static char buf[100];
  int fd;

  char his[50];
  his[0]='e';
     3f9:	c6 45 c2 65          	movb   $0x65,-0x3e(%ebp)
  his[1]='c';
     3fd:	c6 45 c3 63          	movb   $0x63,-0x3d(%ebp)
  his[2]='h';
     401:	c6 45 c4 68          	movb   $0x68,-0x3c(%ebp)
  his[3]='o';
     405:	c6 45 c5 6f          	movb   $0x6f,-0x3b(%ebp)
  his[4]=' ';
     409:	c6 45 c6 20          	movb   $0x20,-0x3a(%ebp)
  his[5]='>';
     40d:	c6 45 c7 3e          	movb   $0x3e,-0x39(%ebp)
  his[6]=' ';
     411:	c6 45 c8 20          	movb   $0x20,-0x38(%ebp)
  his[7]='h';
     415:	c6 45 c9 68          	movb   $0x68,-0x37(%ebp)
  his[8]=0;
     419:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
  if(fork1() == 0)
     41d:	e8 2f 01 00 00       	call   551 <fork1>
     422:	85 c0                	test   %eax,%eax
     424:	75 1b                	jne    441 <main+0x59>
 	runcmd(parsecmd(his));
     426:	83 ec 0c             	sub    $0xc,%esp
     429:	8d 45 c2             	lea    -0x3e(%ebp),%eax
     42c:	50                   	push   %eax
     42d:	e8 77 04 00 00       	call   8a9 <parsecmd>
     432:	83 c4 10             	add    $0x10,%esp
     435:	83 ec 0c             	sub    $0xc,%esp
     438:	50                   	push   %eax
     439:	e8 c2 fb ff ff       	call   0 <runcmd>
     43e:	83 c4 10             	add    $0x10,%esp
  wait();
     441:	e8 2c 0c 00 00       	call   1072 <wait>

  // Assumes three file descriptors open.
  while((fd = open("console", O_RDWR)) >= 0){
     446:	eb 16                	jmp    45e <main+0x76>
    if(fd >= 3){
     448:	83 7d f4 02          	cmpl   $0x2,-0xc(%ebp)
     44c:	7e 10                	jle    45e <main+0x76>
      close(fd);
     44e:	83 ec 0c             	sub    $0xc,%esp
     451:	ff 75 f4             	pushl  -0xc(%ebp)
     454:	e8 39 0c 00 00       	call   1092 <close>
     459:	83 c4 10             	add    $0x10,%esp
      break;
     45c:	eb 1b                	jmp    479 <main+0x91>
  if(fork1() == 0)
 	runcmd(parsecmd(his));
  wait();

  // Assumes three file descriptors open.
  while((fd = open("console", O_RDWR)) >= 0){
     45e:	83 ec 08             	sub    $0x8,%esp
     461:	6a 02                	push   $0x2
     463:	68 fe 15 00 00       	push   $0x15fe
     468:	e8 3d 0c 00 00       	call   10aa <open>
     46d:	83 c4 10             	add    $0x10,%esp
     470:	89 45 f4             	mov    %eax,-0xc(%ebp)
     473:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     477:	79 cf                	jns    448 <main+0x60>
      break;
    }
  }
  
  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
     479:	e9 94 00 00 00       	jmp    512 <main+0x12a>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     47e:	0f b6 05 60 1b 00 00 	movzbl 0x1b60,%eax
     485:	3c 63                	cmp    $0x63,%al
     487:	75 5f                	jne    4e8 <main+0x100>
     489:	0f b6 05 61 1b 00 00 	movzbl 0x1b61,%eax
     490:	3c 64                	cmp    $0x64,%al
     492:	75 54                	jne    4e8 <main+0x100>
     494:	0f b6 05 62 1b 00 00 	movzbl 0x1b62,%eax
     49b:	3c 20                	cmp    $0x20,%al
     49d:	75 49                	jne    4e8 <main+0x100>
      // Clumsy but will have to do for now.
      // Chdir has no effect on the parent if run in the child.
      buf[strlen(buf)-1] = 0;  // chop \n
     49f:	83 ec 0c             	sub    $0xc,%esp
     4a2:	68 60 1b 00 00       	push   $0x1b60
     4a7:	e8 fc 09 00 00       	call   ea8 <strlen>
     4ac:	83 c4 10             	add    $0x10,%esp
     4af:	83 e8 01             	sub    $0x1,%eax
     4b2:	c6 80 60 1b 00 00 00 	movb   $0x0,0x1b60(%eax)
      if(chdir(buf+3) < 0)
     4b9:	b8 63 1b 00 00       	mov    $0x1b63,%eax
     4be:	83 ec 0c             	sub    $0xc,%esp
     4c1:	50                   	push   %eax
     4c2:	e8 13 0c 00 00       	call   10da <chdir>
     4c7:	83 c4 10             	add    $0x10,%esp
     4ca:	85 c0                	test   %eax,%eax
     4cc:	79 44                	jns    512 <main+0x12a>
        printf(2, "cannot cd %s\n", buf+3);
     4ce:	b8 63 1b 00 00       	mov    $0x1b63,%eax
     4d3:	83 ec 04             	sub    $0x4,%esp
     4d6:	50                   	push   %eax
     4d7:	68 06 16 00 00       	push   $0x1606
     4dc:	6a 02                	push   $0x2
     4de:	e8 fe 0c 00 00       	call   11e1 <printf>
     4e3:	83 c4 10             	add    $0x10,%esp
      continue;
     4e6:	eb 2a                	jmp    512 <main+0x12a>
    }
    if(fork1() == 0)
     4e8:	e8 64 00 00 00       	call   551 <fork1>
     4ed:	85 c0                	test   %eax,%eax
     4ef:	75 1c                	jne    50d <main+0x125>
      runcmd(parsecmd(buf));
     4f1:	83 ec 0c             	sub    $0xc,%esp
     4f4:	68 60 1b 00 00       	push   $0x1b60
     4f9:	e8 ab 03 00 00       	call   8a9 <parsecmd>
     4fe:	83 c4 10             	add    $0x10,%esp
     501:	83 ec 0c             	sub    $0xc,%esp
     504:	50                   	push   %eax
     505:	e8 f6 fa ff ff       	call   0 <runcmd>
     50a:	83 c4 10             	add    $0x10,%esp
    wait();
     50d:	e8 60 0b 00 00       	call   1072 <wait>
      break;
    }
  }
  
  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
     512:	83 ec 08             	sub    $0x8,%esp
     515:	6a 64                	push   $0x64
     517:	68 60 1b 00 00       	push   $0x1b60
     51c:	e8 2a fd ff ff       	call   24b <getcmd>
     521:	83 c4 10             	add    $0x10,%esp
     524:	85 c0                	test   %eax,%eax
     526:	0f 89 52 ff ff ff    	jns    47e <main+0x96>
    }
    if(fork1() == 0)
      runcmd(parsecmd(buf));
    wait();
  }
  exit();
     52c:	e8 39 0b 00 00       	call   106a <exit>

00000531 <panic>:
}

void
panic(char *s)
{
     531:	55                   	push   %ebp
     532:	89 e5                	mov    %esp,%ebp
     534:	83 ec 08             	sub    $0x8,%esp
  printf(2, "%s\n", s);
     537:	83 ec 04             	sub    $0x4,%esp
     53a:	ff 75 08             	pushl  0x8(%ebp)
     53d:	68 14 16 00 00       	push   $0x1614
     542:	6a 02                	push   $0x2
     544:	e8 98 0c 00 00       	call   11e1 <printf>
     549:	83 c4 10             	add    $0x10,%esp
  exit();
     54c:	e8 19 0b 00 00       	call   106a <exit>

00000551 <fork1>:
}

int
fork1(void)
{
     551:	55                   	push   %ebp
     552:	89 e5                	mov    %esp,%ebp
     554:	83 ec 18             	sub    $0x18,%esp
  int pid;
  
  pid = fork();
     557:	e8 06 0b 00 00       	call   1062 <fork>
     55c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pid == -1)
     55f:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
     563:	75 10                	jne    575 <fork1+0x24>
    panic("fork");
     565:	83 ec 0c             	sub    $0xc,%esp
     568:	68 18 16 00 00       	push   $0x1618
     56d:	e8 bf ff ff ff       	call   531 <panic>
     572:	83 c4 10             	add    $0x10,%esp
  return pid;
     575:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     578:	c9                   	leave  
     579:	c3                   	ret    

0000057a <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     57a:	55                   	push   %ebp
     57b:	89 e5                	mov    %esp,%ebp
     57d:	83 ec 18             	sub    $0x18,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     580:	83 ec 0c             	sub    $0xc,%esp
     583:	6a 54                	push   $0x54
     585:	e8 2a 0f 00 00       	call   14b4 <malloc>
     58a:	83 c4 10             	add    $0x10,%esp
     58d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     590:	83 ec 04             	sub    $0x4,%esp
     593:	6a 54                	push   $0x54
     595:	6a 00                	push   $0x0
     597:	ff 75 f4             	pushl  -0xc(%ebp)
     59a:	e8 30 09 00 00       	call   ecf <memset>
     59f:	83 c4 10             	add    $0x10,%esp
  cmd->type = EXEC;
     5a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5a5:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  return (struct cmd*)cmd;
     5ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     5ae:	c9                   	leave  
     5af:	c3                   	ret    

000005b0 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     5b0:	55                   	push   %ebp
     5b1:	89 e5                	mov    %esp,%ebp
     5b3:	83 ec 18             	sub    $0x18,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     5b6:	83 ec 0c             	sub    $0xc,%esp
     5b9:	6a 18                	push   $0x18
     5bb:	e8 f4 0e 00 00       	call   14b4 <malloc>
     5c0:	83 c4 10             	add    $0x10,%esp
     5c3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     5c6:	83 ec 04             	sub    $0x4,%esp
     5c9:	6a 18                	push   $0x18
     5cb:	6a 00                	push   $0x0
     5cd:	ff 75 f4             	pushl  -0xc(%ebp)
     5d0:	e8 fa 08 00 00       	call   ecf <memset>
     5d5:	83 c4 10             	add    $0x10,%esp
  cmd->type = REDIR;
     5d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5db:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  cmd->cmd = subcmd;
     5e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5e4:	8b 55 08             	mov    0x8(%ebp),%edx
     5e7:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->file = file;
     5ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5ed:	8b 55 0c             	mov    0xc(%ebp),%edx
     5f0:	89 50 08             	mov    %edx,0x8(%eax)
  cmd->efile = efile;
     5f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5f6:	8b 55 10             	mov    0x10(%ebp),%edx
     5f9:	89 50 0c             	mov    %edx,0xc(%eax)
  cmd->mode = mode;
     5fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     5ff:	8b 55 14             	mov    0x14(%ebp),%edx
     602:	89 50 10             	mov    %edx,0x10(%eax)
  cmd->fd = fd;
     605:	8b 45 f4             	mov    -0xc(%ebp),%eax
     608:	8b 55 18             	mov    0x18(%ebp),%edx
     60b:	89 50 14             	mov    %edx,0x14(%eax)
  return (struct cmd*)cmd;
     60e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     611:	c9                   	leave  
     612:	c3                   	ret    

00000613 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     613:	55                   	push   %ebp
     614:	89 e5                	mov    %esp,%ebp
     616:	83 ec 18             	sub    $0x18,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     619:	83 ec 0c             	sub    $0xc,%esp
     61c:	6a 0c                	push   $0xc
     61e:	e8 91 0e 00 00       	call   14b4 <malloc>
     623:	83 c4 10             	add    $0x10,%esp
     626:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     629:	83 ec 04             	sub    $0x4,%esp
     62c:	6a 0c                	push   $0xc
     62e:	6a 00                	push   $0x0
     630:	ff 75 f4             	pushl  -0xc(%ebp)
     633:	e8 97 08 00 00       	call   ecf <memset>
     638:	83 c4 10             	add    $0x10,%esp
  cmd->type = PIPE;
     63b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     63e:	c7 00 03 00 00 00    	movl   $0x3,(%eax)
  cmd->left = left;
     644:	8b 45 f4             	mov    -0xc(%ebp),%eax
     647:	8b 55 08             	mov    0x8(%ebp),%edx
     64a:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->right = right;
     64d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     650:	8b 55 0c             	mov    0xc(%ebp),%edx
     653:	89 50 08             	mov    %edx,0x8(%eax)
  return (struct cmd*)cmd;
     656:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     659:	c9                   	leave  
     65a:	c3                   	ret    

0000065b <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     65b:	55                   	push   %ebp
     65c:	89 e5                	mov    %esp,%ebp
     65e:	83 ec 18             	sub    $0x18,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     661:	83 ec 0c             	sub    $0xc,%esp
     664:	6a 0c                	push   $0xc
     666:	e8 49 0e 00 00       	call   14b4 <malloc>
     66b:	83 c4 10             	add    $0x10,%esp
     66e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     671:	83 ec 04             	sub    $0x4,%esp
     674:	6a 0c                	push   $0xc
     676:	6a 00                	push   $0x0
     678:	ff 75 f4             	pushl  -0xc(%ebp)
     67b:	e8 4f 08 00 00       	call   ecf <memset>
     680:	83 c4 10             	add    $0x10,%esp
  cmd->type = LIST;
     683:	8b 45 f4             	mov    -0xc(%ebp),%eax
     686:	c7 00 04 00 00 00    	movl   $0x4,(%eax)
  cmd->left = left;
     68c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     68f:	8b 55 08             	mov    0x8(%ebp),%edx
     692:	89 50 04             	mov    %edx,0x4(%eax)
  cmd->right = right;
     695:	8b 45 f4             	mov    -0xc(%ebp),%eax
     698:	8b 55 0c             	mov    0xc(%ebp),%edx
     69b:	89 50 08             	mov    %edx,0x8(%eax)
  return (struct cmd*)cmd;
     69e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     6a1:	c9                   	leave  
     6a2:	c3                   	ret    

000006a3 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     6a3:	55                   	push   %ebp
     6a4:	89 e5                	mov    %esp,%ebp
     6a6:	83 ec 18             	sub    $0x18,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     6a9:	83 ec 0c             	sub    $0xc,%esp
     6ac:	6a 08                	push   $0x8
     6ae:	e8 01 0e 00 00       	call   14b4 <malloc>
     6b3:	83 c4 10             	add    $0x10,%esp
     6b6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(cmd, 0, sizeof(*cmd));
     6b9:	83 ec 04             	sub    $0x4,%esp
     6bc:	6a 08                	push   $0x8
     6be:	6a 00                	push   $0x0
     6c0:	ff 75 f4             	pushl  -0xc(%ebp)
     6c3:	e8 07 08 00 00       	call   ecf <memset>
     6c8:	83 c4 10             	add    $0x10,%esp
  cmd->type = BACK;
     6cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6ce:	c7 00 05 00 00 00    	movl   $0x5,(%eax)
  cmd->cmd = subcmd;
     6d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6d7:	8b 55 08             	mov    0x8(%ebp),%edx
     6da:	89 50 04             	mov    %edx,0x4(%eax)
  return (struct cmd*)cmd;
     6dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     6e0:	c9                   	leave  
     6e1:	c3                   	ret    

000006e2 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     6e2:	55                   	push   %ebp
     6e3:	89 e5                	mov    %esp,%ebp
     6e5:	83 ec 18             	sub    $0x18,%esp
  char *s;
  int ret;
  
  s = *ps;
     6e8:	8b 45 08             	mov    0x8(%ebp),%eax
     6eb:	8b 00                	mov    (%eax),%eax
     6ed:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
     6f0:	eb 04                	jmp    6f6 <gettoken+0x14>
    s++;
     6f2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
{
  char *s;
  int ret;
  
  s = *ps;
  while(s < es && strchr(whitespace, *s))
     6f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
     6f9:	3b 45 0c             	cmp    0xc(%ebp),%eax
     6fc:	73 1e                	jae    71c <gettoken+0x3a>
     6fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
     701:	0f b6 00             	movzbl (%eax),%eax
     704:	0f be c0             	movsbl %al,%eax
     707:	83 ec 08             	sub    $0x8,%esp
     70a:	50                   	push   %eax
     70b:	68 34 1b 00 00       	push   $0x1b34
     710:	e8 d4 07 00 00       	call   ee9 <strchr>
     715:	83 c4 10             	add    $0x10,%esp
     718:	85 c0                	test   %eax,%eax
     71a:	75 d6                	jne    6f2 <gettoken+0x10>
    s++;
  if(q)
     71c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
     720:	74 08                	je     72a <gettoken+0x48>
    *q = s;
     722:	8b 45 10             	mov    0x10(%ebp),%eax
     725:	8b 55 f4             	mov    -0xc(%ebp),%edx
     728:	89 10                	mov    %edx,(%eax)
  ret = *s;
     72a:	8b 45 f4             	mov    -0xc(%ebp),%eax
     72d:	0f b6 00             	movzbl (%eax),%eax
     730:	0f be c0             	movsbl %al,%eax
     733:	89 45 f0             	mov    %eax,-0x10(%ebp)
  switch(*s){
     736:	8b 45 f4             	mov    -0xc(%ebp),%eax
     739:	0f b6 00             	movzbl (%eax),%eax
     73c:	0f be c0             	movsbl %al,%eax
     73f:	83 f8 29             	cmp    $0x29,%eax
     742:	7f 14                	jg     758 <gettoken+0x76>
     744:	83 f8 28             	cmp    $0x28,%eax
     747:	7d 28                	jge    771 <gettoken+0x8f>
     749:	85 c0                	test   %eax,%eax
     74b:	0f 84 94 00 00 00    	je     7e5 <gettoken+0x103>
     751:	83 f8 26             	cmp    $0x26,%eax
     754:	74 1b                	je     771 <gettoken+0x8f>
     756:	eb 3a                	jmp    792 <gettoken+0xb0>
     758:	83 f8 3e             	cmp    $0x3e,%eax
     75b:	74 1a                	je     777 <gettoken+0x95>
     75d:	83 f8 3e             	cmp    $0x3e,%eax
     760:	7f 0a                	jg     76c <gettoken+0x8a>
     762:	83 e8 3b             	sub    $0x3b,%eax
     765:	83 f8 01             	cmp    $0x1,%eax
     768:	77 28                	ja     792 <gettoken+0xb0>
     76a:	eb 05                	jmp    771 <gettoken+0x8f>
     76c:	83 f8 7c             	cmp    $0x7c,%eax
     76f:	75 21                	jne    792 <gettoken+0xb0>
  case '(':
  case ')':
  case ';':
  case '&':
  case '<':
    s++;
     771:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    break;
     775:	eb 75                	jmp    7ec <gettoken+0x10a>
  case '>':
    s++;
     777:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(*s == '>'){
     77b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     77e:	0f b6 00             	movzbl (%eax),%eax
     781:	3c 3e                	cmp    $0x3e,%al
     783:	75 63                	jne    7e8 <gettoken+0x106>
      ret = '+';
     785:	c7 45 f0 2b 00 00 00 	movl   $0x2b,-0x10(%ebp)
      s++;
     78c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    }
    break;
     790:	eb 56                	jmp    7e8 <gettoken+0x106>
  default:
    ret = 'a';
     792:	c7 45 f0 61 00 00 00 	movl   $0x61,-0x10(%ebp)
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     799:	eb 04                	jmp    79f <gettoken+0xbd>
      s++;
     79b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      s++;
    }
    break;
  default:
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     79f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7a2:	3b 45 0c             	cmp    0xc(%ebp),%eax
     7a5:	73 44                	jae    7eb <gettoken+0x109>
     7a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7aa:	0f b6 00             	movzbl (%eax),%eax
     7ad:	0f be c0             	movsbl %al,%eax
     7b0:	83 ec 08             	sub    $0x8,%esp
     7b3:	50                   	push   %eax
     7b4:	68 34 1b 00 00       	push   $0x1b34
     7b9:	e8 2b 07 00 00       	call   ee9 <strchr>
     7be:	83 c4 10             	add    $0x10,%esp
     7c1:	85 c0                	test   %eax,%eax
     7c3:	75 26                	jne    7eb <gettoken+0x109>
     7c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7c8:	0f b6 00             	movzbl (%eax),%eax
     7cb:	0f be c0             	movsbl %al,%eax
     7ce:	83 ec 08             	sub    $0x8,%esp
     7d1:	50                   	push   %eax
     7d2:	68 3c 1b 00 00       	push   $0x1b3c
     7d7:	e8 0d 07 00 00       	call   ee9 <strchr>
     7dc:	83 c4 10             	add    $0x10,%esp
     7df:	85 c0                	test   %eax,%eax
     7e1:	74 b8                	je     79b <gettoken+0xb9>
      s++;
    break;
     7e3:	eb 06                	jmp    7eb <gettoken+0x109>
  if(q)
    *q = s;
  ret = *s;
  switch(*s){
  case 0:
    break;
     7e5:	90                   	nop
     7e6:	eb 04                	jmp    7ec <gettoken+0x10a>
    s++;
    if(*s == '>'){
      ret = '+';
      s++;
    }
    break;
     7e8:	90                   	nop
     7e9:	eb 01                	jmp    7ec <gettoken+0x10a>
  default:
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
     7eb:	90                   	nop
  }
  if(eq)
     7ec:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
     7f0:	74 0e                	je     800 <gettoken+0x11e>
    *eq = s;
     7f2:	8b 45 14             	mov    0x14(%ebp),%eax
     7f5:	8b 55 f4             	mov    -0xc(%ebp),%edx
     7f8:	89 10                	mov    %edx,(%eax)
  
  while(s < es && strchr(whitespace, *s))
     7fa:	eb 04                	jmp    800 <gettoken+0x11e>
    s++;
     7fc:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    break;
  }
  if(eq)
    *eq = s;
  
  while(s < es && strchr(whitespace, *s))
     800:	8b 45 f4             	mov    -0xc(%ebp),%eax
     803:	3b 45 0c             	cmp    0xc(%ebp),%eax
     806:	73 1e                	jae    826 <gettoken+0x144>
     808:	8b 45 f4             	mov    -0xc(%ebp),%eax
     80b:	0f b6 00             	movzbl (%eax),%eax
     80e:	0f be c0             	movsbl %al,%eax
     811:	83 ec 08             	sub    $0x8,%esp
     814:	50                   	push   %eax
     815:	68 34 1b 00 00       	push   $0x1b34
     81a:	e8 ca 06 00 00       	call   ee9 <strchr>
     81f:	83 c4 10             	add    $0x10,%esp
     822:	85 c0                	test   %eax,%eax
     824:	75 d6                	jne    7fc <gettoken+0x11a>
    s++;
  *ps = s;
     826:	8b 45 08             	mov    0x8(%ebp),%eax
     829:	8b 55 f4             	mov    -0xc(%ebp),%edx
     82c:	89 10                	mov    %edx,(%eax)
  return ret;
     82e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     831:	c9                   	leave  
     832:	c3                   	ret    

00000833 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     833:	55                   	push   %ebp
     834:	89 e5                	mov    %esp,%ebp
     836:	83 ec 18             	sub    $0x18,%esp
  char *s;
  
  s = *ps;
     839:	8b 45 08             	mov    0x8(%ebp),%eax
     83c:	8b 00                	mov    (%eax),%eax
     83e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(s < es && strchr(whitespace, *s))
     841:	eb 04                	jmp    847 <peek+0x14>
    s++;
     843:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
peek(char **ps, char *es, char *toks)
{
  char *s;
  
  s = *ps;
  while(s < es && strchr(whitespace, *s))
     847:	8b 45 f4             	mov    -0xc(%ebp),%eax
     84a:	3b 45 0c             	cmp    0xc(%ebp),%eax
     84d:	73 1e                	jae    86d <peek+0x3a>
     84f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     852:	0f b6 00             	movzbl (%eax),%eax
     855:	0f be c0             	movsbl %al,%eax
     858:	83 ec 08             	sub    $0x8,%esp
     85b:	50                   	push   %eax
     85c:	68 34 1b 00 00       	push   $0x1b34
     861:	e8 83 06 00 00       	call   ee9 <strchr>
     866:	83 c4 10             	add    $0x10,%esp
     869:	85 c0                	test   %eax,%eax
     86b:	75 d6                	jne    843 <peek+0x10>
    s++;
  *ps = s;
     86d:	8b 45 08             	mov    0x8(%ebp),%eax
     870:	8b 55 f4             	mov    -0xc(%ebp),%edx
     873:	89 10                	mov    %edx,(%eax)
  return *s && strchr(toks, *s);
     875:	8b 45 f4             	mov    -0xc(%ebp),%eax
     878:	0f b6 00             	movzbl (%eax),%eax
     87b:	84 c0                	test   %al,%al
     87d:	74 23                	je     8a2 <peek+0x6f>
     87f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     882:	0f b6 00             	movzbl (%eax),%eax
     885:	0f be c0             	movsbl %al,%eax
     888:	83 ec 08             	sub    $0x8,%esp
     88b:	50                   	push   %eax
     88c:	ff 75 10             	pushl  0x10(%ebp)
     88f:	e8 55 06 00 00       	call   ee9 <strchr>
     894:	83 c4 10             	add    $0x10,%esp
     897:	85 c0                	test   %eax,%eax
     899:	74 07                	je     8a2 <peek+0x6f>
     89b:	b8 01 00 00 00       	mov    $0x1,%eax
     8a0:	eb 05                	jmp    8a7 <peek+0x74>
     8a2:	b8 00 00 00 00       	mov    $0x0,%eax
}
     8a7:	c9                   	leave  
     8a8:	c3                   	ret    

000008a9 <parsecmd>:
struct cmd *parseexec(char**, char*);
struct cmd *nulterminate(struct cmd*);

struct cmd*
parsecmd(char *s)
{
     8a9:	55                   	push   %ebp
     8aa:	89 e5                	mov    %esp,%ebp
     8ac:	53                   	push   %ebx
     8ad:	83 ec 14             	sub    $0x14,%esp
  char *es;
  struct cmd *cmd;

  es = s + strlen(s);
     8b0:	8b 5d 08             	mov    0x8(%ebp),%ebx
     8b3:	8b 45 08             	mov    0x8(%ebp),%eax
     8b6:	83 ec 0c             	sub    $0xc,%esp
     8b9:	50                   	push   %eax
     8ba:	e8 e9 05 00 00       	call   ea8 <strlen>
     8bf:	83 c4 10             	add    $0x10,%esp
     8c2:	01 d8                	add    %ebx,%eax
     8c4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  cmd = parseline(&s, es);
     8c7:	83 ec 08             	sub    $0x8,%esp
     8ca:	ff 75 f4             	pushl  -0xc(%ebp)
     8cd:	8d 45 08             	lea    0x8(%ebp),%eax
     8d0:	50                   	push   %eax
     8d1:	e8 61 00 00 00       	call   937 <parseline>
     8d6:	83 c4 10             	add    $0x10,%esp
     8d9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  peek(&s, es, "");
     8dc:	83 ec 04             	sub    $0x4,%esp
     8df:	68 1d 16 00 00       	push   $0x161d
     8e4:	ff 75 f4             	pushl  -0xc(%ebp)
     8e7:	8d 45 08             	lea    0x8(%ebp),%eax
     8ea:	50                   	push   %eax
     8eb:	e8 43 ff ff ff       	call   833 <peek>
     8f0:	83 c4 10             	add    $0x10,%esp
  if(s != es){
     8f3:	8b 45 08             	mov    0x8(%ebp),%eax
     8f6:	3b 45 f4             	cmp    -0xc(%ebp),%eax
     8f9:	74 26                	je     921 <parsecmd+0x78>
    printf(2, "leftovers: %s\n", s);
     8fb:	8b 45 08             	mov    0x8(%ebp),%eax
     8fe:	83 ec 04             	sub    $0x4,%esp
     901:	50                   	push   %eax
     902:	68 1e 16 00 00       	push   $0x161e
     907:	6a 02                	push   $0x2
     909:	e8 d3 08 00 00       	call   11e1 <printf>
     90e:	83 c4 10             	add    $0x10,%esp
    panic("syntax");
     911:	83 ec 0c             	sub    $0xc,%esp
     914:	68 2d 16 00 00       	push   $0x162d
     919:	e8 13 fc ff ff       	call   531 <panic>
     91e:	83 c4 10             	add    $0x10,%esp
  }
  nulterminate(cmd);
     921:	83 ec 0c             	sub    $0xc,%esp
     924:	ff 75 f0             	pushl  -0x10(%ebp)
     927:	e8 eb 03 00 00       	call   d17 <nulterminate>
     92c:	83 c4 10             	add    $0x10,%esp
  return cmd;
     92f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     932:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     935:	c9                   	leave  
     936:	c3                   	ret    

00000937 <parseline>:

struct cmd*
parseline(char **ps, char *es)
{
     937:	55                   	push   %ebp
     938:	89 e5                	mov    %esp,%ebp
     93a:	83 ec 18             	sub    $0x18,%esp
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
     93d:	83 ec 08             	sub    $0x8,%esp
     940:	ff 75 0c             	pushl  0xc(%ebp)
     943:	ff 75 08             	pushl  0x8(%ebp)
     946:	e8 99 00 00 00       	call   9e4 <parsepipe>
     94b:	83 c4 10             	add    $0x10,%esp
     94e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(peek(ps, es, "&")){
     951:	eb 23                	jmp    976 <parseline+0x3f>
    gettoken(ps, es, 0, 0);
     953:	6a 00                	push   $0x0
     955:	6a 00                	push   $0x0
     957:	ff 75 0c             	pushl  0xc(%ebp)
     95a:	ff 75 08             	pushl  0x8(%ebp)
     95d:	e8 80 fd ff ff       	call   6e2 <gettoken>
     962:	83 c4 10             	add    $0x10,%esp
    cmd = backcmd(cmd);
     965:	83 ec 0c             	sub    $0xc,%esp
     968:	ff 75 f4             	pushl  -0xc(%ebp)
     96b:	e8 33 fd ff ff       	call   6a3 <backcmd>
     970:	83 c4 10             	add    $0x10,%esp
     973:	89 45 f4             	mov    %eax,-0xc(%ebp)
parseline(char **ps, char *es)
{
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
  while(peek(ps, es, "&")){
     976:	83 ec 04             	sub    $0x4,%esp
     979:	68 34 16 00 00       	push   $0x1634
     97e:	ff 75 0c             	pushl  0xc(%ebp)
     981:	ff 75 08             	pushl  0x8(%ebp)
     984:	e8 aa fe ff ff       	call   833 <peek>
     989:	83 c4 10             	add    $0x10,%esp
     98c:	85 c0                	test   %eax,%eax
     98e:	75 c3                	jne    953 <parseline+0x1c>
    gettoken(ps, es, 0, 0);
    cmd = backcmd(cmd);
  }
  if(peek(ps, es, ";")){
     990:	83 ec 04             	sub    $0x4,%esp
     993:	68 36 16 00 00       	push   $0x1636
     998:	ff 75 0c             	pushl  0xc(%ebp)
     99b:	ff 75 08             	pushl  0x8(%ebp)
     99e:	e8 90 fe ff ff       	call   833 <peek>
     9a3:	83 c4 10             	add    $0x10,%esp
     9a6:	85 c0                	test   %eax,%eax
     9a8:	74 35                	je     9df <parseline+0xa8>
    gettoken(ps, es, 0, 0);
     9aa:	6a 00                	push   $0x0
     9ac:	6a 00                	push   $0x0
     9ae:	ff 75 0c             	pushl  0xc(%ebp)
     9b1:	ff 75 08             	pushl  0x8(%ebp)
     9b4:	e8 29 fd ff ff       	call   6e2 <gettoken>
     9b9:	83 c4 10             	add    $0x10,%esp
    cmd = listcmd(cmd, parseline(ps, es));
     9bc:	83 ec 08             	sub    $0x8,%esp
     9bf:	ff 75 0c             	pushl  0xc(%ebp)
     9c2:	ff 75 08             	pushl  0x8(%ebp)
     9c5:	e8 6d ff ff ff       	call   937 <parseline>
     9ca:	83 c4 10             	add    $0x10,%esp
     9cd:	83 ec 08             	sub    $0x8,%esp
     9d0:	50                   	push   %eax
     9d1:	ff 75 f4             	pushl  -0xc(%ebp)
     9d4:	e8 82 fc ff ff       	call   65b <listcmd>
     9d9:	83 c4 10             	add    $0x10,%esp
     9dc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }
  return cmd;
     9df:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     9e2:	c9                   	leave  
     9e3:	c3                   	ret    

000009e4 <parsepipe>:

struct cmd*
parsepipe(char **ps, char *es)
{
     9e4:	55                   	push   %ebp
     9e5:	89 e5                	mov    %esp,%ebp
     9e7:	83 ec 18             	sub    $0x18,%esp
  struct cmd *cmd;

  cmd = parseexec(ps, es);
     9ea:	83 ec 08             	sub    $0x8,%esp
     9ed:	ff 75 0c             	pushl  0xc(%ebp)
     9f0:	ff 75 08             	pushl  0x8(%ebp)
     9f3:	e8 ec 01 00 00       	call   be4 <parseexec>
     9f8:	83 c4 10             	add    $0x10,%esp
     9fb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(peek(ps, es, "|")){
     9fe:	83 ec 04             	sub    $0x4,%esp
     a01:	68 38 16 00 00       	push   $0x1638
     a06:	ff 75 0c             	pushl  0xc(%ebp)
     a09:	ff 75 08             	pushl  0x8(%ebp)
     a0c:	e8 22 fe ff ff       	call   833 <peek>
     a11:	83 c4 10             	add    $0x10,%esp
     a14:	85 c0                	test   %eax,%eax
     a16:	74 35                	je     a4d <parsepipe+0x69>
    gettoken(ps, es, 0, 0);
     a18:	6a 00                	push   $0x0
     a1a:	6a 00                	push   $0x0
     a1c:	ff 75 0c             	pushl  0xc(%ebp)
     a1f:	ff 75 08             	pushl  0x8(%ebp)
     a22:	e8 bb fc ff ff       	call   6e2 <gettoken>
     a27:	83 c4 10             	add    $0x10,%esp
    cmd = pipecmd(cmd, parsepipe(ps, es));
     a2a:	83 ec 08             	sub    $0x8,%esp
     a2d:	ff 75 0c             	pushl  0xc(%ebp)
     a30:	ff 75 08             	pushl  0x8(%ebp)
     a33:	e8 ac ff ff ff       	call   9e4 <parsepipe>
     a38:	83 c4 10             	add    $0x10,%esp
     a3b:	83 ec 08             	sub    $0x8,%esp
     a3e:	50                   	push   %eax
     a3f:	ff 75 f4             	pushl  -0xc(%ebp)
     a42:	e8 cc fb ff ff       	call   613 <pipecmd>
     a47:	83 c4 10             	add    $0x10,%esp
     a4a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }
  return cmd;
     a4d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     a50:	c9                   	leave  
     a51:	c3                   	ret    

00000a52 <parseredirs>:

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     a52:	55                   	push   %ebp
     a53:	89 e5                	mov    %esp,%ebp
     a55:	83 ec 18             	sub    $0x18,%esp
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     a58:	e9 b6 00 00 00       	jmp    b13 <parseredirs+0xc1>
    tok = gettoken(ps, es, 0, 0);
     a5d:	6a 00                	push   $0x0
     a5f:	6a 00                	push   $0x0
     a61:	ff 75 10             	pushl  0x10(%ebp)
     a64:	ff 75 0c             	pushl  0xc(%ebp)
     a67:	e8 76 fc ff ff       	call   6e2 <gettoken>
     a6c:	83 c4 10             	add    $0x10,%esp
     a6f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(gettoken(ps, es, &q, &eq) != 'a')
     a72:	8d 45 ec             	lea    -0x14(%ebp),%eax
     a75:	50                   	push   %eax
     a76:	8d 45 f0             	lea    -0x10(%ebp),%eax
     a79:	50                   	push   %eax
     a7a:	ff 75 10             	pushl  0x10(%ebp)
     a7d:	ff 75 0c             	pushl  0xc(%ebp)
     a80:	e8 5d fc ff ff       	call   6e2 <gettoken>
     a85:	83 c4 10             	add    $0x10,%esp
     a88:	83 f8 61             	cmp    $0x61,%eax
     a8b:	74 10                	je     a9d <parseredirs+0x4b>
      panic("missing file for redirection");
     a8d:	83 ec 0c             	sub    $0xc,%esp
     a90:	68 3a 16 00 00       	push   $0x163a
     a95:	e8 97 fa ff ff       	call   531 <panic>
     a9a:	83 c4 10             	add    $0x10,%esp
    switch(tok){
     a9d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     aa0:	83 f8 3c             	cmp    $0x3c,%eax
     aa3:	74 0c                	je     ab1 <parseredirs+0x5f>
     aa5:	83 f8 3e             	cmp    $0x3e,%eax
     aa8:	74 26                	je     ad0 <parseredirs+0x7e>
     aaa:	83 f8 2b             	cmp    $0x2b,%eax
     aad:	74 43                	je     af2 <parseredirs+0xa0>
     aaf:	eb 62                	jmp    b13 <parseredirs+0xc1>
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     ab1:	8b 55 ec             	mov    -0x14(%ebp),%edx
     ab4:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ab7:	83 ec 0c             	sub    $0xc,%esp
     aba:	6a 00                	push   $0x0
     abc:	6a 00                	push   $0x0
     abe:	52                   	push   %edx
     abf:	50                   	push   %eax
     ac0:	ff 75 08             	pushl  0x8(%ebp)
     ac3:	e8 e8 fa ff ff       	call   5b0 <redircmd>
     ac8:	83 c4 20             	add    $0x20,%esp
     acb:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     ace:	eb 43                	jmp    b13 <parseredirs+0xc1>
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     ad0:	8b 55 ec             	mov    -0x14(%ebp),%edx
     ad3:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ad6:	83 ec 0c             	sub    $0xc,%esp
     ad9:	6a 01                	push   $0x1
     adb:	68 01 02 00 00       	push   $0x201
     ae0:	52                   	push   %edx
     ae1:	50                   	push   %eax
     ae2:	ff 75 08             	pushl  0x8(%ebp)
     ae5:	e8 c6 fa ff ff       	call   5b0 <redircmd>
     aea:	83 c4 20             	add    $0x20,%esp
     aed:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     af0:	eb 21                	jmp    b13 <parseredirs+0xc1>
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     af2:	8b 55 ec             	mov    -0x14(%ebp),%edx
     af5:	8b 45 f0             	mov    -0x10(%ebp),%eax
     af8:	83 ec 0c             	sub    $0xc,%esp
     afb:	6a 01                	push   $0x1
     afd:	68 01 02 00 00       	push   $0x201
     b02:	52                   	push   %edx
     b03:	50                   	push   %eax
     b04:	ff 75 08             	pushl  0x8(%ebp)
     b07:	e8 a4 fa ff ff       	call   5b0 <redircmd>
     b0c:	83 c4 20             	add    $0x20,%esp
     b0f:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     b12:	90                   	nop
parseredirs(struct cmd *cmd, char **ps, char *es)
{
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     b13:	83 ec 04             	sub    $0x4,%esp
     b16:	68 57 16 00 00       	push   $0x1657
     b1b:	ff 75 10             	pushl  0x10(%ebp)
     b1e:	ff 75 0c             	pushl  0xc(%ebp)
     b21:	e8 0d fd ff ff       	call   833 <peek>
     b26:	83 c4 10             	add    $0x10,%esp
     b29:	85 c0                	test   %eax,%eax
     b2b:	0f 85 2c ff ff ff    	jne    a5d <parseredirs+0xb>
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    }
  }
  return cmd;
     b31:	8b 45 08             	mov    0x8(%ebp),%eax
}
     b34:	c9                   	leave  
     b35:	c3                   	ret    

00000b36 <parseblock>:

struct cmd*
parseblock(char **ps, char *es)
{
     b36:	55                   	push   %ebp
     b37:	89 e5                	mov    %esp,%ebp
     b39:	83 ec 18             	sub    $0x18,%esp
  struct cmd *cmd;

  if(!peek(ps, es, "("))
     b3c:	83 ec 04             	sub    $0x4,%esp
     b3f:	68 5a 16 00 00       	push   $0x165a
     b44:	ff 75 0c             	pushl  0xc(%ebp)
     b47:	ff 75 08             	pushl  0x8(%ebp)
     b4a:	e8 e4 fc ff ff       	call   833 <peek>
     b4f:	83 c4 10             	add    $0x10,%esp
     b52:	85 c0                	test   %eax,%eax
     b54:	75 10                	jne    b66 <parseblock+0x30>
    panic("parseblock");
     b56:	83 ec 0c             	sub    $0xc,%esp
     b59:	68 5c 16 00 00       	push   $0x165c
     b5e:	e8 ce f9 ff ff       	call   531 <panic>
     b63:	83 c4 10             	add    $0x10,%esp
  gettoken(ps, es, 0, 0);
     b66:	6a 00                	push   $0x0
     b68:	6a 00                	push   $0x0
     b6a:	ff 75 0c             	pushl  0xc(%ebp)
     b6d:	ff 75 08             	pushl  0x8(%ebp)
     b70:	e8 6d fb ff ff       	call   6e2 <gettoken>
     b75:	83 c4 10             	add    $0x10,%esp
  cmd = parseline(ps, es);
     b78:	83 ec 08             	sub    $0x8,%esp
     b7b:	ff 75 0c             	pushl  0xc(%ebp)
     b7e:	ff 75 08             	pushl  0x8(%ebp)
     b81:	e8 b1 fd ff ff       	call   937 <parseline>
     b86:	83 c4 10             	add    $0x10,%esp
     b89:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(!peek(ps, es, ")"))
     b8c:	83 ec 04             	sub    $0x4,%esp
     b8f:	68 67 16 00 00       	push   $0x1667
     b94:	ff 75 0c             	pushl  0xc(%ebp)
     b97:	ff 75 08             	pushl  0x8(%ebp)
     b9a:	e8 94 fc ff ff       	call   833 <peek>
     b9f:	83 c4 10             	add    $0x10,%esp
     ba2:	85 c0                	test   %eax,%eax
     ba4:	75 10                	jne    bb6 <parseblock+0x80>
    panic("syntax - missing )");
     ba6:	83 ec 0c             	sub    $0xc,%esp
     ba9:	68 69 16 00 00       	push   $0x1669
     bae:	e8 7e f9 ff ff       	call   531 <panic>
     bb3:	83 c4 10             	add    $0x10,%esp
  gettoken(ps, es, 0, 0);
     bb6:	6a 00                	push   $0x0
     bb8:	6a 00                	push   $0x0
     bba:	ff 75 0c             	pushl  0xc(%ebp)
     bbd:	ff 75 08             	pushl  0x8(%ebp)
     bc0:	e8 1d fb ff ff       	call   6e2 <gettoken>
     bc5:	83 c4 10             	add    $0x10,%esp
  cmd = parseredirs(cmd, ps, es);
     bc8:	83 ec 04             	sub    $0x4,%esp
     bcb:	ff 75 0c             	pushl  0xc(%ebp)
     bce:	ff 75 08             	pushl  0x8(%ebp)
     bd1:	ff 75 f4             	pushl  -0xc(%ebp)
     bd4:	e8 79 fe ff ff       	call   a52 <parseredirs>
     bd9:	83 c4 10             	add    $0x10,%esp
     bdc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  return cmd;
     bdf:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
     be2:	c9                   	leave  
     be3:	c3                   	ret    

00000be4 <parseexec>:

struct cmd*
parseexec(char **ps, char *es)
{
     be4:	55                   	push   %ebp
     be5:	89 e5                	mov    %esp,%ebp
     be7:	83 ec 28             	sub    $0x28,%esp
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;
  
  if(peek(ps, es, "("))
     bea:	83 ec 04             	sub    $0x4,%esp
     bed:	68 5a 16 00 00       	push   $0x165a
     bf2:	ff 75 0c             	pushl  0xc(%ebp)
     bf5:	ff 75 08             	pushl  0x8(%ebp)
     bf8:	e8 36 fc ff ff       	call   833 <peek>
     bfd:	83 c4 10             	add    $0x10,%esp
     c00:	85 c0                	test   %eax,%eax
     c02:	74 16                	je     c1a <parseexec+0x36>
    return parseblock(ps, es);
     c04:	83 ec 08             	sub    $0x8,%esp
     c07:	ff 75 0c             	pushl  0xc(%ebp)
     c0a:	ff 75 08             	pushl  0x8(%ebp)
     c0d:	e8 24 ff ff ff       	call   b36 <parseblock>
     c12:	83 c4 10             	add    $0x10,%esp
     c15:	e9 fb 00 00 00       	jmp    d15 <parseexec+0x131>

  ret = execcmd();
     c1a:	e8 5b f9 ff ff       	call   57a <execcmd>
     c1f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  cmd = (struct execcmd*)ret;
     c22:	8b 45 f0             	mov    -0x10(%ebp),%eax
     c25:	89 45 ec             	mov    %eax,-0x14(%ebp)

  argc = 0;
     c28:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  ret = parseredirs(ret, ps, es);
     c2f:	83 ec 04             	sub    $0x4,%esp
     c32:	ff 75 0c             	pushl  0xc(%ebp)
     c35:	ff 75 08             	pushl  0x8(%ebp)
     c38:	ff 75 f0             	pushl  -0x10(%ebp)
     c3b:	e8 12 fe ff ff       	call   a52 <parseredirs>
     c40:	83 c4 10             	add    $0x10,%esp
     c43:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while(!peek(ps, es, "|)&;")){
     c46:	e9 87 00 00 00       	jmp    cd2 <parseexec+0xee>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     c4b:	8d 45 e0             	lea    -0x20(%ebp),%eax
     c4e:	50                   	push   %eax
     c4f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     c52:	50                   	push   %eax
     c53:	ff 75 0c             	pushl  0xc(%ebp)
     c56:	ff 75 08             	pushl  0x8(%ebp)
     c59:	e8 84 fa ff ff       	call   6e2 <gettoken>
     c5e:	83 c4 10             	add    $0x10,%esp
     c61:	89 45 e8             	mov    %eax,-0x18(%ebp)
     c64:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     c68:	0f 84 84 00 00 00    	je     cf2 <parseexec+0x10e>
      break;
    if(tok != 'a')
     c6e:	83 7d e8 61          	cmpl   $0x61,-0x18(%ebp)
     c72:	74 10                	je     c84 <parseexec+0xa0>
      panic("syntax");
     c74:	83 ec 0c             	sub    $0xc,%esp
     c77:	68 2d 16 00 00       	push   $0x162d
     c7c:	e8 b0 f8 ff ff       	call   531 <panic>
     c81:	83 c4 10             	add    $0x10,%esp
    cmd->argv[argc] = q;
     c84:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
     c87:	8b 45 ec             	mov    -0x14(%ebp),%eax
     c8a:	8b 55 f4             	mov    -0xc(%ebp),%edx
     c8d:	89 4c 90 04          	mov    %ecx,0x4(%eax,%edx,4)
    cmd->eargv[argc] = eq;
     c91:	8b 55 e0             	mov    -0x20(%ebp),%edx
     c94:	8b 45 ec             	mov    -0x14(%ebp),%eax
     c97:	8b 4d f4             	mov    -0xc(%ebp),%ecx
     c9a:	83 c1 08             	add    $0x8,%ecx
     c9d:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)
    argc++;
     ca1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(argc >= MAXARGS)
     ca5:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
     ca9:	7e 10                	jle    cbb <parseexec+0xd7>
      panic("too many args");
     cab:	83 ec 0c             	sub    $0xc,%esp
     cae:	68 7c 16 00 00       	push   $0x167c
     cb3:	e8 79 f8 ff ff       	call   531 <panic>
     cb8:	83 c4 10             	add    $0x10,%esp
    ret = parseredirs(ret, ps, es);
     cbb:	83 ec 04             	sub    $0x4,%esp
     cbe:	ff 75 0c             	pushl  0xc(%ebp)
     cc1:	ff 75 08             	pushl  0x8(%ebp)
     cc4:	ff 75 f0             	pushl  -0x10(%ebp)
     cc7:	e8 86 fd ff ff       	call   a52 <parseredirs>
     ccc:	83 c4 10             	add    $0x10,%esp
     ccf:	89 45 f0             	mov    %eax,-0x10(%ebp)
  ret = execcmd();
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
  while(!peek(ps, es, "|)&;")){
     cd2:	83 ec 04             	sub    $0x4,%esp
     cd5:	68 8a 16 00 00       	push   $0x168a
     cda:	ff 75 0c             	pushl  0xc(%ebp)
     cdd:	ff 75 08             	pushl  0x8(%ebp)
     ce0:	e8 4e fb ff ff       	call   833 <peek>
     ce5:	83 c4 10             	add    $0x10,%esp
     ce8:	85 c0                	test   %eax,%eax
     cea:	0f 84 5b ff ff ff    	je     c4b <parseexec+0x67>
     cf0:	eb 01                	jmp    cf3 <parseexec+0x10f>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
      break;
     cf2:	90                   	nop
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
     cf3:	8b 45 ec             	mov    -0x14(%ebp),%eax
     cf6:	8b 55 f4             	mov    -0xc(%ebp),%edx
     cf9:	c7 44 90 04 00 00 00 	movl   $0x0,0x4(%eax,%edx,4)
     d00:	00 
  cmd->eargv[argc] = 0;
     d01:	8b 45 ec             	mov    -0x14(%ebp),%eax
     d04:	8b 55 f4             	mov    -0xc(%ebp),%edx
     d07:	83 c2 08             	add    $0x8,%edx
     d0a:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%eax,%edx,4)
     d11:	00 
  return ret;
     d12:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     d15:	c9                   	leave  
     d16:	c3                   	ret    

00000d17 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     d17:	55                   	push   %ebp
     d18:	89 e5                	mov    %esp,%ebp
     d1a:	83 ec 28             	sub    $0x28,%esp
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     d1d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
     d21:	75 0a                	jne    d2d <nulterminate+0x16>
    return 0;
     d23:	b8 00 00 00 00       	mov    $0x0,%eax
     d28:	e9 e4 00 00 00       	jmp    e11 <nulterminate+0xfa>
  
  switch(cmd->type){
     d2d:	8b 45 08             	mov    0x8(%ebp),%eax
     d30:	8b 00                	mov    (%eax),%eax
     d32:	83 f8 05             	cmp    $0x5,%eax
     d35:	0f 87 d3 00 00 00    	ja     e0e <nulterminate+0xf7>
     d3b:	8b 04 85 90 16 00 00 	mov    0x1690(,%eax,4),%eax
     d42:	ff e0                	jmp    *%eax
  case EXEC:
    ecmd = (struct execcmd*)cmd;
     d44:	8b 45 08             	mov    0x8(%ebp),%eax
     d47:	89 45 f0             	mov    %eax,-0x10(%ebp)
    for(i=0; ecmd->argv[i]; i++)
     d4a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     d51:	eb 14                	jmp    d67 <nulterminate+0x50>
      *ecmd->eargv[i] = 0;
     d53:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d56:	8b 55 f4             	mov    -0xc(%ebp),%edx
     d59:	83 c2 08             	add    $0x8,%edx
     d5c:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
     d60:	c6 00 00             	movb   $0x0,(%eax)
    return 0;
  
  switch(cmd->type){
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
     d63:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     d67:	8b 45 f0             	mov    -0x10(%ebp),%eax
     d6a:	8b 55 f4             	mov    -0xc(%ebp),%edx
     d6d:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
     d71:	85 c0                	test   %eax,%eax
     d73:	75 de                	jne    d53 <nulterminate+0x3c>
      *ecmd->eargv[i] = 0;
    break;
     d75:	e9 94 00 00 00       	jmp    e0e <nulterminate+0xf7>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
     d7a:	8b 45 08             	mov    0x8(%ebp),%eax
     d7d:	89 45 ec             	mov    %eax,-0x14(%ebp)
    nulterminate(rcmd->cmd);
     d80:	8b 45 ec             	mov    -0x14(%ebp),%eax
     d83:	8b 40 04             	mov    0x4(%eax),%eax
     d86:	83 ec 0c             	sub    $0xc,%esp
     d89:	50                   	push   %eax
     d8a:	e8 88 ff ff ff       	call   d17 <nulterminate>
     d8f:	83 c4 10             	add    $0x10,%esp
    *rcmd->efile = 0;
     d92:	8b 45 ec             	mov    -0x14(%ebp),%eax
     d95:	8b 40 0c             	mov    0xc(%eax),%eax
     d98:	c6 00 00             	movb   $0x0,(%eax)
    break;
     d9b:	eb 71                	jmp    e0e <nulterminate+0xf7>

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
     d9d:	8b 45 08             	mov    0x8(%ebp),%eax
     da0:	89 45 e8             	mov    %eax,-0x18(%ebp)
    nulterminate(pcmd->left);
     da3:	8b 45 e8             	mov    -0x18(%ebp),%eax
     da6:	8b 40 04             	mov    0x4(%eax),%eax
     da9:	83 ec 0c             	sub    $0xc,%esp
     dac:	50                   	push   %eax
     dad:	e8 65 ff ff ff       	call   d17 <nulterminate>
     db2:	83 c4 10             	add    $0x10,%esp
    nulterminate(pcmd->right);
     db5:	8b 45 e8             	mov    -0x18(%ebp),%eax
     db8:	8b 40 08             	mov    0x8(%eax),%eax
     dbb:	83 ec 0c             	sub    $0xc,%esp
     dbe:	50                   	push   %eax
     dbf:	e8 53 ff ff ff       	call   d17 <nulterminate>
     dc4:	83 c4 10             	add    $0x10,%esp
    break;
     dc7:	eb 45                	jmp    e0e <nulterminate+0xf7>
    
  case LIST:
    lcmd = (struct listcmd*)cmd;
     dc9:	8b 45 08             	mov    0x8(%ebp),%eax
     dcc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    nulterminate(lcmd->left);
     dcf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     dd2:	8b 40 04             	mov    0x4(%eax),%eax
     dd5:	83 ec 0c             	sub    $0xc,%esp
     dd8:	50                   	push   %eax
     dd9:	e8 39 ff ff ff       	call   d17 <nulterminate>
     dde:	83 c4 10             	add    $0x10,%esp
    nulterminate(lcmd->right);
     de1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     de4:	8b 40 08             	mov    0x8(%eax),%eax
     de7:	83 ec 0c             	sub    $0xc,%esp
     dea:	50                   	push   %eax
     deb:	e8 27 ff ff ff       	call   d17 <nulterminate>
     df0:	83 c4 10             	add    $0x10,%esp
    break;
     df3:	eb 19                	jmp    e0e <nulterminate+0xf7>

  case BACK:
    bcmd = (struct backcmd*)cmd;
     df5:	8b 45 08             	mov    0x8(%ebp),%eax
     df8:	89 45 e0             	mov    %eax,-0x20(%ebp)
    nulterminate(bcmd->cmd);
     dfb:	8b 45 e0             	mov    -0x20(%ebp),%eax
     dfe:	8b 40 04             	mov    0x4(%eax),%eax
     e01:	83 ec 0c             	sub    $0xc,%esp
     e04:	50                   	push   %eax
     e05:	e8 0d ff ff ff       	call   d17 <nulterminate>
     e0a:	83 c4 10             	add    $0x10,%esp
    break;
     e0d:	90                   	nop
  }
  return cmd;
     e0e:	8b 45 08             	mov    0x8(%ebp),%eax
}
     e11:	c9                   	leave  
     e12:	c3                   	ret    

00000e13 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
     e13:	55                   	push   %ebp
     e14:	89 e5                	mov    %esp,%ebp
     e16:	57                   	push   %edi
     e17:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
     e18:	8b 4d 08             	mov    0x8(%ebp),%ecx
     e1b:	8b 55 10             	mov    0x10(%ebp),%edx
     e1e:	8b 45 0c             	mov    0xc(%ebp),%eax
     e21:	89 cb                	mov    %ecx,%ebx
     e23:	89 df                	mov    %ebx,%edi
     e25:	89 d1                	mov    %edx,%ecx
     e27:	fc                   	cld    
     e28:	f3 aa                	rep stos %al,%es:(%edi)
     e2a:	89 ca                	mov    %ecx,%edx
     e2c:	89 fb                	mov    %edi,%ebx
     e2e:	89 5d 08             	mov    %ebx,0x8(%ebp)
     e31:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
     e34:	90                   	nop
     e35:	5b                   	pop    %ebx
     e36:	5f                   	pop    %edi
     e37:	5d                   	pop    %ebp
     e38:	c3                   	ret    

00000e39 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     e39:	55                   	push   %ebp
     e3a:	89 e5                	mov    %esp,%ebp
     e3c:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
     e3f:	8b 45 08             	mov    0x8(%ebp),%eax
     e42:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
     e45:	90                   	nop
     e46:	8b 45 08             	mov    0x8(%ebp),%eax
     e49:	8d 50 01             	lea    0x1(%eax),%edx
     e4c:	89 55 08             	mov    %edx,0x8(%ebp)
     e4f:	8b 55 0c             	mov    0xc(%ebp),%edx
     e52:	8d 4a 01             	lea    0x1(%edx),%ecx
     e55:	89 4d 0c             	mov    %ecx,0xc(%ebp)
     e58:	0f b6 12             	movzbl (%edx),%edx
     e5b:	88 10                	mov    %dl,(%eax)
     e5d:	0f b6 00             	movzbl (%eax),%eax
     e60:	84 c0                	test   %al,%al
     e62:	75 e2                	jne    e46 <strcpy+0xd>
    ;
  return os;
     e64:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     e67:	c9                   	leave  
     e68:	c3                   	ret    

00000e69 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     e69:	55                   	push   %ebp
     e6a:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
     e6c:	eb 08                	jmp    e76 <strcmp+0xd>
    p++, q++;
     e6e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     e72:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     e76:	8b 45 08             	mov    0x8(%ebp),%eax
     e79:	0f b6 00             	movzbl (%eax),%eax
     e7c:	84 c0                	test   %al,%al
     e7e:	74 10                	je     e90 <strcmp+0x27>
     e80:	8b 45 08             	mov    0x8(%ebp),%eax
     e83:	0f b6 10             	movzbl (%eax),%edx
     e86:	8b 45 0c             	mov    0xc(%ebp),%eax
     e89:	0f b6 00             	movzbl (%eax),%eax
     e8c:	38 c2                	cmp    %al,%dl
     e8e:	74 de                	je     e6e <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
     e90:	8b 45 08             	mov    0x8(%ebp),%eax
     e93:	0f b6 00             	movzbl (%eax),%eax
     e96:	0f b6 d0             	movzbl %al,%edx
     e99:	8b 45 0c             	mov    0xc(%ebp),%eax
     e9c:	0f b6 00             	movzbl (%eax),%eax
     e9f:	0f b6 c0             	movzbl %al,%eax
     ea2:	29 c2                	sub    %eax,%edx
     ea4:	89 d0                	mov    %edx,%eax
}
     ea6:	5d                   	pop    %ebp
     ea7:	c3                   	ret    

00000ea8 <strlen>:

uint
strlen(char *s)
{
     ea8:	55                   	push   %ebp
     ea9:	89 e5                	mov    %esp,%ebp
     eab:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
     eae:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
     eb5:	eb 04                	jmp    ebb <strlen+0x13>
     eb7:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
     ebb:	8b 55 fc             	mov    -0x4(%ebp),%edx
     ebe:	8b 45 08             	mov    0x8(%ebp),%eax
     ec1:	01 d0                	add    %edx,%eax
     ec3:	0f b6 00             	movzbl (%eax),%eax
     ec6:	84 c0                	test   %al,%al
     ec8:	75 ed                	jne    eb7 <strlen+0xf>
    ;
  return n;
     eca:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
     ecd:	c9                   	leave  
     ece:	c3                   	ret    

00000ecf <memset>:

void*
memset(void *dst, int c, uint n)
{
     ecf:	55                   	push   %ebp
     ed0:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
     ed2:	8b 45 10             	mov    0x10(%ebp),%eax
     ed5:	50                   	push   %eax
     ed6:	ff 75 0c             	pushl  0xc(%ebp)
     ed9:	ff 75 08             	pushl  0x8(%ebp)
     edc:	e8 32 ff ff ff       	call   e13 <stosb>
     ee1:	83 c4 0c             	add    $0xc,%esp
  return dst;
     ee4:	8b 45 08             	mov    0x8(%ebp),%eax
}
     ee7:	c9                   	leave  
     ee8:	c3                   	ret    

00000ee9 <strchr>:

char*
strchr(const char *s, char c)
{
     ee9:	55                   	push   %ebp
     eea:	89 e5                	mov    %esp,%ebp
     eec:	83 ec 04             	sub    $0x4,%esp
     eef:	8b 45 0c             	mov    0xc(%ebp),%eax
     ef2:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
     ef5:	eb 14                	jmp    f0b <strchr+0x22>
    if(*s == c)
     ef7:	8b 45 08             	mov    0x8(%ebp),%eax
     efa:	0f b6 00             	movzbl (%eax),%eax
     efd:	3a 45 fc             	cmp    -0x4(%ebp),%al
     f00:	75 05                	jne    f07 <strchr+0x1e>
      return (char*)s;
     f02:	8b 45 08             	mov    0x8(%ebp),%eax
     f05:	eb 13                	jmp    f1a <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     f07:	83 45 08 01          	addl   $0x1,0x8(%ebp)
     f0b:	8b 45 08             	mov    0x8(%ebp),%eax
     f0e:	0f b6 00             	movzbl (%eax),%eax
     f11:	84 c0                	test   %al,%al
     f13:	75 e2                	jne    ef7 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
     f15:	b8 00 00 00 00       	mov    $0x0,%eax
}
     f1a:	c9                   	leave  
     f1b:	c3                   	ret    

00000f1c <gets>:

char*
gets(char *buf, int max)
{
     f1c:	55                   	push   %ebp
     f1d:	89 e5                	mov    %esp,%ebp
     f1f:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     f22:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     f29:	eb 42                	jmp    f6d <gets+0x51>
    cc = read(0, &c, 1);
     f2b:	83 ec 04             	sub    $0x4,%esp
     f2e:	6a 01                	push   $0x1
     f30:	8d 45 ef             	lea    -0x11(%ebp),%eax
     f33:	50                   	push   %eax
     f34:	6a 00                	push   $0x0
     f36:	e8 47 01 00 00       	call   1082 <read>
     f3b:	83 c4 10             	add    $0x10,%esp
     f3e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
     f41:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     f45:	7e 33                	jle    f7a <gets+0x5e>
      break;
    buf[i++] = c;
     f47:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f4a:	8d 50 01             	lea    0x1(%eax),%edx
     f4d:	89 55 f4             	mov    %edx,-0xc(%ebp)
     f50:	89 c2                	mov    %eax,%edx
     f52:	8b 45 08             	mov    0x8(%ebp),%eax
     f55:	01 c2                	add    %eax,%edx
     f57:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     f5b:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
     f5d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     f61:	3c 0a                	cmp    $0xa,%al
     f63:	74 16                	je     f7b <gets+0x5f>
     f65:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
     f69:	3c 0d                	cmp    $0xd,%al
     f6b:	74 0e                	je     f7b <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     f6d:	8b 45 f4             	mov    -0xc(%ebp),%eax
     f70:	83 c0 01             	add    $0x1,%eax
     f73:	3b 45 0c             	cmp    0xc(%ebp),%eax
     f76:	7c b3                	jl     f2b <gets+0xf>
     f78:	eb 01                	jmp    f7b <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
     f7a:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     f7b:	8b 55 f4             	mov    -0xc(%ebp),%edx
     f7e:	8b 45 08             	mov    0x8(%ebp),%eax
     f81:	01 d0                	add    %edx,%eax
     f83:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
     f86:	8b 45 08             	mov    0x8(%ebp),%eax
}
     f89:	c9                   	leave  
     f8a:	c3                   	ret    

00000f8b <stat>:

int
stat(char *n, struct stat *st)
{
     f8b:	55                   	push   %ebp
     f8c:	89 e5                	mov    %esp,%ebp
     f8e:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     f91:	83 ec 08             	sub    $0x8,%esp
     f94:	6a 00                	push   $0x0
     f96:	ff 75 08             	pushl  0x8(%ebp)
     f99:	e8 0c 01 00 00       	call   10aa <open>
     f9e:	83 c4 10             	add    $0x10,%esp
     fa1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
     fa4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     fa8:	79 07                	jns    fb1 <stat+0x26>
    return -1;
     faa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     faf:	eb 25                	jmp    fd6 <stat+0x4b>
  r = fstat(fd, st);
     fb1:	83 ec 08             	sub    $0x8,%esp
     fb4:	ff 75 0c             	pushl  0xc(%ebp)
     fb7:	ff 75 f4             	pushl  -0xc(%ebp)
     fba:	e8 03 01 00 00       	call   10c2 <fstat>
     fbf:	83 c4 10             	add    $0x10,%esp
     fc2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
     fc5:	83 ec 0c             	sub    $0xc,%esp
     fc8:	ff 75 f4             	pushl  -0xc(%ebp)
     fcb:	e8 c2 00 00 00       	call   1092 <close>
     fd0:	83 c4 10             	add    $0x10,%esp
  return r;
     fd3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
     fd6:	c9                   	leave  
     fd7:	c3                   	ret    

00000fd8 <atoi>:

int
atoi(const char *s)
{
     fd8:	55                   	push   %ebp
     fd9:	89 e5                	mov    %esp,%ebp
     fdb:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
     fde:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
     fe5:	eb 25                	jmp    100c <atoi+0x34>
    n = n*10 + *s++ - '0';
     fe7:	8b 55 fc             	mov    -0x4(%ebp),%edx
     fea:	89 d0                	mov    %edx,%eax
     fec:	c1 e0 02             	shl    $0x2,%eax
     fef:	01 d0                	add    %edx,%eax
     ff1:	01 c0                	add    %eax,%eax
     ff3:	89 c1                	mov    %eax,%ecx
     ff5:	8b 45 08             	mov    0x8(%ebp),%eax
     ff8:	8d 50 01             	lea    0x1(%eax),%edx
     ffb:	89 55 08             	mov    %edx,0x8(%ebp)
     ffe:	0f b6 00             	movzbl (%eax),%eax
    1001:	0f be c0             	movsbl %al,%eax
    1004:	01 c8                	add    %ecx,%eax
    1006:	83 e8 30             	sub    $0x30,%eax
    1009:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    100c:	8b 45 08             	mov    0x8(%ebp),%eax
    100f:	0f b6 00             	movzbl (%eax),%eax
    1012:	3c 2f                	cmp    $0x2f,%al
    1014:	7e 0a                	jle    1020 <atoi+0x48>
    1016:	8b 45 08             	mov    0x8(%ebp),%eax
    1019:	0f b6 00             	movzbl (%eax),%eax
    101c:	3c 39                	cmp    $0x39,%al
    101e:	7e c7                	jle    fe7 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    1020:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1023:	c9                   	leave  
    1024:	c3                   	ret    

00001025 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1025:	55                   	push   %ebp
    1026:	89 e5                	mov    %esp,%ebp
    1028:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    102b:	8b 45 08             	mov    0x8(%ebp),%eax
    102e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    1031:	8b 45 0c             	mov    0xc(%ebp),%eax
    1034:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    1037:	eb 17                	jmp    1050 <memmove+0x2b>
    *dst++ = *src++;
    1039:	8b 45 fc             	mov    -0x4(%ebp),%eax
    103c:	8d 50 01             	lea    0x1(%eax),%edx
    103f:	89 55 fc             	mov    %edx,-0x4(%ebp)
    1042:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1045:	8d 4a 01             	lea    0x1(%edx),%ecx
    1048:	89 4d f8             	mov    %ecx,-0x8(%ebp)
    104b:	0f b6 12             	movzbl (%edx),%edx
    104e:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    1050:	8b 45 10             	mov    0x10(%ebp),%eax
    1053:	8d 50 ff             	lea    -0x1(%eax),%edx
    1056:	89 55 10             	mov    %edx,0x10(%ebp)
    1059:	85 c0                	test   %eax,%eax
    105b:	7f dc                	jg     1039 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    105d:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1060:	c9                   	leave  
    1061:	c3                   	ret    

00001062 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1062:	b8 01 00 00 00       	mov    $0x1,%eax
    1067:	cd 40                	int    $0x40
    1069:	c3                   	ret    

0000106a <exit>:
SYSCALL(exit)
    106a:	b8 02 00 00 00       	mov    $0x2,%eax
    106f:	cd 40                	int    $0x40
    1071:	c3                   	ret    

00001072 <wait>:
SYSCALL(wait)
    1072:	b8 03 00 00 00       	mov    $0x3,%eax
    1077:	cd 40                	int    $0x40
    1079:	c3                   	ret    

0000107a <pipe>:
SYSCALL(pipe)
    107a:	b8 04 00 00 00       	mov    $0x4,%eax
    107f:	cd 40                	int    $0x40
    1081:	c3                   	ret    

00001082 <read>:
SYSCALL(read)
    1082:	b8 05 00 00 00       	mov    $0x5,%eax
    1087:	cd 40                	int    $0x40
    1089:	c3                   	ret    

0000108a <write>:
SYSCALL(write)
    108a:	b8 10 00 00 00       	mov    $0x10,%eax
    108f:	cd 40                	int    $0x40
    1091:	c3                   	ret    

00001092 <close>:
SYSCALL(close)
    1092:	b8 15 00 00 00       	mov    $0x15,%eax
    1097:	cd 40                	int    $0x40
    1099:	c3                   	ret    

0000109a <kill>:
SYSCALL(kill)
    109a:	b8 06 00 00 00       	mov    $0x6,%eax
    109f:	cd 40                	int    $0x40
    10a1:	c3                   	ret    

000010a2 <exec>:
SYSCALL(exec)
    10a2:	b8 07 00 00 00       	mov    $0x7,%eax
    10a7:	cd 40                	int    $0x40
    10a9:	c3                   	ret    

000010aa <open>:
SYSCALL(open)
    10aa:	b8 0f 00 00 00       	mov    $0xf,%eax
    10af:	cd 40                	int    $0x40
    10b1:	c3                   	ret    

000010b2 <mknod>:
SYSCALL(mknod)
    10b2:	b8 11 00 00 00       	mov    $0x11,%eax
    10b7:	cd 40                	int    $0x40
    10b9:	c3                   	ret    

000010ba <unlink>:
SYSCALL(unlink)
    10ba:	b8 12 00 00 00       	mov    $0x12,%eax
    10bf:	cd 40                	int    $0x40
    10c1:	c3                   	ret    

000010c2 <fstat>:
SYSCALL(fstat)
    10c2:	b8 08 00 00 00       	mov    $0x8,%eax
    10c7:	cd 40                	int    $0x40
    10c9:	c3                   	ret    

000010ca <link>:
SYSCALL(link)
    10ca:	b8 13 00 00 00       	mov    $0x13,%eax
    10cf:	cd 40                	int    $0x40
    10d1:	c3                   	ret    

000010d2 <mkdir>:
SYSCALL(mkdir)
    10d2:	b8 14 00 00 00       	mov    $0x14,%eax
    10d7:	cd 40                	int    $0x40
    10d9:	c3                   	ret    

000010da <chdir>:
SYSCALL(chdir)
    10da:	b8 09 00 00 00       	mov    $0x9,%eax
    10df:	cd 40                	int    $0x40
    10e1:	c3                   	ret    

000010e2 <dup>:
SYSCALL(dup)
    10e2:	b8 0a 00 00 00       	mov    $0xa,%eax
    10e7:	cd 40                	int    $0x40
    10e9:	c3                   	ret    

000010ea <getpid>:
SYSCALL(getpid)
    10ea:	b8 0b 00 00 00       	mov    $0xb,%eax
    10ef:	cd 40                	int    $0x40
    10f1:	c3                   	ret    

000010f2 <sbrk>:
SYSCALL(sbrk)
    10f2:	b8 0c 00 00 00       	mov    $0xc,%eax
    10f7:	cd 40                	int    $0x40
    10f9:	c3                   	ret    

000010fa <sleep>:
SYSCALL(sleep)
    10fa:	b8 0d 00 00 00       	mov    $0xd,%eax
    10ff:	cd 40                	int    $0x40
    1101:	c3                   	ret    

00001102 <uptime>:
SYSCALL(uptime)
    1102:	b8 0e 00 00 00       	mov    $0xe,%eax
    1107:	cd 40                	int    $0x40
    1109:	c3                   	ret    

0000110a <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    110a:	55                   	push   %ebp
    110b:	89 e5                	mov    %esp,%ebp
    110d:	83 ec 18             	sub    $0x18,%esp
    1110:	8b 45 0c             	mov    0xc(%ebp),%eax
    1113:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    1116:	83 ec 04             	sub    $0x4,%esp
    1119:	6a 01                	push   $0x1
    111b:	8d 45 f4             	lea    -0xc(%ebp),%eax
    111e:	50                   	push   %eax
    111f:	ff 75 08             	pushl  0x8(%ebp)
    1122:	e8 63 ff ff ff       	call   108a <write>
    1127:	83 c4 10             	add    $0x10,%esp
}
    112a:	90                   	nop
    112b:	c9                   	leave  
    112c:	c3                   	ret    

0000112d <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    112d:	55                   	push   %ebp
    112e:	89 e5                	mov    %esp,%ebp
    1130:	53                   	push   %ebx
    1131:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    1134:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    113b:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    113f:	74 17                	je     1158 <printint+0x2b>
    1141:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1145:	79 11                	jns    1158 <printint+0x2b>
    neg = 1;
    1147:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    114e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1151:	f7 d8                	neg    %eax
    1153:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1156:	eb 06                	jmp    115e <printint+0x31>
  } else {
    x = xx;
    1158:	8b 45 0c             	mov    0xc(%ebp),%eax
    115b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    115e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    1165:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1168:	8d 41 01             	lea    0x1(%ecx),%eax
    116b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    116e:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1171:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1174:	ba 00 00 00 00       	mov    $0x0,%edx
    1179:	f7 f3                	div    %ebx
    117b:	89 d0                	mov    %edx,%eax
    117d:	0f b6 80 44 1b 00 00 	movzbl 0x1b44(%eax),%eax
    1184:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    1188:	8b 5d 10             	mov    0x10(%ebp),%ebx
    118b:	8b 45 ec             	mov    -0x14(%ebp),%eax
    118e:	ba 00 00 00 00       	mov    $0x0,%edx
    1193:	f7 f3                	div    %ebx
    1195:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1198:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    119c:	75 c7                	jne    1165 <printint+0x38>
  if(neg)
    119e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    11a2:	74 2d                	je     11d1 <printint+0xa4>
    buf[i++] = '-';
    11a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11a7:	8d 50 01             	lea    0x1(%eax),%edx
    11aa:	89 55 f4             	mov    %edx,-0xc(%ebp)
    11ad:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    11b2:	eb 1d                	jmp    11d1 <printint+0xa4>
    putc(fd, buf[i]);
    11b4:	8d 55 dc             	lea    -0x24(%ebp),%edx
    11b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11ba:	01 d0                	add    %edx,%eax
    11bc:	0f b6 00             	movzbl (%eax),%eax
    11bf:	0f be c0             	movsbl %al,%eax
    11c2:	83 ec 08             	sub    $0x8,%esp
    11c5:	50                   	push   %eax
    11c6:	ff 75 08             	pushl  0x8(%ebp)
    11c9:	e8 3c ff ff ff       	call   110a <putc>
    11ce:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    11d1:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    11d5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    11d9:	79 d9                	jns    11b4 <printint+0x87>
    putc(fd, buf[i]);
}
    11db:	90                   	nop
    11dc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    11df:	c9                   	leave  
    11e0:	c3                   	ret    

000011e1 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    11e1:	55                   	push   %ebp
    11e2:	89 e5                	mov    %esp,%ebp
    11e4:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    11e7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    11ee:	8d 45 0c             	lea    0xc(%ebp),%eax
    11f1:	83 c0 04             	add    $0x4,%eax
    11f4:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    11f7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    11fe:	e9 59 01 00 00       	jmp    135c <printf+0x17b>
    c = fmt[i] & 0xff;
    1203:	8b 55 0c             	mov    0xc(%ebp),%edx
    1206:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1209:	01 d0                	add    %edx,%eax
    120b:	0f b6 00             	movzbl (%eax),%eax
    120e:	0f be c0             	movsbl %al,%eax
    1211:	25 ff 00 00 00       	and    $0xff,%eax
    1216:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    1219:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    121d:	75 2c                	jne    124b <printf+0x6a>
      if(c == '%'){
    121f:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    1223:	75 0c                	jne    1231 <printf+0x50>
        state = '%';
    1225:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    122c:	e9 27 01 00 00       	jmp    1358 <printf+0x177>
      } else {
        putc(fd, c);
    1231:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1234:	0f be c0             	movsbl %al,%eax
    1237:	83 ec 08             	sub    $0x8,%esp
    123a:	50                   	push   %eax
    123b:	ff 75 08             	pushl  0x8(%ebp)
    123e:	e8 c7 fe ff ff       	call   110a <putc>
    1243:	83 c4 10             	add    $0x10,%esp
    1246:	e9 0d 01 00 00       	jmp    1358 <printf+0x177>
      }
    } else if(state == '%'){
    124b:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    124f:	0f 85 03 01 00 00    	jne    1358 <printf+0x177>
      if(c == 'd'){
    1255:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    1259:	75 1e                	jne    1279 <printf+0x98>
        printint(fd, *ap, 10, 1);
    125b:	8b 45 e8             	mov    -0x18(%ebp),%eax
    125e:	8b 00                	mov    (%eax),%eax
    1260:	6a 01                	push   $0x1
    1262:	6a 0a                	push   $0xa
    1264:	50                   	push   %eax
    1265:	ff 75 08             	pushl  0x8(%ebp)
    1268:	e8 c0 fe ff ff       	call   112d <printint>
    126d:	83 c4 10             	add    $0x10,%esp
        ap++;
    1270:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    1274:	e9 d8 00 00 00       	jmp    1351 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
    1279:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    127d:	74 06                	je     1285 <printf+0xa4>
    127f:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    1283:	75 1e                	jne    12a3 <printf+0xc2>
        printint(fd, *ap, 16, 0);
    1285:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1288:	8b 00                	mov    (%eax),%eax
    128a:	6a 00                	push   $0x0
    128c:	6a 10                	push   $0x10
    128e:	50                   	push   %eax
    128f:	ff 75 08             	pushl  0x8(%ebp)
    1292:	e8 96 fe ff ff       	call   112d <printint>
    1297:	83 c4 10             	add    $0x10,%esp
        ap++;
    129a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    129e:	e9 ae 00 00 00       	jmp    1351 <printf+0x170>
      } else if(c == 's'){
    12a3:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    12a7:	75 43                	jne    12ec <printf+0x10b>
        s = (char*)*ap;
    12a9:	8b 45 e8             	mov    -0x18(%ebp),%eax
    12ac:	8b 00                	mov    (%eax),%eax
    12ae:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    12b1:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    12b5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    12b9:	75 25                	jne    12e0 <printf+0xff>
          s = "(null)";
    12bb:	c7 45 f4 a8 16 00 00 	movl   $0x16a8,-0xc(%ebp)
        while(*s != 0){
    12c2:	eb 1c                	jmp    12e0 <printf+0xff>
          putc(fd, *s);
    12c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    12c7:	0f b6 00             	movzbl (%eax),%eax
    12ca:	0f be c0             	movsbl %al,%eax
    12cd:	83 ec 08             	sub    $0x8,%esp
    12d0:	50                   	push   %eax
    12d1:	ff 75 08             	pushl  0x8(%ebp)
    12d4:	e8 31 fe ff ff       	call   110a <putc>
    12d9:	83 c4 10             	add    $0x10,%esp
          s++;
    12dc:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    12e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    12e3:	0f b6 00             	movzbl (%eax),%eax
    12e6:	84 c0                	test   %al,%al
    12e8:	75 da                	jne    12c4 <printf+0xe3>
    12ea:	eb 65                	jmp    1351 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    12ec:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    12f0:	75 1d                	jne    130f <printf+0x12e>
        putc(fd, *ap);
    12f2:	8b 45 e8             	mov    -0x18(%ebp),%eax
    12f5:	8b 00                	mov    (%eax),%eax
    12f7:	0f be c0             	movsbl %al,%eax
    12fa:	83 ec 08             	sub    $0x8,%esp
    12fd:	50                   	push   %eax
    12fe:	ff 75 08             	pushl  0x8(%ebp)
    1301:	e8 04 fe ff ff       	call   110a <putc>
    1306:	83 c4 10             	add    $0x10,%esp
        ap++;
    1309:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    130d:	eb 42                	jmp    1351 <printf+0x170>
      } else if(c == '%'){
    130f:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    1313:	75 17                	jne    132c <printf+0x14b>
        putc(fd, c);
    1315:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1318:	0f be c0             	movsbl %al,%eax
    131b:	83 ec 08             	sub    $0x8,%esp
    131e:	50                   	push   %eax
    131f:	ff 75 08             	pushl  0x8(%ebp)
    1322:	e8 e3 fd ff ff       	call   110a <putc>
    1327:	83 c4 10             	add    $0x10,%esp
    132a:	eb 25                	jmp    1351 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    132c:	83 ec 08             	sub    $0x8,%esp
    132f:	6a 25                	push   $0x25
    1331:	ff 75 08             	pushl  0x8(%ebp)
    1334:	e8 d1 fd ff ff       	call   110a <putc>
    1339:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    133c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    133f:	0f be c0             	movsbl %al,%eax
    1342:	83 ec 08             	sub    $0x8,%esp
    1345:	50                   	push   %eax
    1346:	ff 75 08             	pushl  0x8(%ebp)
    1349:	e8 bc fd ff ff       	call   110a <putc>
    134e:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    1351:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1358:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    135c:	8b 55 0c             	mov    0xc(%ebp),%edx
    135f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1362:	01 d0                	add    %edx,%eax
    1364:	0f b6 00             	movzbl (%eax),%eax
    1367:	84 c0                	test   %al,%al
    1369:	0f 85 94 fe ff ff    	jne    1203 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    136f:	90                   	nop
    1370:	c9                   	leave  
    1371:	c3                   	ret    

00001372 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1372:	55                   	push   %ebp
    1373:	89 e5                	mov    %esp,%ebp
    1375:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1378:	8b 45 08             	mov    0x8(%ebp),%eax
    137b:	83 e8 08             	sub    $0x8,%eax
    137e:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1381:	a1 cc 1b 00 00       	mov    0x1bcc,%eax
    1386:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1389:	eb 24                	jmp    13af <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    138b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    138e:	8b 00                	mov    (%eax),%eax
    1390:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1393:	77 12                	ja     13a7 <free+0x35>
    1395:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1398:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    139b:	77 24                	ja     13c1 <free+0x4f>
    139d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    13a0:	8b 00                	mov    (%eax),%eax
    13a2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    13a5:	77 1a                	ja     13c1 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    13a7:	8b 45 fc             	mov    -0x4(%ebp),%eax
    13aa:	8b 00                	mov    (%eax),%eax
    13ac:	89 45 fc             	mov    %eax,-0x4(%ebp)
    13af:	8b 45 f8             	mov    -0x8(%ebp),%eax
    13b2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    13b5:	76 d4                	jbe    138b <free+0x19>
    13b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
    13ba:	8b 00                	mov    (%eax),%eax
    13bc:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    13bf:	76 ca                	jbe    138b <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    13c1:	8b 45 f8             	mov    -0x8(%ebp),%eax
    13c4:	8b 40 04             	mov    0x4(%eax),%eax
    13c7:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    13ce:	8b 45 f8             	mov    -0x8(%ebp),%eax
    13d1:	01 c2                	add    %eax,%edx
    13d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
    13d6:	8b 00                	mov    (%eax),%eax
    13d8:	39 c2                	cmp    %eax,%edx
    13da:	75 24                	jne    1400 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    13dc:	8b 45 f8             	mov    -0x8(%ebp),%eax
    13df:	8b 50 04             	mov    0x4(%eax),%edx
    13e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
    13e5:	8b 00                	mov    (%eax),%eax
    13e7:	8b 40 04             	mov    0x4(%eax),%eax
    13ea:	01 c2                	add    %eax,%edx
    13ec:	8b 45 f8             	mov    -0x8(%ebp),%eax
    13ef:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    13f2:	8b 45 fc             	mov    -0x4(%ebp),%eax
    13f5:	8b 00                	mov    (%eax),%eax
    13f7:	8b 10                	mov    (%eax),%edx
    13f9:	8b 45 f8             	mov    -0x8(%ebp),%eax
    13fc:	89 10                	mov    %edx,(%eax)
    13fe:	eb 0a                	jmp    140a <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    1400:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1403:	8b 10                	mov    (%eax),%edx
    1405:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1408:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    140a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    140d:	8b 40 04             	mov    0x4(%eax),%eax
    1410:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    1417:	8b 45 fc             	mov    -0x4(%ebp),%eax
    141a:	01 d0                	add    %edx,%eax
    141c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    141f:	75 20                	jne    1441 <free+0xcf>
    p->s.size += bp->s.size;
    1421:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1424:	8b 50 04             	mov    0x4(%eax),%edx
    1427:	8b 45 f8             	mov    -0x8(%ebp),%eax
    142a:	8b 40 04             	mov    0x4(%eax),%eax
    142d:	01 c2                	add    %eax,%edx
    142f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1432:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1435:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1438:	8b 10                	mov    (%eax),%edx
    143a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    143d:	89 10                	mov    %edx,(%eax)
    143f:	eb 08                	jmp    1449 <free+0xd7>
  } else
    p->s.ptr = bp;
    1441:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1444:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1447:	89 10                	mov    %edx,(%eax)
  freep = p;
    1449:	8b 45 fc             	mov    -0x4(%ebp),%eax
    144c:	a3 cc 1b 00 00       	mov    %eax,0x1bcc
}
    1451:	90                   	nop
    1452:	c9                   	leave  
    1453:	c3                   	ret    

00001454 <morecore>:

static Header*
morecore(uint nu)
{
    1454:	55                   	push   %ebp
    1455:	89 e5                	mov    %esp,%ebp
    1457:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    145a:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    1461:	77 07                	ja     146a <morecore+0x16>
    nu = 4096;
    1463:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    146a:	8b 45 08             	mov    0x8(%ebp),%eax
    146d:	c1 e0 03             	shl    $0x3,%eax
    1470:	83 ec 0c             	sub    $0xc,%esp
    1473:	50                   	push   %eax
    1474:	e8 79 fc ff ff       	call   10f2 <sbrk>
    1479:	83 c4 10             	add    $0x10,%esp
    147c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    147f:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    1483:	75 07                	jne    148c <morecore+0x38>
    return 0;
    1485:	b8 00 00 00 00       	mov    $0x0,%eax
    148a:	eb 26                	jmp    14b2 <morecore+0x5e>
  hp = (Header*)p;
    148c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    148f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    1492:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1495:	8b 55 08             	mov    0x8(%ebp),%edx
    1498:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    149b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    149e:	83 c0 08             	add    $0x8,%eax
    14a1:	83 ec 0c             	sub    $0xc,%esp
    14a4:	50                   	push   %eax
    14a5:	e8 c8 fe ff ff       	call   1372 <free>
    14aa:	83 c4 10             	add    $0x10,%esp
  return freep;
    14ad:	a1 cc 1b 00 00       	mov    0x1bcc,%eax
}
    14b2:	c9                   	leave  
    14b3:	c3                   	ret    

000014b4 <malloc>:

void*
malloc(uint nbytes)
{
    14b4:	55                   	push   %ebp
    14b5:	89 e5                	mov    %esp,%ebp
    14b7:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    14ba:	8b 45 08             	mov    0x8(%ebp),%eax
    14bd:	83 c0 07             	add    $0x7,%eax
    14c0:	c1 e8 03             	shr    $0x3,%eax
    14c3:	83 c0 01             	add    $0x1,%eax
    14c6:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    14c9:	a1 cc 1b 00 00       	mov    0x1bcc,%eax
    14ce:	89 45 f0             	mov    %eax,-0x10(%ebp)
    14d1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    14d5:	75 23                	jne    14fa <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    14d7:	c7 45 f0 c4 1b 00 00 	movl   $0x1bc4,-0x10(%ebp)
    14de:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14e1:	a3 cc 1b 00 00       	mov    %eax,0x1bcc
    14e6:	a1 cc 1b 00 00       	mov    0x1bcc,%eax
    14eb:	a3 c4 1b 00 00       	mov    %eax,0x1bc4
    base.s.size = 0;
    14f0:	c7 05 c8 1b 00 00 00 	movl   $0x0,0x1bc8
    14f7:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    14fa:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14fd:	8b 00                	mov    (%eax),%eax
    14ff:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    1502:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1505:	8b 40 04             	mov    0x4(%eax),%eax
    1508:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    150b:	72 4d                	jb     155a <malloc+0xa6>
      if(p->s.size == nunits)
    150d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1510:	8b 40 04             	mov    0x4(%eax),%eax
    1513:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    1516:	75 0c                	jne    1524 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    1518:	8b 45 f4             	mov    -0xc(%ebp),%eax
    151b:	8b 10                	mov    (%eax),%edx
    151d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1520:	89 10                	mov    %edx,(%eax)
    1522:	eb 26                	jmp    154a <malloc+0x96>
      else {
        p->s.size -= nunits;
    1524:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1527:	8b 40 04             	mov    0x4(%eax),%eax
    152a:	2b 45 ec             	sub    -0x14(%ebp),%eax
    152d:	89 c2                	mov    %eax,%edx
    152f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1532:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    1535:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1538:	8b 40 04             	mov    0x4(%eax),%eax
    153b:	c1 e0 03             	shl    $0x3,%eax
    153e:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    1541:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1544:	8b 55 ec             	mov    -0x14(%ebp),%edx
    1547:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    154a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    154d:	a3 cc 1b 00 00       	mov    %eax,0x1bcc
      return (void*)(p + 1);
    1552:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1555:	83 c0 08             	add    $0x8,%eax
    1558:	eb 3b                	jmp    1595 <malloc+0xe1>
    }
    if(p == freep)
    155a:	a1 cc 1b 00 00       	mov    0x1bcc,%eax
    155f:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    1562:	75 1e                	jne    1582 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
    1564:	83 ec 0c             	sub    $0xc,%esp
    1567:	ff 75 ec             	pushl  -0x14(%ebp)
    156a:	e8 e5 fe ff ff       	call   1454 <morecore>
    156f:	83 c4 10             	add    $0x10,%esp
    1572:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1575:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1579:	75 07                	jne    1582 <malloc+0xce>
        return 0;
    157b:	b8 00 00 00 00       	mov    $0x0,%eax
    1580:	eb 13                	jmp    1595 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1582:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1585:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1588:	8b 45 f4             	mov    -0xc(%ebp),%eax
    158b:	8b 00                	mov    (%eax),%eax
    158d:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    1590:	e9 6d ff ff ff       	jmp    1502 <malloc+0x4e>
}
    1595:	c9                   	leave  
    1596:	c3                   	ret    
