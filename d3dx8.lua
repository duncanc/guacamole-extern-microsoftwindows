
local ffi = require 'ffi'
local com = require 'extern.microsoftwindows.com'
local d3d8 = require 'extern.microsoftwindows.d3d8'

-- math
ffi.cdef [[

	typedef struct D3DXVECTOR2    { float x, y;       } D3DXVECTOR2;
	typedef struct D3DXVECTOR3    { float x, y, z;    } D3DXVECTOR3;
	typedef struct D3DXVECTOR4    { float x, y, z, w; } D3DXVECTOR4;
	typedef struct D3DXQUATERNION { float x, y, z, w; } D3DXQUATERNION;
	typedef struct D3DXPLANE      { float a, b, c, d; } D3DXPLANE;
	typedef struct D3DXCOLOR      { float r, g, b, a; } D3DXCOLOR;
	typedef D3DMATRIX D3DXMATRIX;

]]
com.def {
	{'ID3DXMatrixStack';
		methods = {
			{'Pop'};
			{'Push'};
			{'LoadIdentity'};
			{'LoadMatrix', 'const D3DMATRIX*'};
			{'MultMatrix', 'const D3DMATRIX*'};
			{'MultMatrixLocal', 'const D3DMATRIX*'};
			{'RotateAxis', 'const D3DXVECTOR3*, float angle'};
			{'RotateAxisLocal', 'const D3DXVECTOR3*, float angle'};
			{'RotateYawPitchRoll', 'float yaw, float pitch, float roll'};
			{'RotateYawPitchRollLocal', 'float yaw, float pitch, float roll'};
			{'Scale', 'float x, float y, float z'};
			{'ScaleLocal', 'float x, float y, float z'};
			{'Translate', 'float x, float y, float z'};
			{'TranslateLocal', 'float x, float y, float z'};
			{'GetTop', ret='D3DMATRIX*'};
		};
		iid = 'e3357330-cc5e-11d2-a434-00a0c90629a8';
	};
}
ffi.cdef[[

	D3DXVECTOR2* D3DXVec2Normalize(D3DXVECTOR2* out_vec, const D3DXVECTOR2*);
	D3DXVECTOR2* D3DXVec2Hermite(D3DXVECTOR2* out_vec, const D3DXVECTOR2* v1, const D3DXVECTOR2* t1, const D3DXVECTOR2* v2, const D3DXVECTOR2* t2, float s);
	D3DXVECTOR2* D3DXVec2CatmullRom(D3DXVECTOR2* out_vec, const D3DXVECTOR2* v0, const D3DXVECTOR2* v1, const D3DXVECTOR2* v2, const D3DXVECTOR2* v3, float s);
	D3DXVECTOR2* D3DXVec2BaryCentric(D3DXVECTOR2* out_vec, const D3DXVECTOR2* v1, const D3DXVECTOR2* v2, const D3DXVECTOR2* v3, float f, float g);
	D3DXVECTOR4* D3DXVec2Transform(D3DXVECTOR4* out_vec, const D3DXVECTOR2* v, const D3DMATRIX* m);
	D3DXVECTOR2* D3DXVec2TransformCoord(D3DXVECTOR2* out_vec, const D3DXVECTOR2* v, const D3DMATRIX* m);
	D3DXVECTOR2* D3DXVec2TransformNormal(D3DXVECTOR2* out_vec, const D3DXVECTOR2* v, const D3DMATRIX* m);

	D3DXVECTOR3* D3DXVec3Normalize(D3DXVECTOR3* out_vec, const D3DXVECTOR3* v);
	D3DXVECTOR3* D3DXVec3Hermite(D3DXVECTOR3* out_vec, const D3DXVECTOR3* v1, const D3DXVECTOR3* t1, const D3DXVECTOR3* v2, const D3DXVECTOR3* t2, float s);
	D3DXVECTOR3* D3DXVec3CatmullRom(D3DXVECTOR3* out_vec, const D3DXVECTOR3* v0, const D3DXVECTOR3* v1, const D3DXVECTOR3* v2, const D3DXVECTOR3* v3, float s);
	D3DXVECTOR3* D3DXVec3BaryCentric(D3DXVECTOR3* out_vec, const D3DXVECTOR3* v1, const D3DXVECTOR3* v2, const D3DXVECTOR3* v3, float f, float g);
	D3DXVECTOR4* D3DXVec3Transform(D3DXVECTOR4* out_vec, const D3DXVECTOR3* v, const D3DMATRIX* m);
	D3DXVECTOR3* D3DXVec3TransformCoord(D3DXVECTOR3* out_vec, const D3DXVECTOR3* v, const D3DMATRIX* m);
	D3DXVECTOR3* D3DXVec3TransformNormal(D3DXVECTOR3* out_vec, const D3DXVECTOR3* v, const D3DMATRIX* m);
	D3DXVECTOR3* D3DXVec3Project(D3DXVECTOR3* out_vec,
		const D3DXVECTOR3* v, const D3DVIEWPORT8* viewport, const D3DMATRIX* projection, const D3DMATRIX* view, const D3DMATRIX* pWorld);
	D3DXVECTOR3* D3DXVec3Unproject(D3DXVECTOR3* out_vec,
		const D3DXVECTOR3* v, const D3DVIEWPORT8* viewport, const D3DMATRIX* projection, const D3DMATRIX* view, const D3DMATRIX* pWorld);

	D3DXVECTOR4* D3DXVec4Cross(D3DXVECTOR4* out_vec, const D3DXVECTOR4* v1, const D3DXVECTOR4* v2, const D3DXVECTOR4* v3);
	D3DXVECTOR4* D3DXVec4Normalize(D3DXVECTOR4* out_vec, const D3DXVECTOR4* v);
	D3DXVECTOR4* D3DXVec4Hermite(D3DXVECTOR4* out_vec, const D3DXVECTOR4* v1, const D3DXVECTOR4* t1, const D3DXVECTOR4* v2, const D3DXVECTOR4* t2, float s);
	D3DXVECTOR4* D3DXVec4CatmullRom(D3DXVECTOR4* out_vec, const D3DXVECTOR4* v0, const D3DXVECTOR4* v1, const D3DXVECTOR4* v2, const D3DXVECTOR4* v3, float s);
	D3DXVECTOR4* D3DXVec4BaryCentric(D3DXVECTOR4* out_vec, const D3DXVECTOR4* v1, const D3DXVECTOR4* v2, const D3DXVECTOR4* v3, float f, float g);
	D3DXVECTOR4* D3DXVec4Transform(D3DXVECTOR4* out_vec, const D3DXVECTOR4* v, const D3DMATRIX* m);

	float D3DXMatrixfDeterminant(const D3DMATRIX*);
	D3DMATRIX* D3DXMatrixTranspose(D3DMATRIX* out_mat, const D3DMATRIX*);
	D3DMATRIX* D3DXMatrixMultiply(D3DMATRIX* out_mat, const D3DMATRIX*, const D3DMATRIX*);
	D3DMATRIX* D3DXMatrixMultiplyTranspose(D3DMATRIX* out_mat, const D3DMATRIX*, const D3DMATRIX*);
	D3DMATRIX* D3DXMatrixInverse(D3DMATRIX* out_mat, float* out_determinant, const D3DMATRIX* m);
	D3DMATRIX* D3DXMatrixScaling(D3DMATRIX* out_mat, float sx, float sy, float sz);
	D3DMATRIX* D3DXMatrixTranslation(D3DMATRIX* out_mat, float x, float y, float z);
	D3DMATRIX* D3DXMatrixRotationX(D3DMATRIX* out_mat, float angle);
	D3DMATRIX* D3DXMatrixRotationY(D3DMATRIX* out_mat, float angle);
	D3DMATRIX* D3DXMatrixRotationZ(D3DMATRIX* out_mat, float angle);
	D3DMATRIX* D3DXMatrixRotationAxis(D3DMATRIX* out_mat, const D3DXVECTOR3* v, float angle);
	D3DMATRIX* D3DXMatrixRotationQuaternion(D3DMATRIX* out_mat, const D3DXQUATERNION* q);
	D3DMATRIX* D3DXMatrixRotationYawPitchRoll(D3DMATRIX* out_mat, float Yaw, float Pitch, float Roll);
	D3DMATRIX* D3DXMatrixTransformation(D3DMATRIX* out_mat, const D3DXVECTOR3* pScalingCenter,
      const D3DXQUATERNION* pScalingRotation, const D3DXVECTOR3* pScaling,
      const D3DXVECTOR3* pRotationCenter, const D3DXQUATERNION* pRotation,
      const D3DXVECTOR3* translation);
	D3DMATRIX* D3DXMatrixAffineTransformation(D3DMATRIX* out_mat, float scaling, const D3DXVECTOR3* rotation_center,
      const D3DXQUATERNION* rotation, const D3DXVECTOR3* translation);
	D3DMATRIX* D3DXMatrixLookAtRH(D3DMATRIX* out_mat, const D3DXVECTOR3* eye, const D3DXVECTOR3* at, const D3DXVECTOR3* up);
	D3DMATRIX* D3DXMatrixLookAtLH(D3DMATRIX* out_mat, const D3DXVECTOR3* eye, const D3DXVECTOR3* at, const D3DXVECTOR3* up);
	D3DMATRIX* D3DXMatrixPerspectiveRH(D3DMATRIX* out_mat, float w, float h, float zn, float zf);
	D3DMATRIX* D3DXMatrixPerspectiveLH(D3DMATRIX* out_mat, float w, float h, float zn, float zf);
	D3DMATRIX* D3DXMatrixPerspectiveFovRH(D3DMATRIX* out_mat, float fovy, float aspect, float zn, float zf);
	D3DMATRIX* D3DXMatrixPerspectiveFovLH(D3DMATRIX* out_mat, float fovy, float aspect, float zn, float zf);
	D3DMATRIX* D3DXMatrixPerspectiveOffCenterRH(D3DMATRIX* out_mat, float l, float r, float b, float t, float zn, float zf);
	D3DMATRIX* D3DXMatrixPerspectiveOffCenterLH(D3DMATRIX* out_mat, float l, float r, float b, float t, float zn, float zf);
	D3DMATRIX* D3DXMatrixOrthoRH(D3DMATRIX* out_mat, float w, float h, float zn, float zf);
	D3DMATRIX* D3DXMatrixOrthoLH(D3DMATRIX* out_mat, float w, float h, float zn, float zf);
	D3DMATRIX* D3DXMatrixOrthoOffCenterRH(D3DMATRIX* out_mat, float l, float r, float b, float t, float zn, float zf);
	D3DMATRIX* D3DXMatrixOrthoOffCenterLH(D3DMATRIX* out_mat, float l, float r, float b, float t, float zn, float zf);
	D3DMATRIX* D3DXMatrixShadow(D3DMATRIX* out_mat, const D3DXVECTOR4* light, const D3DXPLANE* plane);
	D3DMATRIX* D3DXMatrixReflect(D3DMATRIX* out_mat, const D3DXPLANE* plane);

	void D3DXQuaternionToAxisAngle(const D3DXQUATERNION* q, D3DXVECTOR3* out_axis, float* out_angle);
	D3DXQUATERNION* D3DXQuaternionRotationMatrix(D3DXQUATERNION* out_quat, const D3DMATRIX* m);
	D3DXQUATERNION* D3DXQuaternionRotationAxis(D3DXQUATERNION* out_quat, const D3DXVECTOR3* v, float angle);
	D3DXQUATERNION* D3DXQuaternionRotationYawPitchRoll(D3DXQUATERNION* out_quat, float yaw, float pitch, float roll);
	D3DXQUATERNION* D3DXQuaternionMultiply(D3DXQUATERNION* out_quat, const D3DXQUATERNION* q1, const D3DXQUATERNION* q2);
	D3DXQUATERNION* D3DXQuaternionNormalize(D3DXQUATERNION* out_quat, const D3DXQUATERNION* q);
	D3DXQUATERNION* D3DXQuaternionInverse(D3DXQUATERNION* out_quat, const D3DXQUATERNION* q);
	D3DXQUATERNION* D3DXQuaternionLn(D3DXQUATERNION* out_quat, const D3DXQUATERNION* q);
	D3DXQUATERNION* D3DXQuaternionExp(D3DXQUATERNION* out_quat, const D3DXQUATERNION* q);
	D3DXQUATERNION* D3DXQuaternionSlerp(D3DXQUATERNION* out_quat, const D3DXQUATERNION* q1, const D3DXQUATERNION* q2, float t);
	D3DXQUATERNION* D3DXQuaternionSquad(D3DXQUATERNION* out_quat,
		const D3DXQUATERNION* q, const D3DXQUATERNION* a, const D3DXQUATERNION* b, const D3DXQUATERNION* c, float t);
	void D3DXQuaternionSquadSetup(D3DXQUATERNION* out_a, D3DXQUATERNION* out_b, D3DXQUATERNION* out_c,
		const D3DXQUATERNION* q0, const D3DXQUATERNION* q1,
		const D3DXQUATERNION* q2, const D3DXQUATERNION* q3);
	D3DXQUATERNION* D3DXQuaternionBaryCentric(D3DXQUATERNION* out_quat,
		const D3DXQUATERNION* q1, const D3DXQUATERNION* q2, const D3DXQUATERNION* q3,
    float f, float g);

	D3DXPLANE* D3DXPlaneNormalize(D3DXPLANE* out_plane, const D3DXPLANE*);
	D3DXVECTOR3* D3DXPlaneIntersectLine(D3DXVECTOR3* out_vec, const D3DXPLANE*, const D3DXVECTOR3*, const D3DXVECTOR3*);
	D3DXPLANE* D3DXPlaneFromPointNormal(D3DXPLANE* out_plane, const D3DXVECTOR3* point, const D3DXVECTOR3* pNormal);
	D3DXPLANE* D3DXPlaneFromPoints(D3DXPLANE* out_plane, const D3DXVECTOR3* v1, const D3DXVECTOR3* v2, const D3DXVECTOR3* v3);
	D3DXPLANE* D3DXPlaneTransform(D3DXPLANE* out_plane, const D3DXPLANE* p, const D3DMATRIX* m);

	D3DXCOLOR* D3DXColorAdjustSaturation(D3DXCOLOR* out_color, const D3DXCOLOR*, float s);
	D3DXCOLOR* D3DXColorAdjustContrast(D3DXCOLOR* out_color, const D3DXCOLOR* c, float c);

	float D3DXFresnelTerm(float CosTheta, float RefractionIndex);

	int32_t D3DXCreateMatrixStack(uint32_t flags, ID3DXMatrixStack** out_stack);
	
]]

