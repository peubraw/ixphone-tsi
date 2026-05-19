import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Basic as Control

import Linphone
import 'qrc:/qt/qml/Linphone/view/Style/buttonStyle.js' as ButtonStyle
import "qrc:/qt/qml/Linphone/view/Control/Tool/Helper/utils.js" as Utils

LoginLayout {
    id: mainItem
    signal startButtonPressed()

    titleContent: [
        Text {
            id: welcome
            text: applicationName
            Layout.alignment: Qt.AlignVCenter
            Layout.leftMargin: Utils.getSizeWithScreenRatio(132)
            color: DefaultStyle.main1_500_main
            font {
                pixelSize: Utils.getSizeWithScreenRatio(96)
                weight: Typography.h4.weight
            }
            scaleLettersFactor: 1.1
        },
        Text {
            Layout.alignment: Qt.AlignBottom
            Layout.leftMargin: Utils.getSizeWithScreenRatio(29)
            Layout.bottomMargin: Utils.getSizeWithScreenRatio(19)
            color: DefaultStyle.main2_800
            text: qsTr("Softphone corporativo")
            font {
                pixelSize: Typography.h1.pixelSize
                weight: Typography.h1.weight
            }
            scaleLettersFactor: 1.1
        },
        Item {
            Layout.fillWidth: true
        }
    ]
    centerContent: ColumnLayout {
        spacing: Utils.getSizeWithScreenRatio(76)
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: Utils.getSizeWithScreenRatio(308)
        anchors.topMargin: Utils.getSizeWithScreenRatio(166)

        RowLayout {
            id: carouselLayout
            spacing: Utils.getSizeWithScreenRatio(76)
            Image {
                id: carouselImg
                Layout.preferredWidth: Utils.getSizeWithScreenRatio(153)
                Layout.preferredHeight: Utils.getSizeWithScreenRatio(156)
                fillMode: Image.PreserveAspectFit
                source: AppIcons.ixphoneLogo
            }
            ColumnLayout {
                spacing: Utils.getSizeWithScreenRatio(10)
                Layout.leftMargin: Utils.getSizeWithScreenRatio(76)
                Text {
                    text: applicationName
                    textFormat: Text.RichText
                    font {
                        pixelSize: Typography.h2.pixelSize
                        weight: Typography.h2.weight
                    }
                    color: DefaultStyle.main1_500_main
                }
                Text {
                    Layout.maximumWidth: Utils.getSizeWithScreenRatio(361)
                    wrapMode: Text.WordWrap
                    textFormat: Text.RichText
                    font {
                        pixelSize: Typography.p1.pixelSize
                        weight: Typography.p1.weight
                    }
                    //: "Softphone corporativo seguro e confiavel."
                    text: qsTr("welcome_page_1_message")
                }
            }
        }

        BigButton {
            Layout.leftMargin: Utils.getSizeWithScreenRatio(509)
            style: ButtonStyle.main
            //: "Comecar"
            text: qsTr("start")
            onClicked: {
                mainItem.startButtonPressed()
            }
        }
    }
}