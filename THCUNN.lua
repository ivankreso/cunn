local ffi = require 'ffi'
local THNN = require 'nn.THNN'

local THCUNN = {}

-- load libTHCUNN
THCUNN.C = ffi.load(package.searchpath('libTHCUNN', package.cpath))

local THCState_ptr = ffi.typeof('THCState*')

function THCUNN.getState()
   return THCState_ptr(cutorch.getState());
end

local THCUNN_h = [[
typedef void THCState;

TH_API void THNN_CudaAbs_updateOutput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *output);
TH_API void THNN_CudaAbs_updateGradInput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *gradOutput,
          THCudaTensor *gradInput);

TH_API void THNN_CudaAbsCriterion_updateOutput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *target,
          THCudaTensor *output,
          bool sizeAverage);
TH_API void THNN_CudaAbsCriterion_updateGradInput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *target,
          THCudaTensor *gradInput,
          bool sizeAverage);

TH_API void THNN_CudaClassNLLCriterion_updateOutput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *target,
          THCudaTensor *output,
          bool sizeAverage,
          THCudaTensor *weights,
          THCudaTensor *total_weight);
TH_API void THNN_CudaClassNLLCriterion_updateGradInput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *target,
          THCudaTensor *gradInput,
          bool sizeAverage,
          THCudaTensor *weights,
          THCudaTensor *total_weight);

TH_API void THNN_CudaDistKLDivCriterion_updateOutput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *target,
          THCudaTensor *output,
          bool sizeAverage);
TH_API void THNN_CudaDistKLDivCriterion_updateGradInput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *target,
          THCudaTensor *gradInput,
          bool sizeAverage);

TH_API void THNN_CudaELU_updateOutput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *output,
          float alpha);
TH_API void THNN_CudaELU_updateGradInput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *gradOutput,
          THCudaTensor *gradInput,
          THCudaTensor *output,
          float alpha);

TH_API void THNN_CudaHardTanh_updateOutput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *output,
          float min_val,
          float max_val);
TH_API void THNN_CudaHardTanh_updateGradInput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *gradOutput,
          THCudaTensor *gradInput,
          float min_val,
          float max_val);

TH_API void THNN_CudaL1Cost_updateOutput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *output);
TH_API void THNN_CudaL1Cost_updateGradInput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *gradOutput,
          THCudaTensor *gradInput);

TH_API void THNN_CudaLeakyReLU_updateOutput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *output,
          double negval, bool inplace);
TH_API void THNN_CudaLeakyReLU_updateGradInput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *gradOutput,
          THCudaTensor *gradInput,
          double negval,
          bool inplace);

TH_API void THNN_CudaLogSigmoid_updateOutput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *output,
          THCudaTensor *buffer);
TH_API void THNN_CudaLogSigmoid_updateGradInput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *gradOutput,
          THCudaTensor *gradInput,
          THCudaTensor *buffer);

TH_API void THNN_CudaLogSoftMax_updateOutput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *output);
TH_API void THNN_CudaLogSoftMax_updateGradInput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *gradOutput,
          THCudaTensor *gradInput,
          THCudaTensor *output);

TH_API void THNN_CudaLookupTable_accGradParameters(
          THCState *state,
          THIndexTensor *input,
          THCudaTensor *gradOutput,
          THCudaTensor *gradWeight,
          THIntegerTensor *count,
          THCudaTensor *sorted,
          THCudaTensor *indices,
          bool scaleGradByFreq,
          float scale);

TH_API void THNN_CudaMarginCriterion_updateOutput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *target,
          THCudaTensor *output,
          bool sizeAverage,
          float margin);
TH_API void THNN_CudaMarginCriterion_updateGradInput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *target,
          THCudaTensor *gradInput,
          bool sizeAverage,
          float margin);

TH_API void THNN_CudaMSECriterion_updateOutput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *target,
          THCudaTensor *output,
          bool sizeAverage);
TH_API void THNN_CudaMSECriterion_updateGradInput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *target,
          THCudaTensor *gradInput,
          bool sizeAverage);

TH_API void THNN_CudaMultiMarginCriterion_updateOutput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *target,
          THCudaTensor *output,
          bool sizeAverage,
          int p);
TH_API void THNN_CudaMultiMarginCriterion_updateGradInput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *target,
          THCudaTensor *gradInput,
          bool sizeAverage,
          int p);

TH_API void THNN_CudaPReLU_updateOutput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *output,
          THCudaTensor *weight,
          long nOutputPlane);
TH_API void THNN_CudaPReLU_updateGradInput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *gradOutput,
          THCudaTensor *gradInput,
          THCudaTensor *weight,
          long nOutputPlane);
