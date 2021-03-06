import QtQuick 2.8
import QtQuick.Controls 2.1

Popup {
	id: popup
	modal: true
	x: (parent.width-width)/2
	y: (parent.height-height)/2

	width: parent.width*3/4
	height: parent.height/2

    onOpened: rep.model = planManager.getAvailableColors(currentID)

	property int currentIndex
	property int planIndex
	property int currentColor
	property int currentID

	contentItem: Page {
		Flickable {
			anchors.fill: parent
			contentHeight: grid.implicitHeight

			Grid {
				id: grid
				spacing: 10
				width: parent.width

				Repeater {
					id: rep

					delegate: AbstractButton {

						onClicked: {
							popup.close()
                            programmer.changeColor(PlanManager.searchPlansIndex(currentID)
												   , parseInt(modelData))

							PlanManager.updateItem(currentIndex)
						}

						background: Rectangle {
							implicitWidth: 40
							implicitHeight: 40

							radius: width
							antialiasing: true
							border.color: "black"
							color: "transparent"
						}

						contentItem: Label {
							text: modelData
							verticalAlignment: Text.AlignVCenter
							horizontalAlignment: Text.AlignHCenter
						}
					}
				}
			}
		}

		footer: Button {
			text: "+"
			width: parent.width
			onClicked: {
                programmer.addColor(PlanManager.searchPlansIndex(currentID));
				rep.model = PlanManager.getAvailableColors(currentID);
			}
		}
	}
}