-- core
ffi.cdef [[

	enum {
		D3DXASM_DEBUG = 1,
		D3DXASM_SKIPVALIDATION = 2
	};

	typedef struct D3DXRTS_DESC {
		uint32_t Width, Height;
		D3Denum Format;
		bool32 DepthStencil;
		D3Denum DepthStencilFormat;
	} D3DXRTS_DESC;

	typedef struct D3DXRTE_DESC {
		uint32_t Size;
		D3Denum Format;
		bool32 DepthStencil;
		D3Denum DepthStencilFormat;
	} D3DXRTE_DESC;

]]
com.def {
	{'ID3DXFont';
		methods = {
			{'GetDevice', 'IDirect3DDevice8** out_device'};
			{'GetLogFont', 'LOGFONT* out_logfont'};
			{'Begin'};
			{'DrawTextA', 'char* string, int32_t count, RECT*, uint32_t format, uint32_t color', ret='int32_t'};
			{'DrawTextW', 'wchar_t* string, int32_t count, RECT*, uint32_t format, uint32_t color', ret='int32_t'};
			{'End'};
			{'OnLostDevice'};
			{'OnResetDevice'};
		};
		iid = '89fad6a5-024d-49af-8fe7-f51123b85e25';
	};
	{'ID3DXSprite';
		methods = {
			{'GetDevice', 'IDirect3DDevice8** out_device'};
			{'Begin'};
			{'Draw', [[
				IDirect3DTexture8* src_texture, const RECT* src_rect,
				const D3DXVECTOR2* scale, const D3DXVECTOR2* rotation_center, float rotation, const D3DXVECTOR2* translation,
				uint32_t color]]};
			{'DrawTransform', 'IDirect3DTexture8* src_texture, const RECT* src_rect, const D3DMATRIX* transform, uint32_t color'};
			{'End'};
			{'OnLostDevice'};
			{'OnResetDevice'};
		};
		iid = '13d69d15-f9b0-4e0f-b39e-c91eb33f6ce7';
	};
	{'ID3DXRenderToSurface';
		methods = {
			{'GetDevice', 'IDirect3DDevice8** out_device'};
			{'GetDesc', 'D3DXRTS_DESC* out_desc'};
			{'BeginScene', 'IDirect3DSurface8*, const D3DVIEWPORT8*'};
			{'EndScene'};
			{'OnLostDevice'};
			{'OnResetDevice'};
		};
		iid = '82df5b90-e34e-496e-ac1c-62117a6a5913';
	};
	{'ID3DXRenderToEnvMap';
		methods = {
			{'GetDevice', 'IDirect3DDevice8** out_device'};
			{'GetDesc', 'D3DXRTE_DESC* out_desc'};
			{'BeginCube', 'IDirect3DCubeTexture8*'};
			{'BeginSphere', 'IDirect3DTexture8*'};
			{'BeginHemisphere', 'IDirect3DTexture8* zpositive, IDirect3DTexture8* znegative'};
			{'BeginParabolic', 'IDirect3DTexture8* zpositive, IDirect3DTexture8* znegative'};
			{'Face', 'D3Denum cubemap_faces'};
			{'End'};
			{'OnLostDevice'};
			{'OnResetDevice'};
		};
		iid = '4e42c623-9451-44b7-8c86-abccde5d52c8';
	};
	{'ID3DXBuffer';
		methods = {
			{'GetBufferPointer', ret='void*'};
			{'GetBufferSize', ret='uint32_t'};
		};
		iid = '932e6a7e-c68e-45dd-a7bf-53d19c86db1f';
	};
}
ffi.cdef [[

	int32_t D3DXCreateFont(IDirect3DDevice8*, HFONT, ID3DXFont** out_font);
	int32_t D3DXCreateFontIndirect(IDirect3DDevice8*, const LOGFONT*, ID3DXFont** out_font);
	int32_t D3DXCreateSprite(IDirect3DDevice8*, ID3DXSprite** out_sprite);
	int32_t D3DXCreateRenderToSurface(IDirect3DDevice8*, uint32_t width, uint32_t height, D3Denum format,
		bool32 depthstencil, D3Denum depthstencilformat, ID3DXRenderToSurface** out_rts);
	int32_t D3DXCreateRenderToEnvMap(IDirect3DDevice8*, uint32_t size, D3Denum format,
		bool32 depthstencil, D3Denum depthstencilformat, ID3DXRenderToEnvMap** out_rte);
	int32_t D3DXAssembleShader(void* srcdata, uint32_t length, uint32_t flags,
		ID3DXBuffer** out_constants, ID3DXBuffer** out_compiled, ID3DXBuffer** out_errors);
	int32_t D3DXAssembleShaderFromFileA(char* path, uint32_t flags,
		ID3DXBuffer** out_constants, ID3DXBuffer** out_compiled, ID3DXBuffer** out_errors);
	int32_t D3DXAssembleShaderFromFileW(wchar_t* path, uint32_t flags,
		ID3DXBuffer** out_constants, ID3DXBuffer** out_compiled, ID3DXBuffer** out_errors);
	int32_t D3DXAssembleShaderFromResourceA(HMODULE, char* resource, uint32_t flags,
		ID3DXBuffer** out_constants, ID3DXBuffer** out_compiled, ID3DXBuffer** out_errors);
	int32_t D3DXAssembleShaderFromResourceW(HMODULE, wchar_t* resource, uint32_t flags,
		ID3DXBuffer** out_constants, ID3DXBuffer** out_compiled, ID3DXBuffer** out_errors);
	int32_t D3DXGetErrorStringA(int32_t hresult, char* buffer, uint32_t buffer_length);
	int32_t D3DXGetErrorStringW(int32_t hresult, wchar_t* buffer, uint32_t buffer_length);

]]

