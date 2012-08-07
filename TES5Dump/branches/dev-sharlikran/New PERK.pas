  wbRecord(PERK, 'Perk', [
    wbEDIDReq,
    wbVMAD,
    wbFULL,
    wbDESCReq,
    wbICON,
    wbCTDAs,
//    wbUnknown(DATA),
    wbStruct(DATA, 'Data', [
//      wbInteger('IsTrait', itU8, wbEnum(['False', 'True'])),
      wbByteArray('IsTrait', 1),
//      wbInteger('Level', itU8),
      wbByteArray('Level', 1),
      wbInteger('NumRanks', itU8),
      wbInteger('IsPlayable', itU8, wbEnum(['False', 'True'])),
      wbInteger('IsHidden', itU8, wbEnum(['False', 'True']))
    ], cpNormal, True{, nil, 4}),
    wbFormIDCK(NNAM, 'Next Perk', [PERK,NULL]),
    wbRArray('The Array', wbRStruct('Unknown', [ // Array PRKE to PRKF
      wbStructSK(PRKE, [1, 2, 0], 'Header', [
        wbInteger('Type', itU8, wbEnum([
          'Quest + Stage',
          'Ability',
          'Entry Point'
        ]), cpNormal, False, nil, wbPERKPRKETypeAfterSet),
        wbInteger('Rank', itU8),
        wbInteger('Priority', itU8)
      ]),
//      wbUnknown(PRKE),
//      wbUnknown(DATA),
      wbUnion(DATA, 'Effect Data', wbPerkDATADecider, [
        wbStructSK([0, 1], 'Quest + Stage', [
          wbFormIDCk('Quest', [QUST]),
          wbInteger('Quest Stage', itS8, wbPerkDATAQuestStageToStr, wbCTDAParam2QuestStageToInt),
          wbByteArray('Unused', 3)
        ]),
        wbFormIDCk('Ability', [SPEL]),
        wbStructSK([0, 1], 'Entry Point', [
          wbInteger('Entry Point', itU8, wbEnum([
           {00} 'Calculate Weapon Damage',
           {01} 'Calculate My Critical Hit Chance',
           {02} 'Calculate My Critical Hit Damage',
           {03} 'Calculate Weapon Attack AP Cost',
           {04} 'Calculate Mine Explode Chance',
           {05} 'Adjust Range Penalty',
           {06} 'Adjust Limb Damage',
           {07} 'Calculate Weapon Range',
           {08} 'Calculate To Hit Chance',
           {09} 'Adjust Experience Points',
           {10} 'Adjust Gained Skill Points',
           {11} 'Adjust Book Skill Points',
           {12} 'Modify Recovered Health',
           {13} 'Calculate Inventory AP Cost',
           {14} 'Get Disposition',
           {15} 'Get Should Attack',
           {16} 'Get Should Assist',
           {17} 'Calculate Buy Price',
           {18} 'Get Bad Karma',
           {19} 'Get Good Karma',
           {20} 'Ignore Locked Terminal',
           {21} 'Add Leveled List On Death',
           {22} 'Get Max Carry Weight',
           {23} 'Modify Addiction Chance',
           {24} 'Modify Addiction Duration',
           {25} 'Modify Positive Chem Duration',
           {26} 'Adjust Drinking Radiation',
           {27} 'Activate',
           {28} 'Mysterious Stranger',
           {29} 'Has Paralyzing Palm',
           {30} 'Hacking Science Bonus',
           {31} 'Ignore Running During Detection',
           {32} 'Ignore Broken Lock',
           {33} 'Has Concentrated Fire',
           {34} 'Calculate Gun Spread',
           {35} 'Player Kill AP Reward',
           {36} 'Modify Enemy Critical Hit Chance',
           {37} 'Reload Speed',
           {38} 'Equip Speed',
           {39} 'Action Point Regen',
           {40} 'Action Point Cost',
           {41} 'Miss Fortune',
           {42} 'Modify Run Speed',
           {43} 'Modify Attack Speed',
           {44} 'Modify Radiation Consumed',
           {45} 'Has Pip Hacker',
           {46} 'Has Meltdown',
           {47} 'See Enemy Health',
           {48} 'Has Jury Rigging',
           {49} 'Modify Threat Range',
           {50} 'Modify Thread',
           {51} 'Has Fast Travel Always',
           {52} 'Knockdown Chance',
           {53} 'Modify Weapon Strength Req',
           {54} 'Modify Aiming Move Speed',
           {55} 'Modify Light Items',
           {56} 'Modify Damage Threshold (defender)',
           {57} 'Modify Chance for Ammo Item',
           {58} 'Modify Damage Threshold (attacker)',
           {59} 'Modify Throwing Velocity',
           {60} 'Chance for Item on Fire',
           {61} 'Has Unarmed Forward Power Attack',
           {62} 'Has Unarmed Back Power Attack',
           {63} 'Has Unarmed Crouched Power Attack',
           {64} 'Has Unarmed Counter Attack',
           {65} 'Has Unarmed Left Power Attack',
           {66} 'Has Unarmed Right Power Attack',
           {67} 'VATS HelperChance',
           {68} 'Modify Item Damage',
           {69} 'Has Improved Detection',
           {70} 'Has Improved Spotting',
           {71} 'Has Improved Item Detection',
           {72} 'Adjust Explosion Radius',
           {73} 'Reserved'
          ]), cpNormal, True, nil, wbPERKEntryPointAfterSet),
          wbInteger('Function', itU8, wbPerkDATAFunctionToStr, wbPerkDATAFunctionToInt, cpNormal, False, nil, wbPerkDATAFunctionAfterSet),
          wbInteger('Perk Condition Tab Count', itU8, nil, cpIgnore)
        ])
      ], cpNormal, True),

      wbRArray('The Array', wbRStruct('Unknown', [ // Array PRKC and CTDA
        // This was originally not part of an array
        wbRStructsSK('Perk Conditions', 'Perk Condition', [0], [
          wbInteger(PRKC, 'Run On', itS8, wbPRKCToStr, wbPRKCToInt),
          wbCTDAsReq
        ], [], cpNormal, False, nil, nil, wbPERKPRKCDontShow)
//        wbUnknown(PRKC),
//        wbCTDAs
      ], [])),
      wbRStruct('Entry Point Function Parameters', [
        wbInteger(EPFT, 'Type', itU8, wbPerkEPFTToStr, wbPerkEPFTToInt, cpIgnore, False, nil, wbPerkEPFTAfterSet),
        wbString(EPF2, 'Button Label', 0, cpNormal, False, wbEPF2DontShow),
        wbInteger(EPF3, 'Script Flags', itU16, wbFlags([
          'Run Immediately'
        ]), cpNormal, False, False, wbEPF2DontShow),
        wbUnion(EPFD, 'Data', wbEPFDDecider, [
          wbByteArray('Unknown'),
          wbFloat('Float'),
          wbStruct('Float, Float', [
            wbFloat('Float 1'),
            wbFloat('Float 2')
          ]),
          wbFormIDCk('Leveled Item', [LVLI]),
          wbEmpty('None (Script)'),
          wbStruct('Actor Value, Float', [
            wbInteger('Actor Value', itU32, wbEPFDActorValueToStr, wbEPFDActorValueToInt),
            wbFloat('Float')
          ])
        ], cpNormal, False, wbEPFDDontShow)
//        wbEmbeddedScriptPerk
      ], [], cpNormal, False, wbPERKPRKCDontShow),
      wbEmpty(PRKF, 'End Marker', cpIgnore, True)
    ], [])
//      wbUnknown(EPFT),
//      wbUnknown(EPF2),
//      wbUnknown(EPF3),
//      wbUnknown(EPFD),
//      wbUnknown(PRKF)
    ], []))
  ]);

