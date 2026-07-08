import QtQuick
import QtQuick.Controls

Rectangle {
    id: root
    color: "#1e1e2e"

    // ─── Catppuccin Mocha ───
    readonly property color cBase:     "#1e1e2e"
    readonly property color cMantle:   "#181825"
    readonly property color cText:     "#cdd6f4"
    readonly property color cSubtext:  "#a6adc8"
    readonly property color cOverlay:  "#6c7086"
    readonly property color cSurface1: "#45475a"
    readonly property color cAccent:   "#cba6f7"
    readonly property color cAccent2:  "#b4befe"
    readonly property color cRed:      "#f38ba8"
    readonly property color cYellow:   "#f9e2af"

    property bool loginFailed: false

    function doLogin() {
        loginFailed = false
        sddm.login(userField.text, passwordField.text, sessionCombo.currentIndex)
    }

    Connections {
        target: sddm
        function onLoginFailed() {
            loginFailed = true
            passwordField.text = ""
            passwordField.forceActiveFocus()
        }
    }

    // ─── Clock ───
    Text {
        id: clock
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -220
        color: root.cText
        font.family: "CaskaydiaCove Nerd Font"
        font.bold: true
        font.pixelSize: 110
        text: Qt.formatTime(new Date(), "HH:mm")

        Timer {
            interval: 1000; running: true; repeat: true
            onTriggered: clock.text = Qt.formatTime(new Date(), "HH:mm")
        }
    }

    // ─── Date ───
    Text {
        id: dateLabel
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: clock.bottom
        anchors.topMargin: 6
        color: root.cAccent2
        font.family: "CaskaydiaCove Nerd Font"
        font.pixelSize: 24
        text: new Date().toLocaleDateString(Qt.locale("de_DE"), "dddd, d. MMMM yyyy")
    }

    // ─── Username ───
    TextField {
        id: userField
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -10
        width: 320
        horizontalAlignment: TextInput.AlignHCenter
        text: userModel.lastUser
        placeholderText: "Benutzer…"
        placeholderTextColor: root.cOverlay
        color: root.cSubtext
        font.family: "CaskaydiaCove Nerd Font"
        font.pixelSize: 18
        background: null
        onAccepted: passwordField.forceActiveFocus()
    }

    // ─── Password field ───
    TextField {
        id: passwordField
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: 60
        width: 320
        height: 55
        horizontalAlignment: TextInput.AlignHCenter
        echoMode: TextInput.Password
        passwordCharacter: "•"
        color: root.cText
        font.family: "CaskaydiaCove Nerd Font"
        font.pixelSize: 20
        placeholderText: "Passwort…"
        placeholderTextColor: root.cOverlay
        background: Rectangle {
            color: root.cBase
            radius: 14
            border.width: 2
            border.color: root.loginFailed ? root.cRed
                        : passwordField.activeFocus ? root.cAccent
                        : root.cSurface1
        }
        onTextEdited: root.loginFailed = false
        onAccepted: root.doLogin()
        Component.onCompleted: forceActiveFocus()
    }

    // ─── Error message ───
    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: passwordField.bottom
        anchors.topMargin: 14
        visible: root.loginFailed
        color: root.cRed
        font.family: "CaskaydiaCove Nerd Font"
        font.italic: true
        font.pixelSize: 16
        text: "Falsch"
    }

    // ─── Session picker (bottom left) ───
    ComboBox {
        id: sessionCombo
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.margins: 28
        width: 190
        height: 36
        model: sessionModel
        currentIndex: sessionModel.lastIndex
        textRole: "name"

        contentItem: Text {
            leftPadding: 12
            verticalAlignment: Text.AlignVCenter
            color: root.cSubtext
            font.family: "CaskaydiaCove Nerd Font"
            font.pixelSize: 14
            text: sessionCombo.displayText
        }
        indicator: Text {
            x: sessionCombo.width - width - 10
            anchors.verticalCenter: parent.verticalCenter
            color: root.cOverlay
            font.pixelSize: 12
            text: "▾"
        }
        background: Rectangle {
            color: root.cMantle
            radius: 10
            border.width: 1
            border.color: sessionCombo.pressed || sessionCombo.popup.visible
                          ? root.cAccent : root.cSurface1
        }
        delegate: ItemDelegate {
            required property var model
            required property int index
            width: sessionCombo.width
            height: 34
            contentItem: Text {
                verticalAlignment: Text.AlignVCenter
                color: sessionCombo.currentIndex === index ? root.cAccent : root.cSubtext
                font.family: "CaskaydiaCove Nerd Font"
                font.pixelSize: 14
                text: model.name
            }
            background: Rectangle {
                color: parent.hovered ? root.cSurface1 : root.cMantle
            }
        }
        popup: Popup {
            y: -implicitHeight - 6
            width: sessionCombo.width
            implicitHeight: contentItem.implicitHeight + 12
            padding: 6
            contentItem: ListView {
                clip: true
                implicitHeight: contentHeight
                model: sessionCombo.popup.visible ? sessionCombo.delegateModel : null
            }
            background: Rectangle {
                color: root.cMantle
                radius: 10
                border.width: 1
                border.color: root.cSurface1
            }
        }
    }

    // ─── Power (bottom right) ───
    Row {
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 28
        spacing: 22

        Text {
            visible: sddm.canReboot
            color: rebootArea.containsMouse ? root.cAccent : root.cOverlay
            font.family: "CaskaydiaCove Nerd Font"
            font.pixelSize: 15
            text: "Neustart"
            MouseArea {
                id: rebootArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: sddm.reboot()
            }
        }
        Text {
            visible: sddm.canPowerOff
            color: powerArea.containsMouse ? root.cRed : root.cOverlay
            font.family: "CaskaydiaCove Nerd Font"
            font.pixelSize: 15
            text: "Ausschalten"
            MouseArea {
                id: powerArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: sddm.powerOff()
            }
        }
    }
}
