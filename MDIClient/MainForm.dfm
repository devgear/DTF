object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Devgear Training Framework - MDI Client'
  ClientHeight = 501
  ClientWidth = 749
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 185
    Top = 0
    Height = 480
    MinSize = 185
    ResizeStyle = rsLine
    ExplicitLeft = 384
    ExplicitTop = 232
    ExplicitHeight = 100
  end
  object MDITabSet: TTabSet
    Left = 0
    Top = 480
    Width = 749
    Height = 21
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    OnMouseUp = MDITabSetMouseUp
  end
  object pnlMenu: TPanel
    Left = 0
    Top = 0
    Width = 185
    Height = 480
    Align = alLeft
    BevelOuter = bvNone
    Constraints.MinWidth = 185
    TabOrder = 1
    object pnlMenuTop: TPanel
      Left = 0
      Top = 0
      Width = 185
      Height = 232
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object pnlShortCut: TPanel
        Left = 0
        Top = 0
        Width = 185
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        DesignSize = (
          185
          41)
        object edtShortCut: TEdit
          Left = 8
          Top = 11
          Width = 165
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
          TextHint = #48148#47196#44032#44592
        end
      end
      object lstFavorites: TListView
        Left = 0
        Top = 41
        Width = 185
        Height = 191
        Align = alClient
        Columns = <>
        TabOrder = 1
      end
    end
    object trvMenus: TTreeView
      Left = 0
      Top = 232
      Width = 185
      Height = 248
      Align = alClient
      Images = vilMenus
      Indent = 19
      ParentShowHint = False
      RowSelect = True
      ShowButtons = False
      ShowHint = True
      ShowRoot = False
      TabOrder = 1
    end
  end
  object MainMenu: TMainMenu
    Left = 216
    Top = 72
    object F1: TMenuItem
      Caption = #54028#51068'(&F)'
      object N2: TMenuItem
        Caption = #53580#49828#53944'('#52264#51068#46300' '#49373#49457')'
        OnClick = N2Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object X1: TMenuItem
        Caption = #51333#47308'(&X)'
      end
    end
    object N3: TMenuItem
      Caption = #53580#49828#53944
      OnClick = N3Click
    end
    object MDI1: TMenuItem
      Caption = #47700#45684
      OnClick = MDI1Click
    end
  end
  object pmnMDI: TPopupMenu
    Left = 368
    Top = 392
    object mnuMDIClose: TMenuItem
      Caption = #45803#44592'(&C)'
      OnClick = mnuMDICloseClick
    end
    object mnuMDICloseAll: TMenuItem
      Caption = #47784#46160' '#45803#44592'(&L)'
      OnClick = mnuMDICloseAllClick
    end
  end
  object vilMenus: TVirtualImageList
    DisabledGrayscale = False
    DisabledSuffix = '_Disabled'
    Images = <
      item
        CollectionIndex = 1
        CollectionName = 'icons8-sugar_cubes'
        Disabled = False
        Name = 'icons8-sugar_cubes'
      end
      item
        CollectionIndex = 0
        CollectionName = 'icons8-sugar_cube'
        Disabled = False
        Name = 'icons8-sugar_cube'
      end>
    ImageCollection = imcMenus
    Left = 88
    Top = 352
  end
  object imcMenus: TImageCollection
    Images = <
      item
        Name = 'icons8-sugar_cube'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D4948445200000060000000600806000000E29877
              3800000006624B474400FF00FF00FFA0BDA7930000047849444154789CED9C3B
              88554718C77F6E7C24BE92100346349E1891B885092A081AACB64861B0B2152B
              5BCBB429D3A64CAA25A595A0560AA6903C8A2488A2A28DE203498CA0C457F4BA
              16DF1984CBDE7BE73B337366CEB9DF0F0696DD3DF33DFEE7CC77E6CE9D01C330
              0CC3300CC3300CC3300CC3305A61496E0702D8041CAB7FFE1EB895D197A9E273
              E027E07F60A16E2F8193C09E8C7EF59A25C01C92E457BC49FC62ED3C7008782B
              8BA73D63397018B8C4F8A42FD6AE2343D43BAD7BDD03D601DF00B7D1277EB8FD
              0D7C077CD46A041DE553A4A03E263CF1C3ED19523B665B8BA643EC074E000374
              497D5837CD3583DAD6FE56222B9819E06BE017F477F35DE05BE07D600D32D6DF
              68D0CF9F488D599A34D2C2584D78C2962DD26F0C41DF8B1A6961AC47827C807E
              C83889BC86FAB20B19EF5F2A6D3D426AD0C74D832C91C5264E9AA2B93DC0F616
              24A1FF296D777E62A799380DB77BC893F241447FD622C3DE2DA52F0B746C6217
              3271BA001C05DE4EECDF21E0F706FE153DB10B99389D478A67DB1F0C7E49B327
              B4A889DD0EE007E009BA209E023F52C6A46816F1E529BA189E20B1EF68DFE537
              68EF7677F76CC8E1EC043E449EE23BE8E3CA8676FC5C99C74D152BD0D7B1C6CC
              845CECC90232393A8D3CB6A5F31CF1F70F32DFDD3E681ED301701CD896C5533F
              2A645C7F41CF86A0D285A86896F84E0A5092101561892F56004D402F8079606B
              8B7E6FAD6D6AFDEC8C0015FA3BAB8D2722D4AFCE08E0A8284388587E744E0047
              451E2162DBEDAC008E8A76844865A7F302382AD2242855BFA1F12623D4A18A38
              098BD54FEA78A313CBA1A6AF85F301D73579EDEDAD008E8A3813A35877FC30BD
              17C051114F8898AFB5532380A3A2B91029E613532780A3C25F889433EAA915C0
              E18AF528BBF3A4FD4C297ABCA10BE1A38CA75E60EF8DDD3656C48C3198009931
              0132630264C604C88C0990191320332640664C80CC980099310132630264C604
              C88C0990995402EC4CD46F4E8A8C69D402C52B6455EA9396EDA66023B21A376E
              D37736262D0F3E47364ABFDB92DD98AC46F62BFB6C40CC86EF02F97D6403DCF2
              C47663B014D9AF7C6F8C9D620438826E6FF055E06004BBA9127110F1D1379EDB
              480EB2B212B9BB35E7F6FC0AEC0DB0195B805DC0B931FD0EB7C7C876DB350136
              A3B30E19EF7DBFC3E30AF59606B66209E00AACEF415103E400912276C98FE233
              24B1BE77932BD49AB37A4205D01458D7CE2027BF748639E02FFC03FC1719CA56
              78F4DD548065E80BEC65E08047DF4532839C4E7213FF80AFD5D78CFBAE4D1301
              E6D0ED7EBF8388D589636A26D1A450FF06EC1BD19F4680DDC0CF0ABBAEC0AE6D
              166AD96C60F2ACD2A750FB08B0097D813D4ECF8E2B1BC576E4AC9EA6857A9C00
              AEC06A8E9F39037C9126D4B2F90AB8887FA2EE23A7AE8CFAFBB1FA7F7CFBBB58
              FB30D5CC20C7C3DCC53F71A1ED1F44ACA93A2F7412AE503F225DE27B5D6063A1
              2DD49A02BBB9C5383ACF2C708AF0E49F654A0B6C2CE690232DB589BF824CE88C
              08680AB515D884AC6274A1B602DB221B910D7983BACDD7BF335A6627857E5BC1
              300CC3300CC3300CC3300CA3405E03B5639F2CFCB29BBF0000000049454E44AE
              426082}
          end>
      end
      item
        Name = 'icons8-sugar_cubes'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D4948445200000060000000600806000000E29877
              3800000006624B474400FF00FF00FFA0BDA7930000063849444154789CED9D4F
              8855551CC73F4E8EA9336AEAA0D8943E65FEA863A911D8225CCD36A245204481
              1B095C046DB25DCB69570B893629810B2348180461DCA42EA2846C93B4108934
              9599CCC93173FEB6F89D8B8F37EFDD77CEEF9E7BEF9B37BF0F1C1CC6FBCEEFFB
              FBFDCEFD73CEF9DD376018866118866118866118866118ADCD5AE028F0A36B47
              DDEF8C9CD90D8C0013C0424D9B04BE040E94A6AE4D7916781B186371D01BB5AB
              C031A0AB04BD6D43DA68F76DC959B1BF60ED4B96EAD13E8F3EF076560432888C
              F671E206BD5E7B809D1500AC06DE052EA30BE43CF0BD6BDAB3E5B2D3B03A675F
              5B8ABDC067C07D7441BB0B7C0A0C54F539E07E7757D9E77DA7696F2E1EB71097
              D0056816380FBC0574A6F4DFE98E39EF3EA3B1752992AF2D4968306E21F7868A
              C2D6F3C047C00D85DDB625240817806D116C6E737D5902D05D7AC69047D39501
              763A8061E01B605A61B76DD15C9393761BB91CED4AE9BF17B9ECDCCC68AB6DC9
              1294A4CD2167C57BC01A6015F00632DAB537DED212B0A2486334766E0AE856F4
              37E1FEED517C36CD66D171298C46236E0DF92D41D4B66449625DCA316D8B8FC3
              03C027C0EF29C787B63BC0E7C0CB0A3D6D4588C3D54F324F523EDBA8553F4135
              9ABC5902F073782372D9F839A58FA45D479E84B6E6A867C912C3E14329FD1C2A
              414F265AE529285447ABF5A3A6A32843467D2C0125630928194B40C958024AC6
              1250329680922932016925832F14A6C2CF66DB943776206BF5CDCA0A678151E0
              35CF7EB3CC600F005FD37CA7EC2AB2E710B213D732AC073E40B733750559407B
              26A5FFD004240B7BA30A3DB791D5D9CDBECE97493FB2EC3B45B8A3B5ED0692C4
              7AA584BE09588D8CE25F23E8798C9C39FB82A392332B783ABAF2D84C994492FA
              6295CD6609D88A8CDA2C85BD59CFD2DCE9068E03BF11EEC03CE1C97A828CC083
              29C71C74C784EE1F68F42C38DF8FA3DB4E55B313A94EF84B21F82152183B44DC
              CB95B6FD87246C08E8737EFDADE8272983DF9D21AE4D390C7C875425840ABC01
              7C086CA8D3EF66E063A40AAEA8C0FF019C0036D5D1B3C169D554D4CDB9181D6E
              12CB60AE281DBD08BC89DF7CA3137807F84969CBA7FD001C21BDBE34A1C369BF
              A8B475C5C3863721861F21A76396A785D7816F8953E733039CC57F8E518F7D88
              4F8F026D47C3D7E019EA9FD65A2AC8A6BC36F867811D11F56C427C6CD9042C20
              B3DE5723D8DC81DCA41F07DAAF6ED3C84DB63F829E9790C110F2B4140D8DF3DA
              44EC444E774D516DA33687046F50A14713F896484068227621819FC968CF2711
              7B3CF464097C4B25A059228690CB44ACC25ADF448C02AFD4D11323F08525E004
              616F36CE03E79019EB7EE44927645E314BFA4DF00C61899C731AF63B4DE7080B
              FCB88B4169090099866B1211E2E834F0154F6FA6697AFADDB121F790503D49E0
              932588521390D085AC5EDE0970A4594BD67FFA147AB6234F51FF46D433812CF2
              D5CEE85B2201093112318504AF37829E2D48D02633E86914788D1E151A039A44
              3C4402DFECE53C8D9E1E2488218B6DCD029F454F10590CF82462125989DC5880
              9E7548F574DA5E816FE063E829CC40774A3FEB4AD093F6864CE8FABE5A8F6F15
              70A3CE967A5573E9FD585D50C958024AC6125032968092B104948C25A064B226
              600429435CAEAC4762903B69D3F57BC0FBF815B1669D40F501A753FA39CDE285
              BB3CF4AC447CBE97D2472133E1EA761DA984D6F4D38C0AFEBB65C9AED740BD8E
              22E819067EF1D0113501210B6A17905DAE7A840A4D46BC669B7286E66744889E
              21C2BE79EB4E8ADD609E034EE21F8819E00B6429B81A5F87B3043E24113E7AB6
              385F427C3FE962169D41C2EA74A69055C5E47B399B395C21BF8DF97A97A6343D
              AB9055DC070136C658FC8D2CB9300C5C0B10761329096CF4FF9A119F8C6CEDE7
              FA528E3942D8CB25D75C4C0AA503F9DEFE1845B5DA002668139855F72D178352
              E7536B910D8E2C5B7E3ECDE7E9A642FEB5450B488DE808E1FB18B9D2836C27C6
              AEEF0979AC4CA8904F22E690228118DF679A1B7BD0BD0C1723F0B55488978831
              96D837AE87DEA86306BE960AFA445C47DE075B9274206F29FE493981AFA5827F
              22C691C7D025F99E702D5DC88DFA1FCA097C2D151A2722B9C1B6E522632F700A
              B9514FBB9F4316CF62D3E7344C3B4DA7685C0CD656EC454A075B85ED2C833FDE
              6018866118866118866118C6B2E77F190C447EE7CF352B0000000049454E44AE
              426082}
          end>
      end
      item
        Name = 'icons8-bluestacks'
        SourceImages = <
          item
            Image.Data = {
              89504E470D0A1A0A0000000D4948445200000060000000600806000000E29877
              3800000006624B474400FF00FF00FFA0BDA793000007B449444154789CEDDD6B
              8C5D5515C0F1DF4CDBE9536C6D0BA2625183402988188D5AE20B4462204A3426
              463056514994A0A9EF0F066C8C128D222A2F158C88119FC4478D2D4AA258A83C
              A46AAD52E8CB37B4A5A50FA6C599F1C36AD329CEB967DF7BF7B9F7CE78FEC9FA
              D4B967ADBDCE39FBECBDD6DAABD4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4D4FCBF
              D0D76D0312988F73701A16E23938E2C0BF0D6233B6E01EDC89BBB1B7F3664E2C
              66E05DB80DFFC14813328895F8001675DAF0F1CE542CC5C39A737A23D984ABC4
              5B34A363231987BC047F91CFF163C95E2CC77BC454568329B854F3534D0EF907
              BE23A6BB67543CCE9EE438ACD179C78F25C3F803AEC0B90E7DE8272CE7E21169
              CED9804FE14C1C79E0F77DE2A97D253E885B9AB85E8A3C8E55587640C7F40A7C
              D015FA719978E2CA9C701F5E2B7DB93C098B85D3EE49D4912AFBF06B7C1267E3
              492D8DBECBCCC14F950F7617DE2D6E563B3C154BF05DEC48D0DBEC1B72073E2C
              F62A3DCF297840F9C06E57CD0A65325E81CBC5DB3194604BAAEC150B89810AEC
              CEC2F9D8A3FC23B84C4C239D602EDE28F608B996BFAB30AF43F627311D5F516E
              F83631D7779363F036DC2896A7ADDE847BF5C886EF78694BCCBB706C774C6CC8
              425C8CEFE321CDDD84ABBB60EF61BC198F2A37F41A117EE875FAC40DB90837E1
              6F1A8F6B082776C3D069C2A9658EDF83B776C3C08CBC003F503CC6CF74DAA0E3
              C5BABDCCF9EB7072A78DAB901B147F903BC60562ED5EE6FC6F6256270DEB000B
              8C3DD6AD9D503E53F113305AF6E2C24E18D405661B7BCC0F57ADF864FCA940F9
              68F9B3D8844D4426E13A638F7B4D958A2F144F7599F36F324E632609CCC50AC5
              63FF62154A27ABA71C783E362A1EFF309E975BE980D89494397FAD899D8B5DA2
              FCEDFF4D158ABF50A27404D7EB916D78054CC7D794FB604464F78ECBA9FC048D
              A387BB44C06DA2B200BF95E6FC8372594E03AE68A0E8419C9453598FF17AADE5
              1256E734E28F054A6E13AB8189C864114E6835ABB623A73145BBDC89EAFCA7E1
              575A73FC4119CC6950D10D383DA7921EE10CFC5B7BCE1F11E592D9B8AB40C9A0
              F8D8CCCEA9AC4BF4E3E3F2D527ADC869DCD212653B44B5C0D139957690F9F8B9
              3C8E3F28EFCF69E04C519B53A6741FBE2E96ADE385C5F8ABBCCEDF8627E736F4
              F2260C18C2B74416A957E9136FF67E799D3F22A201598B0B4ED5DADC38849BF5
              5E6862367E28BFE347CB9B721A7C439BC60CE17B2A0850B5C06962F358A5F347
              C478B3B1319351C3F8369E9BD3B826B8088F95D8984B36E5343CB7D18F8B7AA1
              63721AD98059223791CBFE0DA2247129FE59F0378FE51C40EEBACAD1467E5EB5
              B5952749CBDCA5CA8D0E4F329D5EF077BB730EE21719073096ECC227E4AFC9BF
              403822878D8F1ABB946656C1DFAFCF3990B7671A44996C15AFF5B436ED9D2572
              13B9ECBA5B717CFF5505BFB9B9CD311CC654F93EC429B205EF1011C966799178
              FA72D8318CCF29AE7AEE132732C7FAED5B5AB0BD218D12D055C93A915B9E9960
              DF7CE1AC5C1BAB8794170C7FACE0B7FFD2FE5B7C18E76418503BF208AEC4ABC5
              11A57E71D86301CE13150829B5A8A9B252795CEB62C5B9823D32171C17D540FE
              589C42395138A1536BECAA643F3EA2F1C99C69E261284BD45C97E0D7648AEAE5
              9F988A7CA6F8F875E3C869BB723F5E58E28745E22465CAF536965CAB298AE6D5
              A2B979A1EA632D39E5AB1AD7ACF6E1BD9A7BC3F735B85ED314B50E7869C9EF5E
              2CF2C6DD7670916CC31B4AC670247ED2C2B5B36EC4961728B953DA018BB3C5D1
              9D6E3B7CB4FC52F9E9F8D7280E3594C97D097E49E6BC068A56484B3EF48B9333
              B9D6E8ADCA3E11C769F4A19D2A96B4ED9C33BE26C127C9F48BE85E91B24DE229
              4F618AE8CDD0E87A55C96AE595DA8BA41D342993C589FE48E21411C12C53BA52
              C4DB531810E1E12D09D76D5776E37D1A67A9FA45CB83C10CFA6E49F441323F6A
              42F9903809B320F1DA0378A7EA92243F53BE297AB6F6EB800ECA261544775B69
              823188CFE229893A268BE8E5DA16748D25F78A8F6823FAC4CD4F395E95221B54
              D48728E53046916C17AF766A6CA40F2FC737349F87D82F7A519CA5BCC1C7B314
              07D25A91E50E7572C9CEFD190CDC2C9EF0661A700C88A77899984AD63BF436EE
              14E7756F1707A3CF97562A39497C0F72E5090671898A1B205E95C9D811FC4E04
              D5BAC122B177C93596B53A54687082FCF533B78A3E719D602EBE246D25972A57
              EB7013A746E1D776E7CE332AB2798A981EB667B4772B5E5791BDA52C91B72DD8
              685923529F397A470C88FCEDBACC36DE8AA767B0AF2D668B8AE8AA2A25B6E35A
              D15CA9D994E46C7C4879338D6665F0C075DBEDE0F53FB4F3E59E232A802F515D
              87C19DA22263B5F8783F282298BB4563A4B9384AECBECF14CDF572775F5923DE
              A6DF67BE6E368E10C1ADAAA6A66EC99038193A1EDAE92076BC97AA6E6AEAA46C
              C0CBB27AA783CCC3A7E5DBDE775286F1656955183DCF3CF146ECD47DC7A6C87A
              D52D87BB4AAFDF88FDE28DCD5AC7D38B1C250E7CE788B7E792557AEFF048E52C
              10E7C872364E6D56FE2EB272D9D7F5E38945A2A570276B88B6890DD5446D28D2
              12478B6F44CEFF35E389B247CCF3733A33A4F1C90C919DBA43BEA0DF667CD438
              69AEDD4B1C2BCE09ACD05C366E58C4E8AF141BA99E9FE3C7C37F63355534083C
              55D49ECE1541BADDA254709708113F20EA36B777C7CC9A9A9A9A9A9A9A9A9A9A
              9A9A9A9A9A9A9A9AC6FC17621C05BE907EA60C0000000049454E44AE426082}
          end>
      end>
    Left = 88
    Top = 288
  end
end