TH_API void THNN_CudaPReLU_accGradParameters(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *gradOutput,
          THCudaTensor *gradInput,
          THCudaTensor *weight,
          THCudaTensor *gradWeight,
          THCudaTensor *gradWeightBuf,
          THCudaTensor *gradWeightBuf2,
          long nOutputPlane,
          float scale);

TH_API void THNN_CudaRReLU_updateOutput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *output,
          THCudaTensor *noise,
          double lower,
          double upper,
          bool train,
          bool inplace,
          void *generator);
TH_API void THNN_CudaRReLU_updateGradInput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *gradOutput,
          THCudaTensor *gradInput,
          THCudaTensor *noise,
          double lower,
          double upper,
          bool train,
          bool inplace);

TH_API void THNN_CudaSigmoid_updateOutput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *output);
TH_API void THNN_CudaSigmoid_updateGradInput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *gradOutput,
          THCudaTensor *gradInput,
          THCudaTensor *output);

TH_API void THNN_CudaSmoothL1Criterion_updateOutput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *target,
          THCudaTensor *output,
          bool sizeAverage);
TH_API void THNN_CudaSmoothL1Criterion_updateGradInput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *target,
          THCudaTensor *gradInput,
          bool sizeAverage);

TH_API void THNN_CudaSoftMax_updateOutput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *output);
TH_API void THNN_CudaSoftMax_updateGradInput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *gradOutput,
          THCudaTensor *gradInput,
          THCudaTensor *output);

TH_API void THNN_CudaSoftPlus_updateOutput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *output,
          float beta,
          float threshold);
TH_API void THNN_CudaSoftPlus_updateGradInput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *gradOutput,
          THCudaTensor *gradInput,
          THCudaTensor *output,
          float beta,
          float threshold);

TH_API void THNN_CudaSoftShrink_updateOutput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *output,
          double lambda);
TH_API void THNN_CudaSoftShrink_updateGradInput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *gradOutput,
          THCudaTensor *gradInput,
          double lambda);

TH_API void THNN_CudaSqrt_updateOutput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *output,
          float eps);
TH_API void THNN_CudaSqrt_updateGradInput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *gradOutput,
          THCudaTensor *gradInput,
          THCudaTensor *output);

TH_API void THNN_CudaSquare_updateOutput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *output);
TH_API void THNN_CudaSquare_updateGradInput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *gradOutput,
          THCudaTensor *gradInput);

TH_API void THNN_CudaTanh_updateOutput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *output);
TH_API void THNN_CudaTanh_updateGradInput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *gradOutput,
          THCudaTensor *gradInput,
          THCudaTensor *output);

TH_API void THNN_CudaThreshold_updateOutput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *output,
          double threshold,
          double val,
          bool inplace);
TH_API void THNN_CudaThreshold_updateGradInput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *gradOutput,
          THCudaTensor *gradInput,
          double threshold,
          bool inplace);

TH_API void THNN_CudaSpatialConvolutionMM_updateOutput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *output,
          THCudaTensor *weight,
          THCudaTensor *bias,
          THCudaTensor *columns,
          THCudaTensor *ones,
          int kW, int kH,
          int dW, int dH,
          int padW, int padH);
TH_API void THNN_CudaSpatialConvolutionMM_updateGradInput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *gradOutput,
          THCudaTensor *gradInput,
          THCudaTensor *weight,
          THCudaTensor *bias,
          THCudaTensor *columns,
          THCudaTensor *ones,
          int kW, int kH,
          int dW, int dH,
          int padW, int padH);
TH_API void THNN_CudaSpatialConvolutionMM_accGradParameters(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *gradOutput,
          THCudaTensor *gradWeight,
          THCudaTensor *gradBias,
          THCudaTensor *columns,
          THCudaTensor *ones,
          int kW, int kH,
          int dW, int dH,
          int padW, int padH,
          float scale);

TH_API void THNN_CudaSpatialAdaptiveMaxPooling_updateOutput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *output,
          THCudaTensor *indices,
          int nOutputCols,
          int nOutputRows);
TH_API void THNN_CudaSpatialAdaptiveMaxPooling_updateGradInput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *gradOutput,
          THCudaTensor *gradInput,
          THCudaTensor *indices);

TH_API void THNN_CudaSpatialAveragePooling_updateOutput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *output,
          int kW, int kH,
          int dW, int dH,
          int padW, int padH,
          bool ceil_mode,
          bool count_include_pad);
