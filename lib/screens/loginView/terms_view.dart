import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../main.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({ Key? key }) : super(key: key);
  final policyHtml = """
  <style type="text/css">

    p.p1 {
        margin: 0.0px, 0.0px, 0.0px, 0.0px;
        font-size: 12.0px;
        font-family: Helvetica;
        color: #ffffff;
    }

    p.p2 {
        margin: 5.0px 0.0px 0.0px 0.0px;
        font-size: 14.0px;
        color: #ffffff;
        font-family: Helvetica;
    }

</style>
<p class="p2"><strong>Privacy Policy</strong></p>
<p class="p1">Last Revised: Jan 12, 2022&nbsp;</p>
<p class="p1">Talkers (&ldquo;Talkers,&rdquo; &ldquo;we,&rdquo; or &ldquo;us&rdquo;) are committed to protecting your privacy. This Privacy Policy explains our practices regarding the collection, use, disclosure, and protection of information that is collected through our Service, as well as your choices regarding the collection and use of information.&nbsp;</p>
<p class="p2"><strong>How We Collect and Use Information</strong></p>
<p class="p1">We collect the following types of information about you:&nbsp;</p>
<p class="p1">Device Information: When you download and use the Talkers, we may collect your device information such as your operating system, device model, os version, ip address. We do not collect/store neither your mobile phone number nor any other phone number you add. We may also collect billing information when you sign up for Premium service. If you remove your account from Talkers, we destroy all data.&nbsp;</p>
<p class="p2"><strong>Sharing of Your Information</strong></p>
<p class="p1">We may share your personal information with our third-party business partners, vendors and consultants who perform services on our behalf or who help us provide our Services, such as cloud systems, marketing or analytic services.&nbsp;</p>
<p class="p1">Except as described above, we will not disclose personal information to third parties (including law enforcement, other government entity, or civil litigant; excluding our subcontractors) unless required to do so by law or subpoena or if in our sole discretion, we determine it is necessary to (a) conform to the law, comply with legal process, or investigate, prevent, or take action regarding suspected or actual illegal activities; (b) to enforce our Terms of Use, take precautions against liability, to investigate and defend ourselves against any claims or allegations, or to protect the security or integrity of our site; and/or (c) to exercise or protect the rights, property, or personal safety of Talkers, our Users or others.&nbsp;</p>
<p class="p2"><strong>How we protect your information&nbsp;</strong></p>
<p class="p1">Talkers cares about the security of your information and uses commercially reasonable physical, administrative, and technological safeguards to preserve the integrity and security of all information we collect and that we share with our service providers. However, no security system is impenetrable and we cannot guarantee the security of our systems 100%. In the event that any information under our control is compromised as a result of a breach of security, we will take reasonable steps to investigate the situation and where appropriate, notify those individuals whose information may have been compromised and take other steps, in accordance with any applicable laws and regulations.&nbsp;</p>
<p class="p2"><strong>Your Choices About Your Information</strong></p>
<p class="p1">You may, of course, decline to submit any personal information through the Service, in which case Talkers may not be able to provide its Services to you.&nbsp;</p>
<p class="p1">Modifying Your Account Information and Settings: You may modify your account information, update or amend your personal information, or change your number at any time by contacting us at bhdrbhr1000@gmail.com. We make every effort to promptly process all unsubscribe requests. As noted above, you may not opt out of Service-related communications (e.g., account verification, parental consent notification, order confirmations, change or updates to features of the Service, technical and security notices). If you have any questions about reviewing or modifying your account information, you can contact us directly at bhdrbhr1000@gmail.com&nbsp;</p>
<p class="p2"><strong>Children&rsquo;s Privacy</strong></p>
<p class="p1">Our Service allows parents to keep track of their children&rsquo;s location on mobile devices that the Parent has added to the Family account. The Service is intended to be used by children under 18 only with significant parental involvement and approval. If a Parent wishes to add a User who is under 18 to the Family account, the Parent must first complete the Parental Consent Form and return it via mail, fax or email. The Parental consent form can be found here&nbsp;</p>
<p class="p2"><strong>Links to Other Web Sites and Services</strong></p>
<p class="p1">We are not responsible for the practices employed by websites or services linked to or from the Service, nor the information or content contained therein. Please remember that when you use a link to go from the Service to another website, our Privacy Policy does not apply to third-party websites or services. Your browsing and interaction on any third-party website or service, including those that have a link on our website, are subject to that third party&rsquo;s own rules and policies. Please read over those rules and policies before proceeding.&nbsp;</p>
<p class="p2"><strong>Changes to Our Privacy Policy</strong></p>
<p class="p1">Talkers may, in its sole discretion, modify or update this Privacy Policy from time to time, and so you should review this page periodically. When we change the policy, we will update the &lsquo;last modified&rsquo; date at the top of this page. If there are material changes to this Privacy Policy or in how Talkers will use your personal information, we will notify you either by prominently posting a notice of such changes prior to implementing the change or by directly sending you a notification.&nbsp;</p>
<p class="p2"><strong>How to contact us</strong></p>
<p class="p1">If you have any questions about this Privacy Policy or the Service, please contact us at bhdrbhr1000@gmail.com&nbsp;</p>
<p class="p1">* This app is not associated with or affiliated with any app. You will not receive any access permission.</p>
<p class="p2"><br></p>
  """;
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(parsedJson['privacy']),
    
    ),
    body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        child: Html(
          data: policyHtml,
        ),
      ),
    );
  }
}

