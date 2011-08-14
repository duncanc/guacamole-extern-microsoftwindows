
local win32 = require 'extern.microsoftwindows'
local com = require 'extern.microsoftwindows.com'
local d3d9 = require 'extern.microsoftwindows.d3d9'
local ffi = require 'ffi'

ffi.cdef [[

	typedef struct D3DXVECTOR2    { float x, y;       } D3DXVECTOR2;
	typedef struct D3DXVECTOR3    { float x, y, z;    } D3DXVECTOR3;
	typedef struct D3DXVECTOR4    { float x, y, z, w; } D3DXVECTOR4;
	typedef struct D3DXQUATERNION { float x, y, z, w; } D3DXQUATERNION;
	typedef struct D3DXPLANE      { float a, b, c, d; } D3DXPLANE;
	typedef struct D3DXCOLOR      { float r, g, b, a; } D3DXCOLOR;
	typedef D3DMATRIX D3DXMATRIX;

]]

--=== core ===--

ffi.cdef [[

	enum {
	
		D3DX_VERSION = 0x0902,
		D3DX_SDK_VERSION = 22,
		
		D3DXSPRITE_DONOTSAVESTATE = 1,
		D3DXSPRITE_DONOTMODIFY_RENDERSTATE = 2,
		D3DXSPRITE_OBJECTSPACE = 4,
		D3DXSPRITE_BILLBOARD = 8,
		D3DXSPRITE_ALPHABLEND = 16,
		D3DXSPRITE_SORT_TEXTURE = 32,
		D3DXSPRITE_SORT_DEPTH_FRONTTOBACK = 64,
		D3DXSPRITE_SORT_DEPTH_BACKTOFRONT = 128

	};

	typedef struct D3DXFONT_DESCA {
		int32_t Height;
		uint32_t Width;
		uint32_t Weight;
		uint32_t MipLevels;
		bool32 Italic;
		uint8_t CharSet;
		uint8_t OutputPrecision;
		uint8_t Quality;
		uint8_t PitchAndFamily;
		char FaceName[LF_FACESIZE];
	} D3DXFONT_DESCA;

	typedef struct D3DXFONT_DESCW {
		int32_t Height;
		uint32_t Width;
		uint32_t Weight;
		uint32_t MipLevels;
		bool32 Italic;
		uint8_t CharSet;
		uint8_t OutputPrecision;
		uint8_t Quality;
		uint8_t PitchAndFamily;
		wchar_t FaceName[LF_FACESIZE];
	} D3DXFONT_DESCW;

	typedef struct D3DXRTS_DESC {
		uint32_t Width, Height;
		D3Denum Format;
		bool32 DepthStencil;
		D3Denum DepthStencilFormat;
	} D3DXRTS_DESC;

	typedef struct D3DXRTE_DESC {
		uint32_t        Size;
		uint32_t        MipLevels;
		D3Denum   Format;
		bool32        DepthStencil;
		D3Denum   DepthStencilFormat;
	} D3DXRTE_DESC;

]]