TH_API void THNN_CudaSpatialAveragePooling_updateGradInput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *gradOutput,
          THCudaTensor *gradInput,
          int kW, int kH,
          int dW, int dH,
          int padW, int padH,
          bool ceil_mode,
          bool count_include_pad);

TH_API void THNN_CudaSpatialMaxPooling_updateOutput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *output,
          THCudaTensor *indices,
          int kW, int kH,
          int dW, int dH,
          int padW, int padH,
          bool ceil_mode);
TH_API void THNN_CudaSpatialMaxPooling_updateGradInput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *gradOutput,
          THCudaTensor *gradInput,
          THCudaTensor *indices,
          int kW, int kH,
          int dW, int dH,
          int padW, int padH,
          bool ceil_mode);

TH_API void THNN_CudaVolumetricAveragePooling_updateOutput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *output,
          int kT, int kW, int kH,
          int dT, int dW, int dH);
TH_API void THNN_CudaVolumetricAveragePooling_updateGradInput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *gradOutput,
          THCudaTensor *gradInput,
          int kT, int kW, int kH,
          int dT, int dW, int dH);

TH_API void THNN_CudaVolumetricConvolution_updateOutput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *output,
          THCudaTensor *weight,
          THCudaTensor *bias,
          THCudaTensor *finput,
          THCudaTensor *fgradInput,
          int dT, int dW, int dH,
          int padT, int padW, int padH);
TH_API void THNN_CudaVolumetricConvolution_updateGradInput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *gradOutput,
          THCudaTensor *gradInput,
          THCudaTensor *weight,
          THCudaTensor *finput,
          int dT, int dW, int dH,
          int padT, int padW, int padH);
TH_API void THNN_CudaVolumetricConvolution_accGradParameters(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *gradOutput,
          THCudaTensor *gradWeight,
          THCudaTensor *gradBias,
          THCudaTensor *finput,
          THCudaTensor *fgradInput,
          int dT, int dW, int dH,
          int padT, int padW, int padH,
          float scale);

TH_API void THNN_CudaVolumetricFullConvolution_updateOutput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *output,
          THCudaTensor *weight,
          THCudaTensor *bias,
          THCudaTensor *finput,
          THCudaTensor *fgradInput,
          int dT, int dW, int dH,
          int pT, int pW, int pH);
TH_API void THNN_CudaVolumetricFullConvolution_updateGradInput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *gradOutput,
          THCudaTensor *gradInput,
          THCudaTensor *weight,
          THCudaTensor *finput,
          THCudaTensor *fgradInput,
          int dT, int dW, int dH,
          int pT, int pW, int pH);
TH_API void THNN_CudaVolumetricFullConvolution_accGradParameters(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *gradOutput,
          THCudaTensor *gradWeight,
          THCudaTensor *gradBias,
          THCudaTensor *finput,
          THCudaTensor *fgradInput,
          int dT, int dW, int dH,
          int pT, int pW, int pH,
          float scale);

TH_API void THNN_CudaVolumetricMaxPooling_updateOutput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *output,
          THCudaTensor *indices,
          int kT, int kW, int kH,
          int dT, int dW, int dH,
          int padT, int padW, int padH,
          bool ceilMode);
TH_API void THNN_CudaVolumetricMaxPooling_updateGradInput(
          THCState *state,
          THCudaTensor *input,
          THCudaTensor *gradOutput,
          THCudaTensor *gradInput,
          THCudaTensor *indices,
          int dT, int dW, int dH,
          int padT, int padW, int padH);
]]

local preprocessed = string.gsub(THCUNN_h, 'TH_API ', '')

local replacements =
{
   {
      ['THTensor'] = 'THCudaTensor',
      ['THIndexTensor'] = 'THCudaTensor',
      ['THIntegerTensor'] = 'THCudaTensor',
      ['THIndex_t'] = 'float',
      ['THInteger_t'] = 'float'
   }
}

for i=1,#replacements do
   local r = replacements[i]
   local s = preprocessed
   for k,v in pairs(r) do
      s = string.gsub(s, k, v)
   end
   ffi.cdef(s)
end

local function extract_function_names(s)
   local t = {}
   for n in string.gmatch(s, 'TH_API void THNN_Cuda([%a%d_]+)') do
      t[#t+1] = n
   end
   return t
end

-- build function table
local function_names = extract_function_names(THCUNN_h)

THNN.kernels['torch.CudaTensor'] = THNN.bind(THCUNN.C, function_names, 'Cuda', THCUNN.getState)
torch.getmetatable('torch.CudaTensor').THNN = THNN.kernels['torch.CudaTensor']

return THCUNN