-- effect
ffi.cdef [[

	enum {
		D3DXFX_DONOTSAVESTATE = 1,
    D3DXPT_DWORD        = 0,
    D3DXPT_FLOAT        = 1,
    D3DXPT_VECTOR       = 2,
    D3DXPT_MATRIX       = 3,
    D3DXPT_TEXTURE      = 4,
    D3DXPT_VERTEXSHADER = 5,
    D3DXPT_PIXELSHADER  = 6,
    D3DXPT_CONSTANT     = 7,
    D3DXPT_STRING       = 8
	};

	typedef struct D3DXEFFECT_DESC {
		uint32_t Parameters, Techniques;
	} D3DXEFFECT_DESC;

	typedef struct D3DXPARAMETER_DESC {
		char* Name;
		char* Index;
		D3Denum Type;
	} D3DXPARAMETER_DESC;

	typedef struct D3DXTECHNIQUE_DESC {
    char* Name;
    char* Index;
    uint32_t Passes;
	} D3DXTECHNIQUE_DESC;

	typedef struct D3DXPASS_DESC {
		char* Name;
		char* Index;
	} D3DXPASS_DESC;

]]
com.def {
	{'ID3DXEffect';
		methods = {
			{'GetDevice', 'IDirect3DDevice8** out_device'};
			{'GetDesc', 'D3DXEFFECT_DESC* out_desc'};
			{'GetParameterDesc', 'const char* parameter, D3DXPARAMETER_DESC* out_desc'};
			{'GetTechniqueDesc', 'const char* technique, D3DXTECHNIQUE_DESC* out_desc'};
			{'GetPassDesc', 'const char* technique, const char* pass, D3DXPASS_DESC* out_desc'};
			{'FindNextValidTechnique', 'const char* technique, D3DXTECHNIQUE_DESC* out_desc'};
			{'CloneEffect', 'IDirect3DDevice8* device, ID3DXEffect** out_effect'};
			{'GetCompiledEffect', 'ID3DXBuffer** out_compiledeffect'};
			{'SetTechnique', 'const char* technique'};
			{'GetTechnique', 'char** out_technique'};
			{'SetDword', 'const char* parameter, uint32_t dw'};
			{'GetDword', 'const char* parameter, uint32_t* out_dw'};
			{'SetFloat', 'const char* parameter, float f'};
			{'GetFloat', 'const char* parameter, float* out_f'};
			{'SetVector', 'const char* parameter, const D3DXVECTOR4* vector'};
			{'GetVector', 'const char* parameter, D3DXVECTOR4* out_vector'};
			{'SetMatrix', 'const char* parameter, const D3DXMATRIX* vector'};
			{'GetMatrix', 'const char* parameter, D3DXMATRIX* out_vector'};
			{'SetTexture', 'const char* parameter, IDirect3DBaseTexture8* texture'};
			{'GetTexture', 'const char* parameter, IDirect3DBaseTexture8** out_texture'};
			{'SetVertexShader', 'const char* parameter, uint32_t handle'};
			{'GetVertexShader', 'const char* parameter, uint32_t* out_handle'};
			{'SetPixelShader', 'const char* parameter, uint32_t handle'};
			{'GetPixelShader', 'const char* parameter, uint32_t* out_handle'};
			{'SetString', 'const char* parameter, const char* str'};
			{'GetString', 'const char* parameter, char** out_str'};
			{'IsParameterUsed', 'const char* parameter', ret='bool32'};
			{'Validate'};
			{'Begin', 'uint32_t* out_passes, uint32_t flags'};
			{'Pass', 'uint32_t pass'};
			{'End'};
			{'OnLostDevice'};
			{'OnResetDevice'};
		};
		iid = '648b1ceb-8d4e-4d66-b6fa-e44969e82e89';
	};
}
ffi.cdef [[

	int32_t D3DXCreateEffect(IDirect3DDevice8*, void* data, uint32_t size, ID3DXEffect** out_effect, ID3DXBuffer** out_errors);
	int32_t D3DXCreateEffectFromFileA(IDirect3DDevice8*, const char* path, ID3DXEffect** out_effect, ID3DXBuffer** out_errors);
	int32_t D3DXCreateEffectFromFileW(IDirect3DDevice8*, const wchar_t* path, ID3DXEffect** out_effect, ID3DXBuffer** out_errors);
	int32_t D3DXCreateEffectFromResourceA(IDirect3DDevice8*, HMODULE, const char* resource, ID3DXEffect** out_effect, ID3DXBuffer** out_errors);
	int32_t D3DXCreateEffectFromResourceW(IDirect3DDevice8*, HMODULE, const wchar_t* resource, ID3DXEffect** out_effect, ID3DXBuffer** out_errors);

]]