com.def {
	{'ID3DXBuffer';
		methods = {
			{'GetBufferPointer', ret='void*'};
			{'GetBufferSize', ret='uint32_t'};
		};
		iid = '8ba5fb08-5195-40e2-ac58-0d989c3a0102';
	};
	{'ID3DXSprite';
		methods = {
			{'GetDevice', 'IDirect3DDevice9** ppDevice'};
			{'GetTransform', 'D3DXMATRIX *pTransform'};
			{'SetTransform', 'const D3DXMATRIX *pTransform'};
			{'SetWorldViewRH', 'const D3DXMATRIX *pWorld, const D3DXMATRIX *pView'};
			{'SetWorldViewLH', 'const D3DXMATRIX *pWorld, const D3DXMATRIX *pView'};
			{'Begin', 'uint32_t Flags'};
			{'Draw', 'IDirect3DTexture9* pTexture, const RECT *pSrcRect, const D3DXVECTOR3 *pCenter, const D3DXVECTOR3 *pPosition, uint32_t Color'};
			{'Flush'};
			{'End'};
			{'OnLostDevice'};
			{'OnResetDevice'};
		};
		iid = 'ba0b762d-7d28-43ec-b9dc-2f84443b0614';
	};
	{'ID3DXFont';
		methods = {
			{'GetDevice', 'IDirect3DDevice9* *ppDevice'};
			{'GetDescA', 'D3DXFONT_DESCA *pDesc'};
			{'GetDescW', 'D3DXFONT_DESCW *pDesc'};
			{'GetTextMetricsA', 'TEXTMETRICA* out_textMetrics', ret='bool32'};
			{'GetTextMetricsW', 'TEXTMETRICW* out_textMetrics', ret='bool32'};
			{'GetDC', ret='HDC'};
			{'GetGlyphData', 'uint32_t Glyph, IDirect3DTexture9* *ppTexture, RECT *pBlackBox, POINT *pCellInc'};
			{'PreloadCharacters', 'uint32_t first, uint32_t last'};
			{'PreloadGlyphs', 'uint32_t first, uint32_t last'};
			{'PreloadTextA', 'const char* text, int32_t count'};
			{'PreloadTextW', 'const wchar_t* text, int32_t count'};
			{'DrawTextA', 'ID3DXSprite* sprite, const char* text, int32_t count, RECT* rect, uint32_t format, uint32_t color', ret='int32_t'};
			{'DrawTextW', 'ID3DXSprite* sprite, const wchar_t* text, int32_t count, RECT* rect, uint32_t format, uint32_t color', ret='int32_t'};
			{'OnLostDevice'};
			{'OnResetDevice'};
		};
		iid = 'd79dbb70-5f21-4d36-bbc2-ff525c213cdc';
	};
	{'ID3DXRenderToSurface';
		methods = {
			{'GetDevice', 'IDirect3DDevice9** out_device'};
			{'GetDesc', 'D3DXRTS_DESC* out_desc'};
			{'BeginScene', 'IDirect3DSurface9* surface, const D3DVIEWPORT9* viewport'};
			{'EndScene', 'uint32_t mipFilter'};
			{'OnLostDevice'};
			{'OnResetDevice'};
		};
		iid = '6985f346-2c3d-43b3-be8b-daae8a03d894';
	};
	{'ID3DXRenderToEnvMap';
		methods = {
			{'GetDevice', 'IDirect3DDevice9** ppDevice'};
			{'GetDesc', 'D3DXRTE_DESC* pDesc'};
			{'BeginCube', 'IDirect3DCubeTexture9* pCubeTex'};
			{'BeginSphere', 'IDirect3DTexture9* tex'};
			{'BeginHemisphere', 'IDirect3DTexture9* pTexZPos, IDirect3DTexture9* pTexZNeg'};
			{'BeginParabolic', 'IDirect3DTexture9* texZPositive, IDirect3DTexture9* texZNegative'};
			{'Face', 'D3Denum face, uint32_t mipFilter'};
			{'End', 'uint32_t MipFilter'};
			{'OnLostDevice'};
			{'OnResetDevice'};
		};
		iid = '313f1b4b-c7b0-4fa2-9d9d-8d380b64385e';
	};
	{'ID3DXLine';
		methods = {
			{'GetDevice', 'IDirect3DDevice9** ppDevice'};
			{'Begin'};
			{'Draw', 'const D3DXVECTOR2* vertexList, uint32_t vertexCount, uint32_t color'};
			{'DrawTransform', 'const D3DXVECTOR3* vertexList, uint32_t vertexCount, const D3DXMATRIX* transform, uint32_t color'};
			{'SetPattern', 'uint32_t'};
			{'GetPattern', ret='uint32_t'};
			{'SetPatternScale', 'float'};
			{'GetPatternScale', ret='float'};
			{'SetWidth', 'float'};
			{'GetWidth', ret='float'};
			{'SetAntialias', 'bool32'};
			{'GetAntialias', ret='bool32'};
			{'SetGLLines', 'bool32'};
			{'GetGLLines', ret='bool32'};
			{'End'};
			{'OnLostDevice'};
			{'OnResetDevice'};
		};
		iid = 'D379BA7F-9042-4ac4-9F5E-58192A4C6BD8';
	};
};
	
