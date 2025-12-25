package com.hurlant.crypto.cert
{
   public class X509CertificateCollection
   {
      
      private var _map:Object;
      
      public function X509CertificateCollection()
      {
         super();
         this._map = {};
      }
      
      public function addPEMCertificate(param1:String, param2:String, param3:String) : void
      {
         this._map[param2] = new X509Certificate(param3);
      }
      
      public function addCertificate(param1:X509Certificate) : void
      {
         var _loc2_:String = param1.getSubjectPrincipal();
         this._map[_loc2_] = param1;
      }
      
      public function getCertificate(param1:String) : X509Certificate
      {
         return this._map[param1];
      }
   }
}