class AboutSubscriptions extends StatelessWidget {
  const AboutSubscriptions({ Key? key }) : super(key: key);
  final subsHTML = """
  <style type="text/css">
    p.p1 {
        margin: 0.0px 0.0px 0.0px 0.0px;
        font: 12.0px Helvetica;
        color: #ffffff;
    }

    p.p2 {
        margin: 0.0px 0.0px 0.0px 0.0px;
        font: 12.0px Helvetica;
        color: #ffffff;
        min-height: 14.0px
    }
</style>
<style type="text/css" id="isPasted">
    p.p1 {
        margin: 0.0px 0.0px 0.0px 0.0px;
        font: 12.0px Helvetica;
        color: #ffffff;
    }

    p.p2 {
        margin: 0.0px 0.0px 0.0px 0.0px;
        font: 12.0px Helvetica;
        color: #ffffff;
        min-height: 14.0px
    }
</style>
<style type="text/css" id="isPasted">
    p.p1 {
        margin: 0.0px 0.0px 0.0px 0.0px;
        font: 12.0px Helvetica;
        color: #ffffff;
    }

    p.p2 {
        margin: 0.0px 0.0px 0.0px 0.0px;
        font: 12.0px Helvetica;
        color: #ffffff;
        min-height: 14.0px
    }

    li.li1 {
        margin: 0.0px 0.0px 0.0px 0.0px;
        font: 12.0px Helvetica;
        color: #ffffff;
    }

    span.s1 {
        font: 12.0px Symbol
    }

    ul.ul1 {
        list-style-type: disc
    }
</style>
<p class="p1"><strong>About Subscriptions</strong></p>
<p class="p1">We offer weekly, monthly and yearly subscriptions. Prices are clearly displayed in the app.</p>
<ul class="ul1">
    <li class="li1">Payment will be charged to your iTunes account at confirmation of purchase.</li>
    <li class="li1">Your subscription will automatically renew itself unless auto-renewal is turned off at least 24 hours before the end of the current period.</li>
    <li class="li1">Your account will be charged for renewal within 24 hours prior to the end of the current period.</li>
    <li class="li1">You can manage your subscriptions and turn off auto-renewal by going to your Account Settings in the iTunes store.</li>
    <li class="li1">If offered, if you choose to use our free trial, any unused portion of the free trial period will be forfeited when you purchase a subscription to that publication, where applicable.</li>
</ul>
  """;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(parsedJson['subscriptions'])),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10),
          child: Html(data: subsHTML),
        ),
      )
      );
  }
}

