--[[
	aviutl_effect_list.lua / ver.1.0.1
	Copyright (c) 2022 CaffemochaY

	- parameter
		- _name         : "string"
		- track
			- track0      : "number"
			- track1      : "number"
			- track2      : "number"
			- track3      : "number"
			- track4      : "number"
			- track5      : "number"
			- track6      : "number"
			- track7      : "number"
		- color
			- color1/col  : "number"
			- color2/col  : "number"
		- check
			- check0/chk  : "number"
			- check1/chk  : "number"
			- check2/chk  : "number"
			- check3/chk  : "number"
			- check4/chk  : "number"
		- mode          : "number"
		- etype         : "number"
		- name / file   : "string"
		- color_yc
			- color_yc1   : "table" or "number"
			- color_yc2   : "table" or "number"
		- seed          : "number"
		- calc          : "number"
		- param         : "string"

	- changelog
		- ver.1.0.1
			- �o�[�W�����\�L��3���ɕύX
			- �R�����g����������
]]

--YCbCr�̐��l�ϊ�
local function ycbcrconvert(ycbcrcol)
	local colycre, ycstatus, colyc = 0, 1, {}
	if type(ycbcrcol) == "table" then
		if ycbcrcol[2] then
			local bit = require("bit")
			for i = 1, 3 do
				if ycbcrcol[i] then
					colyc[i] = bit.tohex(bit.rshift(bit.bswap(ycbcrcol[i]), 16), 4)
				else
					colyc[i] = bit.tohex(0, 4)
				end
			end
			colycre = colyc[1] .. colyc[2] .. colyc[3]
		else
			colycre = ycbcrcol[1]
		end
	elseif type(ycbcrcol) == "number" or "string" then
		colycre = ycbcrcol
	else
		ycstatus = 0
	end
	return colycre, ycstatus
end

--name�̐��`
local function nameformat(name)
	local nfe
	if not name then
		nfe = nil
	elseif name == "*tempbuffer" or "tempbuffer" or "���z�o�b�t�@" then
		nfe = "*tempbuffer"
	elseif string.sub(name, 1, 5) == "scene" then
		nfe = ":"..string.sub(name, 6)
	elseif string.sub(name, 1, 1) == ":" then
		nfe = name
	elseif string.sub(name, 2, 3) == ":\\" then
		nfe = "*"..name
	elseif string.sub(name, 1, 1) == "*" and string.sub(name, 3, 4) == ":\\" then
		nfe = name
	else
		nfe = nil
	end
	return nfe
end

--------------------------------------------------

--�F���␳
local function colorcorrection(track0, track1, track2, track3, track4, check0)
	obj.effect("�F���␳", "���邳", track0, "���׽�", track1, "�F��", track2, "�P�x", track3, "�ʓx", track4, "�O�a����", check0)
end

--�N���b�s���O
local function clipping(track0, track1, track2, track3, check0)
	obj.effect("�N���b�s���O", "��", track0 "��", track1 "��", track2 "�E", track3 "���S�̈ʒu��ύX", check0)
end

--�ڂ���
local function shadingoff(track0, track1, track2, check0)
	if track0 ~= 0 then obj.effect("�ڂ���", "�͈�", track0, "�c����", track1, "���̋���", track2, "�T�C�Y�Œ�", check0) end
end

--���E�ڂ���
local function bordershadingoff(track0, track1, check0)
	if track0 ~= 0 then obj.effect("���E�ڂ���", "�͈�", track0, "�c����", track1, "�����x�̋��E���ڂ���", check0) end
end

--���U�C�N
local function mosaic(track0, check0)
	if track0 ~= 0 then obj.effect("���U�C�N", "�T�C�Y", track0, "�^�C����", check0) end
end

--����
local function luminescence(track0, track1, track2, track3, check0, color1)
	if track0 ~= 0 then
		local nocol1 = 0
		if not color1 then color1, nocol1 = 0x0, 1 end
		obj.effect("����", "����", track0, "�g�U", track1, "�������l", track2, "�g�U���x", track3, "�T�C�Y�Œ�", check0, "color", color1, "no_color", nocol1)
	end
end

--�M��
local function flash(track0, track1, track2, check0, color1, mode)
	if track0 ~= 0 then
		local nocol1 = 0
		if not color1 then color1, nocol1 = 0x0, 1 end
		obj.effect("�M��", "����", track0, "X", track1, "Y", track2, "�T�C�Y�Œ�", check0, "color", color1, "no_color", nocol1, "mode", mode)
	end
end

--�g�U��
local function diffuselight(track0, track1, check0)
	if track0 ~= 0 then obj.effect("�g�U��", "����", track0, "�g�U", track1, "�T�C�Y�Œ�", check0) end
end

--�O���[
local function glow(track0, track1, track2, track3, check0, color1, etype)
	local nocol1 = 0
	if not color1 then color1, nocol1 = 0x0, 1 end
	if track0 ~= 0 then obj.effect("�O���[", "����", track0, "�g�U", track1, "�������l", track2, "�ڂ���", track3, "�������̂�", check0, "color", color1, "no_color", nocol1, "type", etype) end
end

--�N���}�L�[
local function chromakey(track0, track1, track2, check0, check1, color_yc1)
	local colycre1, ycstatus1 = ycbcrconvert(color_yc1)
	obj.effect("�N���}�L�[", "�F���͈�", track0, "�ʓx�͈�", track1, "���E�␳", track2, "�F�ʕ␳", check0, "���ߕ␳", check1, "color_yc", colycre1, "status", ycstatus1)
end

--�J���[�L�[
local function colorkey(track0, track1, track2, color_yc1)
	local colycre1, ycstatus1 = ycbcrconvert(color_yc1)
	obj.effect("�J���[�L�[", "�P�x�͈�", track0, "�F���͈�", track1, "���E�␳", track2, "color_yc", colycre1, "status", ycstatus1)
end

--���~�i���X�L�[
local function luminancekey(track0, track1, etype)
	obj.effect("���~�i���X�L�[", "��P�x", track0 "�ڂ���", track1 "type", etype)
end

--���C�g
local function light(track0, track1, track2, check0, color1)
	if track0 ~= 0 then obj.effect("���C�g", "����", track0, "�g�U", track1, "�䗦", track2, "�t��", check0, "color", color1) end
end

--�V���h�[
local function shadow(track0, track1, track2, track3, check0, color1, name)
	if track2 ~= 0 then obj.effect("�V���h�[", "X", track0, "Y", track1, "�Z��", track2, "�g�U", track3, "�e��ʃI�u�W�F�N�g�ŕ`��", check0, "color", color1, "file", name) end
end

--�����
local function bordering(track0, track1, color1, name)
	if track0 ~= 0 then obj.effect("�����", "�T�C�Y", track0, "�ڂ���", track1, "color", color1, "file", name) end
end

--�ʃG�b�W
local function convexedge(track0, track1, track2)
	if track0 ~= 0 then obj.effect("�ʃG�b�W", "��", track0, "����", track1, "�p�x", track2) end
end

--�G�b�W���o
local function edgeextraction(track0, track1, check0, check1, color1)
	if track0 ~= 0 then obj.effect("�G�b�W���o", "����", track0, "�������l", track1, "�P�x�G�b�W�𒊏o", check0, "�����x�G�b�W�𒊏o", check1, "color", color1) end
end

--�V���[�v
local function sharp(track0, track1)
	if track0 ~= 0 then obj.effect("�V���[�v", "����", track0, "�͈�", track1) end
end

--�t�F�[�h
local function fade(track0, track1)
	obj.effect("�t�F�[�h", "�C��", track0, "�A�E�g", track1)
end

--���C�v
local function wipe(track0, track1, track2, check0, check1, etype, name)
	obj.effect("���C�v", "�C��", track0, "�A�E�g", track1, "�ڂ���", track2, "���](�C��)", check0, "���](�A�E�g)", check1, "type", etype, "name", name)
end

--�}�X�N
	--�G�t�F�N�g�̃}�X�N�ŃV�[������x�w�肵�Ȃ���obj.effect�̃}�X�N�ŃV�[�����ǂ߂Ă��Ȃ����ۂ��̂Œ���
local function mask(track0, track1, track2, track3, track4, track5, check0, check1, etype, name, mode)
	local nfe = nameformat(name)
	obj.effect("�}�X�N", "X", track0, "Y", track1, "��]", track2, "�T�C�Y", track3, "�c����", track4, "�ڂ���", track5, "�}�X�N�̔��]", check0, "���̃T�C�Y�ɍ��킹��", check1, "type", etype, "name", nfe, "mode", mode)
end

--�΂߃N���b�s���O
local function obliqueclip(track0, track1, track2, track3, track4)
	obj.effect("�΂߃N���b�s���O", "���SX", track0, "���SY", track1, "�p�x", track2, "�ڂ���", track3, "��", track4)
end

--���˃u���[
local function radiationblur(track0, track1, track2, check0)
	if track0 ~= 0 then obj.effect("���˃u���[", "�͈�", track0, "X", track1, "Y", track2, "�T�C�Y�Œ�", check0) end
end

--�����u���[
local function directionblur(track0, track1, check0)
	if track0 ~= 0 then obj.effect("�����u���[", "�͈�", track0, "�p�x", track1, "�T�C�Y�Œ�", check0) end
end

--�����Y�u���[
local function lensblur(track0, track1, check0)
	if track0 ~= 0 then obj.effect("�����Y�u���[", "�͈�", track0, "���̋���", track1, "�T�C�Y�Œ�", check0) end
end

--���[�V�����u���[
	--�����Ȃ��H / �I�t�X�N���[���`���1�ɂ���ƍŏ��ƍŌ�̃t���[���݂̂�������
--[[
local function motionblur(track0, track1, check0, check1, check2)
	obj.effect("���[�V�����u���[", "�Ԋu", track0, "����\", track1, "�c��", check0, "�I�t�X�N���[���`��", check1, "�o�͎��ɕ���\���グ��", check2)
end
--]]

--���W
local function coordinate(track0, track1, track2)
	obj.effect("���W", "X", track0, "Y", track1, "Z", track2)
end

--�g�嗦
local function zoomrate(track0, track1, track2)
	obj.effect("���W", "�g�嗦", track0, "X", track1, "Y", track2)
end

--�����x
local function transparency(track0)
	obj.effect("���W", "�����x", track0)
end

--��]
local function turning(track0, track1, track2)
	obj.effect("��]", "X", track0, "Y", track1, "Z", track2)
end

--�̈�g��
local function areaextension(track0, track1, track2, track3 ,check0)
	obj.effect("�̈�g��", "��", track0, "��", track1, "��", track2, "�E", track3, "�h��Ԃ�", check0)
end

--���T�C�Y
local function resize(track0, track1, track2, check0, check1)
	obj.effect("���T�C�Y", "�g�嗦", track0, "X", track1, "Y", track2, "��ԂȂ�", check0, "�h�b�g���ŃT�C�Y�w��", check1)
end

--���[�e�[�V����
local function rotation(track0)
	obj.effect("���[�e�[�V����", "90�x��]", track0)
end

--���]
local function inversion(check0, check1, check2, check3, check4)
	obj.effect("���]", "�㉺���]", check0, "���E���]", check1, "�P�x���]", check2, "�F�����]", check3, "�����x���]", check4)
end

--�U��
local function vibration(track0, track1, track2, track3, check0, check1)
	obj.effect("�U��", "X", track0, "Y", track1, "Z", track2, "����", track3, "�����_���ɋ�����ς���", check0, "���G�ɐU��", check1)
end

--�~���[
local function mirror(track0, track1, track2, check0, etype)
	obj.effect("�~���[", "�����x", track0, "����", track1, "���ڒ���", track2, "���S�̈ʒu��ύX", check0, "type", etype)
end

--���X�^�[
local function raster(track0, track1, track2, check0, check1)
	obj.effect("���X�^�[", "����", track0, "����", track1, "����", track2, "�c���X�^�[", check0, "�����_���U��", check1)
end

--�摜���[�v
local function imageloop(track0, track1, track2, track3, check0)
	obj.effect("�摜���[�v", "����", track0, "�c��", track1, "���xX", track2, "���xY", track3, "�ʃI�u�W�F�N�g", check0)
end

--�ɍ��W�ϊ�
local function polarcoordconv(track0, track1, track2, track3)
	obj.effect("�ɍ��W�ϊ�", "���S��", track0, "�g�嗦", track1, "��]", track2, "�Q��", track3)
end

--�f�B�X�v���C�X�����g�}�b�v
	--�G�t�F�N�g�̃f�B�X�v���C�X�����g�}�b�v�ŃV�[������x�w�肵�Ȃ���obj.effect�̃}�X�N�ŃV�[�����ǂ߂Ă��Ȃ����ۂ��̂Œ���
local function displacementmap(track0, track1, track2, track3, track4, track5, track6, track7, check0, etype, name, mode, calc)
	local nfe = nameformat(name)
	obj.effect("�f�B�X�v���C�X�����g�}�b�v", "param0", track0, "param1", track1, "X", track2, "Y", track3, "��]", track4, "�T�C�Y", track5, "�c����", track6, "�ڂ���", track7, "���̃T�C�Y�ɍ��킹��", check0, "type", etype, "name", nfe, "mode", mode, "calc", calc)
end

--�m�C�Y
local function noise(track0, track1, track2, track3, track4, track5, track6, etype, mode, seed)
	if track0 ~= 0 then obj.effect("�m�C�Y", "����", track0, "���xX", track1, "���xY", track2, "�ω����x", track3, "����X", track4, "����Y", track5, "�������l", track6, "type", etype, "mode", mode, "seed", seed) end
end

--�F����
local function colorshift(track0, track1, track2, etype)
	if track0 ~= 0 and track2 ~= 0 then obj.effect("�F����", "���ꕝ", track0, "�p�x", track1, "����", track2, "type", etype) end
end

--�P�F��
local function monochroma(track0, check0, color1)
	if not color1 then color1 = 0x0 end
	obj.effect("�P�F��", "����", track0, "�P�x��ێ�����", check0, "color", color1)
end

--�O���f�[�V����
local function gradation(track0, track1, track2, track3, track4, mode, color1, color2 ,etype)
	local nocol1, nocol2 = 0, 0
	if not color1 then color1, nocol1 = 0x0, 1 end
	if not color2 then color2, nocol2 = 0x0, 1 end
	if track0 ~= 0 then obj.effect("�O���f�[�V����", "����", track0, "���SX", track1, "���SY", track2, "�p�x", track3, "��", track4, "blend", mode, "color", color1, "no_color", nocol1, "color2", color2, "no_color2", nocol2, "type", etype) end
end

--�g���F�ݒ�
--[[
local function advancecolset(track0, track1, track2, check0)
	obj.effect("�g���F�ݒ�", "R", track0, "G", track1, "B", track2, "RGB��HSV", check0)
end
--]]

--����F��ϊ�
local function specolspaceconv(track0, track1, track2, color_yc1, color_yc2)
	local colycre1, ycstatus1 = ycbcrconvert(color_yc1)
	local colycre2, ycstatus2 = ycbcrconvert(color_yc2)
	obj.effect("����F��ϊ�", "�F���͈�", track0, "�ʓx�͈�", track1, "���E�␳", track2, "color_yc", colycre1, "status", ycstatus1, "color_yc2", colycre2, "status2", ycstatus2)
end

--�A�j���[�V��������
local function animationeffect(track0, track1, track2, track3, check0, name, param)
	obj.effect("�A�j���[�V��������", "track0", track0, "track1", track1, "track2", track2, "track3", track3, "check0", check0, "name", name, "param", param)
end

--����t�@�C������
local function videocomposition(track0, track1, track2, track3, track4, check0, check1, check2, file, mode)
	local nfe = nameformat(file)
	obj.effect("����t�@�C������", "�Đ��ʒu", track0, "�Đ����x", track1, "X", track2, "Y", track3, "�g�嗦", track4, "���[�v�Đ�", check0, "����t�@�C���̓���", check1, "���[�v�摜", check2, "file", nfe, "mode", mode)
end

--�摜�t�@�C������
local function pictcomposition(track0, track1, track2, check0, mode, file)
	local nfe = nameformat(file)
	obj.effect("����t�@�C������", "X", track0, "Y", track1, "�g�嗦", track2, "���[�v�摜", check0, "file", nfe, "mode", mode, "file", nfe)
end

--�C���^�[���[�X����
local function deinterlacing(etype)
	obj.effect("���^�[���[�X����", "type", etype)
end

--�J��������I�v�V����
local function camctrloption(check0, check1, check2, check3)
	obj.effect("�J��������I�v�V����", "�J�����̕�������", check0, "�J�����̕�������(�c�������̂�)", check1, "�J�����̕�������(�������̂�)", check2, "�V���h�[�̑Ώۂ���O��", check3)
end

--�I�t�X�N���[���`��
local function offscreen()
	obj.effect("�I�t�X�N���[���`��")
end

--�I�u�W�F�N�g����
local function objsplit(track0, track1)
	obj.effect("�I�u�W�F�N�g����", "��������", track0, "�c������", track1)
end

--------------------------------------------------

--����
local function auleffectlist(_name, track0, track1, track2, track3, track4, track5, track6, track7, color1, color2, check0, check1, check2, check3, check4, mode, etype, name, color_yc1, color_yc2, seed, calc, param)
	if _name == "�F���␳" then colorcorrection(track0, track1, track2, track3, track4, check0)
	elseif _name == "�N���b�s���O" then clipping(track0, track1, track2, track3, check0)
	elseif _name == "�ڂ���" then shadingoff(track0, track1, track2, check0)
	elseif _name == "���E�ڂ���" then bordershadingoff(track0, track1, check0)
	elseif _name == "���U�C�N" then mosaic(track0, check0)
	elseif _name == "����" then luminescence(track0, track1, track2, track3, check0, color1)
	elseif _name == "�M��" then flash(track0, track1, track2, check0, color1, mode)
	elseif _name == "�g�U��" then diffuselight(track0, track1, check0)
	elseif _name == "�O���[" then glow(track0, track1, track2, track3, check0, color1, etype)
	elseif _name == "�N���}�L�[" then chromakey(track0, track1, track2, check0, check1, color_yc1)
	elseif _name == "�J���[�L�[" then colorkey(track0, track1, track2, color_yc1)
	elseif _name == "���~�i���X�L�[" then luminancekey(track0, track1, etype)
	elseif _name == "���C�g" then light(track0, track1, track2, check0, color1)
	elseif _name == "�V���h�[" then shadow(track0, track1, track2, track3, check0, color1, name)
	elseif _name == "�����" then bordering(track0, track1, color1, name)
	elseif _name == "�ʃG�b�W" then convexedge(track0, track1, track2)
	elseif _name == "�G�b�W���o" then edgeextraction(track0, track1, check0, check1, color1)
	elseif _name == "�V���[�v" then sharp(track0, track1)
	elseif _name == "�t�F�[�h" then fade(track0, track1)
	elseif _name == "���C�v" then wipe(track0, track1, track2, check0, check1, etype, name)
	elseif _name == "�}�X�N" then mask(track0, track1, track2, track3, track4, track5, check0, check1, etype, name, mode)
	elseif _name == "�΂߃N���b�s���O" then obliqueclip(track0, track1, track2, track3, track4)
	elseif _name == "���˃u���[" then radiationblur(track0, track1, track2, check0)
	elseif _name == "�����u���[" then directionblur(track0, track1, check0)
	elseif _name == "�����Y�u���[" then lensblur(track0, track1, check0)
	-- elseif _name == "���[�V�����u���[" then motionblur(track0, track1, check0, check1, check2)
	elseif _name == "���W" then coordinate(track0, track1, track2)
	elseif _name == "�g�嗦" then zoomrate(track0, track1, track2)
	elseif _name == "�����x" then transparency(track0)
	elseif _name == "��]" then turning(track0, track1, track2)
	elseif _name == "�̈�g��" then areaextension(track0, track1, track2, track3 ,check0)
	elseif _name == "���T�C�Y" then resize(track0, track1, track2, check0, check1)
	elseif _name == "���[�e�[�V����" then rotation(track0)
	elseif _name == "���]" then inversion(check0, check1, check2, check3, check4)
	elseif _name == "�U��" then vibration(track0, track1, track2, track3, check0, check1)
	elseif _name == "�~���[" then mirror(track0, track1, track2, check0, etype)
	elseif _name == "���X�^�[" then raster(track0, track1, track2, check0, check1)
	elseif _name == "�摜���[�v" then imageloop(track0, track1, track2, track3, check0)
	elseif _name == "�ɍ��W�ϊ�" then polarcoordconv(track0, track1, track2, track3)
	elseif _name == "�f�B�X�v���C�X�����g�}�b�v" then displacementmap(track0, track1, track2, track3, track4, track5, track6, track7, check0, etype, name, mode, calc)
	elseif _name == "�m�C�Y" then noise(track0, track1, track2, track3, track4, track5, track6, etype, mode, seed)
	elseif _name == "�F����" then colorshift(track0, track1, track2, etype)
	elseif _name == "�P�F��" then monochroma(track0, check0, color1)
	elseif _name == "�O���f�[�V����" then gradation(track0, track1, track2, track3, track4, mode, color1, color2 ,etype)
	-- elseif _name == "�g���F�ݒ�" then advancecolset(track0, track1, track2, check0)
	elseif _name == "����F��ϊ�" then specolspaceconv(track0, track1, track2, color_yc1, color_yc2)
	elseif _name == "�A�j���[�V��������" then animationeffect(track0, track1, track2, track3, check0, name, param)
	elseif _name == "����t�@�C������" then videocomposition(track0, track1, track2, track3, track4, check0, check1, check2, name, mode)
	elseif _name == "�摜�t�@�C������" then pictcomposition(track0, track1, track2, check0, mode, name)
	elseif _name == "�C���^�[���[�X����" then deinterlacing(etype)
	elseif _name == "�J��������I�v�V����" then camctrloption(check0, check1, check2, check3)
	elseif _name == "�I�t�X�N���[���`��" then offscreen()
	elseif _name == "�I�u�W�F�N�g����" then objsplit(track0, track1)
	end
end

--�֐����
local AULEL = {}
AULEL.colorcorrection = colorcorrection   -- �F���␳
AULEL.clipping = clipping                 -- �N���b�s���O
AULEL.shadingoff = shadingoff             -- �ڂ���
AULEL.bordershadingoff = bordershadingoff -- ���E�ڂ���
AULEL.mosaic = mosaic                     -- ���U�C�N
AULEL.luminescence = luminescence         -- ����
AULEL.flash = flash                       -- �M��
AULEL.diffuselight = diffuselight         -- �g�U��
AULEL.glow = glow                         -- �O���[
AULEL.chromakey = chromakey               -- �N���}�L�[
AULEL.colorkey = colorkey                 -- �J���[�L�[
AULEL.luminancekey = luminancekey         -- ���~�i���X�L�[
AULEL.light = light                       -- ���C�g
AULEL.shadow = shadow                     -- �V���h�[
AULEL.bordering = bordering               -- �����
AULEL.convexedge = convexedge             -- �ʃG�b�W
AULEL.edgeextraction = edgeextraction     -- �G�b�W���o
AULEL.sharp = sharp                       -- �V���[�v
AULEL.fade = fade                         -- �t�F�[�h
AULEL.wipe = wipe                         -- ���C�v
AULEL.mask = mask                         -- �}�X�N
AULEL.obliqueclip = obliqueclip           -- �΂߃N���b�s���O
AULEL.radiationblur = radiationblur       -- ���˃u���[
AULEL.directionblur = directionblur       -- �����u���[
AULEL.lensblur = lensblur                 -- �����Y�u���[
-- AULEL.motionblur = motionblur             -- ���[�V�����u���[
AULEL.coordinate = coordinate             -- ���W
AULEL.zoomrate = zoomrate                 -- �g�嗦
AULEL.transparency = transparency         -- �����x
AULEL.turning = turning                   -- ��]
AULEL.areaextension = areaextension       -- �̈�g��
AULEL.resize = resize                     -- ���T�C�Y
AULEL.rotation = rotation                 -- ���[�e�[�V����
AULEL.inversion = inversion               -- ���]
AULEL.vibration = vibration               -- �U��
AULEL.mirror = mirror                     -- �~���[
AULEL.raster = raster                     -- ���X�^�[
AULEL.imageloop = imageloop               -- �摜���[�v
AULEL.polarcoordconv = polarcoordconv     -- �ɍ��W�ϊ�
AULEL.displacementmap = displacementmap   -- �f�B�X�v���C�X�����g�}�b�v
AULEL.noise = noise                       -- �m�C�Y
AULEL.colorshift = colorshift             -- �F����
AULEL.monochroma = monochroma             -- �P�F��
AULEL.gradation = gradation               -- �O���f�[�V����
-- AULEL.advancecolset = advancecolset       -- �g���F�ݒ�
AULEL.specolspaceconv = specolspaceconv   -- ����F��ϊ�
AULEL.animationeffect = animationeffect   -- �A�j���[�V��������
AULEL.videocomposition = videocomposition -- ����t�@�C������
AULEL.pictcomposition = pictcomposition   -- �摜�t�@�C������
AULEL.deinterlacing = deinterlacing       -- �C���^�[���[�X����
AULEL.camctrloption = camctrloption       -- �J��������I�v�V����
AULEL.offscreen = offscreen               -- �I�t�X�N���[���`��
AULEL.objsplit = objsplit                 -- �I�u�W�F�N�g����
AULEL.auleffectlist = auleffectlist       -- ����

return AULEL
