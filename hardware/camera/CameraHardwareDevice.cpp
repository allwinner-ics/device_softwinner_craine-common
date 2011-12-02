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

/*
 * Contains implementation of a class CameraHardwareDevice that encapsulates
 * functionality of a fake camera.
 */

#define LOG_NDEBUG 0
#define LOG_TAG "CameraHardwareDevice"
#include <cutils/log.h>
#include <cutils/properties.h>
#include "CameraHardwareDevice.h"
#include "HALCameraFactory.h"

#define F_LOG LOGV("%s, line: %d", __FUNCTION__, __LINE__);

namespace android {

CameraHardwareDevice::CameraHardwareDevice(int cameraId, struct hw_module_t* module)
        : CameraHardware(cameraId, module),
          mV4L2CameraDevice(NULL)
{
	F_LOG;
}

CameraHardwareDevice::~CameraHardwareDevice()
{
	F_LOG;
	if (mV4L2CameraDevice != NULL)
	{
		delete mV4L2CameraDevice;
		mV4L2CameraDevice = NULL;
	}
}

/****************************************************************************
 * Public API overrides
 ***************************************************************************/

status_t CameraHardwareDevice::Initialize()
{
	F_LOG;

	// instance V4L2CameraDevice object
	mV4L2CameraDevice = new V4L2CameraDevice(this, mCameraID);
	if (mV4L2CameraDevice == NULL)
	{
		LOGE("Failed to create V4L2Camera instance");
		return NO_MEMORY;
	}
	
    status_t res = mV4L2CameraDevice->Initialize();
    if (res != NO_ERROR) {
        return res;
    }

	// set v4l2 device name and device id
	// note: device id is not the same as camera id
	char * pDevice = mCameraConfig->cameraDevice();
	int deviceId = mCameraConfig->getDeviceID();
	mV4L2CameraDevice->setV4L2DeviceName(pDevice);
	mV4L2CameraDevice->setV4L2DeviceID(deviceId);

	if (mCameraID == 0)
	{
	    mParameters.set(CameraHardware::FACING_KEY, CameraHardware::FACING_BACK);
	    LOGD("%s: Fake camera is facing %s", __FUNCTION__, CameraHardware::FACING_BACK);
	}
	else
	{
	    mParameters.set(CameraHardware::FACING_KEY, CameraHardware::FACING_FRONT);
	    LOGD("%s: Fake camera is facing %s", __FUNCTION__, CameraHardware::FACING_FRONT);
	}

    mParameters.set(CameraHardware::ORIENTATION_KEY,
                    gEmulatedCameraFactory.getFakeCameraOrientation());

    res = CameraHardware::Initialize();
    if (res != NO_ERROR) {
        return res;
    }

    /*
     * Parameters provided by the camera device.
     */
#if 0
    mParameters.set(CameraParameters::KEY_SUPPORTED_PICTURE_SIZES, "640x480");
    mParameters.set(CameraParameters::KEY_SUPPORTED_PREVIEW_SIZES, "640x480");
    mParameters.setPreviewSize(640, 480);
    mParameters.setPictureSize(640, 480);
#endif
    return NO_ERROR;
}

V4L2CameraDevice* CameraHardwareDevice::getCameraDevice()
{
	F_LOG;
    return mV4L2CameraDevice;
}

void CameraHardwareDevice::releaseRecordingFrame(const void* opaque)
{
	mV4L2CameraDevice->releasePreviewFrame(*(int*)opaque);
}

};  /* namespace android */
