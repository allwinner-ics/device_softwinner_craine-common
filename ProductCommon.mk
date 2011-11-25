# full crane product config
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)

DEVICE_PACKAGE_OVERLAYS := device/softwinner/crane-common/overlay

PRODUCT_PACKAGES += \
	make_ext4fs \
	libjni_pinyinime
	
# init.rc
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
	device/softwinner/crane-common/bin/busybox:system/bin/busybox \
	device/softwinner/crane-common/bin/e2fsck:system/bin/e2fsck 
	
# gps conf
PRODUCT_COPY_FILES += \
	device/softwinner/crane-common/gps.conf:system/etc/gps.conf	

# wifi conf
PRODUCT_COPY_FILES += \
	device/softwinner/crane-common/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf 

# mali lib so
PRODUCT_COPY_FILES += \
	device/softwinner/crane-common/egl/gralloc.sun4i.so:system/lib/hw/gralloc.sun4i.so \
	device/softwinner/crane-common/egl/libMali.so:system/lib/libMali.so \
	device/softwinner/crane-common/egl/libUMP.so:system/lib/libUMP.so \
	device/softwinner/crane-common/egl/egl.cfg:system/lib/egl/egl.cfg \
	device/softwinner/crane-common/egl/libEGL_mali.so:system/lib/egl/libEGL_mali.so \
	device/softwinner/crane-common/egl/libGLESv1_CM_mali.so:system/lib/egl/libGLESv1_CM_mali.so \
	device/softwinner/crane-common/egl/libGLESv2_mali.so:system/lib/egl/libGLESv2_mali.so
	

PRODUCT_PROPERTY_OVERRIDES += \
	dalvik.vm.heapsize=32m \
	ro.kernel.android.checkjni=0 \
	persist.sys.timezone=Asia/Shanghai \
	persist.sys.language=zh \
	persist.sys.country=CN \
	wifi.interface=wlan0 \
	wifi.supplicant_scan_interval=15 \
	debug.egl.hw=1 \
	ro.opengles.version=131072


# Overrides
PRODUCT_BRAND  := softwinners
PRODUCT_NAME   := crane_common
PRODUCT_DEVICE := crane-common