-- mesh
ffi.cdef [[

	enum {
	/*
		D3DXERR_CANNOTMODIFYINDEXBUFFER = MAKE_DDHRESULT(2900),
		D3DXERR_INVALIDMESH = MAKE_DDHRESULT(2901),
		D3DXERR_CANNOTATTRSORT = MAKE_DDHRESULT(2902),
		D3DXERR_SKINNINGNOTSUPPORTED = MAKE_DDHRESULT(2903),
		D3DXERR_TOOMANYINFLUENCES = MAKE_DDHRESULT(2904),
		D3DXERR_INVALIDDATA = MAKE_DDHRESULT(2905),
		D3DXERR_LOADEDMESHASNODATA = MAKE_DDHRESULT(2906),
	*/
		D3DX_COMP_TANGENT_NONE = 0xFFFFFFFF,
    D3DXMESH_32BIT = 0x001,
    D3DXMESH_DONOTCLIP = 0x002,
    D3DXMESH_POINTS = 0x004,
    D3DXMESH_RTPATCHES = 0x008,
    D3DXMESH_NPATCHES = 0x4000,
    D3DXMESH_VB_SYSTEMMEM = 0x010,
    D3DXMESH_VB_MANAGED = 0x020,
    D3DXMESH_VB_WRITEONLY = 0x040,
    D3DXMESH_VB_DYNAMIC = 0x080,
    D3DXMESH_VB_SOFTWAREPROCESSING = 0x8000,
    D3DXMESH_IB_SYSTEMMEM = 0x100,
    D3DXMESH_IB_MANAGED = 0x200,
    D3DXMESH_IB_WRITEONLY = 0x400,
    D3DXMESH_IB_DYNAMIC = 0x800,
    D3DXMESH_IB_SOFTWAREPROCESSING = 0x10000,
    D3DXMESH_VB_SHARE = 0x1000,
    D3DXMESH_USEHWONLY = 0x2000,
    D3DXMESH_SYSTEMMEM = 0x110,
    D3DXMESH_MANAGED = 0x220,
    D3DXMESH_WRITEONLY = 0x440,
    D3DXMESH_DYNAMIC = 0x880,
    D3DXMESH_SOFTWAREPROCESSING = 0x18000,
    D3DXMESHSIMP_VERTEX = 0x1,
    D3DXMESHSIMP_FACE = 0x2,
    MAX_FVF_DECL_SIZE = 20,
    D3DXWELDEPSILONS_WELDALL = 0x1,
    D3DXWELDEPSILONS_WELDPARTIALMATCHES = 0x2,
    D3DXWELDEPSILONS_DONOTREMOVEVERTICES = 0x4,
		UNUSED16 = 0xffff,
		UNUSED32 = 0xffffffff,
    D3DXMESHOPT_COMPACT = 0x01000000,
    D3DXMESHOPT_ATTRSORT = 0x02000000,
    D3DXMESHOPT_VERTEXCACHE = 0x04000000,
    D3DXMESHOPT_STRIPREORDER = 0x08000000,
    D3DXMESHOPT_IGNOREVERTS = 0x10000000,
    D3DXMESHOPT_SHAREVB = 0x1000
	};

	typedef struct D3DXATTRIBUTERANGE {
    uint32_t AttribId, FaceStart, FaceCount, VertexStart, VertexCount;
	} D3DXATTRIBUTERANGE;

	typedef struct D3DXMATERIAL {
    D3DMATERIAL8 MatD3D;
    char* pTextureFilename;
	} D3DXMATERIAL;

	typedef struct D3DXATTRIBUTEWEIGHTS {
		float Position, Boundary, Normal, Diffuse, Specular, Tex[8];
	} D3DXATTRIBUTEWEIGHTS;

	typedef struct D3DXWELDEPSILONS {
		float SkinWeights, Normal, Tex[8];
		uint32_t Flags;
	} D3DXWELDEPSILONS;

	typedef struct D3DXBONECOMBINATION {
    uint32_t AttribId, FaceStart, FaceCount, VertexStart, VertexCount;
    uint32_t* BoneId;
	} D3DXBONECOMBINATION;

	typedef struct D3DXINTERSECTINFO {
    uint32_t FaceIndex;
    float U, V, Dist;
	} D3DXINTERSECTINFO;

]]
com.def {
	{'ID3DXBaseMesh';
		methods = {
			{'DrawSubset', 'uint32_t attribId'};
			{'GetNumFaces', ret='uint32_t'};
			{'GetNumVertices', ret='uint32_t'};
			{'GetFVF', ret='uint32_t'};
			{'GetDeclaration', 'uint32_t declaration[MAX_FVF_DECL_SIZE]'};
			{'GetOptions', ret='uint32_t'};
			{'GetDevice', 'IDirect3DDevice8** out_device'};
			{'CloneMeshFVF', 'uint32_t options, uint32_t fvf, IDirect3DDevice8* device, ID3DXMesh** out_mesh'};
			{'CloneMesh', 'uint32_t options, const uint32_t* declaration, IDirect3DDevice8* device, ID3DXMesh** out_mesh'};
			{'GetVertexBuffer', 'IDirect3DVertexBuffer8** out_vb'};
			{'GetIndexBuffer', 'IDirect3DIndexBuffer8** out_ib'};
			{'LockVertexBuffer', 'uint32_t Flags, uint8_t** out_ptr'};
			{'UnlockVertexBuffer'};
			{'LockIndexBuffer', 'uint32_t Flags, uint8_t** out_ptr'};
			{'UnlockIndexBuffer'};
			{'GetAttributeTable', 'D3DXATTRIBUTERANGE *pAttribTable, uint32_t* pAttribTableSize'};
			{'ConvertPointRepsToAdjacency', 'const uint32_t* pPRep, uint32_t* pAdjacency'};
			{'ConvertAdjacencyToPointReps', 'const uint32_t* pAdjacency, uint32_t* pPRep'};
			{'GenerateAdjacency', 'float Epsilon, uint32_t* pAdjacency'};
		};
		iid = '2a835771-bf4d-43f4-8e14-82a809f17d8a';
	};
	{'ID3DXMesh', inherits='ID3DXBaseMesh';
		methods = {
			{'LockAttributeBuffer', 'uint32_t Flags, uint32_t** ppData'};
			{'UnlockAttributeBuffer'};
			{'Optimize', [[
				uint32_t flags, const uint32_t* adjacency, uint32_t* out_adjacency, uint32_t* face_remap, ID3DXBuffer** out_vertexremap, ID3DXMesh** out_mesh]]};
			{'OptimizeInplace', 'uint32_t Flags, const uint32_t* pAdjacencyIn, uint32_t* pAdjacencyOut, uint32_t* pFaceRemap, ID3DXBuffer* *ppVertexRemap'};
		};
		iid = 'ccae5c3b-4dd1-4d0f-997e-4684ca64557f';
	};
	{'ID3DXPMesh', inherits='ID3DXBaseMesh';
		methods = {
			{'ClonePMeshFVF', 'uint32_t Options, uint32_t FVF, IDirect3DDevice8* pD3D, ID3DXPMesh** ppCloneMesh'};
			{'ClonePMesh', 'uint32_t Options, const uint32_t *pDeclaration, IDirect3DDevice8* pD3D, ID3DXPMesh** ppCloneMesh'};
			{'SetNumFaces', 'uint32_t Faces'};
			{'SetNumVertices', 'uint32_t Vertices'};
			{'GetMaxFaces', ret='uint32_t'};
			{'GetMinFaces', ret='uint32_t'};
			{'GetMaxVertices', ret='uint32_t'};
			{'GetMinVertices', ret='uint32_t'};
			{'Save', 'IStream *pStream, D3DXMATERIAL* pMaterials, uint32_t NumMaterials'};
			{'Optimize', 'uint32_t flags, uint32_t* out_adjacency, uint32_t* out_faceremap, ID3DXBuffer** out_vertexremap, ID3DXMesh** out_mesh'};
			{'OptimizeBaseLOD', 'uint32_t flags, uint32_t* pFaceRemap'};
			{'TrimByFaces', 'uint32_t NewFacesMin, uint32_t NewFacesMax, uint32_t *rgiFaceRemap, uint32_t *rgiVertRemap'};
			{'TrimByVertices', 'uint32_t NewVerticesMin, uint32_t NewVerticesMax, uint32_t *rgiFaceRemap, uint32_t *rgiVertRemap'};
			{'GetAdjacency', 'uint32_t* pAdjacency'};
		};
		iid = '19fbe386-c282-4659-97bd-cb869b084a6c';
	};
	{'ID3DXSPMesh'; -- not a mistake: inherits only from IUnknown
		methods = {
			{'GetNumFaces', ret='uint32_t'};
			{'GetNumVertices', ret='uint32_t'};
			{'GetFVF', ret='uint32_t'};
			{'GetDeclaration', 'uint32_t declaration[MAX_FVF_DECL_SIZE]'};
			{'GetOptions', ret='uint32_t'};
			{'GetDevice', 'IDirect3DDevice8** out_device'};
			{'CloneMeshFVF', 'uint32_t options, uint32_t fvf, IDirect3DDevice8* pD3D, uint32_t *pAdjacencyOut, uint32_t *pVertexRemapOut, ID3DXMesh** ppCloneMesh'};
			{'CloneMesh', 'uint32_t Options, const uint32_t *declaration, IDirect3DDevice8* pD3DDevice, uint32_t *pAdjacencyOut, uint32_t *pVertexRemapOut, ID3DXMesh** ppCloneMesh'};
			{'ClonePMeshFVF', 'uint32_t Options, uint32_t fvf, IDirect3DDevice8* pD3D, uint32_t *pVertexRemapOut, ID3DXPMesh** ppCloneMesh'};
			{'ClonePMesh', 'uint32_t Options, const uint32_t *declaration, IDirect3DDevice8* pD3D, uint32_t *pVertexRemapOut, ID3DXPMesh** ppCloneMesh'};
			{'ReduceFaces', 'uint32_t Faces'};
			{'ReduceVertices', 'uint32_t Vertices'};
			{'GetMaxFaces', ret='uint32_t'};
			{'GetMaxVertices', ret='uint32_t'};
			{'GetVertexAttributeWeights', 'D3DXATTRIBUTEWEIGHTS* out_weights'};
			{'GetVertexWeights', 'float *pVertexWeights'};
		};
		iid = '4e3ca05c-d4ff-4d11-8a02-16459e08f6f4';
	};
	{'ID3DXSkinMesh'; -- also inherits from IUnknown
		methods = {
			{'GetNumFaces', ret='uint32_t'};
			{'GetNumVertices', ret='uint32_t'};
			{'GetFVF', ret='uint32_t'};
			{'GetDeclaration', 'uint32_t Declaration[MAX_FVF_DECL_SIZE]'};
			{'GetOptions', ret='uint32_t'};
			{'GetDevice', 'IDirect3DDevice8** out_device'};
			{'GetVertexBuffer', 'IDirect3DVertexBuffer8** out_vb'};
			{'GetIndexBuffer', 'IDirect3DIndexBuffer8** out_ib'};
			{'LockVertexBuffer', 'uint32_t flags, uint8_t** ppData'};
			{'UnlockVertexBuffer'};
			{'LockIndexBuffer', 'uint32_t flags, uint8_t** ppData'};
			{'UnlockIndexBuffer'};
			{'LockAttributeBuffer', 'uint32_t flags, uint32_t** ppData'};
			{'UnlockAttributeBuffer'};
			{'GetNumBones', ret='uint32_t'};
			{'GetOriginalMesh', 'ID3DXMesh** ppMesh'};
			{'SetBoneInfluence', 'uint32_t bone, uint32_t numInfluences, const uint32_t* vertices, const float* weights'};
			{'GetNumBoneInfluences', 'uint32_t bone', ret='uint32_t'};
			{'GetBoneInfluence', 'uint32_t bone, uint32_t* vertices, float* weights'};
			{'GetMaxVertexInfluences', 'uint32_t* maxVertexInfluences'};
			{'GetMaxFaceInfluences', 'uint32_t* maxFaceInfluences'};
			{'ConvertToBlendedMesh', 'uint32_t options, const uint32_t* pAdjacencyIn, uint32_t* pAdjacencyOut, uint32_t* pNumBoneCombinations, ID3DXBuffer** ppBoneCombinationTable, uint32_t* pFaceRemap, ID3DXBuffer* *ppVertexRemap, ID3DXMesh** ppMesh'};
			{'ConvertToIndexedBlendedMesh', 'uint32_t Options, const uint32_t* pAdjacencyIn, uint32_t paletteSize, uint32_t* pAdjacencyOut, uint32_t* pNumBoneCombinations, ID3DXBuffer** ppBoneCombinationTable, uint32_t* pFaceRemap, ID3DXBuffer* *ppVertexRemap, ID3DXMesh** ppMesh'};
			{'GenerateSkinnedMesh', 'uint32_t Options, float minWeight, const uint32_t* pAdjacencyIn, uint32_t* pAdjacencyOut, uint32_t* pFaceRemap, ID3DXBuffer* *ppVertexRemap, ID3DXMesh** ppMesh'};
			{'UpdateSkinnedMesh', 'const D3DMATRIX* pBoneTransforms, const D3DMATRIX* pBoneInvTransforms, ID3DXMesh* pMesh'};
		};
		iid = '8db06ecc-ebfc-408a-9404-3074b4773515';
	};
}
ffi.cdef [[

	int32_t D3DXCreateMesh(uint32_t NumFaces, uint32_t NumVertices, uint32_t Options, const uint32_t *pDeclaration, IDirect3DDevice8* pD3D, ID3DXMesh** ppMesh);
	int32_t D3DXCreateMeshFVF(uint32_t NumFaces, uint32_t NumVertices, uint32_t Options, uint32_t fvf, IDirect3DDevice8* pD3D, ID3DXMesh** ppMesh);
	int32_t D3DXCreateSPMesh(ID3DXMesh* pMesh, const uint32_t* pAdjacency, const D3DXATTRIBUTEWEIGHTS*, const float *pVertexWeights, ID3DXSPMesh** ppSMesh);
	int32_t D3DXCleanMesh(ID3DXMesh* pMeshIn, const uint32_t* pAdjacencyIn, ID3DXMesh** ppMeshOut, uint32_t* pAdjacencyOut, ID3DXBuffer** ppErrorsAndWarnings);
	int32_t D3DXValidMesh(ID3DXMesh* pMeshIn, const uint32_t* pAdjacency, ID3DXBuffer** ppErrorsAndWarnings);
	int32_t D3DXGeneratePMesh(ID3DXMesh* pMesh, const uint32_t* pAdjacency, const D3DXATTRIBUTEWEIGHTS*, const float *pVertexWeights, uint32_t MinValue, uint32_t Options, ID3DXPMesh** ppPMesh);
	int32_t D3DXSimplifyMesh(ID3DXMesh* pMesh, const uint32_t* pAdjacency, const D3DXATTRIBUTEWEIGHTS*, const float *pVertexWeights, uint32_t MinValue, uint32_t Options, ID3DXMesh** ppMesh);
	int32_t D3DXComputeBoundingSphere(void* pPointsFVF, uint32_t NumVertices, uint32_t fvf, D3DXVECTOR3 *pCenter, float *pRadius);
	int32_t D3DXComputeBoundingBox(void* pPointsFVF, uint32_t NumVertices, uint32_t fvf, D3DXVECTOR3 *pMin, D3DXVECTOR3 *pMax);
	int32_t D3DXComputeNormals(ID3DXBaseMesh* pMesh, const uint32_t *pAdjacency);
	int32_t D3DXCreateBuffer(uint32_t size, ID3DXBuffer** out_buffer);
	int32_t D3DXLoadMeshFromX(char* filename, uint32_t options, IDirect3DDevice8*,
		ID3DXBuffer** out_adjacency, ID3DXBuffer** out_materials, uint32_t* out_nummaterials, ID3DXMesh** out_mesh);
	int32_t D3DXLoadMeshFromXInMemory(uint8_t* memory, uint32_t size, uint32_t options, IDirect3DDevice8*,
		ID3DXBuffer** out_adjacency, ID3DXBuffer** out_materials, uint32_t* out_nummaterials, ID3DXMesh** out_mesh);
	/*
	int32_t D3DXLoadMeshFromXResource(
        HMODULE Module,
        LPCTSTR Name,
        LPCTSTR Type,
        uint32_t Options,
        IDirect3DDevice8* pD3D,
        ID3DXBuffer* *ppAdjacency,
        ID3DXBuffer* *ppMaterials,
        uint32_t *pNumMaterials,
        ID3DXMesh* *ppMesh);
	*/
	int32_t D3DXSaveMeshToX(char* pFilename, ID3DXMesh* pMesh, const uint32_t* pAdjacency, const D3DXMATERIAL* pMaterials, uint32_t NumMaterials, uint32_t Format);
	int32_t D3DXCreatePMeshFromStream(IStream *pStream, uint32_t Options, IDirect3DDevice8*, ID3DXBuffer* *ppMaterials, uint32_t* pNumMaterials, ID3DXPMesh* *ppPMesh);
	int32_t D3DXCreateSkinMesh(uint32_t NumFaces, uint32_t NumVertices, uint32_t NumBones,
		uint32_t Options, const uint32_t* declaration, IDirect3DDevice8*, ID3DXSkinMesh** out_skinmesh);
	int32_t D3DXCreateSkinMeshFVF(uint32_t NumFaces, uint32_t NumVertices, uint32_t NumBones, uint32_t Options, uint32_t fvf, IDirect3DDevice8*, ID3DXSkinMesh** out_skinmesh);
	int32_t D3DXCreateSkinMeshFromMesh(ID3DXMesh*, uint32_t numBones, ID3DXSkinMesh** out_skinmesh);
	/*
	int32_t D3DXLoadMeshFromXof(
        LPDIRECTXFILEDATA pXofObjMesh,
        uint32_t Options,
        IDirect3DDevice8* pD3DDevice,
        ID3DXBuffer* *ppAdjacency,
        ID3DXBuffer* *ppMaterials,
        uint32_t *pNumMaterials,
        ID3DXMesh* *ppMesh);
	int32_t D3DXLoadSkinMeshFromXof(
        LPDIRECTXFILEDATA pxofobjMesh,
        uint32_t Options,
        IDirect3DDevice8* pD3D,
        ID3DXBuffer** ppAdjacency,
        ID3DXBuffer** ppMaterials,
        uint32_t *pMatOut,
        ID3DXBuffer** ppBoneNames,
        ID3DXBuffer** ppBoneTransforms,
        ID3DXSkinMesh** ppMesh);
	*/
	int32_t D3DXTessellateNPatches(ID3DXMesh* pMeshIn, const uint32_t* pAdjacencyIn, float NumSegs, bool32 QuadraticInterpNormals, ID3DXMesh** ppMeshOut, ID3DXBuffer** ppAdjacencyOut);
	uint32_t D3DXGetFVFVertexSize(uint32_t fvf);
	int32_t D3DXDeclaratorFromFVF(uint32_t fvf, uint32_t Declaration[MAX_FVF_DECL_SIZE]);

	int32_t D3DXFVFFromDeclarator(const uint32_t *pDeclarator, uint32_t *pFVF);

	/*
	int32_t D3DXWeldVertices(const ID3DXMesh* pMesh,
        LPD3DXWELDEPSILONS pEpsilons,
        const uint32_t *pAdjacencyIn,
        uint32_t *pAdjacencyOut,
        uint32_t* pFaceRemap,
        ID3DXBuffer* *ppVertexRemap);
	*/
	
	int32_t D3DXIntersect(ID3DXBaseMesh* pMesh, const D3DXVECTOR3 *pRayPos, const D3DXVECTOR3 *pRayDir, bool32 *pHit, uint32_t *pFaceIndex, float *pU, float *pV, float *pDist, ID3DXBuffer* *ppAllHits, uint32_t *pCountOfHits);
	int32_t D3DXIntersectSubset(ID3DXBaseMesh* pMesh, uint32_t AttribId, const D3DXVECTOR3 *pRayPos, const D3DXVECTOR3 *pRayDir, bool32 *pHit, uint32_t *pFaceIndex, float   *pU, float *pV, float *pDist, ID3DXBuffer* *ppAllHits, uint32_t* pCountOfHits);
	int32_t  D3DXSplitMesh(const ID3DXMesh* pMeshIn, const uint32_t *pAdjacencyIn, const uint32_t MaxSize, const uint32_t Options, uint32_t *pMeshesOut, ID3DXBuffer* *ppMeshArrayOut, ID3DXBuffer* *ppAdjacencyArrayOut, ID3DXBuffer* *ppFaceRemapArrayOut, ID3DXBuffer* *ppVertRemapArrayOut);
	bool32 D3DXIntersectTri(const D3DXVECTOR3 *p0, const D3DXVECTOR3 *p1, const D3DXVECTOR3 *p2, const D3DXVECTOR3 *pRayPos, const D3DXVECTOR3 *pRayDir, float *pU, float *pV, float *pDist);
	bool32 D3DXSphereBoundProbe(const D3DXVECTOR3 *pCenter, float Radius, const D3DXVECTOR3 *pRayPosition, const D3DXVECTOR3 *pRayDirection);
	bool32 D3DXBoxBoundProbe(const D3DXVECTOR3 *pMin, const D3DXVECTOR3 *pMax, const D3DXVECTOR3 *pRayPosition, const D3DXVECTOR3 *pRayDirection);
	int32_t D3DXComputeTangent(ID3DXMesh* InMesh, uint32_t TexStage, ID3DXMesh* OutMesh, uint32_t TexStageUVec, uint32_t TexStageVVec, uint32_t Wrap, uint32_t *Adjacency);
	int32_t D3DXConvertMeshSubsetToSingleStrip(ID3DXBaseMesh* MeshIn, uint32_t AttribId, uint32_t IBOptions, IDirect3DIndexBuffer8* *ppIndexBuffer, uint32_t *pNumIndices);
	int32_t D3DXConvertMeshSubsetToStrips(ID3DXBaseMesh* mesh, uint32_t AttribId, uint32_t IBOptions,
		IDirect3DIndexBuffer8** out_indexbuffer, uint32_t *out_indices, ID3DXBuffer** out_striplengths, uint32_t* out_numstrips);

]]

