//
//  OnBoardingView.swift
//  zodica
//
//  Created by Onur Uğur on 18.10.2022.
//

import SwiftUI

struct OnBoardingView: View {
    @AppStorage ("onboarding") var isOnBoardingViewActive : Bool = true
    
    @State private var buttonWidth : Double = UIScreen.main.bounds.width-80
    
    @State private var buttonOffSet : CGFloat = 0
    
    @State private var isAnimating : Bool = false
     
    @State private var imageOfSet : CGSize = .zero
    
    
    var body: some View {
        ZStack {
            Color(.black).ignoresSafeArea(.all,edges: .all)
            
            VStack(spacing:20) {
                Spacer()
                
                VStack(spacing:0){
                    Text("Share").font(.system(size:60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                    
                    Text("""
                         It is not how much you give
                         but how much we care
                         """).font(.title3)
                        .fontWeight(.light)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                }
                .opacity(isAnimating ? 1 : 0)
                .offset(y : isAnimating ? 0 : -40)
                .animation(.easeOut(duration: 1),value: isAnimating)
                
                ZStack{
                    CircleGroupView(ShapeColor: .white, ShapeOpacity: 0.2)
                        .offset(x : imageOfSet.width * -1)
                        .blur(radius: abs(imageOfSet.width / 5))
                        .animation(.easeOut(duration: 1), value: imageOfSet)
                    
                    Image("karakter_1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 0.5), value: isAnimating)
                        .offset(x : imageOfSet.width * 1.2 , y : 0)
                        .rotationEffect(.degrees(Double(imageOfSet.width / 20)))
                        .gesture(DragGesture().onChanged{
                            gesture in
                            if abs(imageOfSet.width) <= 150{
                                imageOfSet = gesture.translation
                            }
                        }.onEnded{
                            _ in
                            imageOfSet = .zero
                        }).animation(.easeOut(duration: 1), value: imageOfSet)
                    
                    
                }
                
                Spacer( )
                
                ZStack{
                    
                    Capsule( )
                        .fill(Color.white.opacity(0.2))
                    Capsule( )
                        .fill(Color.white.opacity(0.2)).padding(8)
                    
                    Text("Get Started")
                        .font(.system(.title3,design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(x:20)
                    
                    HStack{
                        Capsule( ).fill(Color("ColorRed"))
                            .frame(width: buttonOffSet + 80)
                        
                        Spacer()
                    }
                    
                    HStack {
                        
                        ZStack{
                            
                            Circle().fill(Color("ColorRed"))
                            
                            Circle().fill(.black.opacity(0.15))
                                .padding(8)
                            Image(systemName: "chevron.right.2").font(.system(size: 24,weight: .bold))
                                
                            
                        }.foregroundColor(.white)
                            .frame(width: 80, height: 80 ,alignment: .center)
                            .offset(x:buttonOffSet)
                            .gesture(DragGesture().onChanged{
                                gesture in
                                if gesture.translation.width > 0 && buttonOffSet <= buttonWidth-80{
                                    buttonOffSet = gesture.translation.width
                                }
                            }.onEnded({ _ in
                                withAnimation(Animation.easeOut(duration: 0.4)){
                                    if buttonOffSet > buttonWidth / 2 {
                                        buttonOffSet = buttonWidth - 80
                                        isOnBoardingViewActive = false
                                    } else{
                                        buttonOffSet = 0
                                    }
                                }
                            })
                            )
                        
                        Spacer()
                    }
                        
                    
                }
                .frame(width: buttonWidth, height: 80,alignment: .center)
                .padding()
            }
        }.onAppear(perform: {
            isAnimating = true
        })
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
