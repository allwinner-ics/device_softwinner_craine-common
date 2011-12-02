/*
 * Copyright (C) 2011 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#ifndef HW_EMULATOR_CAMERA_EMULATED_FAKE_CAMERA_DEVICE_H
#define HW_EMULATOR_CAMERA_EMULATED_FAKE_CAMERA_DEVICE_H

/*
 * Contains declaration of a class V4L2CameraDevice that encapsulates
 * a fake camera device.
 */

#include "Converters.h"
#include "V4L2Camera.h"

namespace android {

class CameraHardwareDevice;

/* Encapsulates a fake camera device.
 * Fake camera device emulates a camera device by providing frames containing
 * a black and white checker board, moving diagonally towards the 0,0 corner.
 * There is also a green, or red square that bounces inside the frame, changing
 * its color when bouncing off the 0,0 corner.
 */
class V4L2CameraDevice : public V4L2Camera {
public:
    /* Constructs V4L2CameraDevice instance. */
    explicit V4L2CameraDevice(CameraHardwareDevice* camera_hal, int id);

    /* Destructs V4L2CameraDevice instance. */
    ~V4L2CameraDevice();

    /***************************************************************************
     * V4L2Camera device abstract interface implementation.
     * See declarations of these methods in V4L2Camera class for
     * information on each of these methods.
     **************************************************************************/

public:
    /* Connects to the camera device.
     * Since there is no real device to connect to, this method does nothing,
     * but changes the state.
     */
    status_t connectDevice();

    /* Disconnects from the camera device.
     * Since there is no real device to disconnect from, this method does
     * nothing, but changes the state.
     */
    status_t disconnectDevice();

    /* Starts the camera device. */
    status_t startDevice(int width, int height, uint32_t pix_fmt);

    /* Stops the camera device. */
    status_t stopDevice();

    /* Gets current preview fame into provided buffer. */
    status_t getPreviewFrame(void* buffer);

    /***************************************************************************
     * Worker thread management overrides.
     * See declarations of these methods in V4L2Camera class for
     * information on each of these methods.
     **************************************************************************/

protected:
    /* Implementation of the worker thread routine.
     * This method simply sleeps for a period of time defined by the FPS property
     * of the fake camera (simulating frame frequency), and then calls emulated
     * camera's onNextFrameAvailable method.
     */
    bool inWorkerThread();

    /****************************************************************************
     * Fake camera device data members
     ***************************************************************************/

private:
    /* Emulated FPS (frames per second).
     * We will emulate 50 FPS. */
    static const int        mEmulatedFPS = 15;

    /* Defines time (in nanoseconds) between redrawing the checker board.
     * We will redraw the checker board every 15 milliseconds. */
    static const nsecs_t    mRedrawAfter = 15000000LL;

	// -------------------------------------------------------------------------
	// extended interfaces here <***** star *****>
	// -------------------------------------------------------------------------

public:

	virtual status_t Initialize();
	int setV4L2DeviceName(char * pname);			// set device node name, such as "/dev/video0"
	int setV4L2DeviceID(int device_id);				// set different device id on the same CSI
	int tryFmtSize(int * width, int * height);		// check if driver support this size
	int getFrameRate();								// get v4l2 device current frame rate

	int setImageEffect(int effect);
	int setWhiteBalance(int wb);
	int setExposure(int exp);
	int setFlashMode(int mode);
	
	void releasePreviewFrame(int index);			// Q buffer for encoder
	
private:
	int openCameraDev();
	void closeCameraDev();
	int v4l2SetVideoParams(int width, int height, uint32_t pix_fmt);
	int v4l2ReqBufs();
	int v4l2QueryBuf();
	int v4l2StartStreaming(); 
	int v4l2StopStreaming(); 
	int v4l2UnmapBuf();
	
	int getPreviewFrame(v4l2_buffer *buf);

	// camera id
	int mCameraID;
	
	// v4l2 device handle
	int mCamFd; 

	// device node name
	char mDeviceName[16];

	// device id on the CSI, used when two camera device shared with one CSI
	int mDeviceID;

	typedef struct v4l2_mem_map_t{
		void *	mem[NB_BUFFER]; 
		int 	length;
	}v4l2_mem_map_t;
	v4l2_mem_map_t mMapMem;

	// use MetaData buffer mode for HW encoder and HW preview
	bool mUseMetaDataBufferMode;
};

}; /* namespace android */

#endif  /* HW_EMULATOR_CAMERA_EMULATED_FAKE_CAMERA_DEVICE_H */
