  wbRecord(REFR, 'Placed Object', [
    wbEDID,
    wbVMAD,
    wbFormIDCk(NAME, 'Base', [TREE, SOUN, ACTI, DOOR, STAT, FURN, CONT, ARMO, AMMO, LVLN, LVLC,
                              MISC, WEAP, BOOK, KEYM, ALCH, LIGH, GRAS, ASPC, IDLM, ARMA, CHIP,
                              MSTT, NOTE, PWAT, SCOL, TACT, TERM, TXST, CCRD], False, cpNormal, True),

    {--- Bound Contents ---}
    {--- Bound Data ---}
    wbByteArray(XMBO, 'Bound Half Extents'),

    {--- Primitive ---}
    wbByteArray(XPRM, 'Primitive'),

    wbByteArray(XOCP, 'Occlusion Plane Data'),

    wbArray(XPOD, 'Portal Data', wbStruct('References', [
      wbFormIDCk('Origin', [REFR, NULL]),
      wbFormIDCk('Destination', [REFR, NULL])
    ])),

    wbRStruct('Room Data', [
      wbByteArray(XRMR, 'Header'),
      wbFormIDCk(LNAM, 'Lighting Template', [LGTM]),
      wbFormIDCk(INAM, 'Image Space', [IMGS]),
      wbRArrayS('Linked Rooms',
        wbFormIDCk(XLRM, 'Linked Room', [REFR])
      )
    ], []),
    wbByteArray(XMBP, 'MultiBound Primitive Marker'),

// XLCM XLRT DATA
    wbXLCM,
    wbArray(XLRT, 'Location Ref Type', wbFormIDCk('Ref', [LCRT, NULL])),
		
// XLRT XRGD XLKR      DATA

// XLRT      XLKR XSCL DATA

    wbXRGD,
    wbXRGB,
    wbFloat(XRDS, 'Radius'),

    {--- Reflected By / Refracted By ---}
    wbRArray('Reflected/Refracted By', wbRStruct('Data', [
      wbByteArray(XPWR, 'Water')
    ], [])),

    {--- Lit Water ---}
    wbRArrayS('Lit Water',
      wbFormIDCk(XLTW, 'Water', [REFR])
    ),

    {--- Emittance ---}
    wbFormIDCk(XEMI, 'Emittance', [LIGH, REGN]),
		wbUnknown(XLIG),
		wbUnknown(XALP),

    {--- Teleport ---}
    wbByteArray(XTEL, 'Teleport Destination'),
    wbFormIDCk(XTNM, 'Message Box', [MESG]),

    {--- MultiBound ---}
    wbFormIDCk(XMBR, 'MultiBound Reference', [REFR]),

		wbUnknown(XWCN),
		wbUnknown(XWCU),
		wbUnknown(XCVL),
		wbUnknown(XCZA),
		wbUnknown(XCZC),
    wbXESP,
		
    {--- Generated Data ---}
    wbByteArray(XNDP, 'Navigation Door Link'),
// XNDP XSCL DATA

// XESP XSCL DATA
    wbFormIDCk(XSPC, 'Ref?', [REFR]),

    {--- Activate Parents ---}
    wbRStruct('Activate Parents', [
      wbByteArray(XAPD, 'Flags'),
      wbRArrayS('Activate Parent Refs', wbRStruct('Data', [
				wbByteArray(XAPR, 'Activate Parent Ref')
      ], []))
    ], []),

    wbFormIDCk(XLIB, 'Leveled Item Base', [LVLI]),

    wbFormIDCk(XLCN, 'Persistent Location', [LCTN]),

    wbByteArray(XTRI, 'Collision Layer'),

    {--- Lock ---}
    wbByteArray(XLOC, 'Lock Data'),

    wbFormIDCk(XEZN, 'Encounter Zone', [ECZN]),


    wbByteArray(XIS2, 'Ignored by Sandbox'),

    wbRStruct('Ownership', [
      wbXOWN,
      wbByteArray(XRNK, 'Faction rank')
    ], []),

    wbByteArray(XCNT, 'Item Count'),
    wbUnknown(XLRL),

		// XLKR XPRD XPPA INAM PDTO
		wbRStruct('Data', [
			wbRArray('Linked References', wbStruct(XLKR, 'Linked Reference', [
				wbFormIDCk('Keyword', [KYWD, NULL]),
				wbFormIDCk('Ref', [REFR, ACRE, ACHR, PGRE, PMIS])
			])),
			wbRArray('Patrol', wbRStruct('Data', [
				wbByteArray(XPRD, 'Idle Time'),
				wbByteArray(XPPA, 'Patrol Script Marker'),
				wbFormIDCk(INAM, 'Idle', [IDLE, NULL]),
				wbUnknown(SCHR),
				wbUnknown(SCTX),
			], [])),
		], [])),
		// PDTO XLKR XSCL
		wbRStruct('Data', [
			wbUnknown(PDTO),
			wbRArray('Linked References', wbStruct(XLKR, 'Linked Reference', [
				wbFormIDCk('Keyword', [KYWD, NULL]),
				wbFormIDCk('Ref', [REFR, ACRE, ACHR, PGRE, PMIS])
			])),
		], [])),

    wbXSCL,

    {--- Flags ---}
    wbByteArray(XACT, 'Action Flag'),

    wbByteArray(XHTW, 'Head-Tracking Weight'),
    wbUnknown(XFVC),

    wbByteArray(ONAM, 'Open by Default'),

    {--- Map Data ---}
    wbRArray('Map', wbRStruct('Map Data', [
      wbByteArray(XMRK, 'Map Data Marker'),
      wbByteArray(FNAM, 'Flags'),
      wbFULLReq,
      wbByteArray(TNAM, 'Data')
    ], [])),

    wbDataPosRot
], wbAllowUnordered);

