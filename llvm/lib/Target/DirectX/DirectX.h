//===- DirectXTargetMachine.h - DirectX Target Implementation ---*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
///
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIB_TARGET_DIRECTX_DIRECTX_H
#define LLVM_LIB_TARGET_DIRECTX_DIRECTX_H

namespace llvm {
class FunctionPass;
class ModulePass;
class PassRegistry;
class raw_ostream;

/// Initializer for dxil writer pass
void initializeWriteDXILPassPass(PassRegistry &);

/// Initializer for dxil embedder pass
void initializeEmbedDXILPassPass(PassRegistry &);

/// Initializer for DXIL-prepare
void initializeDXILPrepareModulePass(PassRegistry &);

/// Pass to convert modules into DXIL-compatable modules
ModulePass *createDXILPrepareModulePass();

/// Initializer for DXIL Intrinsic Expansion
void initializeDXILIntrinsicExpansionLegacyPass(PassRegistry &);

/// Pass to expand intrinsic operations that lack DXIL opCodes
ModulePass *createDXILIntrinsicExpansionLegacyPass();

/// Initializer for DXIL CBuffer Access Pass
void initializeDXILCBufferAccessLegacyPass(PassRegistry &);

/// Pass to translate loads in the cbuffer address space to intrinsics
ModulePass *createDXILCBufferAccessLegacyPass();

/// Initializer for DXIL Data Scalarization Pass
void initializeDXILDataScalarizationLegacyPass(PassRegistry &);

/// Pass to scalarize llvm global data into a DXIL legal form
ModulePass *createDXILDataScalarizationLegacyPass();

/// Initializer for DXIL Array Flatten Pass
void initializeDXILFlattenArraysLegacyPass(PassRegistry &);

/// Pass to flatten arrays into a one dimensional DXIL legal form
ModulePass *createDXILFlattenArraysLegacyPass();

/// Initializer for DXIL Forward Handle Accesses Pass
void initializeDXILForwardHandleAccessesLegacyPass(PassRegistry &);

/// Pass to eliminate redundant stores and loads from handle globals.
FunctionPass *createDXILForwardHandleAccessesLegacyPass();

/// Initializer DXIL legalizationPass
void initializeDXILLegalizeLegacyPass(PassRegistry &);

/// Pass to Legalize DXIL by remove i8 truncations and i64 insert/extract
/// elements
FunctionPass *createDXILLegalizeLegacyPass();

/// Initializer for DXILOpLowering
void initializeDXILOpLoweringLegacyPass(PassRegistry &);

/// Pass to lowering LLVM intrinsic call to DXIL op function call.
ModulePass *createDXILOpLoweringLegacyPass();

/// Initializer for DXILResourceAccess
void initializeDXILResourceAccessLegacyPass(PassRegistry &);

/// Pass to update resource accesses to use load/store directly.
FunctionPass *createDXILResourceAccessLegacyPass();

/// Initializer for DXILTranslateMetadata.
void initializeDXILTranslateMetadataLegacyPass(PassRegistry &);

/// Pass to emit metadata for DXIL.
ModulePass *createDXILTranslateMetadataLegacyPass();

/// Pass to pretty print DXIL metadata.
ModulePass *createDXILPrettyPrinterLegacyPass(raw_ostream &OS);

/// Initializer for DXILPrettyPrinter.
void initializeDXILPrettyPrinterLegacyPass(PassRegistry &);

/// Initializer for dxil::ShaderFlagsAnalysisWrapper pass.
void initializeShaderFlagsAnalysisWrapperPass(PassRegistry &);

/// Initializer for dxil::RootSignatureAnalysisWrapper pass.
void initializeRootSignatureAnalysisWrapperPass(PassRegistry &);

/// Initializer for DXContainerGlobals pass.
void initializeDXContainerGlobalsPass(PassRegistry &);

/// Pass for generating DXContainer part globals.
ModulePass *createDXContainerGlobalsPass();

/// Initializer for DXILFinalizeLinkage pass.
void initializeDXILFinalizeLinkageLegacyPass(PassRegistry &);

/// Pass to finalize linkage of functions.
ModulePass *createDXILFinalizeLinkageLegacyPass();

} // namespace llvm

#endif // LLVM_LIB_TARGET_DIRECTX_DIRECTX_H