-- shape
ffi.cdef [[

	int32_t D3DXCreatePolygon(IDirect3DDevice8*, float length, uint32_t sides, ID3DXMesh** out_mesh, ID3DXBuffer** out_adjacency);
	int32_t D3DXCreateBox(IDirect3DDevice8*, float width, float height, float depth, ID3DXMesh** out_mesh, ID3DXBuffer** out_adjacency);
	int32_t D3DXCreateCylinder(IDirect3DDevice8*, float radius1, float radius2, float length, uint32_t slices, uint32_t stacks, ID3DXMesh** out_mesh, ID3DXMesh** out_adjacency);
	int32_t D3DXCreateSphere(IDirect3DDevice8*, float radius, uint32_t slices, uint32_t stacks, ID3DXMesh** out_mesh, ID3DXBuffer** out_adjacency);
	int32_t D3DXCreateTorus(IDirect3DDevice8*, float innerRadius, float outerRadius, uint32_t sides, uint32_t rings, ID3DXMesh** out_mesh, ID3DXBuffer** out_adjacency);
	int32_t D3DXCreateTeapot(IDirect3DDevice8*, ID3DXMesh** out_mesh, ID3DXBuffer** out_adjacency);
	/*
	int32_t D3DXCreateTextA(IDirect3DDevice8*, HDC, const char* text, float deviation, float extrusion, ID3DXMesh** out_mesh, ID3DXBuffer* out_adjacency, GLYPHMETRICSFLOAT*);
	int32_t D3DXCreateTextW(IDirect3DDevice8*, HDC, const wchar_t* text, float deviation, float extrusion, ID3DXMesh** out_mesh, ID3DXBuffer* out_adjacency, GLYPHMETRICSFLOAT*);
	*/

]]

