public with sharing class GoIbiboConnectController {
    public String source                { get; set; }
    public String destination           { get; set; }
    public List<Onwardflights> wrpList  { get; set; }
    public String adults                { get; set; }
    public String children              { get; set; }
    public String infants               { get; set; }
    public String counter               { get; set; }
    public Boolean isDomestic           { get; set; }
    public String pClass                { get; set; }
    public String url                   { get; set; }

    //private static String dateofdeparture;

    public String buildURL () {
        String formattedDate = Apexpages.currentPage().getParameters().get('formatDate');
        String baseURL = 'http://developer.goibibo.com/api/search/';
        String otherParam = '?app_id=efd148b5&app_key=948fe6c2abb970dfee5439927eaa6e2d' +
                            '&format=xml&source=' + source;
               otherParam += '&destination=' + destination;
               otherParam += '&dateofdeparture=' + formattedDate;
               otherParam += '&adults=' + adults;
               otherParam += '&children=' + children;
               otherParam += '&infants=' + infants;
               otherParam += '&seatingclass=' + pClass;
               otherParam += '&counter=' + retrieveCount ();
         return baseURL + otherParam;
    }

    public Dom.Document callWebService () {
        String mainURL = buildURL ();
        System.debug ('mainURL ==> '+mainURL);
        HttpResponse res;
        try { 
             Http h1 = new Http();
             HttpRequest req = new HttpRequest();
             req.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionID());
             req.setHeader('Content-Type', 'application/xml');
             req.setEndpoint(mainURL);
             req.setMethod('GET');
             res = h1.send(req);
             //werbServiceResult = res1.getbody();
        } catch (Exception e) {
             System.debug ('Error ==> '+ e.getMessage());
        }
        //System.debug ('werbServiceResult ==> '+results);*/
       return res.getBodyDocument(); 
    }

    public String fetchData () {
        wrpList = new List<Onwardflights> ();
        Dom.Document response = callWebService ();
        System.debug('response : ' + response);
        Dom.XMLNode rootNode = response.getRootElement();
        Dom.XMLNode data = rootNode.getChildElement('data', null);
        Dom.XMLNode onwardFlights = data.getChildElement('onwardflights', null);
        for (Dom.XMLNode resource : onwardFlights.getChildElements ()) {
            Onwardflights wrpObj = new Onwardflights ();
            for (Dom.XMLNode info : resource.getChildElements ()) {
                if (info.getName() == 'origin')
                    wrpObj.origin = info.getText ();
                if (info.getName() == 'deptime')
                    wrpObj.deptime = info.getText ();
                if (info.getName() == 'airline')
                    wrpObj.airline = info.getText ();
                if (info.getName() == 'flightno')
                    wrpObj.flightno = info.getText ();
                if (info.getName() == 'stops')
                    wrpObj.stops = info.getText ();
                if (info.getName() == 'carrierid')
                    wrpObj.carrierid = info.getText ();
                if (info.getName() == 'duration')
                    wrpObj.duration = info.getText ();
                if (info.getName() == 'arrtime')
                    wrpObj.arrTime = info.getText ();

                // Wrapping the fare array
                if (info.getName() == 'fare') {
                    Fare flightFare = new Fare ();
                    for (Dom.XMLNode res : info.getChildren ()) {
                        if (res.getName() == 'totalbasefare')
                            flightFare.totalbasefare = res.getText();
                        if (res.getName() == 'taxes' ||
                            res.getName() == 'totaltaxes')
                            flightFare.totaltaxes = res.getText();
                        if (res.getName() == 'totalfare')
                            flightFare.totalfare = res.getText();
                    }
                    System.debug ('flightFare ==> '+flightFare);
                    wrpObj.fare = flightFare;
                }
                //wrpObj.arrTime = getArrTime (wrpObj.deptime, wrpObj.duration);
            }
            wrpList.add (wrpObj);
        }
        return null;
    }

    @RemoteAction
    public static String formatDate (String pDate) {
        List<String> strArray = pDate.split ('/');
       // dateofdeparture= strArray.get (2) + strArray.get (0) + strArray.get (1);
        //System.debug ('dateofdeparture ==> '+dateofdeparture);
        return strArray.get (2) + strArray.get (0) + strArray.get (1);
    } // End method

    private Integer retrieveCount () {
        if (isDomestic)
            return 100;
        return 0;
    }

    // A method that returns list of airport codes
    public List<SelectOption> retriveAirportCode () {
        List<SelectOption> options = new List<SelectOption>();
            options.add(new SelectOption('-NA-','--Choose--'));
            options.add(new SelectOption('HYD','Hydrabad'));
            options.add(new SelectOption('DEL','Delhi'));
            options.add(new SelectOption('BHO','Bhopal'));
            options.add(new SelectOption('PNQ','Pune'));
            options.add(new SelectOption('BOM','Mumbai'));
            options.add(new SelectOption('AMD','Ahmedabad'));
        return options;
    }

    public List<SelectOption> getSourceCodes () {
        return retriveAirportCode ();
    }
    public List<SelectOption> getDesCodes () {
        return retriveAirportCode ();
    }

    public class Onwardflights {
        public String origin    { get; set; }
        public String deptime   { get; set; }
        public String airline   { get; set; }
        public String flightno  { get; set; }
        public String stops     { get; set; }
        public String carrierid { get; set; }
        public String duration  { get; set; }
        public String arrTime   { get; set; }
        public Fare fare        { get; set; }
    }
    public class Fare {
        // double variables
        public String totalbasefare { get; set; }
        public String totalfare     { get; set; }
        public String totaltaxes    { get; set; }
    }
}