-------------------------------------------------------------------------
    {--- Bound Data ---}
    wbUnknown(XMBO),

    {--- Primitive ---}
    wbUnknown(XPRM),

    wbRStruct('Room Data', [
      wbUnknown(XRMR),
      wbUnknown(LNAM),
      wbUnknown(INAM),
      wbUnknown(XLRM)
    ], []),

// XLCM XLRT DATA
    wbRStruct('XLCM XLRT', [
      wbUnknown(XLCM),
      wbUnknown(XLRT)
    ], []),

// XLRT XRGD XLKR DATA
    wbRStruct('XLRT XRGD XLKR', [
      wbUnknown(XLRT),
      wbUnknown(XRGD),
      wbUnknown(XLKR)
    ], []),

// XLRT XLKR XSCL DATA
    wbRStruct('XLRT XLKR XSCL', [
      wbUnknown(XLRT),
      wbUnknown(XLKR),
      wbUnknown(XSCL)
    ], []),

    {--- Emittance ---}
//    wbUnknown(XEMI),
//		wbUnknown(XLIG),
//		wbUnknown(XALP),

    {--- Teleport ---}
//    wbByteArray(XTEL, 'Teleport Destination'),
//    wbFormIDCk(XTNM, 'Message Box', [MESG]),

    {--- MultiBound ---}
//    wbFormIDCk(XMBR, 'MultiBound Reference', [REFR]),

//		wbUnknown(XWCN),
//		wbUnknown(XWCU),
//		wbUnknown(XCVL),
//		wbUnknown(XCZA),
//		wbUnknown(XCZC),
//    wbXESP,

    {--- Generated Data ---}
// XNDP XSCL DATA
    wbRStruct('XNDP XSCL', [
      wbUnknown(XNDP),
      wbUnknown(XSCL)
    ], []),

// XESP XSCL DATA
    wbRStruct('XESP XSCL', [
      wbUnknown(XESP),
      wbUnknown(XSCL)
    ], []),

    {--- Activate Parents ---}
//    wbRStruct('Activate Parents', [
//      wbByteArray(XAPD, 'Flags'),
//      wbRArrayS('Activate Parent Refs', wbRStruct('Data', [
//				wbByteArray(XAPR, 'Activate Parent Ref')
//      ], []))
//    ], []),

//    wbFormIDCk(XLIB, 'Leveled Item Base', [LVLI]),

//    wbFormIDCk(XLCN, 'Persistent Location', [LCTN]),

//    wbByteArray(XTRI, 'Collision Layer'),

    {--- Lock ---}
//    wbByteArray(XLOC, 'Lock Data'),

//    wbFormIDCk(XEZN, 'Encounter Zone', [ECZN]),


//    wbByteArray(XIS2, 'Ignored by Sandbox'),

//    wbRStruct('Ownership', [
//      wbXOWN,
//      wbByteArray(XRNK, 'Faction rank')
//    ], []),

//    wbByteArray(XCNT, 'Item Count'),
//    wbUnknown(XLRL),

		// XLKR XPRD XPPA INAM PDTO
		wbRStruct('Data', [
				wbUnknown(XLKR),
				wbUnknown(XPRD),
				wbUnknown(XPPA),
				wbUnknown(INAM),
				wbUnknown(SCHR),
				wbUnknown(SCTX),
  			wbUnknown(PDTO)
		], []),
		// PDTO XLKR XSCL
		wbRStruct('Data', [
			wbUnknown(PDTO),
			wbUnknown(XLKR),
			wbUnknown(XSCL)
		], []),

//    wbXSCL,

    {--- Flags ---}
//    wbByteArray(XACT, 'Action Flag'),

//    wbByteArray(XHTW, 'Head-Tracking Weight'),
//    wbUnknown(XFVC),

//    wbByteArray(ONAM, 'Open by Default'),

    {--- Map Data ---}
//    wbRArray('Map', wbRStruct('Map Data', [
//      wbByteArray(XMRK, 'Map Data Marker'),
//      wbByteArray(FNAM, 'Flags'),
//      wbFULLReq,
//      wbByteArray(TNAM, 'Data')
//    ], [])),

    wbDataPosRot