ffi.cdef [[

	bool32 D3DXCheckVersion(uint32_t d3dVersion, uint32_t d3dxVersion);
	uint32_t D3DXGetDriverLevel(IDirect3DDevice9* device);
	int32_t D3DXCreateSprite(IDirect3DDevice9* device, ID3DXSprite** out_sprite);
	int32_t D3DXCreateFontA(
		IDirect3DDevice9* device,  
		int32_t height,
		uint32_t width,
		uint32_t weight,
		uint32_t mipLevels,
		bool32 italic,
		uint32_t charSet,
		uint32_t outputPrecision,
		uint32_t quality,
		uint32_t pitchAndFamily,
		const char* faceName,
		ID3DXFont** out_font);
	int32_t D3DXCreateFontW(
		IDirect3DDevice9* device,  
		int32_t height,
		uint32_t width,
		uint32_t weight,
		uint32_t mipLevels,
		bool32 italic,
		uint32_t charSet,
		uint32_t outputPrecision,
		uint32_t quality,
		uint32_t pitchAndFamily,
		const wchar_t* faceName,
		ID3DXFont** out_font);
	int32_t D3DXCreateFontIndirectA(IDirect3DDevice9* device, const D3DXFONT_DESCA* desc, ID3DXFont** out_font);
	int32_t D3DXCreateFontIndirectW(IDirect3DDevice9* device, const D3DXFONT_DESCW* desc, ID3DXFont** out_font);
	int32_t D3DXCreateRenderToSurface(
		IDirect3DDevice9* device,
		uint32_t width,
		uint32_t height,
		D3Denum format,
		bool32 depthStencil,
		D3Denum depthStencilFormat,
		ID3DXRenderToSurface** out_rts);
	int32_t D3DXCreateRenderToEnvMap(
		IDirect3DDevice9* device,
		uint32_t size,
		uint32_t mipLevels,
		D3Denum format,
		bool32 depthStencil,
		D3Denum depthStencilFormat,
		ID3DXRenderToEnvMap** out_rtem);
	int32_t D3DXCreateLine(IDirect3DDevice9* device, ID3DXLine** out_line);

]]

--=== shaders ===--

ffi.cdef [[

	enum {
		D3DXSHADER_DEBUG = 1,
		D3DXSHADER_SKIPVALIDATION = 2,
		D3DXSHADER_SKIPOPTIMIZATION = 4,
		D3DXSHADER_PACKMATRIX_ROWMAJOR = 8,
		D3DXSHADER_PACKMATRIX_COLUMNMAJOR = 16,
		D3DXSHADER_PARTIALPRECISION = 32,
		D3DXSHADER_FORCE_VS_SOFTWARE_NOOPT = 64,
		D3DXSHADER_FORCE_PS_SOFTWARE_NOOPT = 128,
		D3DXSHADER_NO_PRESHADER = 256,
		D3DXSHADER_AVOID_FLOW_CONTROL = 512,
		D3DXSHADER_PREFER_FLOW_CONTROL = 1024,

		D3DXPC_SCALAR = 0,
		D3DXPC_VECTOR = 1,
		D3DXPC_MATRIX_ROWS = 2,
		D3DXPC_MATRIX_COLUMNS = 3,
		D3DXPC_OBJECT = 4,
		D3DXPC_STRUCT = 5,

		D3DXPT_VOID = 0,
		D3DXPT_BOOL = 1,	
		D3DXPT_INT = 2,
		D3DXPT_FLOAT = 3,
		D3DXPT_STRING = 4,
		D3DXPT_TEXTURE = 5,
		D3DXPT_TEXTURE1D = 6,
		D3DXPT_TEXTURE2D = 7,
		D3DXPT_TEXTURE3D = 8,
		D3DXPT_TEXTURECUBE = 9,
		D3DXPT_SAMPLER = 10,
		D3DXPT_SAMPLER1D = 11,
		D3DXPT_SAMPLER2D = 12,
		D3DXPT_SAMPLER3D = 13,
		D3DXPT_SAMPLERCUBE = 14,
		D3DXPT_PIXELSHADER = 15,
		D3DXPT_VERTEXSHADER = 16,
		D3DXPT_PIXELFRAGMENT = 17,
		D3DXPT_VERTEXFRAGMENT = 18,
		
		D3DXRS_BOOL = 0,
		D3DXRS_INT4 = 1,
		D3DXRS_FLOAT4 = 2,
		D3DXRS_SAMPLER = 3,
		
		D3DXINC_LOCAL = 0,
		D3DXINC_SYSTEM = 1
	};

	typedef struct D3DXMACRO {
		const char* Name;
		const char* Definition;
	} D3DXMACRO;

	typedef struct D3DXSEMANTIC {
		uint32_t Usage;
		uint32_t UsageIndex;
	} D3DXSEMANTIC;

	typedef struct D3DXFRAGMENT_DESC {
		const char* Name;
		uint32_t Target;
	} D3DXFRAGMENT_DESC;

	typedef struct D3DXCONSTANTTABLE_DESC {
		const char* Creator;
		uint32_t Version;
		uint32_t Constants;
	} D3DXCONSTANTTABLE_DESC;

	typedef struct D3DXCONSTANT_DESC {
		const char* Name;

		D3Denum RegisterSet;
		uint32_t RegisterIndex;
		uint32_t RegisterCount;

		D3Denum Class;
		D3Denum Type;

		uint32_t Rows;
		uint32_t Columns;
		uint32_t Elements;
		uint32_t StructMembers;

		uint32_t Bytes;
		const void* DefaultValue;
	} D3DXCONSTANT_DESC;
	
	typedef struct D3DXSHADER_CONSTANTTABLE {
		uint32_t Size; // sizeof(D3DXSHADER_CONSTANTTABLE)
		uint32_t Creator;
		uint32_t Version;
		uint32_t Constants;
		uint32_t ConstantInfo; // D3DXSHADER_CONSTANTINFO[Constants] offset
		uint32_t Flags;
		uint32_t Target;
	} D3DXSHADER_CONSTANTTABLE;

	typedef struct D3DXSHADER_CONSTANTINFO {
		uint32_t Name;
		uint16_t RegisterSet;
		uint16_t RegisterIndex;
		uint16_t RegisterCount;
		uint16_t Reserved;
		uint32_t TypeInfo;
		uint32_t DefaultValue;
	} D3DXSHADER_CONSTANTINFO;

	typedef struct D3DXSHADER_TYPEINFO {
		uint16_t Class;
		uint16_t Type;
		uint16_t Rows;
		uint16_t Columns;
		uint16_t Elements;
		uint16_t StructMembers;
		uint32_t StructMemberInfo; // D3DXSHADER_STRUCTMEMBERINFO[Members] offset
	} D3DXSHADER_TYPEINFO;

	typedef struct D3DXSHADER_STRUCTMEMBERINFO {
		uint32_t Name;
		uint32_t TypeInfo; // D3DXSHADER_TYPEINFO offset
	} D3DXSHADER_STRUCTMEMBERINFO;
	
]]

