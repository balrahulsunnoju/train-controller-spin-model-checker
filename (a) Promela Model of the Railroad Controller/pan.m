#define rand	pan_rand
#define pthread_equal(a,b)	((a)==(b))
#if defined(HAS_CODE) && defined(VERBOSE)
	#ifdef BFS_PAR
		bfs_printf("Pr: %d Tr: %d\n", II, t->forw);
	#else
		cpu_printf("Pr: %d Tr: %d\n", II, t->forw);
	#endif
#endif
	switch (t->forw) {
	default: Uerror("bad forward move");
	case 0:	/* if without executable clauses */
		continue;
	case 1: /* generic 'goto' or 'skip' */
		IfNotBlocked
		_m = 3; goto P999;
	case 2: /* generic 'else' */
		IfNotBlocked
		if (trpt->o_pm&1) continue;
		_m = 3; goto P999;

		 /* PROC :init: */
	case 3: // STATE 1 - railroad_controller.pml:70 - [(run Controller())] (0:0:0 - 1)
		IfNotBlocked
		reached[3][1] = 1;
		if (!(addproc(II, 1, 0, 0, 0, 0)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 4: // STATE 2 - railroad_controller.pml:71 - [(run Train(requestW,signalW,Idle))] (0:0:0 - 1)
		IfNotBlocked
		reached[3][2] = 1;
		if (!(addproc(II, 1, 1, now.requestW, now.signalW, 3)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 5: // STATE 3 - railroad_controller.pml:72 - [(run Train(requestE,signalE,Idle))] (0:0:0 - 1)
		IfNotBlocked
		reached[3][3] = 1;
		if (!(addproc(II, 1, 1, now.requestE, now.signalE, 3)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 6: // STATE 4 - railroad_controller.pml:73 - [(run Monitor())] (0:0:0 - 1)
		IfNotBlocked
		reached[3][4] = 1;
		if (!(addproc(II, 1, 2, 0, 0, 0)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 7: // STATE 5 - railroad_controller.pml:74 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[3][5] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC Monitor */
	case 8: // STATE 1 - railroad_controller.pml:63 - [assert(!(((ControllerStateW==Green)&&(ControllerStateE==Green))))] (0:0:0 - 1)
		IfNotBlocked
		reached[2][1] = 1;
		spin_assert( !(((now.ControllerStateW==4)&&(now.ControllerStateE==4))), " !(((ControllerStateW==4)&&(ControllerStateE==4)))", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 9: // STATE 5 - railroad_controller.pml:66 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[2][5] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC Train */
	case 10: // STATE 1 - railroad_controller.pml:45 - [((state==Idle))] (0:0:1 - 1)
		IfNotBlocked
		reached[1][1] = 1;
		if (!((((P1 *)_this)->state==3)))
			continue;
		if (TstOnly) return 1; /* TT */
		/* dead 1: state */  (trpt+1)->bup.oval = ((P1 *)_this)->state;
#ifdef HAS_CODE
		if (!readtrail)
#endif
			((P1 *)_this)->state = 0;
		_m = 3; goto P999; /* 0 */
	case 11: // STATE 2 - railroad_controller.pml:46 - [req!1] (0:0:0 - 1)
		IfNotBlocked
		reached[1][2] = 1;
		if (q_full(((P1 *)_this)->req))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", ((P1 *)_this)->req);
		sprintf(simtmp, "%d", 1); strcat(simvals, simtmp);		}
#endif
		
		qsend(((P1 *)_this)->req, 0, 1, 1);
		_m = 2; goto P999; /* 0 */
	case 12: // STATE 3 - railroad_controller.pml:47 - [state = Waiting] (0:0:1 - 1)
		IfNotBlocked
		reached[1][3] = 1;
		(trpt+1)->bup.oval = ((P1 *)_this)->state;
		((P1 *)_this)->state = 2;
#ifdef VAR_RANGES
		logval("Train:state", ((P1 *)_this)->state);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 13: // STATE 4 - railroad_controller.pml:48 - [((state==Waiting))] (0:0:1 - 1)
		IfNotBlocked
		reached[1][4] = 1;
		if (!((((P1 *)_this)->state==2)))
			continue;
		if (TstOnly) return 1; /* TT */
		/* dead 1: state */  (trpt+1)->bup.oval = ((P1 *)_this)->state;
#ifdef HAS_CODE
		if (!readtrail)
#endif
			((P1 *)_this)->state = 0;
		_m = 3; goto P999; /* 0 */
	case 14: // STATE 5 - railroad_controller.pml:49 - [sig?recvd] (0:0:1 - 1)
		reached[1][5] = 1;
		if (q_len(((P1 *)_this)->sig) == 0) continue;

		XX=1;
		(trpt+1)->bup.oval = ((P1 *)_this)->recvd;
		;
		((P1 *)_this)->recvd = qrecv(((P1 *)_this)->sig, XX-1, 0, 1);
#ifdef VAR_RANGES
		logval("Train:recvd", ((P1 *)_this)->recvd);
#endif
		;
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", ((P1 *)_this)->sig);
			sprintf(simtmp, "%d", ((P1 *)_this)->recvd); strcat(simvals, simtmp);
		}
#endif
		;
		_m = 4; goto P999; /* 0 */
	case 15: // STATE 6 - railroad_controller.pml:51 - [((recvd==Green))] (13:0:2 - 1)
		IfNotBlocked
		reached[1][6] = 1;
		if (!((((P1 *)_this)->recvd==4)))
			continue;
		if (TstOnly) return 1; /* TT */
		/* dead 1: recvd */  (trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = ((P1 *)_this)->recvd;
#ifdef HAS_CODE
		if (!readtrail)
#endif
			((P1 *)_this)->recvd = 0;
		/* merge: state = Bridge(0, 7, 13) */
		reached[1][7] = 1;
		(trpt+1)->bup.ovals[1] = ((P1 *)_this)->state;
		((P1 *)_this)->state = 1;
#ifdef VAR_RANGES
		logval("Train:state", ((P1 *)_this)->state);
#endif
		;
		/* merge: .(goto)(0, 9, 13) */
		reached[1][9] = 1;
		;
		/* merge: .(goto)(0, 14, 13) */
		reached[1][14] = 1;
		;
		_m = 3; goto P999; /* 3 */
	case 16: // STATE 10 - railroad_controller.pml:54 - [((state==Bridge))] (0:0:1 - 1)
		IfNotBlocked
		reached[1][10] = 1;
		if (!((((P1 *)_this)->state==1)))
			continue;
		if (TstOnly) return 1; /* TT */
		/* dead 1: state */  (trpt+1)->bup.oval = ((P1 *)_this)->state;
#ifdef HAS_CODE
		if (!readtrail)
#endif
			((P1 *)_this)->state = 0;
		_m = 3; goto P999; /* 0 */
	case 17: // STATE 11 - railroad_controller.pml:55 - [req!0] (0:0:0 - 1)
		IfNotBlocked
		reached[1][11] = 1;
		if (q_full(((P1 *)_this)->req))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", ((P1 *)_this)->req);
		sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);		}
#endif
		
		qsend(((P1 *)_this)->req, 0, 0, 1);
		_m = 2; goto P999; /* 0 */
	case 18: // STATE 12 - railroad_controller.pml:56 - [state = Idle] (0:0:1 - 1)
		IfNotBlocked
		reached[1][12] = 1;
		(trpt+1)->bup.oval = ((P1 *)_this)->state;
		((P1 *)_this)->state = 3;
#ifdef VAR_RANGES
		logval("Train:state", ((P1 *)_this)->state);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 19: // STATE 16 - railroad_controller.pml:58 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[1][16] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */

		 /* PROC Controller */
	case 20: // STATE 1 - railroad_controller.pml:16 - [(((ControllerStateW==Red)&&(ControllerStateE==Red)))] (0:0:0 - 1)
		IfNotBlocked
		reached[0][1] = 1;
		if (!(((now.ControllerStateW==5)&&(now.ControllerStateE==5))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 21: // STATE 2 - railroad_controller.pml:18 - [requestW?1] (0:0:0 - 1)
		reached[0][2] = 1;
		if (q_len(now.requestW) == 0) continue;

		XX=1;
		if (1 != qrecv(now.requestW, 0, 0, 0)) continue;
		
#ifndef BFS_PAR
		if (q_flds[((Q0 *)qptr(now.requestW-1))->_t] != 1)
			Uerror("wrong nr of msg fields in rcv");
#endif
		;
		qrecv(now.requestW, XX-1, 0, 1);
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", now.requestW);
			sprintf(simtmp, "%d", 1); strcat(simvals, simtmp);
		}
#endif
		;
		_m = 4; goto P999; /* 0 */
	case 22: // STATE 3 - railroad_controller.pml:19 - [ControllerStateW = Green] (0:0:1 - 1)
		IfNotBlocked
		reached[0][3] = 1;
		(trpt+1)->bup.oval = now.ControllerStateW;
		now.ControllerStateW = 4;
#ifdef VAR_RANGES
		logval("ControllerStateW", now.ControllerStateW);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 23: // STATE 4 - railroad_controller.pml:20 - [signalW!Green] (0:0:0 - 1)
		IfNotBlocked
		reached[0][4] = 1;
		if (q_full(now.signalW))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", now.signalW);
		sprintf(simtmp, "%d", 4); strcat(simvals, simtmp);		}
#endif
		
		qsend(now.signalW, 0, 4, 1);
		_m = 2; goto P999; /* 0 */
	case 24: // STATE 5 - railroad_controller.pml:21 - [requestE?1] (0:0:0 - 1)
		reached[0][5] = 1;
		if (q_len(now.requestE) == 0) continue;

		XX=1;
		if (1 != qrecv(now.requestE, 0, 0, 0)) continue;
		
#ifndef BFS_PAR
		if (q_flds[((Q0 *)qptr(now.requestE-1))->_t] != 1)
			Uerror("wrong nr of msg fields in rcv");
#endif
		;
		qrecv(now.requestE, XX-1, 0, 1);
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", now.requestE);
			sprintf(simtmp, "%d", 1); strcat(simvals, simtmp);
		}
#endif
		;
		_m = 4; goto P999; /* 0 */
	case 25: // STATE 6 - railroad_controller.pml:22 - [ControllerStateE = Green] (0:0:1 - 1)
		IfNotBlocked
		reached[0][6] = 1;
		(trpt+1)->bup.oval = now.ControllerStateE;
		now.ControllerStateE = 4;
#ifdef VAR_RANGES
		logval("ControllerStateE", now.ControllerStateE);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 26: // STATE 7 - railroad_controller.pml:23 - [signalE!Green] (0:0:0 - 1)
		IfNotBlocked
		reached[0][7] = 1;
		if (q_full(now.signalE))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", now.signalE);
		sprintf(simtmp, "%d", 4); strcat(simvals, simtmp);		}
#endif
		
		qsend(now.signalE, 0, 4, 1);
		_m = 2; goto P999; /* 0 */
	case 27: // STATE 10 - railroad_controller.pml:25 - [((ControllerStateW==Green))] (0:0:0 - 1)
		IfNotBlocked
		reached[0][10] = 1;
		if (!((now.ControllerStateW==4)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 28: // STATE 11 - railroad_controller.pml:27 - [requestW?0] (0:0:0 - 1)
		reached[0][11] = 1;
		if (q_len(now.requestW) == 0) continue;

		XX=1;
		if (0 != qrecv(now.requestW, 0, 0, 0)) continue;
		
#ifndef BFS_PAR
		if (q_flds[((Q0 *)qptr(now.requestW-1))->_t] != 1)
			Uerror("wrong nr of msg fields in rcv");
#endif
		;
		qrecv(now.requestW, XX-1, 0, 1);
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", now.requestW);
			sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);
		}
#endif
		;
		_m = 4; goto P999; /* 0 */
	case 29: // STATE 12 - railroad_controller.pml:28 - [signalW!Red] (0:0:0 - 1)
		IfNotBlocked
		reached[0][12] = 1;
		if (q_full(now.signalW))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", now.signalW);
		sprintf(simtmp, "%d", 5); strcat(simvals, simtmp);		}
#endif
		
		qsend(now.signalW, 0, 5, 1);
		_m = 2; goto P999; /* 0 */
	case 30: // STATE 13 - railroad_controller.pml:29 - [ControllerStateW = Red] (0:0:1 - 1)
		IfNotBlocked
		reached[0][13] = 1;
		(trpt+1)->bup.oval = now.ControllerStateW;
		now.ControllerStateW = 5;
#ifdef VAR_RANGES
		logval("ControllerStateW", now.ControllerStateW);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 31: // STATE 16 - railroad_controller.pml:31 - [((ControllerStateE==Green))] (0:0:0 - 1)
		IfNotBlocked
		reached[0][16] = 1;
		if (!((now.ControllerStateE==4)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 32: // STATE 17 - railroad_controller.pml:33 - [requestE?0] (0:0:0 - 1)
		reached[0][17] = 1;
		if (q_len(now.requestE) == 0) continue;

		XX=1;
		if (0 != qrecv(now.requestE, 0, 0, 0)) continue;
		
#ifndef BFS_PAR
		if (q_flds[((Q0 *)qptr(now.requestE-1))->_t] != 1)
			Uerror("wrong nr of msg fields in rcv");
#endif
		;
		qrecv(now.requestE, XX-1, 0, 1);
		
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[32];
			sprintf(simvals, "%d?", now.requestE);
			sprintf(simtmp, "%d", 0); strcat(simvals, simtmp);
		}
#endif
		;
		_m = 4; goto P999; /* 0 */
	case 33: // STATE 18 - railroad_controller.pml:34 - [signalE!Red] (0:0:0 - 1)
		IfNotBlocked
		reached[0][18] = 1;
		if (q_full(now.signalE))
			continue;
#ifdef HAS_CODE
		if (readtrail && gui) {
			char simtmp[64];
			sprintf(simvals, "%d!", now.signalE);
		sprintf(simtmp, "%d", 5); strcat(simvals, simtmp);		}
#endif
		
		qsend(now.signalE, 0, 5, 1);
		_m = 2; goto P999; /* 0 */
	case 34: // STATE 19 - railroad_controller.pml:35 - [ControllerStateE = Red] (0:0:1 - 1)
		IfNotBlocked
		reached[0][19] = 1;
		(trpt+1)->bup.oval = now.ControllerStateE;
		now.ControllerStateE = 5;
#ifdef VAR_RANGES
		logval("ControllerStateE", now.ControllerStateE);
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 35: // STATE 25 - railroad_controller.pml:38 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[0][25] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */
	case  _T5:	/* np_ */
		if (!((!(trpt->o_pm&4) && !(trpt->tau&128))))
			continue;
		/* else fall through */
	case  _T2:	/* true */
		_m = 3; goto P999;
#undef rand
	}

