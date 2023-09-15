//
//  MetalImageOutput.m
//  MetalImage
//
//  Created by erickingxu on 29/7/2016.
//  Copyright © 2016 erickingxu. All rights reserved.
//

#import "MetalImageOutput.h"
#import <simd/simd.h>


@implementation MetalImageOutput



-(id)init
{
    if (!(self= [super init]))
    {
        return nil;
    }
    targets = [[NSMutableArray alloc] init];
    targetTextureIndices = [[NSMutableArray alloc] init];
  
    return self;
}

///first filter must startup once for every frame
-(BOOL)fireOn
{
    if (self)
    {
        sharedcommandBuffer = [MetalImageCmdQueue getNewCommandBuffer];
        if (sharedcommandBuffer)
        {
            return YES;
        }
    }
    
    return NO;
}
-(void)setInputCommandBuffer:(id <MTLCommandBuffer>)cmdBuffer  atIndex:(NSInteger)index;
{
    if (self)
    {
        sharedcommandBuffer = cmdBuffer;//[MetalImageCmdQueue getNewCommandBuffer];
    }
}
-(void)setInputCommandBufferForTarget:(id<MetalImageInput>)target  atIndex:(NSInteger)index;
{
    [target setInputCommandBuffer:sharedcommandBuffer atIndex:index];
}

-(void)dealloc
{
    [self removeAllTargets];
}
//////////////////////////////////////////////////////////////////////////////////////////////
-(void)setInputTextureForTarget:(id<MetalImageInput>)target  atIndex: (NSInteger)iTextureIndex
{
    [target setInputTexture:[self metalTextureForOutput] atIndex: iTextureIndex];
}

-(MetalImageTexture*)metalTextureForOutput
{
    return outputTexture;//from video or input images
}

-(id <MTLCommandBuffer>)sharedCmdBuffer
{
    if (sharedcommandBuffer)
    {
        return sharedcommandBuffer;
    }
    return Nil;
}

-(void)removeOutputTexture
{
    outputTexture = nil;
}

-(NSArray*)targets
{
    return [NSArray arrayWithArray:targets];
}

-(NSArray*)targetTextureIndices
{
    return [NSArray arrayWithArray:targetTextureIndices];
}

-(void)addTarget:(id <MetalImageInput>)newTarget
{
    NSInteger nextAvailableTextureIndex = [newTarget nextAvailableTextureIndex];
    [self addTarget:newTarget atTextureIndex:nextAvailableTextureIndex];
    //ignore or not
}

-(void)addTarget:(id<MetalImageInput>)newTarget  atTextureIndex: (NSInteger)textureLoc
{
    if ([targets containsObject:newTarget] && [targetTextureIndices containsObject:[NSNumber numberWithInteger:textureLoc]])
    {
        return;
    }
    ///////////////////do in a self queue///////////////////////
    if(NO == [targets containsObject:newTarget]){
        [targets addObject:newTarget];
    }
    [self setInputTextureForTarget:newTarget atIndex:textureLoc];
    [targetTextureIndices addObject:[NSNumber numberWithInteger:textureLoc]];
    ////////////////////////////////////////////////////////////
    NSLog(@"****************New filter/target add in filter chain now!!!******* %@ ********************", newTarget.class);
}

-(void)removeTarget:(id <MetalImageInput>)targetToRemove
{
    if(![targets containsObject:targetToRemove])
    {
        return;
    }
    
//    if (_targetToIgnoreForUpdates == targetToRemove)
//    {
//        _targetToIgnoreForUpdates = nil;
//    }
//    
//cachedMaximumOutputSize = CGSizeZero;
    
    NSInteger indexOfObject = [targets indexOfObject:targetToRemove];
    NSInteger textureIndexOfTarget = [[targetTextureIndices objectAtIndex:indexOfObject] integerValue];
    

        [targetToRemove setInputSize:CGSizeZero atIndex:textureIndexOfTarget];
//        [targetToRemove setInputRotation:kGPUImageNoRotation atIndex:textureIndexOfTarget];
        
        [targetTextureIndices removeObjectAtIndex:indexOfObject];
        [targets removeObject:targetToRemove];
//        [targetToRemove endProcessing];

}
-(void)removeAllTargets;
{
    for (id<MetalImageInput> targetToRemove in targets)
    {
        NSInteger indexOfObject = [targets indexOfObject:targetToRemove];
        NSInteger textureIndexOfTarget = [[targetTextureIndices objectAtIndex:indexOfObject] integerValue];
        
        [targetToRemove setInputSize:CGSizeZero atIndex:textureIndexOfTarget];
        //[targetToRemove setInputRotation:kGPUImageNoRotation atIndex:textureIndexOfTarget];
    }
    [targets removeAllObjects];
    [targetTextureIndices removeAllObjects];
}

- (void)setInputSize:(CGSize)newSize atIndex:(NSInteger)textureIndex
{
    newSize.width = 0;
}
@end
