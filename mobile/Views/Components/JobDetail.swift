//
//  JobDetail.swift
//  mobile
//
//  Created by cb on 06.09.23.
//  Describes the job as seen in the feed / search when expanded for more details
//

import SwiftUI
import MapKit

struct JobDetail: View {
    @EnvironmentObject var errorHandlingManager: ErrorHandlingManager
    @EnvironmentObject var authenticationManager: AuthenticationManager
    @EnvironmentObject var jobManager: JobManager
    @EnvironmentObject var applicationManager: ApplicationManager

    @State private var region: MKCoordinateRegion
    @State private var isApplicationPopupVisible = false
    @State private var isLoading = false
    @State private var applicationMessage = "Write your application message here ..."
    @State var job: Job

    init(job: Job) {
        self.job = job
        // Create a coordinate region based on the job's latitude and longitude
        _region = State(initialValue: MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: job.latitude, longitude: job.longitude),
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        ))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            RoundedRectangle(cornerRadius: 10)
                .frame(height: 350)
                .foregroundColor(Color("FeedBgColor"))
                .border(Color("FgColor"), width: 3)
                .cornerRadius(10)
                .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .padding(.all)
                    .frame(height: 350)
                    .foregroundColor(Color("FeedBgColor"))
                    .border(Color("FgColor"), width: 3)
                    .padding(.horizontal, 10.0)
                    .overlay(
                        VStack(alignment: .center, spacing: 10) {
                            Text(job.title)
                                .font(.title)
                                .padding(.horizontal)
                            Divider()
                                .padding()

                            Text("Job Type: \(job.jobType)")
                                .font(.title3)
                                .padding(.horizontal)
                            
                            Text("Salary: \(job.salary) \(job.currency) for \(job.duration) h")
                                .font(.title3)
                                .padding(.horizontal)
                            
                            Text("Duration: \(job.duration) months")
                                .font(.title3)
                                .padding(.horizontal)
                            Divider()
                                .padding()

                            Text("Location: \(job.city), \(job.countryCode)")
                                .font(.subheadline)
                                .padding(.horizontal)
                        }
                    )
                )
            
            RoundedRectangle(cornerRadius: 10)
                .frame(height: 200)
                .foregroundColor(Color("FeedBgColor"))
                .border(Color("FgColor"), width: 3)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 200)
                        .foregroundColor(Color("FeedBgColor"))
                        .border(Color("FgColor"), width: 3)
                        .padding(.horizontal, 10.0)
                        .overlay(
                            Map(coordinateRegion: $region, showsUserLocation: true)
                                .padding()
                        )
                )
                Button(action: {
                    isApplicationPopupVisible.toggle()
                }) {
//                    if authenticationManager.ownApplications.contains(id: job.jobId) {
                        ApplicationButton()
  //                  } else {
    //                    ApplicationDetail(job: $job)
      //              }
                }
            }
            .padding()
            .sheet(isPresented: $isApplicationPopupVisible) {
                NavigationView {
                    ApplicationPopup(isVisible: $isApplicationPopupVisible, message: $applicationMessage, job: job)
                        .navigationBarItems(trailing: Button("Close") {
                            isApplicationPopupVisible.toggle()
                        })
                        .navigationBarTitle("\(job.title)", displayMode: .inline)
                }
        }
    }
}



struct JobDetail_Previews: PreviewProvider {
    static var previews: some View {
        let job = JobModel.generateRandomJob()
        return JobDetail(job: job)
    }
}

