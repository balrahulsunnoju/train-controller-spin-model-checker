	switch (t->back) {
	default: Uerror("bad return move");
	case  0: goto R999; /* nothing to undo */

		 /* PROC :init: */

	case 3: // STATE 1
		;
		;
		delproc(0, now._nr_pr-1);
		;
		goto R999;

	case 4: // STATE 2
		;
		;
		delproc(0, now._nr_pr-1);
		;
		goto R999;

	case 5: // STATE 3
		;
		;
		delproc(0, now._nr_pr-1);
		;
		goto R999;

	case 6: // STATE 4
		;
		;
		delproc(0, now._nr_pr-1);
		;
		goto R999;

	case 7: // STATE 5
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC Monitor */
;
		;
		
	case 9: // STATE 5
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC Train */

	case 10: // STATE 1
		;
	/* 0 */	((P1 *)_this)->state = trpt->bup.oval;
		;
		;
		goto R999;

	case 11: // STATE 2
		;
		_m = unsend(((P1 *)_this)->req);
		;
		goto R999;

	case 12: // STATE 3
		;
		((P1 *)_this)->state = trpt->bup.oval;
		;
		goto R999;

	case 13: // STATE 4
		;
	/* 0 */	((P1 *)_this)->state = trpt->bup.oval;
		;
		;
		goto R999;

	case 14: // STATE 5
		;
		XX = 1;
		unrecv(((P1 *)_this)->sig, XX-1, 0, ((P1 *)_this)->recvd, 1);
		((P1 *)_this)->recvd = trpt->bup.oval;
		;
		;
		goto R999;

	case 15: // STATE 7
		;
		((P1 *)_this)->state = trpt->bup.ovals[1];
	/* 0 */	((P1 *)_this)->recvd = trpt->bup.ovals[0];
		;
		;
		ungrab_ints(trpt->bup.ovals, 2);
		goto R999;

	case 16: // STATE 10
		;
	/* 0 */	((P1 *)_this)->state = trpt->bup.oval;
		;
		;
		goto R999;

	case 17: // STATE 11
		;
		_m = unsend(((P1 *)_this)->req);
		;
		goto R999;

	case 18: // STATE 12
		;
		((P1 *)_this)->state = trpt->bup.oval;
		;
		goto R999;

	case 19: // STATE 16
		;
		p_restor(II);
		;
		;
		goto R999;

		 /* PROC Controller */
;
		;
		
	case 21: // STATE 2
		;
		XX = 1;
		unrecv(now.requestW, XX-1, 0, 1, 1);
		;
		;
		goto R999;

	case 22: // STATE 3
		;
		now.ControllerStateW = trpt->bup.oval;
		;
		goto R999;

	case 23: // STATE 4
		;
		_m = unsend(now.signalW);
		;
		goto R999;

	case 24: // STATE 5
		;
		XX = 1;
		unrecv(now.requestE, XX-1, 0, 1, 1);
		;
		;
		goto R999;

	case 25: // STATE 6
		;
		now.ControllerStateE = trpt->bup.oval;
		;
		goto R999;

	case 26: // STATE 7
		;
		_m = unsend(now.signalE);
		;
		goto R999;
;
		;
		
	case 28: // STATE 11
		;
		XX = 1;
		unrecv(now.requestW, XX-1, 0, 0, 1);
		;
		;
		goto R999;

	case 29: // STATE 12
		;
		_m = unsend(now.signalW);
		;
		goto R999;

	case 30: // STATE 13
		;
		now.ControllerStateW = trpt->bup.oval;
		;
		goto R999;
;
		;
		
	case 32: // STATE 17
		;
		XX = 1;
		unrecv(now.requestE, XX-1, 0, 0, 1);
		;
		;
		goto R999;

	case 33: // STATE 18
		;
		_m = unsend(now.signalE);
		;
		goto R999;

	case 34: // STATE 19
		;
		now.ControllerStateE = trpt->bup.oval;
		;
		goto R999;

	case 35: // STATE 25
		;
		p_restor(II);
		;
		;
		goto R999;
	}

