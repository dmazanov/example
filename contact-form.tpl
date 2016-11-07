{*
* 2007-2016 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author PrestaShop SA <contact@prestashop.com>
*  @copyright  2007-2016 PrestaShop SA
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}
{capture name=path}{l s='Contact'}{/capture}
<div class="col-lg-9" style="margin-bottom:25px;">
<h1>Kontakt</h1>
<div class="col-lg-6">
<h2 class="sub">Dane firmy</h2>
<p>Sklep internetowy BearWheels.pl</p>
<p>ul. Jana Boenigka 21 lok. 37</p>
<p>10-686 Olsztyn</p>
<p style="margin-top: 10px;" >NIP 739 - 388 - 71 - 02, REGON 365454847</p>
</div>
<div class="col-lg-6">
<h2 class="sub">Kontakt</h2>
<p>Telefon  79 492 28 52 </p>
<p>Czynne od poniedziałku do piątku </p>
<p>w godzinach: 09:00 - 17:00</p>
<p style="margin-top: 10px;">E-mail: sklep@bearwheejs.pl</p>
</div>


{if isset($confirmation)}
	<p class="alert alert-success">{l s='Your message has been successfully sent to our team.'}</p>
	
	<ul class="footer_links clearfix">
		<li>
			<a class="btn btn-default button button-small" href="{if isset($force_ssl) && $force_ssl}{$base_dir_ssl}{else}{$base_dir}{/if}">
				<span>
					<i class="icon-chevron-left"></i>{l s='Home'}
				</span>
			</a>
		</li>
	</ul>
{elseif isset($alreadySent)}

	<p class="alert alert-warning">{l s='Your message has already been sent.'}</p>
	<ul class="footer_links clearfix">
		<li>
			<a class="btn btn-default button button-small" href="{if isset($force_ssl) && $force_ssl}{$base_dir_ssl}{else}{$base_dir}{/if}">
				<span>
					<i class="icon-chevron-left"></i>{l s='Home'}
				</span>
			</a>
		</li>
	</ul>

{else}
	<div>{include file="$tpl_dir./errors.tpl"}</div>
	<form action="{$request_uri}" method="post" class="contact-form-box" enctype="multipart/form-data">
		<fieldset>
			<h2 class="sub" style="margin-top:15px;">{l s='send a message'}</h2>
			<p style="margin-top:10px;margin-bottom:15px;">Wypełnij formularz, a nasz specjalista skontaktuje się z Tobą</p>
			<div class="clearfix">
				<div class="">
					<div class="form-group selector1">
						
					<p class="select" style="display:none;">
					<label for="id_contact">Subiect</label>
					<select onchange="showElemFromSelect('id_contact', 'desc_contact')" name="id_contact" id="id_contact">
					<option value="2">Obsługa klienta</option>
					</select>
					</p>
					<p class="form-group">
		
						{if isset($customerThread.email)}
							<input class="form-control grey" type="text" id="email" name="from" value="{$customerThread.email|escape:'html':'UTF-8'}" readonly="readonly" placeholder="{l s='Email address'}"/>
						{else}
							<input class="form-control grey validate" type="text" id="email" name="from" data-validate="isEmail" value="{$email|escape:'html':'UTF-8'}"   placeholder="{l s='Email address'}"/>
						{/if}
					</p>
					{if !$PS_CATALOG_MODE}
						{if (!isset($customerThread.id_order) || $customerThread.id_order > 0)}
							<div class="form-group selector1">
								
								{if !isset($customerThread.id_order) && isset($is_logged) && $is_logged}
									<select name="id_order" class="form-control">
										<option value="0">{l s='-- Choose --'}</option>
										{foreach from=$orderList item=order}
											<option value="{$order.value|intval}"{if $order.selected|intval} selected="selected"{/if}>{$order.label|escape:'html':'UTF-8'}</option>
										{/foreach}
									</select>
								{elseif !isset($customerThread.id_order) && empty($is_logged)}
									<input  placeholder="{l s='Order reference'}" class="form-control grey" type="text" name="id_order" id="id_order" value="{if isset($customerThread.id_order) && $customerThread.id_order|intval > 0}{$customerThread.id_order|intval}{else}{if isset($smarty.post.id_order) && !empty($smarty.post.id_order)}{$smarty.post.id_order|escape:'html':'UTF-8'}{/if}{/if}" />
								{elseif $customerThread.id_order|intval > 0}
									<input  placeholder="{l s='Order reference'}" class="form-control grey" type="text" name="id_order" id="id_order" value="{if isset($customerThread.reference) && $customerThread.reference}{$customerThread.reference|escape:'html':'UTF-8'}{else}{$customerThread.id_order|intval}{/if}" readonly="readonly" />
								{/if}
							</div>
						{/if}
						{if isset($is_logged) && $is_logged}
							<div class="form-group selector1">
								<label class="unvisible">{l s='Product'}</label>
								{if !isset($customerThread.id_product)}
									{foreach from=$orderedProductList key=id_order item=products name=products}
										<select name="id_product" id="{$id_order}_order_products" class="unvisible product_select form-control"{if !$smarty.foreach.products.first} style="display:none;"{/if}{if !$smarty.foreach.products.first} disabled="disabled"{/if}>
											<option value="0">{l s='-- Choose --'}</option>
											{foreach from=$products item=product}
												<option value="{$product.value|intval}">{$product.label|escape:'html':'UTF-8'}</option>
											{/foreach}
										</select>
									{/foreach}
								{elseif $customerThread.id_product > 0}
									<input  type="hidden" name="id_product" id="id_product" value="{$customerThread.id_product|intval}" readonly="readonly" />
								{/if}
							</div>
						{/if}
					{/if}
					
				</div>
				<div class="">
					<div class="form-group">
				
						<textarea class="form-control" id="message" name="message" placeholder="{l s='Message'}">{if isset($message)}{$message|escape:'html':'UTF-8'|stripslashes}{/if}</textarea>
					</div>
				</div>
			</div>


		<div style="display: flex;width: 65%;float: left;"><input type="checkbox" checked id="isAgeSelected"><label style="margin-left:5px;" for="raz">Wyrażam zgodę na przetwarzanie moich danych osobowych</label></div>
		
			<div class="submit" id="txtAge"  >
				<button  type="submit" name="submitMessage" id="submitMessage" class="btn-action" style="    border: 0px !important;"><span>{l s='Send'}</span></button>
			</div>
		</fieldset>
	</form>

{/if}
</div>
<div class="google-maps col-lg-12">
    <iframe src="https://www.google.com/maps/embed?pb=!1m14!1m12!1m3!1d7098.94326104394!2d78.0430654485247!3d27.172909818538997!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!5e0!3m2!1sen!2s!4v1385710909804" width="850" height="250" frameborder="0" style="border:0"></iframe>
</div>
{addJsDefL name='contact_fileDefaultHtml'}{l s='No file selected' js=1}{/addJsDefL}
{addJsDefL name='contact_fileButtonHtml'}{l s='Choose File' js=1}{/addJsDefL}
