import bb.cascades 1.3

NavigationPane
{
    id: navigationPane
    
    onPopTransitionEnded: {
        deviceUtils.cleanUpAndDestroy(page);
    }
    
    Page
    {
        id: welcomePage
        
        keyListeners: [
            KeyListener {
                onKeyLongReleased: {
                    if (event.unicode == "x") {
                        user.points = user.points+300;
                    }
                }
            }
        ]
        
        actions: [
            ActionItem
            {
                property bool soundsLoaded: false
                ActionBar.placement: ActionBarPlacement.Signature
                imageSource: "images/menu/ic_start.png"
                enabled: (sound.muted || soundsLoaded) && user.profileSet
                title: qsTr("Start") + Retranslate.onLanguageChanged
                
                function onLoading(current, total)
                {
                    if (current == total) {
                        soundsLoaded = true;
                    }
                }
                
                onCreationCompleted: {
                    sound.loadProgress.connect(onLoading);
                }
                
                onTriggered: {
                    var x = definition.init("ExamPage.qml");
                    x.nextQuestion();
                    
                    navigationPane.push(x);
                }
            }
        ]
        
        titleBar: TitleBar
        {
            kind: TitleBarKind.FreeForm
            kindProperties: FreeFormTitleBarKindProperties
            {
                UserTitleBanner
                {
                    onBannerTapped: {
                        var p = definition.init("UserProfilePage.qml");
                        navigationPane.push(p);
                    }
                }
            }
        }
        
        Container
        {
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
            background: global.bgPaint
            
            PermissionToast
            {
                id: permissions
                horizontalAlignment: HorizontalAlignment.Right
                verticalAlignment: VerticalAlignment.Center
                
                function process()
                {
                    var allMessages = [];
                    var allIcons = [];
                    
                    if (allMessages.length > 0)
                    {
                        messages = allMessages;
                        icons = allIcons;
                        delegateActive = true;
                    }
                }
            }
        }
    }
    
    attachedObjects: [
        ComponentDefinition {
            id: definition
            
            function init(qml)
            {
                source = qml;
                return createObject();
            }
        }
    ]
}