class TermsOfUseView extends StatelessWidget {
  const TermsOfUseView({ Key? key }) : super(key: key);
  final eulaHtml = """
<style type="text/css">
    p.p1 {
        margin: 0.0px 0.0px 0.0px 0.0px;
        font-size: 12.0px;
        font-family: Helvetica;
        color: #ffffff;
    }

    p.p2 {
        margin: 0.0px 0.0px 0.0px 0.0px;
        font-size: 12.0px;
        font-family: Helvetica;
        color: #ffffff;
    }
</style>
<style type="text/css" id="isPasted">
    p.p1 {
        margin: 0.0px 0.0px 0.0px 0.0px;
        font-size: 12.0px;
        font-family: Helvetica;
        color: #ffffff;
    }

    p.p2 {
        margin: 0.0px 0.0px 0.0px 0.0px;
        font-size: 12.0px;
        font-family: Helvetica;
        color: #ffffff;
    }
</style>
<p class="p1"><strong>TERMS OF USE</strong></p>
<p class="p1">By using the application Talkers, you agree to be bound by these terms of use. The Service is owned or controlled by Talkers (&quot;Talkers&quot;). Please read all of the Terms of Use, if you do not agree to be bound by all of these Terms of Use, do not access or use the services.<span class="Apple-converted-space">&nbsp;</span></p>
<p class="p1"><strong>Conditions of Use</strong></p>
<p class="p1">We reserve the right, in our sole discretion, to change these Terms of Use from time to time. We reserve the right to refuse access to the Service to anyone for any reason at any time. We reserve the right to force forfeiture of any username for any reason. We may, but have no obligation to, remove, edit, block, and/or monitor Content or accounts containing Content that we determine in our sole discretion violates these Terms of Use. We reserve the right to modify or terminate the Service or your access to the Service for any reason, without notice, at any time, and without liability to you. You can deactivate your Talkers account by logging into the Service and completing the form. If we terminate your access to the Service or you use the form detailed above to deactivate your account, your statistics, information and other data will no longer be accessible through your account. There may be links from the Service, or from communications you receive from the Service, to third-party web sites or features. There may also be links to third-party web sites or features in images or comments within the Service. The Service may also includes third-party content that we do not control, maintain or endorse. Functionality on the Service may also permit interactions between the Service and a third-party web site or feature, including applications that connect the Service or your profile on the Service with a third-party web site or feature. Talkers does not control any of these third-party web services or any of their content. You expressly acknowledge and agree that Talkers is in no way responsible or liable for any such third-party services or features. Your correspondence and business dealings with third parties found through the service are solely between you and the third party. You may choose, at your sole and absolute discretion and risk, to use applications that connect the Service or your profile on the Service with a third-party service (each, an &quot;Application&quot;) and such Application may interact with, connect to or gather and/or pull information from and to your Service profile. You agree that you are responsible for all data charges you incur through use of the Service. We prohibit crawling, scraping, caching or otherwise accessing any content on the Service via automated means, including but not limited to, user profiles and photos.<span class="Apple-converted-space">&nbsp;</span></p>
<p class="p1">* You affirm that you are either more than 18 years of age, or an emancipated minor, or possess legal parental or guardian consent, and are fully able and competent to enter into the terms, conditions, obligations, affirmations, representations, and warranties set forth in these Terms of Service, and to abide by and comply with these Terms of Service.</p>
<p class="p1"><strong>Rights</strong></p>
<p class="p1">The Talkers name and logo are trademarks of Talkers, and may not be copied, imitated or used, in whole or in part, without the prior written permission of Talkers. In addition, all page headers, custom graphics, button icons and scripts may not be copied, imitated or used, in whole or in part, without prior written permission from Talkers. The Service contains content owned or licensed by Talkers. Talkers content is protected by copyright, trademark, patent, trade secret and other laws, and, as between you and Talkers, Talkers owns and retains all rights in the Talkers Content and the Service. You will not remove, alter or conceal any copyright, trademark, service mark or other proprietary rights notices incorporated in or accompanying the Talkers Content and you will not reproduce, modify, adapt, prepare derivative works based on, perform, display, publish, distribute, transmit, broadcast, sell, license or otherwise exploit the content. Although it is Talkers&apos;s intention for the Service to be available as much as possible, there will be occasions when the Service may be interrupted, including, without limitation, for scheduled maintenance or upgrades, for emergency repairs, or due to failure of telecommunications links and/or equipment. Also, Talkers reserves the right to remove any content from the Service for any reason, without prior notice. Content and istatistics removed from the Service may continue to be stored by Talkers. Talkers will not be liable to you for any modification, suspension, or discontinuation of the Services, or the loss of any Content.<span class="Apple-converted-space">&nbsp;</span></p>
<p class="p1"><strong>In App Purchase and Payment</strong></p>
<p class="p1">In-app purchase features are offered on an annual, monthly or a weekly basis and will be re-billed every year or month by the Apple App Store, depending upon auto-renewable subscription model, until cancelled by the user.  The Apple App Store will send an e-mail well in advance of renewal containing a hyperlink to manage subscription procedure. App Payments will be processed through the Apple App Store. You may access the applicable in-app purchase rules and policies directly from the Apple App Store. You acknowledge and agree that you are fully responsible for managing your in-app purchases and the amount you spend on in-app purchase within the Talkers.</p>
<p class="p1">If you are under 18 then you are legally required to have you parents’ or legal guardians’ permission to make any in-app purchases. By completing an in-app purchase, you are confirming to us that you have any and all permission that may be necessary in order to allow you make that in-app purchase.  If you are a parent or legal guardian of someone under the age of 18, we recommend that you consider any parental control that may be provided by the Apple App Store provided that you are concerned that your child may make excessive in-app purchases.</p>
<p class="p1">The in-app purchases are purchased from and billed by the Apple App Store. These purchases are subject to the terms and conditions of the Apple App Store. All billing and refund inquiries shall be directed to the Apple App Store. Having said that, Talkers does not have access to the Apple App Store accounts and transactions.</p>
<p class="p1">If any in-app purchase is not successfully downloaded or does not work once it has been successfully downloaded, we will, after becoming aware of fault or being notified of the fault by you, investigate the reason for the fault. We will act reasonably in deciding whether to provide you with a replacement in-app purchase or issue you with a patch to repair the fault. In no event we will charge you anything further to replace or repair the in-app purchase. In the unlikely event that we are unable to replace or repair the relevant in-app purchase or are unable to do so within a reasonable period of time and without significant inconvenience to you, we will authorize the Apple App Store to refund you an amount up to the cost of the relevant in-app purchase.</p>
<p class="p1"><strong>Disclaimer of Warranties</strong></p>
<p class="p1">Talkers do not represent or warrant that the service will be error-free or uninterrupted; that defects will be corrected; or that the service or the server that makes the service available is free from any harmful components, including, without limitation, viruses. Talkers parties do not make any representations or warranties that the information on the service is accurate, complete, or useful. You acknowledge that your use of the service is at your sole risk. By accessing or using the service you represent and warrant that your activities are lawful in every jurisdiction where you access or use the service.<span class="Apple-converted-space">&nbsp;</span></p>
<p class="p1"><strong>Limitation of Liability &amp; Waiver</strong></p>
<p class="p1">Under no circumstances will Talkers be liable to you for any loss or damages of any kind (including, without limitation, for any direct, indirect, economic, exemplary, special, punitive, incidental or consequential losses or damages) that are directly or indirectly related to use of Talkers. Talkers is not responsible for the actions, content, information, or data of third parties, and you release us, our directors, officers, employees, and agents from any claims and damages, known and unknown, arising out of or in any way connected with any claim you have against any such third parties.<span class="Apple-converted-space">&nbsp;</span></p>
<p class="p1"><strong>Indemnification</strong></p>
<p class="p1">You agree to defend, indemnify and hold the Talkers harmless from and against any claims, liabilities, damages, losses, and expenses, including without limitation, reasonable attorney&apos;s fees and costs, arising out of or in any way connected with any of the following (including as a result of your direct activities on the Service or those conducted on your behalf): (i) your Content or your access to or use of the Service; (ii) your breach or alleged breach of these Terms of Use; (iii) your violation of any third-party right, including without limitation, any intellectual property right, publicity, confidentiality, property or privacy right; (iv) your violation of any laws, rules, regulations, codes, statutes, ordinances or orders of any governmental and quasi-governmental authorities, including, without limitation, all regulatory, administrative and legislative authorities; or (v) any misrepresentation made by you. You will cooperate as fully required by Talkers in the defense of any claim. Talkers reserves the right to assume the exclusive defense and control of any matter subject to indemnification by you, and you will not in any event settle any claim without the prior written consent of Talkers.<span class="Apple-converted-space">&nbsp;</span></p>
<p class="p1"><strong>Resolution of Disputes, Governing Law &amp; Venue</strong></p>
<p class="p1">These Terms of Use are governed by and construed in accordance with the Turkish Law, without giving effect to any principles of conflicts of law. Disputes with Talkers and arising from the use of Talkers shall resolute exclusively in the courts of Istanbul, Turkey. You agree that any claim you may have arising out of or related to your relationship with Talkers must be filed within 3 months after such claim arose; otherwise, your claim is permanently barred.<span class="Apple-converted-space">&nbsp;</span></p>
<p class="p1"><strong>Territorial Restrictions</strong></p>
<p class="p1">We reserve the right to limit the availability of the Service or any portion of the Service, to any person, geographic area, or jurisdiction, at any time and in our sole discretion, and to limit the quantities of any content, program, product, service or other feature that Talkers provides.</p>
<p class="p2"><br></p>
  """;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(parsedJson['terms'])),
      body: Padding(
        padding: const EdgeInsets.only(left: 10,right: 10),
        child: SingleChildScrollView(child: Html(data: eulaHtml),),
      ));
  }
}






