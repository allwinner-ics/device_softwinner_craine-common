# full crane product config
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)

DEVICE_PACKAGE_OVERLAYS := device/softwinner/crane-common/overlay

PRODUCT_PACKAGES += \
	hwcomposer.sun4i \
	display.sun4i \
	lights.sun4i \
	gps.sun4i \
	make_ext4fs \
	libjni_pinyinime
	
PRODUCT_PACKAGES += \
	audio.primary.sun4i \
	audio.a2dp.default \
	libaudioutils \
	libcedarxbase \
	libcedarxosal \
        libcedarv \
        libswdrm \
	Camera \
	libjni_mosaic \
	FileExplore \
	u3gmonitor \
	chat
	
PRODUCT_PACKAGES += \
	e2fsck \
	libext2fs \
	libext2_blkid \
	libext2_uuid \
	libext2_profile \
	libext2_com_err \
	libext2_e2p

# init.rc, kernel
PRODUCT_COPY_FILES += \
	device/softwinner/crane-common/init.rc:root/init.rc

# keylayout
PRODUCT_COPY_FILES += \
	device/softwinner/crane-common/axp20-supplyer.kl:system/usr/keylayout/axp20-supplyer.kl

# bin tools
PRODUCT_COPY_FILES += \
	device/softwinner/crane-common/bin/fsck.exfat:system/bin/fsck.exfat \
	device/softwinner/crane-common/bin/mkfs.exfat:system/bin/mkfs.exfat \
	device/softwinner/crane-common/bin/mount.exfat:system/bin/mount.exfat \
	device/softwinner/crane-common/bin/ntfs-3g:system/bin/ntfs-3g \
	device/softwinner/crane-common/bin/ntfs-3g.probe:system/bin/ntfs-3g.probe \
	device/softwinner/crane-common/bin/mkntfs:system/bin/mkntfs \
	device/softwinner/crane-common/bin/busybox:system/bin/busybox
	
# gps conf
PRODUCT_COPY_FILES += \
	device/softwinner/crane-common/gps.conf:system/etc/gps.conf	

# wifi conf
PRODUCT_COPY_FILES += \
	device/softwinner/crane-common/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf 

# 3g dongle conf
PRODUCT_COPY_FILES += \
	device/softwinner/crane-common/rild/ip-down:system/etc/ppp/ip-down \
	device/softwinner/crane-common/rild/ip-up:system/etc/ppp/ip-up \
	device/softwinner/crane-common/rild/call-pppd:system/etc/ppp/call-pppd \
	device/softwinner/crane-common/rild/usb_modeswitch.sh:system/etc/usb_modeswitch.sh \
	device/softwinner/crane-common/rild/3g_dongle.cfg:system/etc/3g_dongle.cfg \
	device/softwinner/crane-common/rild/usb_modeswitch:system/bin/usb_modeswitch \
	device/softwinner/crane-common/rild/liballwinner-ril.so:system/lib/liballwinner-ril.so

PRODUCT_COPY_FILES += \
	$(call find-copy-subdir-files,*,device/softwinner/crane-common/rild/usb_modeswitch.d,system/etc/usb_modeswitch.d)

# mali lib so
PRODUCT_COPY_FILES += \
	device/softwinner/crane-common/egl/gralloc.sun4i.so:system/lib/hw/gralloc.sun4i.so \
	device/softwinner/crane-common/egl/libMali.so:system/lib/libMali.so \
	device/softwinner/crane-common/egl/libUMP.so:system/lib/libUMP.so \
	device/softwinner/crane-common/egl/egl.cfg:system/lib/egl/egl.cfg \
	device/softwinner/crane-common/egl/libEGL_mali.so:system/lib/egl/libEGL_mali.so \
	device/softwinner/crane-common/egl/libGLESv1_CM_mali.so:system/lib/egl/libGLESv1_CM_mali.so \
	device/softwinner/crane-common/egl/libGLESv2_mali.so:system/lib/egl/libGLESv2_mali.so
	

#premission feature
PRODUCT_COPY_FILES += \
	device/softwinner/crane-common/tablet_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml \
    frameworks/base/data/etc/android.hardware.location.xml:system/etc/permissions/android.hardware.location.xml \
    frameworks/base/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/base/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/base/data/etc/android.hardware.touchscreen.xml:system/etc/permissions/android.hardware.touchscreen.xml \
    frameworks/base/data/etc/android.hardware.touchscreen.multitouch.distinct.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.distinct.xml \
    frameworks/base/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/base/data/etc/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml \
    frameworks/base/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml
    
PRODUCT_PROPERTY_OVERRIDES += \
	dalvik.vm.heapsize=48m \
	ro.kernel.android.checkjni=0 \
	persist.sys.timezone=Asia/Shanghai \
	persist.sys.language=zh \
	persist.sys.country=CN \
	wifi.interface=wlan0 \
	wifi.supplicant_scan_interval=15 \
	debug.egl.hw=1 \
	ro.opengles.version=131072 \
	persist.sys.strictmode.visual=0 \
	hwui.render_dirty_regions=true


# Overrides
PRODUCT_BRAND  := softwinners
PRODUCT_NAME   := crane_common
PRODUCT_DEVICE := crane-common


