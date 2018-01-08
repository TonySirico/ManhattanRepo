//
//  RoundImageView.swift
//  Inaldo&Tony
//
//  Created by Davide Cifariello on 13/12/17.
//  Copyright © 2017 Antonio Sirica. All rights reserved.
//

import UIKit

@IBDesignable class RoundImageView: UIImageView {
    
    override init(image: UIImage?) {
        
        super.init(image: image)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        self.layer.borderWidth = 1.0
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.size.height/2
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
    }
    
}

/*
 xxoc;;ldxxddxxxdollllllooooooooooollllllllolllccc::lodoolcldxxolloooxxxkxxxxkkdl::::kWMMMMMMWWWWWWWWWWWWWKOOKOdoool:ld
 xxdl:;cdkkxxxxdoolllllllllooooooooollllllllollllcc::codolclloddodxxdddxddxdlllllcccckWMMMMWWWWWWWWWWWWWWWXO0KOxooolcld
 xxdlc:ldkOOOkkkdolllllllllooooooooolllooollooollllllcclollcccloodddoodddddocclloolllkNWWWNNWWMMMMMWWNNNWWXO0Kkdoodoclo
 xxdoccldkOOOOOkxolllllllllloooooooooolloooloooollllllccclllllooodddddxxkkkkdooddxddokNWWMWWWMMMMMWWWNNNWWXOOKOxooddlld
 xxxolcldkOO0OOkxollllllllllooooooooolloooolloooooollllllcllllloododdddxxkxxxxxxkkxxdONMWWMMMMMMWWWWWNXNWNKOOK0xooddlod
 xxxdlccokOO00OkxolllllllllllooooooooloooooollololllccllllcccccllllllllooodddddddddddkXNNNNWMMMMWNNNNNNNWNOxxO0kooddood
 dkxdlccoxOO0OOkxoc::ccccclllloooooooooooooolllcclccccccllccccccccclllclllloooolllloox0XNNWWMMMMMWXXNNWWWN0xxkOkooddood
 dkkdlccoxOOOOOkxoc;;;::ccllllooooooooooloolcccc:::::ccccccc::::::::ccccccccccc::cllld0XNWMMMMMMMWNXXXXNWN0kkkkxdlodood
 dkkxoccoxO0OOOkxoc;,,;:cclloooooooolllllllccllc:;;;;;:::::;;;;;::;;::::::::::;;:cccco0NNWWMMMMMMMWXKKKXNX0Okkkdocldolo
 oxkxolcoxO000OOxdl;,,;;:cloooollllllllllc::ccc:;,,,,;;;;;;;;;;;;;;;;::;;;;;;;;;:::;:lOXXXKXWMMMMMMWWNNNWX0Okkkxl:ldoll
 oxkxdllldk000OOkdl:;;;:::cloollllllllllc:;;;:;;,,,,,,,,,,;;;,,,,;;;;;;;;,,,,;;;;;:::cdkkOO0NMMMMMMWWWWNX0Okkkkxlcoxocl
 ldkkdolldk000OOkxo:;;;:ccclollllllcllcc;;,,,,,,''''''',,,,,,''',;;,,,,,,,,,,,,;;:::cclloOXNWMWXKKXXXNWN0kxxkkkdoldxocl
 coxkxolldkO000Okxoc;;::ccccllcclccccc:;;,'''''......''''''''''',,''''''''''',,;;::::::ldKWWWWXOxx0NNNX0kddxkkxolcdxocl
 coxkxolldkO000Okxoc:::cccccccccccc::;,,'''''.................'''........'''',;:;::;;:ox0NWWWN0xdkKKOxxOOxxxxxxxdoxkocl
 :lxkxdlloxOOOOOOxdl:::cc:ccc:::::::,''..................................''',;;;;;;;;oxOOOO0XX0OkkOkoox0Okkkxxkkdodxlco
 ;ldkxdoooxkOkkOkxdl:;::c:;;::;,,,;;,'..................................'',',,;;;;;;;cooolokXWWXOdoododxkxxxxxdl:cdxlcl
 ;cdxxdolodxxxxxxxol:;;;::;,,,,''''''......................................''''.....',,,,:lx0K0dlcloox0XKkxxxoc;:cdxoco
 ;:ldxoc:clddddoddoc:;;,,;;,'''..........................................................'',:c:clodkxkKNN0kkxl:cloxxolo
 ;;cllc:;;:lddooodolc:;,'',,'''..............................................................'':ldkOOxkXN0Okkdoddoxxold
 ,;cool:;;:clodooooolc:,''...''''............... ..............................................,cdkOOkOXKkxxdddxddkkxxk
 ,;coolc:;;::lodoollcc:;,'...............   ........  ...  ................................'''',:lodkk0X0kxxxxxkkkkkkxd
 ,,cool:;;,;;::cloolcc::;'................                     .................'',,,,;;;;;;,,,,;:cloxO0kkkkkkkOOkkkxdo
 ,;:looc;,,,;::;;:clcc::;,'................                  ..........................''''''''',,;::loodddxxxxkxxddolc
 ;;:lool:;,;;;;;,,;::::;;,,'...............           .......................................'''',,,;::clooddooooooolcc
 ;;;clolc:;;;;:;;,,,,;;,,',,,'''...............  ............................................''',,,;;;:cclllllccc:cc:::
 ,,,,;::::::::;;;,,''''''...................................''''''.......................'''',,,,;;;;;;::ccclllcc:ccc::
 ,,',,,;;;;;;,,,,'''...'.........'''...............'',,,;,,;;;;,,,,,,'.................'......''',,,;;;:::::::::::::::c
 ,,,',,;cc:;''....................''''''.......'',,;;;;;;:::cccc::::;,'''...........................''',;;;;;;;;;:cllll
 ,,,,,,;:llc:;,'................''',,,,,,,,;;;:::cllcccccccccccllollc:;;,,,''......''..................''''',,,,;;:::cl
 ,,,,;;;;clollc:,.............',;;;;::cccllooddxxkkkkkxdolllllllodddollc:::;;;,,,''''''''..................''''''',,,,;
 ,,,,;;;;clooolc;'..........',;:ccllooddxxkOOOOOO0OOOOOkxdollloodxkkxddddooolcccc:;;,,'''...................'''''''',,,
 ,,,,;;;;:clolc:;'..........;:lloddxxkOOO000000KKKK000OOkkxddddxxkOOkkkxxxxxxddoollcc:;,,''....................',;;;,,;
 ,,,,,;;;:cool:,'..........,coodxxkOOO0KK00KKKKKKKKKKKK000OkkxkkOO0OOOkkkkkkkxxdddollcc:;;,,'...................',;::;;
 ,,,,,;;;:clll:'..........,codxkkOOO000KKK000KKKKKKKKKK000OOOOOOO0000OOOOOkkkkxxxddolllcc::;,'..............',,'',,;:::
 ,,,,,,,;:clol:,..........:oxxkkOOOO00KKKKKKKKKXXXXXXXXXK00OOOOOO0000000OOOkkkkkxxddollllcc:;,'..............,;;;;;;:::
 ,,,,,,,;:lodol;.........'cdxkkOO0000KKXXXXKKKKXXXXXXXKKKK0KKKKKKKKKK00000OOOkkkkxxddoolllcc:;,..............',;:::::cl
 ,,,,,;;;:ldxdo:'........'cdkkkOO000KKKXXXXXXXXXXXXXXKK00OOO0000KKKK0000000OOOOkkxxdddoollcc::;'............,,,;:llc:cl
 ,,,,,,;;:ldxxxo:.... ...'cdkkOO000KKKKXXXXXXXXXXXXNNXXKKKKKKKKKXXXXKKKKK000OOOOkkxxdddoolcc::;'..   .......,:ccloddooo
 ,,,,,,,;;coxkkko;.     ..:dxkOO00KKKKKXXXNNXXXXXXXXXXKKKKKKKKKKKKXXXXKKKKK000OOkkxxdddoolcc::;'.      ....';::lodooddd
 ,,,,,,,,;coxkOOko,.    ..:dxkO00KKKKKXXXXXNNXXXXXXXXKK000KKKKKKKKKXXXKKKKK000OOOkxxxddoolcc::;..       ..;llcclloooodx
 ,,,',,,,;:lxkOOOkl'.    .cdxkO00KKKKKKKKKKXXXXXXXXXXK00KKKKKKKKKKXXXXKKKKK000OOkkxxxddoolccc:,.        .:dkxoodoodoodx
 ,,,'',,,;;cdxkOOOx:.    'cdxkO00KKKKKKKKKKKXXXXXXKXK000KKKKKK000KXXXKKKKK00OOkkkkkkxxdoolcc::,.       .:xOOOkkkxddoldx
 ','''',,,;codxkOOOd,.  .'lxxkOO0000000000000KK000000OOO00K000OOO0KK00000OOkkkkkkkkkkxdolcc::;,.      .,dO00000Okxdloxd
 '''''',,,;codxxkOOkl'  .,ldxxxxxxxxkkkkxxxxxkkkxxxxxxxxkO000OkxkOOkkkkkkkxxxxkkkkkkxxdollc::;,.     .'oOO0K00K0kdolodd
 ''''''',,,:ldxxkOOOxc...;odoolllcccllcccccccccc::cclloodkOOkxdoddddooooooooodddddoolllccc:::;,..    'okO000000KOdlooxk
 '''''',,,,:ldxxkOOOkdc..:ol:;,;;;,,,,,,,,'''...',;;:ccloxxxxdolcccc:;;,,;;::::::::;;;,,;;;;;;;'.   .ckOO00000000xdooxk
 '''''',,,,;codxxkOOkxo;,ldoc;,,,,,,,,'''........',;;:cldxxdolc::;,,''.....''',,,,,,,'....'',,;,....;dkOOO000K000Okxoxk
 ''''''''',;codxxkOOkxo:;oxxdolc:;;;;;,''......'',;:::coxkkdolc:;;;;,,'.......'''',,''.....'',;,...:dkkOOO00OOOO000Oxdd
 ''''''''',;codxxkOOOxo;;okkkxol:,'.'''.......,;,,:cccldk00kxdc:;;cc:,,;;,........'''',,,,,,,;;;'..lkkOOOOOOkkk0K0KKOxd
 ''''''''',;:ldxxxkkkxl;;okOOkxdl:,'';cc:'..',::::cllldk0XX0Okoc::cllc::cc;............',;;;;::;'..okOOOkkO00OOO0OO00Ox
 '''''''',,,;:loddddol:',lxO00Okxdlcccllcc:cccclllloodx0XNNX0Oxlccclloocccc;,'',,,'....';;:::::;'.'dkkOkkOOOOOOO00OO00k
 ''''''''',,;:cloooool;..cdk0000Okxddoooollllloooodddxk0XNNXKOxolllllloollllcc::;;;;,,;;::ccc::;..,dkkkkkkkkkOkO00OOOOO
 ''''''''',,;:cllooool;..;dkO0K00OOkkxxxddddddxxxxxxxkO0XNNK0Oxolooooooodooollllcccc::ccccccc::,..'xOkkkkOkkO000OOO0000
 '''''''',,,;;:ccloool:..,lxOO00000OOOkkkkkkkkkkkxxkkkO0XNXK0Oxollooooodddddddooooollllllllcc:;'..'dOkkkkkOkkOOOOOO0K00
 '''''''',,,,;:ccloool:'.':dxkO0000000OOOOOOOOOkkkkkkkO0XNX0OOxolooooodddxxxxxddddoooooooolcc:,...'dOkkkkkkkkkOOKK00000
 '''''''',,,,;:clloool:'..,ldxkOO00000000000OOOOOkkkkOO0XNX0Okdolllooddxxxxxkxxdddddooooollc:;'...,dOkxxkkxkkkkkOK0OkOO
 '''''',,,,,,;:clooool:'..':oodkOO0000000000000OOkkxkO0KXXX0Okxdolclldxxxxkkkkxxxxddddoollc:;,....cxOOkkkkkkkkkkkO0OOOO
 '''',,,,,''',;:cloooo:,...;cloxkkO0000KKKK0KK0OkxxkO0KKXXK0Okxdolcccodkkkkkkkkxxxxdddoolc::,.. .;dkOkkkkkkkkkkkkkkxxkk
 '',,,,'''''',:clllllc,....';lodxkO0KKKKKKKKKK0OkkkkO0KXXXK0OOkddllolloxkOOOOOkkxxdddoolcc;,'....cxkOkddddxxxxxxxxxxxkk
 ,,,,,''''''',;cll:;'.......,:coxkO0KKKKKKKKK00OOOOOO0KXXXKOOOkxdooxdoodkOOOOOOkxxdddolc:;,'... .cdxOOxxxxxxxxxddoooodx
 '''''''''''',;cc:,'........',;ldkO0KKKKKKKKKK00OOOkO00KXXKOOkkxdoodxdodkOO0OOOkkxxddolc:;'.....,ldxkOOkkkkkxxxxddddoox
 ''''''''''''',;;,'',,,... ...,cokO000KKKKKKKXKOkxxxkOO0KK0OkkxdolllllldO0000OOkkxxdolc:;,'... .,oddxxxxxxxxxxxxxxxxdod
 ''''''''''''.....',,;;,.. ...';ldkO00KKKKXKKXXKkollooxkkkkxxdoc:;;::clxO0000OOkkxxdolc:,'...  .':cloddxddxxxxxxxxxdooo
 '''''''''....'',;;;,,,'.......,coxOOO00KKKKKKK0ko:;,;clooollc;,'..';:lxOO00OOOkkxdoll:;'.... ..''',;;;coddddxxxxxxxxdd
 ''''''''''',,;;,,,''..........':ldxkxxkkkkkkkkxl;'..',:::::;,'......,codxxxxxxxxxdolc;'...   ..;;,''..':lddddddxddxxxx
 '''''',,,;;;,,''..............';cloollllllllll:'.....'',,,,,'........,:ccclllclllolc:,....   ..,;,..',;;;;cdxxxxxxxxdd
 ''',,,,,,,,'''''''',,;;;,......,:cc:;;;;;;;;;;'.........'''''.........',,,;;:;;;;;:;,....   ...',,'',,'','',cdxxxxkkkO
 ',,,,,,,,,,,,,,;;;;;;,,'........',;,,,,,,,;;;,'.........'''............','''',''''''.....  ....'''..',;;:;,'';oxdxxkk0
 ,,,,,,,,;;;;;;;;;,,''.......  ....,,;;;;;;;;;;,'''''',;;,,'''''.......''''..'''..........   .....'',;;;;;,,,''cxxxxxxk
 ,,,,,;;;;;;;;;,,'........ ..........'',;:cllc::::;;;;;:::;,,,,,,,,,'',,;;,,''''......       .....',,,,;,'''..,oxdddddx
 ,,;;;;;;;;,,''....       ..:oc'.  ....';clddddooollllllcllccc:c:::;;;:::::;'........        .....''''''..... .;clooxkO
 ;;;;;;;;,,'....    .......:xK0o'   ...';:lodxxddddddddddddddoollllccccccc:;'......          ..............   ...',;:ox
 ;;;;;,,,''....   .......':xKNN0:.  ....';:loddddoooddooooolllllllllccccc:;,'...             ............    .....'''',
 ;;;;,,'......   ........;d0NWWXx,. .....';:cclllccc::;;;;;,,,;;::::ccc:;,''...            .............    .......''''
 ;,,,'.............'....'cONWWWW0c.  .....',,;:ccc:;,'''''''''',,,;;;;,,'.....             .............   ....''....''
 ,'''...........''''....'oKWWWWWXx;.  ......',;c:;,''.....'''''''',,,,'......              ...........    .....'''...''
 ,'...........'''''''...,dKWWWWWN0dc'........',;,'''.'''.'''..'''''',,'.....         ... ...........      ......''....'
 ;,'.......'''',,,'''...:xXWWWWWWXOkd:.............'',,'.','...','.........        ................   ..........'''....
 ;;;,''..'',,,,,,,'....':dKWWWWWMWKOkxc'...........''''..'''...''.........        ...............   .............'.....
 ;;::;,,'',,,'',,''....',cONWWWWWWN0OOkd:'. ...........................          ..............   ..............'.''...
 :::::::;;,,''''''.....',;oKWWWWWWWXOxkkxo:'.........................           .............    ......''.......'.'''..
 ,;:::::::;;,,''''......',:kNWWWWWWWXkdxxxdl:,......................  ...  .  ............     .......''''......'''''..
 ..',;;::::::;,''.......'',o0WWWWWWWN0xoodddoc;.............  .....  .,:,...............      ......''''''........''''.
 ....',;;;;::::;;,'.'''..'':xXWWWWWWWNKkoloool:;,.....................cd:.............       ......''''.''''...........
 .......',;;;;;;::;,,,''.'',cONWWWWWWWNNKOkxdolcc:;,,,;:c::::;;,'....,dx;............       .....'''''..''''........'''
 ..........',,,;;;,,,,,''''',o0NWWWWWWWWWWWNXXXKKKK0OO00Okkxxxo:'...'lko'................ .............................
 '''..........',;;,,,,''''''':xKWWWWWWWWWWWWNNNNNNNNXXXXXK0OOxc'....:xx;................................'''''..........
 '''..''........'',;;;,,,,'''':kXWWWWWWWWWWWWNNNNNNNNNXXXK0kdc'....;xOl.............................''.',,,,,'.........
 ''''''''''........'ldl;'',,'',ckKNWWWWWWWWWWWNNNNNNNNXXK0x:,.....'oOx,.......................'''''''''',,,,,'.........
 '''''''''''''''''..:k0d'...',,;cxKXNWWWWWWWWNNNNNNNNNXK0xc'.....'cOOc......................'''''''''''',,,,''.........
 ''''''''''''''''''.'cOKd,..'cddolokKXNWWWWWNNNNNNNNNNX0kl,......,x0d'......................''''''''',,,,,'',,'........
 .''''''''''''''''''.'l0Kd'..,:loddoxOKNNWWNNNNNWWWNNX0kxl,.....'cOO:.....................''''''''',,,,,''.'''.........
 ''.''.....'''....'''';dK0c......,lddxOKXNWNWWWWWWWNX0kxxl,.....;x0d'....................''''''''',,,,,'..'''.''.......
 ,,,'''''.............':kKk;.''...,cddxk0XNWWWWWWWNXKOkkd:'....'c00c...................''''''''''''',''..''''',,'......
 ,,,,,,,,,''''''''''''.,lkkl,,,'..',cdddOKNWWWWWWNXK0OOko,''...,dKx,..................''''''''''''''''...''''',''......
 ,,,,,,,,,,,,,,,''',,'..;ldl,',,'''',codx0NWWWWWNNKK0OOxl,,'''':OKo'.................'',,'''''''''''....'''''''''......
 ,,,,,,,,,,,,,,,,''','...,cc;'''''',',:oxOXWWWWWNXKK0Okd;''''''l00c.................'''''''''''''......................
 ,,,,,,,,,,,,,,,,,'',,'..',;,''',,,,,,,cokKNWWWWNXK000kl,..''.,oKk;.................''''''..................''''''.....
 ,,,,,,,,,,,,,,,,,,,,,'...','.'',,,,,',;cx0NWWWNNXK00Od:'''''.,xKx,...................'''''''''''''''..'',,,,,,,,,'....
 ',,,,,,,,,,,,,,,,,,,,'...'''.',,,,,,',,:oOXWWWNXXK00Oo;,''.'':OXd'................''''''''''''''''''..',,,,,;;,,,,'...
 ,,,,,,,,,,,,,,,,,,,,,''...'...',,,,,,,,;lx0NWWNXK000kc,''...'c0Kl..............''',,,,,,'''''''''''..'',,,,,,,,,'''...
 '',,,,,,,,,,,,,,',,,,,'...'...'',,,,,,,,:dkKWWNXK0K0d;''''..'oK0:.............''',,,,,,,,,,''''',''..'',,,,,,,,,,,'...
 ''',,,,,,,,,',,'',,,,,''..'...',,,,,,,;;:ok0NWNXKKKOl;,'''..;xXk;..........''''',,,,,,,,,',,,,'''''''',,,,,,,,,,,,''..
 ,,'''''''','''''''''''''..'....',,,,,,,,;lxOKNNXKK0xc,'''''':OXd'........''''',,,,,,,,,,,,,,,,'''''',,,,,,,,,,,',''''.
 ;;,,,'''.'''''''''''''''.......'',,,,,,,,:dO0XNXKKOd:,''''',lKKl........'''',,,,,,,,''',,,,,,,'''',,,,,,,,,,,,''''''''

 
 */
