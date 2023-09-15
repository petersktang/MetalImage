//
//  MetalImageOutput.h
//  MetalImage
//
//  Created by erickingxu on 29/7/2016.
//  Copyright © 2016 erickingxu. All rights reserved.
//

#import <Metal/Metal.h>
#import "MetalImageView.h"
#import "MetalImageCmdQueue.h"


@interface MetalImageOutput : NSObject
{
    MetalImageTexture*      outputTexture;
    MetalImageTexture*      outputTexture_attched;
    NSMutableArray*         targets;
    NSMutableArray*         targetTextureIndices;
    id <MTLCommandBuffer>   sharedcommandBuffer;
}

-(BOOL)fireOn;
-(void)setInputCommandBufferForTarget:(id<MetalImageInput>)target  atIndex:(NSInteger)index;
-(void)setInputTextureForTarget:(id<MetalImageInput>)target  atIndex: (NSInteger)iTextureIndex;
-(MetalImageTexture*)metalTextureForOutput;
-(void)removeOutputTexture;

-(NSArray*)targets;
-(NSArray*)targetTextureIndices;
-(id <MTLCommandBuffer>)sharedCmdBuffer;

-(void)addTarget:(id <MetalImageInput>)newTarget;
-(void)addTarget:(id<MetalImageInput>)newTarget  atTextureIndex: (NSInteger)textureLoc;

-(void)removeTarget:(id <MetalImageInput>)targetToRemove;
-(void)removeAllTargets;

@end
