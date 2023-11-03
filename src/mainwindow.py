import os
import shutil
import pydicom
import pydicom.errors

from PySide6.QtCore import QSize
from PySide6.QtWidgets import QApplication, QMainWindow, QPushButton, QVBoxLayout, QWidget, QFileDialog

DICOMDIR = '/Users/Ralph/Desktop/test'


class MainWindow(QMainWindow):
    def __init__(self) -> None:
        super(MainWindow, self).__init__()
        button = QPushButton('Open Directory...')
        button.clicked.connect(self.handlePushButtonClicked)
        buttonExit = QPushButton('Quit')
        buttonExit.clicked.connect(self.handlePushButtonExitClicked)
        layout = QVBoxLayout()
        layout.addWidget(button)
        layout.addWidget(buttonExit)
        widget = QWidget()
        widget.setLayout(layout)
        self.setFixedSize(QSize(250, 100))
        self.setWindowTitle('Add DICOM Extensions')

        self.setCentralWidget(widget)

    def handlePushButtonClicked(self):
        dirPath = QFileDialog.getExistingDirectory(self, 'Open Directory', DICOMDIR)
        if dirPath:
            for root, dirs, files in os.walk(dirPath):
                for f in files:
                    fileName = f
                    filePath = os.path.join(root, fileName)
                    try:
                        pydicom.dcmread(filePath, stop_before_pixels=True)
                        if not filePath.endswith('.dcm'):
                            shutil.move(filePath, filePath + '.dcm')
                            fileNameExt = fileName + '.dcm'
                            print(f'Added extension: {fileName} > {fileNameExt}')
                    except pydicom.errors.InvalidDicomError:
                        pass
            print('Finished')

    def handlePushButtonExitClicked(self):
        QApplication.exit()