com.def{
	{'ID3DXConstantTable';
		methods = {
			{'GetBufferPointer', ret='void*'};
			{'GetBufferSize', ret='uint32_t'};

			-- descs
			{'GetDesc', 'D3DXCONSTANTTABLE_DESC* out_desc'};
			{'GetConstantDesc', 'const char* constant, D3DXCONSTANT_DESC* out_descs, uint32_t* inout_count'};
			{'GetSamplerIndex', 'const char* constant', ret='uint32_t'};

			-- handle operations
			{'GetConstant', 'const char* constant, uint32_t index', ret='const char*'};
			{'GetConstantByName', 'const char* constant, const char* name', ret='const char*'};
			{'GetConstantElement', 'const char* constant, uint32_t index', ret='const char*'};

			-- set constants
			{'SetDefaults', 'IDirect3DDevice9* pDevice'};
			{'SetValue', 'IDirect3DDevice9* pDevice, const char* hConstant, const void* pData, uint32_t Bytes'};
			{'SetBool', 'IDirect3DDevice9* pDevice, const char* hConstant, bool32 b'};
			{'SetBoolArray', 'IDirect3DDevice9* pDevice, const char* hConstant, const bool32* pb, uint32_t Count'};
			{'SetInt', 'IDirect3DDevice9* pDevice, const char* hConstant, int32_t n'};
			{'SetIntArray', 'IDirect3DDevice9* pDevice, const char* hConstant, const int32_t* pn, uint32_t Count'};
			{'SetFloat', 'IDirect3DDevice9* pDevice, const char* hConstant, float f'};
			{'SetFloatArray', 'IDirect3DDevice9* pDevice, const char* hConstant, const float* pf, uint32_t Count'};
			{'SetVector', 'IDirect3DDevice9* pDevice, const char* hConstant, const D3DXVECTOR4* pVector'};
			{'SetVectorArray', 'IDirect3DDevice9* pDevice, const char* hConstant, const D3DXVECTOR4* pVector, uint32_t Count'};
			{'SetMatrix', 'IDirect3DDevice9* pDevice, const char* hConstant, const D3DXMATRIX* pMatrix'};
			{'SetMatrixArray', 'IDirect3DDevice9* pDevice, const char* hConstant, const D3DXMATRIX* pMatrix, uint32_t Count'};
			{'SetMatrixPointerArray', 'IDirect3DDevice9* pDevice, const char* hConstant, const D3DXMATRIX** ppMatrix, uint32_t Count'};
			{'SetMatrixTranspose', 'IDirect3DDevice9* pDevice, const char* hConstant, const D3DXMATRIX* pMatrix'};
			{'SetMatrixTransposeArray', 'IDirect3DDevice9* pDevice, const char* hConstant, const D3DXMATRIX* pMatrix, uint32_t Count'};
			{'SetMatrixTransposePointerArray', 'IDirect3DDevice9* pDevice, const char* hConstant, const D3DXMATRIX** ppMatrix, uint32_t Count'};
		};
		iid = 'ab3c758f-093e-4356-b762-4db18f1b3a01';
	};
	{'ID3DXTextureShader';
		methods = {
			-- gets
			{'GetFunction', 'ID3DXBuffer* *ppFunction'};
			{'GetConstantBuffer', 'ID3DXBuffer* *ppConstantBuffer'};

			-- descs
			{'GetDesc', 'D3DXCONSTANTTABLE_DESC *pDesc'};
			{'GetConstantDesc', 'const char* hConstant, D3DXCONSTANT_DESC *pConstantDesc, uint32_t *pCount'};

			-- handle operations
			{'GetConstant', 'const char* hConstant, uint32_t Index', ret='const char*'};
			{'GetConstantByName', 'const char* hConstant, const char* pName', ret='const char*'};
			{'GetConstantElement', 'const char* hConstant, uint32_t Index', ret='const char*'};
			
			-- set constants
			{'SetDefaults'};
			{'SetValue', 'const char* hConstant, const void* pData, uint32_t Bytes'};
			{'SetBool', 'const char* hConstant, bool32 b'};
			{'SetBoolArray', 'const char* hConstant, const bool32* pb, uint32_t Count'};
			{'SetInt', 'const char* hConstant, int32_t n'};
			{'SetIntArray', 'const char* hConstant, const int32_t* pn, uint32_t Count'};
			{'SetFloat', 'const char* hConstant, float f'};
			{'SetFloatArray', 'const char* hConstant, const float* pf, uint32_t Count'};
			{'SetVector', 'const char* hConstant, const D3DXVECTOR4* pVector'};
			{'SetVectorArray', 'const char* hConstant, const D3DXVECTOR4* pVector, uint32_t Count'};
			{'SetMatrix', 'const char* hConstant, const D3DXMATRIX* pMatrix'};
			{'SetMatrixArray', 'const char* hConstant, const D3DXMATRIX* pMatrix, uint32_t Count'};
			{'SetMatrixPointerArray', 'const char* hConstant, const D3DXMATRIX** ppMatrix, uint32_t Count'};
			{'SetMatrixTranspose', 'const char* hConstant, const D3DXMATRIX* pMatrix'};
			{'SetMatrixTransposeArray', 'const char* hConstant, const D3DXMATRIX* pMatrix, uint32_t Count'};
			{'SetMatrixTransposePointerArray', 'const char* hConstant, const D3DXMATRIX** ppMatrix, uint32_t Count'};
		};
		iid = '3e3d67f8-aa7a-405d-a857-ba01d4758426';
	};
	{'ID3DXFragmentLinker';
		methods = {
			-- fragment access and information retrieval functions
			{'GetDevice', 'IDirect3DDevice9** out_device'};
			{'GetNumberOfFragments', ret='uint32_t'};

			{'GetFragmentHandleByIndex', 'uint32_t Index', ret='const char*'};
			{'GetFragmentHandleByName', 'const char* Name', ret='const char*'};
			{'GetFragmentDesc', 'const char* Name, D3DXFRAGMENT_DESC* FragDesc'};

			-- add the fragments in the buffer to the linker
			{'AddFragments', 'const uint32_t *Fragments'};

			-- create a buffer containing the fragments, suitable for saving to disk
			{'GetAllFragments', 'ID3DXBuffer* *ppBuffer'};
			{'GetFragment', 'const char* Name, ID3DXBuffer* *ppBuffer'};

			{'LinkShader', 'const char* pProfile, uint32_t Flags, const const char* *rgFragmentHandles, uint32_t cFragments, ID3DXBuffer* *ppBuffer, ID3DXBuffer* *ppErrorMsgs'};
			{'LinkVertexShader', 'const char* pProfile, uint32_t Flags, const const char* *rgFragmentHandles, uint32_t cFragments, IDirect3DVertexShader9** out_vshader, ID3DXBuffer* *ppErrorMsgs'};
			{'LinkPixelShader', 'const char* pProfile, uint32_t Flags, const const char* *rgFragmentHandles, uint32_t cFragments, IDirect3DPixelShader9** out_pshader, ID3DXBuffer* *ppErrorMsgs'};

			{'ClearCache'};
		};
		iid = '1a2c0cc2-e5b6-4ebc-9e8d-390e057811b6';
	};
}

