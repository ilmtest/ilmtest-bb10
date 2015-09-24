import bb.cascades 1.0

FullScreenDialog
{
    property variant statistics
    
    onStatisticsChanged: {
        if (statistics)
        {
            barParent.visible = true;
            for (var i = 0; i < statistics.length; i++)
            {
                var bar = barDefinition.createObject();
                var value = statistics[i].ratio;
                bar.preferredHeight = value*3;
                barContainer.add(bar);
                
                var stat = statsDefinition.createObject();
                stat.choice = statistics[i].value;
                stat.value = value;
                legend.add(stat);
            }
        }
    }
    
    dialogContent: Container
    {
        horizontalAlignment: HorizontalAlignment.Fill
        verticalAlignment: VerticalAlignment.Fill
        bottomPadding: 20; topPadding: 20; rightPadding: 20
        layout: DockLayout {}
        
        gestureHandlers: [
            TapHandler {
                onTapped: {
                    if (event.propagationPhase == PropagationPhase.AtTarget) {
                        dismiss();
                    }
                }
            }
        ]
        
        Container
        {
            id: legend
            horizontalAlignment: HorizontalAlignment.Right
            verticalAlignment: VerticalAlignment.Top
            
            attachedObjects: [
                ComponentDefinition
                {
                    id: statsDefinition
                    
                    Container
                    {
                        property alias image: imageView
                        property int value
                        property string choice
                        
                        layout: StackLayout {
                            orientation: LayoutOrientation.LeftToRight
                        }
                        
                        ImageView
                        {
                            id: imageView
                            imageSource: "images/bars/%1.png".arg( legend.count() )
                            preferredHeight: 20;
                            preferredWidth: 20
                            verticalAlignment: VerticalAlignment.Center
                        }
                        
                        Label {
                            text: "%1 (%2%)".arg(choice).arg(value)
                            verticalAlignment: VerticalAlignment.Center
                            textStyle.fontSize: FontSize.XXSmall
                            horizontalAlignment: HorizontalAlignment.Fill
                            textStyle.textAlign: TextAlign.Left
                        }
                        
                        onCreationCompleted: {
                            fader.play();
                        }
                        
                        animations: [
                            FadeTransition {
                                id: fader
                                fromOpacity: 0
                                duration: 500
                            }
                        ]
                    }
                }
            ]
        }
        
        Container
        {
            id: barParent
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Center
            visible: false
            
            Container
            {
                id: barContainer
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Fill
                
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                
                attachedObjects:
                [
                    ComponentDefinition
                    {
                        id: barDefinition
                        
                        ImageView
                        {
                            verticalAlignment: VerticalAlignment.Bottom
                            leftMargin: 40; rightMargin: 40
                            preferredWidth: 50
                            imageSource: "images/bars/%1.png".arg( barContainer.count() )
                            
                            onCreationCompleted: {
                                scaler.play();
                            }
                            
                            animations: [
                                ParallelAnimation
                                {
                                    id: scaler
                                    
                                    TranslateTransition {
                                        fromY: 200
                                        toY: 0
                                        duration: 500
                                    }
                                    
                                    ScaleTransition {
                                        fromY: 0
                                        toY: 1
                                        duration: 500
                                    }   
                                }
                            ]
                        }
                    }
                ]
            }
            
            Divider {
                id: divider
                topMargin: 0; bottomMargin: 0
                verticalAlignment: VerticalAlignment.Bottom
            }
        }
    }
}