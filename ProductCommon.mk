# full crane product config
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)

DEVICE_PACKAGE_OVERLAYS := device/softwinner/crane-common/overlay

PRODUCT_PACKAGES += \
	gralloc.sun4i \
	make_ext4fs

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

# Overrides
PRODUCT_BRAND  := softwinners
PRODUCT_NAME   := crane_common
PRODUCT_DEVICE := crane-common