ffi.cdef [[

	/*
	DECLARE_INTERFACE(ID3DXInclude)
	{
			{'Open', 'D3Denum IncludeType, const char* pFileName, const void* pParentData, const void* *ppData, uint32_t *pBytes'};
			{'Close', 'const void* pData'};
	};
	*/
	typedef void ID3DXInclude;

	int32_t 
			D3DXAssembleShaderFromFileA(
					const char*                     pSrcFile,
					const D3DXMACRO*                pDefines,
					ID3DXInclude*                   pInclude,
					uint32_t                        Flags,
					ID3DXBuffer**                   ppShader,
					ID3DXBuffer**                   ppErrorMsgs);

	int32_t 
			D3DXAssembleShaderFromFileW(
					const wchar_t*                         pSrcFile,
					const D3DXMACRO*                pDefines,
					ID3DXInclude*                   pInclude,
					uint32_t                           Flags,
					ID3DXBuffer**                   ppShader,
					ID3DXBuffer**                   ppErrorMsgs);

	int32_t 
			D3DXAssembleShaderFromResourceA(
					HMODULE                         hSrcModule,
					const char*                          pSrcResource,
					const D3DXMACRO*                pDefines,
					ID3DXInclude*                   pInclude,
					uint32_t                           Flags,
					ID3DXBuffer**                   ppShader,
					ID3DXBuffer**                   ppErrorMsgs);

	int32_t 
			D3DXAssembleShaderFromResourceW(
					HMODULE                         hSrcModule,
					const wchar_t*                         pSrcResource,
					const D3DXMACRO*                pDefines,
					ID3DXInclude*                   pInclude,
					uint32_t                           Flags,
					ID3DXBuffer**                   ppShader,
					ID3DXBuffer**                   ppErrorMsgs);

	int32_t 
			D3DXAssembleShader(
					const char*                          pSrcData,
					uint32_t                            SrcDataLen,
					const D3DXMACRO*                pDefines,
					ID3DXInclude*                   pInclude,
					uint32_t                           Flags,
					ID3DXBuffer**                   ppShader,
					ID3DXBuffer**                   ppErrorMsgs);

	int32_t 
			D3DXCompileShaderFromFileA(
					const char*                          pSrcFile,
					const D3DXMACRO*                pDefines,
					ID3DXInclude*                   pInclude,
					const char*                          pFunctionName,
					const char*                          pProfile,
					uint32_t                           Flags,
					ID3DXBuffer**                   ppShader,
					ID3DXBuffer**                   ppErrorMsgs,
					ID3DXConstantTable**            ppConstantTable);

	int32_t 
			D3DXCompileShaderFromFileW(
					const wchar_t*                         pSrcFile,
					const D3DXMACRO*                pDefines,
					ID3DXInclude*                   pInclude,
					const char*                          pFunctionName,
					const char*                          pProfile,
					uint32_t                           Flags,
					ID3DXBuffer**                   ppShader,
					ID3DXBuffer**                   ppErrorMsgs,
					ID3DXConstantTable**            ppConstantTable);

	int32_t 
			D3DXCompileShaderFromResourceA(
					HMODULE                         hSrcModule,
					const char*                          pSrcResource,
					const D3DXMACRO*                pDefines,
					ID3DXInclude*                   pInclude,
					const char*                          pFunctionName,
					const char*                          pProfile,
					uint32_t                           Flags,
					ID3DXBuffer**                   ppShader,
					ID3DXBuffer**                   ppErrorMsgs,
					ID3DXConstantTable**            ppConstantTable);

	int32_t 
			D3DXCompileShaderFromResourceW(
					HMODULE                         hSrcModule,
					const wchar_t*                         pSrcResource,
					const D3DXMACRO*                pDefines,
					ID3DXInclude*                   pInclude,
					const char*                          pFunctionName,
					const char*                          pProfile,
					uint32_t                           Flags,
					ID3DXBuffer**                   ppShader,
					ID3DXBuffer**                   ppErrorMsgs,
					ID3DXConstantTable**            ppConstantTable);

	int32_t 
			D3DXCompileShader(
					const char*                          pSrcData,
					uint32_t                            SrcDataLen,
					const D3DXMACRO*                pDefines,
					ID3DXInclude*                   pInclude,
					const char*                          pFunctionName,
					const char*                          pProfile,
					uint32_t                           Flags,
					ID3DXBuffer**                   ppShader,
					ID3DXBuffer**                   ppErrorMsgs,
					ID3DXConstantTable**            ppConstantTable);

	int32_t 
			D3DXDisassembleShader(
					const uint32_t*                    pShader, 
					bool32                            EnableColorCode, 
					const char*                          pComments, 
					ID3DXBuffer**                   ppDisassembly);

	const char* 
			D3DXGetPixelShaderProfile(
					IDirect3DDevice9*               pDevice);

	const char* 
			D3DXGetVertexShaderProfile(
					IDirect3DDevice9*               pDevice);

	int32_t 
			D3DXFindShaderComment(
					const uint32_t*                    pFunction,
					uint32_t                           FourCC,
					const void**                        ppData,
					uint32_t*                           pSizeInBytes);

	uint32_t 
			D3DXGetShaderSize(
					const uint32_t*                    pFunction);

	uint32_t 
			D3DXGetShaderVersion(
					const uint32_t*                    pFunction);

	int32_t 
			D3DXGetShaderInputSemantics(
					const uint32_t*                    pFunction,
					D3DXSEMANTIC*                   pSemantics,
					uint32_t*                           pCount);

	int32_t 
			D3DXGetShaderOutputSemantics(
					const uint32_t*                    pFunction,
					D3DXSEMANTIC*                   pSemantics,
					uint32_t*                           pCount);

	int32_t D3DXGetShaderSamplers(const uint32_t* pFunction, const char** pSamplers, uint32_t* pCount);

	int32_t 
			D3DXGetShaderConstantTable(
					const uint32_t*                    pFunction,
					ID3DXConstantTable**            ppConstantTable);

	int32_t 
			D3DXCreateTextureShader(
					const uint32_t*                    pFunction, 
					ID3DXTextureShader**            ppTextureShader);

	int32_t 
	D3DXGatherFragmentsFromFileA(
					const char*                          pSrcFile,
					const D3DXMACRO*                pDefines,
					ID3DXInclude*                   pInclude,
					uint32_t                           Flags,
					ID3DXBuffer**                   ppShader,
					ID3DXBuffer**                   ppErrorMsgs);

	int32_t 
	D3DXGatherFragmentsFromFileW(
					const wchar_t*                         pSrcFile,
					const D3DXMACRO*                pDefines,
					ID3DXInclude*                   pInclude,
					uint32_t                           Flags,
					ID3DXBuffer**                   ppShader,
					ID3DXBuffer**                   ppErrorMsgs);

	int32_t 
			D3DXGatherFragmentsFromResourceA(
					HMODULE                         hSrcModule,
					const char*                          pSrcResource,
					const D3DXMACRO*                pDefines,
					ID3DXInclude*                   pInclude,
					uint32_t                           Flags,
					ID3DXBuffer**                   ppShader,
					ID3DXBuffer**                   ppErrorMsgs);

	int32_t 
			D3DXGatherFragmentsFromResourceW(
					HMODULE                         hSrcModule,
					const wchar_t*                         pSrcResource,
					const D3DXMACRO*                pDefines,
					ID3DXInclude*                   pInclude,
					uint32_t                           Flags,
					ID3DXBuffer**                   ppShader,
					ID3DXBuffer**                   ppErrorMsgs);

	int32_t 
			D3DXGatherFragments(
					const char*                          pSrcData,
					uint32_t                            SrcDataLen,
					const D3DXMACRO*                pDefines,
					ID3DXInclude*                   pInclude,
					uint32_t                           Flags,
					ID3DXBuffer**                   ppShader,
					ID3DXBuffer**                   ppErrorMsgs);


	int32_t 
			D3DXCreateFragmentLinker(
					IDirect3DDevice9*               pDevice,
					uint32_t                            ShaderCacheSize,
					ID3DXFragmentLinker**           ppFragmentLinker);

]]

return ffi.load 'd3dx9d'