-- tex
ffi.cdef [[

	enum {
		D3DX_FILTER_NONE = 1,
		D3DX_FILTER_POINT = 2,
		D3DX_FILTER_LINEAR = 3,
		D3DX_FILTER_TRIANGLE = 4,
		D3DX_FILTER_BOX = 5,
		D3DX_FILTER_MIRROR_U = 0x10000,
		D3DX_FILTER_MIRROR_V = 0x20000,
		D3DX_FILTER_MIRROR_W = 0x40000,
		D3DX_FILTER_MIRROR = 0x70000,
		D3DX_FILTER_DITHER = 0x80000,
		D3DX_NORMALMAP_MIRROR_U = 0x10000,
		D3DX_NORMALMAP_MIRROR_V = 0x20000,
		D3DX_NORMALMAP_MIRROR = 0x30000,
		D3DX_NORMALMAP_INVERTSIGN = 0x80000,
		D3DX_NORMALMAP_COMPUTE_OCCLUSION = 0x100000,
		D3DX_CHANNEL_RED = 1,
		D3DX_CHANNEL_BLUE = 2,
		D3DX_CHANNEL_GREEN = 4,
		D3DX_CHANNEL_ALPHA = 8,
		D3DX_CHANNEL_LUMINANCE = 16,
		D3DXIFF_BMP = 0,
		D3DXIFF_JPG = 1,
		D3DXIFF_TGA = 2,
		D3DXIFF_PNG = 3,
		D3DXIFF_DDS = 4,
		D3DXIFF_PPM = 5,
		D3DXIFF_DIB = 6
	};

	typedef struct D3DXIMAGE_INFO {
    uint32_t Width, Height, Depth, MipLevels;
		D3Denum Format, ResourceType, ImageFileFormat;
	} D3DXIMAGE_INFO;

	int32_t D3DXGetImageInfoFromFileA(const char* path, D3DXIMAGE_INFO* out_info);
	int32_t D3DXGetImageInfoFromFileW(const wchar_t* path, D3DXIMAGE_INFO* out_info);
	int32_t D3DXGetImageInfoFromResourceA(HMODULE, const char* resource, D3DXIMAGE_INFO* out_info);
	int32_t D3DXGetImageInfoFromResourceW(HMODULE, const wchar_t* resource, D3DXIMAGE_INFO* out_info);
	int32_t D3DXGetImageInfoFromFileInMemory(const void* data, uint32_t size, D3DXIMAGE_INFO* out_info);
	int32_t D3DXLoadSurfaceFromFileA(
		IDirect3DSurface8* dest, const PALETTEENTRY* dest_palette, const RECT* dest_rect,
		const char* src_path, const RECT* src_rect,
		uint32_t filter, uint32_t colorkey, D3DXIMAGE_INFO* out_info);
	int32_t D3DXLoadSurfaceFromFileW(
		IDirect3DSurface8* dest, const PALETTEENTRY* dest_palette, const RECT* dest_rect,
		const wchar_t* src_path, const RECT* src_rect,
		uint32_t filter, uint32_t colorkey, D3DXIMAGE_INFO* out_info);
	int32_t D3DXLoadSurfaceFromResourceA(
		IDirect3DSurface8* dest, const PALETTEENTRY* dest_palette, const RECT* dest_rect,
		HMODULE src_module, const char* src_resource, const RECT* src_rect,
		uint32_t filter, uint32_t colorkey, D3DXIMAGE_INFO* out_info);
	int32_t D3DXLoadSurfaceFromResourceA(
		IDirect3DSurface8* dest, const PALETTEENTRY* dest_palette, const RECT* dest_rect,
		HMODULE src_module, const wchar_t* src_resource, const RECT* src_rect,
		uint32_t filter, uint32_t colorkey, D3DXIMAGE_INFO* out_info);
	int32_t D3DXLoadSurfaceFromFileInMemory(IDirect3DSurface8* dest, const PALETTEENTRY* dest_palette, const RECT* dest_rect,
		const void* src_data, uint32_t src_size, const RECT* src_rect,
		uint32_t filter, uint32_t colorkey, D3DXIMAGE_INFO* src_info);
	int32_t D3DXLoadSurfaceFromSurface(IDirect3DSurface8* dest, const PALETTEENTRY* dest_palette, const RECT* dest_rect,
		IDirect3DSurface8* src_surface, const PALETTEENTRY* src_palette, const RECT* src_rect, uint32_t filter, uint32_t colorkey);
	int32_t D3DXLoadSurfaceFromMemory(IDirect3DSurface8* dest, const PALETTEENTRY* dest_palette, const RECT* dest_rect,
		const void* src_data, D3Denum src_format, uint32_t src_pitch, const PALETTEENTRY* src_palette, const RECT* src_rect,
		uint32_t filter, uint32_t colorkey);
	int32_t D3DXSaveSurfaceToFileA(const char* dest_path, D3Denum dest_format,
		IDirect3DSurface8* src_surface, const PALETTEENTRY* src_palette, const RECT* src_rect);
	int32_t D3DXSaveSurfaceToFileW(const wchar_t* dest_path, D3Denum dest_format,
		IDirect3DSurface8* src_surface, const PALETTEENTRY* src_palette, const RECT* src_rect);
	int32_t D3DXLoadVolumeFromFileA(IDirect3DVolume8* dest_volume, const PALETTEENTRY* dest_palette, const D3DBOX* dest_box,
		const char* src_path, const D3DBOX* src_box,
		uint32_t filter, uint32_t colorkey, D3DXIMAGE_INFO* src_info);
	int32_t D3DXLoadVolumeFromFileW(IDirect3DVolume8* dest_volume, const PALETTEENTRY* dest_palette, const D3DBOX* dest_box,
		const wchar_t* src_path, const D3DBOX* src_box,
		uint32_t filter, uint32_t colorkey, D3DXIMAGE_INFO* src_info);
	int32_t D3DXLoadVolumeFromResourceA(IDirect3DVolume8* dest_volume, const PALETTEENTRY* dest_palette, const D3DBOX* dest_box,
		HMODULE src_module, const char* src_resource, const D3DBOX* src_box,
		uint32_t filter, uint32_t colorkey, D3DXIMAGE_INFO* src_info);
	int32_t D3DXLoadVolumeFromResourceW(IDirect3DVolume8* dest_volume, const PALETTEENTRY* dest_palette, const D3DBOX* dest_box,
		HMODULE src_module, const wchar_t* src_resource, const D3DBOX* src_box,
		uint32_t filter, uint32_t colorkey, D3DXIMAGE_INFO* src_info);
	int32_t D3DXLoadVolumeFromFileInMemory(IDirect3DVolume8* dest_volume, const PALETTEENTRY* dest_palette, const D3DBOX* dest_box,
		const void* src_data, uint32_t src_size, const D3DBOX* src_box,
		uint32_t filter, uint32_t colorkey, D3DXIMAGE_INFO* src_info);
	int32_t D3DXLoadVolumeFromVolume(IDirect3DVolume8* dest_volume, const PALETTEENTRY* dest_palette, const D3DBOX* dest_box,
		IDirect3DVolume8* src_volume, const PALETTEENTRY* src_palette, const D3DBOX* src_box,
		uint32_t filter, uint32_t colorkey);
	int32_t D3DXLoadVolumeFromMemory(IDirect3DVolume8* dest_volume, const PALETTEENTRY* dest_palette, const D3DBOX* dest_box,
		const void* src_data, D3Denum src_format, uint32_t src_rowpitch, uint32_t src_slicepitch, const PALETTEENTRY* src_palette, const D3DBOX* src_box,
		uint32_t filter, uint32_t colorkey);
	int32_t D3DXSaveVolumeToFileA(const char* dest_path, D3Denum dest_format,
		IDirect3DVolume8* src_volume, const PALETTEENTRY* src_palette, const D3DBOX* src_box);
	int32_t D3DXSaveVolumeToFileW(const wchar_t* dest_path, D3Denum dest_format,
		IDirect3DVolume8* src_volume, const PALETTEENTRY* src_palette, const D3DBOX* src_box);
	int32_t D3DXCheckTextureRequirements(IDirect3DDevice8*, uint32_t* pWidth, uint32_t* pHeight, uint32_t* pNumMipLevels, uint32_t usage, D3Denum* pFormat, D3Denum pool);
	int32_t D3DXCheckCubeTextureRequirements(IDirect3DDevice8*, uint32_t* pSize, uint32_t* pNumMipLevels, uint32_t usage, D3Denum* pFormat, D3Denum pool);
	int32_t D3DXCheckVolumeTextureRequirements(IDirect3DDevice8*, uint32_t* pWidth, uint32_t* pHeight, uint32_t* pDepth, uint32_t* pNumMipLevels, uint32_t usage, D3Denum* pFormat, D3Denum pool);
	int32_t D3DXCreateTexture(IDirect3DDevice8*, uint32_t width, uint32_t height, uint32_t MipLevels, uint32_t usage, D3Denum Format, D3Denum pool, IDirect3DTexture8** out_tex);
	int32_t D3DXCreateCubeTexture(IDirect3DDevice8*, uint32_t Size, uint32_t MipLevels, uint32_t usage, D3Denum Format, D3Denum pool, IDirect3DCubeTexture8** out_tex);
	int32_t D3DXCreateVolumeTexture(IDirect3DDevice8*, uint32_t width, uint32_t height, uint32_t Depth, uint32_t MipLevels, uint32_t usage, D3Denum Format, D3Denum pool, IDirect3DVolumeTexture8** out_tex);
	int32_t D3DXCreateTextureFromFileA(IDirect3DDevice8*, const char* src_path, IDirect3DTexture8** out_tex);
	int32_t D3DXCreateTextureFromFileW(IDirect3DDevice8*, const wchar_t* src_path, IDirect3DTexture8** out_tex);
	int32_t D3DXCreateCubeTextureFromFileA(IDirect3DDevice8*, const char* src_path, IDirect3DCubeTexture8** out_tex);
	int32_t D3DXCreateCubeTextureFromFileW(IDirect3DDevice8*, const wchar_t* src_path, IDirect3DCubeTexture8** out_tex);
	int32_t D3DXCreateVolumeTextureFromFileA(IDirect3DDevice8*, const char* src_path, IDirect3DVolumeTexture8** out_tex);
	int32_t D3DXCreateVolumeTextureFromFileW(IDirect3DDevice8*, const wchar_t* src_path, IDirect3DVolumeTexture8** out_tex);
	int32_t D3DXCreateTextureFromResourceA(IDirect3DDevice8*, HMODULE src_module, const char* src_resource, IDirect3DTexture8** out_tex);
	int32_t D3DXCreateTextureFromResourceW(IDirect3DDevice8*, HMODULE src_module, const wchar_t* src_resource, IDirect3DTexture8** out_tex);
	int32_t D3DXCreateCubeTextureFromResourceA(IDirect3DDevice8*, HMODULE src_module, const char* src_resource, IDirect3DCubeTexture8** out_tex);
	int32_t D3DXCreateCubeTextureFromResourceW(IDirect3DDevice8*, HMODULE src_module, const wchar_t* src_resource, IDirect3DCubeTexture8** out_tex);
	int32_t D3DXCreateVolumeTextureFromResourceA(IDirect3DDevice8*, HMODULE src_module, const char* src_resource, IDirect3DVolumeTexture8** out_tex);
	int32_t D3DXCreateVolumeTextureFromResourceW(IDirect3DDevice8*, HMODULE src_module, const wchar_t* src_resource, IDirect3DVolumeTexture8** out_tex);
	int32_t D3DXCreateTextureFromFileExA(IDirect3DDevice8*, const char* src_path, uint32_t width, uint32_t height, uint32_t MipLevels, uint32_t usage, D3Denum Format, D3Denum pool, uint32_t filter, uint32_t MipFilter, uint32_t colorkey, D3DXIMAGE_INFO* src_info, PALETTEENTRY* palette, IDirect3DTexture8** out_tex);
	int32_t D3DXCreateTextureFromFileExW(IDirect3DDevice8*, const wchar_t* src_path, uint32_t width, uint32_t height, uint32_t MipLevels, uint32_t usage, D3Denum Format, D3Denum pool, uint32_t filter, uint32_t MipFilter, uint32_t colorkey, D3DXIMAGE_INFO* src_info, PALETTEENTRY* palette, IDirect3DTexture8** out_tex);
	int32_t D3DXCreateCubeTextureFromFileExA(IDirect3DDevice8*, const char* src_path, uint32_t Size, uint32_t MipLevels, uint32_t usage, D3Denum Format, D3Denum pool, uint32_t filter, uint32_t MipFilter, uint32_t colorkey, D3DXIMAGE_INFO* src_info, PALETTEENTRY* palette, IDirect3DCubeTexture8** out_tex);
	int32_t D3DXCreateCubeTextureFromFileExW(IDirect3DDevice8*, const wchar_t* src_path, uint32_t Size, uint32_t MipLevels, uint32_t usage, D3Denum Format, D3Denum pool, uint32_t filter, uint32_t MipFilter, uint32_t colorkey, D3DXIMAGE_INFO* src_info, PALETTEENTRY* palette, IDirect3DCubeTexture8** out_tex);
	int32_t D3DXCreateVolumeTextureFromFileExA(IDirect3DDevice8*, const char* src_path, uint32_t width, uint32_t height, uint32_t Depth, uint32_t MipLevels, uint32_t usage, D3Denum Format, D3Denum pool, uint32_t filter, uint32_t MipFilter, uint32_t colorkey, D3DXIMAGE_INFO* src_info, PALETTEENTRY* palette, IDirect3DVolumeTexture8** out_tex);
	int32_t D3DXCreateVolumeTextureFromFileExW(IDirect3DDevice8*, const wchar_t* src_path, uint32_t width, uint32_t height, uint32_t Depth, uint32_t MipLevels, uint32_t usage, D3Denum Format, D3Denum pool, uint32_t filter, uint32_t MipFilter, uint32_t colorkey, D3DXIMAGE_INFO* src_info, PALETTEENTRY* palette, IDirect3DVolumeTexture8** out_tex);
	int32_t D3DXCreateTextureFromResourceExA(IDirect3DDevice8*, HMODULE src_module, const char* src_resource, uint32_t width, uint32_t height, uint32_t MipLevels, uint32_t usage, D3Denum Format, D3Denum pool, uint32_t filter, uint32_t MipFilter, uint32_t colorkey, D3DXIMAGE_INFO* src_info, PALETTEENTRY* palette, IDirect3DTexture8** out_tex);
	int32_t D3DXCreateTextureFromResourceExW(IDirect3DDevice8*, HMODULE src_module, const wchar_t* src_resource, uint32_t width, uint32_t height, uint32_t MipLevels, uint32_t usage, D3Denum Format, D3Denum pool, uint32_t filter, uint32_t MipFilter, uint32_t colorkey, D3DXIMAGE_INFO* src_info, PALETTEENTRY* palette, IDirect3DTexture8** out_tex);
	int32_t D3DXCreateCubeTextureFromResourceExA(IDirect3DDevice8*, HMODULE src_module, const char* src_resource, uint32_t Size, uint32_t MipLevels, uint32_t usage, D3Denum Format, D3Denum pool, uint32_t filter, uint32_t MipFilter, uint32_t colorkey, D3DXIMAGE_INFO* src_info, PALETTEENTRY* palette, IDirect3DCubeTexture8** out_tex);
	int32_t D3DXCreateCubeTextureFromResourceExW(IDirect3DDevice8*, HMODULE src_module, const wchar_t* src_resource, uint32_t Size, uint32_t MipLevels, uint32_t usage, D3Denum Format, D3Denum pool, uint32_t filter, uint32_t MipFilter, uint32_t colorkey, D3DXIMAGE_INFO* src_info, PALETTEENTRY* palette, IDirect3DCubeTexture8** out_tex);
	int32_t D3DXCreateVolumeTextureFromResourceExA(IDirect3DDevice8*, HMODULE src_module, const char* src_resource,
	uint32_t width, uint32_t height, uint32_t Depth, uint32_t MipLevels, uint32_t usage, D3Denum Format, D3Denum pool, uint32_t filter, uint32_t MipFilter, uint32_t colorkey, D3DXIMAGE_INFO* src_info, PALETTEENTRY* palette, IDirect3DVolumeTexture8** out_tex);
	int32_t D3DXCreateVolumeTextureFromResourceExW(IDirect3DDevice8*, HMODULE src_module, const wchar_t* src_resource, uint32_t width, uint32_t height, uint32_t Depth, uint32_t MipLevels, uint32_t usage, D3Denum Format, D3Denum pool, uint32_t filter, uint32_t MipFilter, uint32_t colorkey, D3DXIMAGE_INFO* src_info, PALETTEENTRY* palette, IDirect3DVolumeTexture8** out_tex);
	int32_t D3DXCreateTextureFromFileInMemory(IDirect3DDevice8*, const void* src_data, uint32_t src_size, IDirect3DTexture8** out_tex);
	int32_t D3DXCreateCubeTextureFromFileInMemory(IDirect3DDevice8*, const void* src_data, uint32_t src_size, IDirect3DCubeTexture8** out_tex);
	int32_t D3DXCreateVolumeTextureFromFileInMemory(IDirect3DDevice8*, const void* src_data, uint32_t src_size, IDirect3DVolumeTexture8** out_tex);
	int32_t D3DXCreateTextureFromFileInMemoryEx(IDirect3DDevice8*, const void* src_data, uint32_t src_size, uint32_t width, uint32_t height, uint32_t MipLevels, uint32_t usage, D3Denum Format, D3Denum pool, uint32_t filter, uint32_t MipFilter, uint32_t colorkey, D3DXIMAGE_INFO* src_info, PALETTEENTRY* palette, IDirect3DTexture8** out_tex);
	int32_t D3DXCreateCubeTextureFromFileInMemoryEx(IDirect3DDevice8*, const void* src_data, uint32_t src_size, uint32_t Size, uint32_t MipLevels, uint32_t usage, D3Denum Format, D3Denum pool, uint32_t filter, uint32_t MipFilter, uint32_t colorkey, D3DXIMAGE_INFO* src_info, PALETTEENTRY* palette, IDirect3DCubeTexture8** out_tex);
	int32_t D3DXCreateVolumeTextureFromFileInMemoryEx(IDirect3DDevice8*, const void* src_data, uint32_t src_size, uint32_t width, uint32_t height, uint32_t Depth, uint32_t MipLevels, uint32_t usage, D3Denum Format, D3Denum pool, uint32_t filter, uint32_t MipFilter, uint32_t colorkey, D3DXIMAGE_INFO* src_info, PALETTEENTRY* palette, IDirect3DVolumeTexture8** out_tex);
	int32_t D3DXSaveTextureToFileA(const char* dest_path, D3Denum dest_format, IDirect3DBaseTexture8* pSrcTexture, const PALETTEENTRY* src_palette);
	int32_t D3DXSaveTextureToFileW(const wchar_t* dest_path, D3Denum dest_format, IDirect3DBaseTexture8* pSrcTexture, const PALETTEENTRY* src_palette);
	int32_t D3DXFilterTexture(IDirect3DBaseTexture8* pBaseTexture, const PALETTEENTRY* palette, uint32_t SrcLevel, uint32_t filter);
	/*
	int32_t D3DXFillTexture(IDirect3DTexture8* pTexture, D3DXFILL2D* pFunction, void* pData);
	int32_t D3DXFillCubeTexture(IDirect3DCubeTexture8* pCubeTexture, LPD3DXFILL3D pFunction, void* pData);
	int32_t D3DXFillVolumeTexture(IDirect3DVolumeTexture8*, LPD3DXFILL3D pFunction, void* pData);
	*/
	int32_t D3DXComputeNormalMap(IDirect3DTexture8* tex, IDirect3DTexture8* src, const PALETTEENTRY* src_palette, uint32_t flags, uint32_t channel, float amplitude);
	
]]

return ffi.load 'd3dx8d'
