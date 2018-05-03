<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text"/>
    <xsl:template match="/">

# Generate by v2v-job
apiVersion: kubevirt.io/v1alpha1
kind: OfflineVirtualMachine
metadata:
  name: <xsl:value-of select="/domain/name"/>
spec:
  running: false
  template:
    spec:
      domain:
        cpu:
          cores: <xsl:value-of select="/domain/vcpu"/>
        resources:
          requests:
            memory: <xsl:value-of select="/domain/memory div 1024"/>M
        devices:
          disks:<xsl:for-each select="/domain/devices/disk">
          - name: disk-<xsl:value-of select="position()"/>
<xsl:text>
            </xsl:text><xsl:value-of select="@device"/>:
              bus: <xsl:value-of select="target/@bus"/>
<xsl:if test="source/@file">
            volumeName: volume-<xsl:value-of select="position()"/>
</xsl:if>
</xsl:for-each>
      volumes:<xsl:for-each select="/domain/devices/disk">
<xsl:if test="source/@file">
        - name: volume-<xsl:value-of select="position()"/>
          persistentVolumeClaim:
            claimName: <xsl:value-of select="/domain/name"/>-disk-<xsl:value-of select="position()"/>
</xsl:if>
</xsl:for-each>

<xsl:text>&#10;</xsl:text><!-- newline -->
<!--xsl:for-each select="/domain/devices/disk">
<xsl:if test="source/@file">
\-\-\-
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: <xsl:value-of select="/domain/name"/>-disk-<xsl:value-of select="position()"/>
spec:
  accessModes:
    - ReadWriteOnce
  volumeMode: Filesystem
  resources:
    requests:
      storage: 8Gi
</xsl:if>
</xsl:for-each-->
	</xsl:template>
</xsl:stylesheet>

