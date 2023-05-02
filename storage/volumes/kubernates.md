### High avilability(HA)
when we run our application on docker container and if the container fails , we need to manually start the container
if the node i.e machine fails all the container running onthe machine should be re-created on the other machine
k8s can do both of the above

Auto scaling 
  * containers don't scale on their own
  * scaling is of two types
      *  vertical scaling
      *  horizantal scaling
  *  k8s cando both vertical and horiznatal scaling of containers
* zero down time deployements
    * k8s can handle deployements with near zero-down time deployements
    * k8s can handle rollout(new version) and roll back (undo previous version=> previous version)
* k8s described as ` production grade container management `

* History
   * Google had a history of running everything on containers
   * To manage these containers , google has deployed container managed tools(in house)
         * Borg
         * Omega
   * With docker publicizing containers, with the experiencing in running and managing containers, google has started a project kubernates(developed in go) and then handed it over to cloud native container foundation (CNCF)

* Competetiors
    * Apache mesos
    * hashocorp nomad
    * docker swam 
    * but k8s is clear winner
* Terms
* Distributed system
* Node
* Cluster
* State
* statefull aplications
* stateless applications
* monolith 
* micro services
* desired state
* Declarative vs imperative
* pet vs cattle
preview k8s.png
