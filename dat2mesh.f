************************************************************************
* ���[�f�[�^(Bathmetry.dat)��
* DHI/ASMIKE 21 SW�p�C��n�`�t�@�C��(Bathymetry.mesh)��
* �ϊ����邽�߂�Fortran�\�[�X
* �쐬�F���c�@���p�i�������ݍH�Ɓj
*-----------------------------
* �T���v���t�@�C��
*   Bathymetry_Slope_DX=025m.dat ��l���z�Ζ� DX= 25 m
*   Bathymetry_Slope_DX=100m.dat ��l���z�Ζ� DX=100 m
*   Bathymetry_Flat_DX=100m.dat  ������ DX=100 m
* ��Bathmetry.dat�Ƀ��l�[�����āC�R���p�C�������v���O���������s�D
************************************************************************

      IMPLICIT INTEGER(I-N),real(4)(A-H,O-Z)

      real, allocatable :: x(:)
      real, allocatable :: y(:)
      real, allocatable :: z(:,:)

      OPEN(11,FILE='Bathymetry.dat')
      OPEN(21,FILE='Bathymetry.mesh')

****************************************
* �f�[�^�̓Ǎ�
****************************************
        READ(11,*) NX, NY
        READ(11,*) DX, DY

        allocate( X(NX) )     ! �z��̊���
        allocate( Y(NY) )     ! �z��̊���
        allocate( Z(NX,NY) )  ! �z��̊���

        READ(11,*) 
        READ(11,*) IDUM,IDUM,(X(I),I=1,NX)
      DO J=1,NY
        READ(11,*) IDUM,Y(J),(Z(I,J),I=1,NX)
      END DO

      WRITE(6,*) 'ok'


****************************************
* �m�[�h�̌v�Z
****************************************
      WRITE(21,*) '100079 1000', NX*NY, 'NON-UTM'

      INO = 0 ! �m�[�h�ԍ�

C-----------------------------
C ��
C-----------------------------
      J=1

        INDT = 4  ! Code Value
        DO I=1,NX-1
          INO = INO+1
          WRITE(21,8000) INO,X(I),Y(J),Z(I,J),INDT
        END DO

        INDT = 1  ! Code Value ����i�E�j
          INO = INO+1
          WRITE(21,8000) INO,X(NX),Y(J),Z(I,J),INDT

C-----------------------------
C 
C-----------------------------
      DO J=2,NY-1

        INDT = 3  ! Code Value ���g���E�i���j
        I=1
          INO = INO+1
          WRITE(21,8000) INO,X(I),Y(J),Z(I,J),INDT

        INDT = 0  ! Code Value ����i���j
        DO I=2,NX-1
          INO = INO+1
          WRITE(21,8000) INO,X(I),Y(J),Z(I,J),INDT
        END DO

        INDT = 1  ! Code Value ����i�E�j
        I=NX
          INO = INO+1
          WRITE(21,8000) INO,X(I),Y(J),Z(I,J),INDT

      END DO

C-----------------------------
C �����E
C-----------------------------
      J=NY

        INDT = 3  ! Code Value ���g���E�i���j
        I=1
          INO = INO+1
          WRITE(21,8000) INO,X(I),Y(J),Z(I,J),INDT

        INDT = 2  ! Code Value
        DO I=2,NX-1
          INO = INO+1
          WRITE(21,8000) INO,X(I),Y(J),Z(I,J),INDT
        END DO

        INDT = 1  ! Code Value ����i�E�j
          INO = INO+1
          WRITE(21,8000) INO,X(NX),Y(J),Z(I,J),INDT

****************************************
* �v�f�̌v�Z
****************************************
      WRITE(21,*) (NX-1)*(NY-1), '4 25'

      IEL=0
      IS  = 0

      DO J=1,NY-1
        DO I=1,NX-1
          IEL = IEL+1
          IS = (J-1)*NX+I
          WRITE(21,8100) IEL,IS,IS+NX,IS+NX+1,IS+1
        END DO
      END DO

      CLOSE(11)
      CLOSE(21)

 8000 FORMAT(I7,F11.2,F11.2,F9.2,I3)
 8100 FORMAT(5I7)



      STOP
      END
      